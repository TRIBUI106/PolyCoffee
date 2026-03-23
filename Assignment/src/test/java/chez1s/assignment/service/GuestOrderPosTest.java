package chez1s.assignment.service;

import chez1s.assignment.dto.CheckoutRequest;
import chez1s.assignment.entity.Bill;
import chez1s.assignment.entity.BillDetail;
import chez1s.assignment.entity.CoffeeTable;
import chez1s.assignment.entity.Drink;
import chez1s.assignment.entity.BillStatus;
import chez1s.assignment.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class GuestOrderPosTest {

    private BillService billService;

    @Mock
    private EntityManager em;

    @Mock
    private EntityTransaction trans;

    private MockedStatic<JpaUtil> jpaUtilMockedStatic;

    @BeforeEach
    void setUp() {
        billService = new BillService();

        // Mock Static JpaUtil
        jpaUtilMockedStatic = mockStatic(JpaUtil.class);
        jpaUtilMockedStatic.when(JpaUtil::getEntityManager).thenReturn(em);

        // Mock Transaction
        when(em.getTransaction()).thenReturn(trans);
    }

    @AfterEach
    void tearDown() {
        jpaUtilMockedStatic.close();
    }

    @Test
    @DisplayName("Should successfully checkout a guest cart with valid items and NO QR / Table logic")
    void testGuestCheckoutSuccess() {
        // Arrange
        CheckoutRequest request = new CheckoutRequest();
        request.setGuestName("Test Guest");
        request.setGuestPhone("0901234567");
        request.setPaymentMethod("CASH");

        CheckoutRequest.CartItem item = new CheckoutRequest.CartItem();
        item.setDrinkId(10);
        item.setQuantity(2);
        item.setNote("Less ice");
        request.setItems(Collections.singletonList(item));

        Drink mockDrink = new Drink();
        mockDrink.setId(10);
        mockDrink.setPrice(25000);
        when(em.find(Drink.class, 10)).thenReturn(mockDrink);

        // Act
        Bill resultBill = billService.checkoutGuestBill(request, null);

        // Assert
        assertNotNull(resultBill, "Bill should not be null");
        assertEquals("Test Guest", resultBill.getGuestName());
        assertEquals("0901234567", resultBill.getGuestPhone());
        assertEquals(BillStatus.WAITING, resultBill.getStatus()); // Guest POS orders begin as WAITING
        assertEquals("CASH", resultBill.getPaymentMethod());
        assertEquals(50000, resultBill.getTotal()); // 25000 * 2
        assertNull(resultBill.getTable(), "Table should be null if not requested");

        assertNotNull(resultBill.getBillDetails());
        assertEquals(1, resultBill.getBillDetails().size());
        BillDetail detail = resultBill.getBillDetails().get(0);
        assertEquals(2, detail.getQuantity());
        assertEquals(25000, detail.getPrice());
        assertEquals("Less ice", detail.getNote());

        // Verify Persistence Call
        verify(trans).begin();
        verify(em).persist(any(Bill.class));
        verify(trans).commit();
        verify(em).close();
    }

    @Test
    @DisplayName("Should assign a Coffee Table properly if specific Table ID is provided in Guest Checkout")
    void testGuestCheckoutWithTable() {
        // Arrange
        CheckoutRequest request = new CheckoutRequest();
        request.setGuestName("Table Guest");
        request.setTableId(5);
        request.setPaymentMethod("VIETQR");

        CheckoutRequest.CartItem item = new CheckoutRequest.CartItem();
        item.setDrinkId(1);
        item.setQuantity(1);
        request.setItems(Collections.singletonList(item));

        CoffeeTable mockTable = new CoffeeTable();
        mockTable.setId(5);
        when(em.find(CoffeeTable.class, 5)).thenReturn(mockTable);

        Drink mockDrink = new Drink();
        mockDrink.setId(1);
        mockDrink.setPrice(30000);
        when(em.find(Drink.class, 1)).thenReturn(mockDrink);

        // Act
        Bill resultBill = billService.checkoutGuestBill(request, null);

        // Assert
        assertNotNull(resultBill);
        assertNotNull(resultBill.getTable());
        assertEquals(5, resultBill.getTable().getId());
        assertEquals("VIETQR", resultBill.getPaymentMethod());
        assertEquals(30000, resultBill.getTotal());
        assertEquals(BillStatus.WAITING, resultBill.getStatus());

        verify(trans).begin();
        verify(em).persist(any(Bill.class));
        verify(trans).commit();
    }

    @Test
    @DisplayName("Should rollback transaction when Checkout encounters Entity Exception (e.g. disconnected DB)")
    void testGuestCheckoutDatabaseErrorRollbacksTransaction() {
        // Arrange
        CheckoutRequest request = new CheckoutRequest();
        request.setGuestName("Error Guest");
        request.setItems(Collections.emptyList());

        // Simulate a persistence failure dynamically using doThrow avoiding unchecked issues
        doThrow(new RuntimeException("Database Offline!")).when(em).persist(any(Bill.class));
        when(trans.isActive()).thenReturn(true); 

        // Act & Assert
        Exception exception = assertThrows(RuntimeException.class, () -> billService.checkoutGuestBill(request, null));

        assertEquals("Database Offline!", exception.getMessage());
        
        // Ensure proper sequence: attempt begin -> throws persist -> active trans -> rollbacks -> finally closes
        verify(trans).begin();
        verify(trans).rollback();
        verify(trans, never()).commit();
        verify(em).close();
    }
}
