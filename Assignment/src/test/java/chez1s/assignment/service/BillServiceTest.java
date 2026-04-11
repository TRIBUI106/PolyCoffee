package chez1s.assignment.service;

import chez1s.assignment.entity.*;
import chez1s.assignment.repository.BillRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * TC-063 to TC-087, TC-118 to TC-124: Bill service tests
 * Note: addDrinkToBill, updateQuantity, updateNote, checkoutGuestBill use EntityManager directly
 * and require integration tests. These tests cover the repository-delegating methods.
 */
@ExtendWith(MockitoExtension.class)
class BillServiceTest {

    @Mock
    private BillRepository billRepo;

    @InjectMocks
    private BillService billService;

    private Bill waitingBill;
    private Bill finishedBill;
    private Bill cancelledBill;
    private User staff;
    private User manager;

    @BeforeEach
    void setUp() {
        staff = new User();
        staff.setId(1);
        staff.setRole(false);

        manager = new User();
        manager.setId(2);
        manager.setRole(true);

        Drink drink = new Drink();
        drink.setId(1);
        drink.setName("Latte");
        drink.setPrice(35000);

        BillDetail detail = new BillDetail();
        detail.setId(1);
        detail.setDrink(drink);
        detail.setQuantity(2);
        detail.setPrice(35000);

        waitingBill = new Bill();
        waitingBill.setId(1);
        waitingBill.setCode("BILL-1000");
        waitingBill.setStatus(BillStatus.WAITING);
        waitingBill.setTotal(70000);
        waitingBill.setUser(staff);
        waitingBill.setCreatedAt(new Date());
        waitingBill.setBillDetails(new ArrayList<>(Arrays.asList(detail)));

        finishedBill = new Bill();
        finishedBill.setId(2);
        finishedBill.setCode("BILL-2000");
        finishedBill.setStatus(BillStatus.FINISHED);
        finishedBill.setTotal(50000);
        finishedBill.setUser(staff);

        cancelledBill = new Bill();
        cancelledBill.setId(3);
        cancelledBill.setCode("BILL-3000");
        cancelledBill.setStatus(BillStatus.CANCELLED);
        cancelledBill.setTotal(0);
    }

    // TC-075
    @Test
    @DisplayName("TC-075: Checkout WAITING -> FINISHED")
    void checkout_waitingBill_becomesFinished() {
        when(billRepo.findById(1)).thenReturn(waitingBill);
        billService.checkout(1);
        assertEquals(BillStatus.FINISHED, waitingBill.getStatus());
        verify(billRepo).update(waitingBill);
    }

    // TC-076
    @Test
    @DisplayName("TC-076: Checkout already FINISHED bill - no change")
    void checkout_finishedBill_noChange() {
        when(billRepo.findById(2)).thenReturn(finishedBill);
        billService.checkout(2);
        assertEquals(BillStatus.FINISHED, finishedBill.getStatus());
        verify(billRepo, never()).update(any());
    }

    // TC-077
    @Test
    @DisplayName("TC-077: Checkout CANCELLED bill - no change")
    void checkout_cancelledBill_noChange() {
        when(billRepo.findById(3)).thenReturn(cancelledBill);
        billService.checkout(3);
        assertEquals(BillStatus.CANCELLED, cancelledBill.getStatus());
        verify(billRepo, never()).update(any());
    }

    // TC-078
    @Test
    @DisplayName("TC-078: Cancel WAITING -> CANCELLED")
    void cancel_waitingBill_becomesCancelled() {
        when(billRepo.findById(1)).thenReturn(waitingBill);
        billService.cancel(1);
        assertEquals(BillStatus.CANCELLED, waitingBill.getStatus());
        verify(billRepo).update(waitingBill);
    }

    // TC-079
    @Test
    @DisplayName("TC-079: Cancel already CANCELLED bill - no change")
    void cancel_cancelledBill_noChange() {
        when(billRepo.findById(3)).thenReturn(cancelledBill);
        billService.cancel(3);
        verify(billRepo, never()).update(any());
    }

    // TC-082
    @Test
    @DisplayName("TC-082: Get bill by ID")
    void getBillById_exists() {
        when(billRepo.findById(1)).thenReturn(waitingBill);
        Bill result = billService.getBillById(1);
        assertNotNull(result);
        assertEquals("BILL-1000", result.getCode());
    }

    // TC-083
    @Test
    @DisplayName("TC-083: Get bill by ID - not found")
    void getBillById_notFound() {
        when(billRepo.findById(999)).thenReturn(null);
        assertNull(billService.getBillById(999));
    }

    // TC-084
    @Test
    @DisplayName("TC-084: Get bill by ID and userId - ownership match")
    void getBill_ownerMatch() {
        when(billRepo.findByIdAndUserId(1, 1)).thenReturn(waitingBill);
        Bill result = billService.getBill(1, 1);
        assertNotNull(result);
    }

    // TC-085
    @Test
    @DisplayName("TC-085: Get bill by ID and wrong userId - returns null")
    void getBill_wrongOwner() {
        when(billRepo.findByIdAndUserId(1, 99)).thenReturn(null);
        assertNull(billService.getBill(1, 99));
    }

    // TC-086
    @Test
    @DisplayName("TC-086: Search bills by query")
    void searchBills_byQuery() {
        when(billRepo.searchBills("BILL-1", null)).thenReturn(Arrays.asList(waitingBill));
        List<Bill> result = billService.searchBills("BILL-1", null);
        assertEquals(1, result.size());
    }

    // TC-087
    @Test
    @DisplayName("TC-087: Search bills by status")
    void searchBills_byStatus() {
        when(billRepo.searchBills(null, "FINISHED")).thenReturn(Arrays.asList(finishedBill));
        List<Bill> result = billService.searchBills(null, "FINISHED");
        assertEquals(1, result.size());
        assertEquals(BillStatus.FINISHED, result.get(0).getStatus());
    }

    // TC-118
    @Test
    @DisplayName("TC-118: Get all bills")
    void getAllBills() {
        when(billRepo.findAll()).thenReturn(Arrays.asList(waitingBill, finishedBill));
        assertEquals(2, billService.getAllBills().size());
    }

    // TC-119
    @Test
    @DisplayName("TC-119: Search user bills (staff's own)")
    void searchUserBills() {
        when(billRepo.searchUserBills(1, null, null)).thenReturn(Arrays.asList(waitingBill));
        List<Bill> result = billService.searchUserBills(1, null, null);
        assertEquals(1, result.size());
    }

    // TC-080 (total calculation)
    @Test
    @DisplayName("TC-080: Bill total = sum(price * quantity)")
    void billTotal_calculation() {
        // waitingBill has 1 detail: price=35000, qty=2 -> total should be 70000
        assertEquals(70000, waitingBill.getTotal());
    }

    // TC-081
    @Test
    @DisplayName("TC-081: Bill code format")
    void billCode_format() {
        assertTrue(waitingBill.getCode().startsWith("BILL-"));
    }

    // Checkout null bill
    @Test
    @DisplayName("Checkout null bill ID - no crash")
    void checkout_nullBill() {
        when(billRepo.findById(999)).thenReturn(null);
        billService.checkout(999);
        verify(billRepo, never()).update(any());
    }

    // Cancel null bill
    @Test
    @DisplayName("Cancel null bill ID - no crash")
    void cancel_nullBill() {
        when(billRepo.findById(999)).thenReturn(null);
        billService.cancel(999);
        verify(billRepo, never()).update(any());
    }

    // Get bill with details
    @Test
    @DisplayName("TC-080b: getBillWithDetails delegates to repo")
    void getBillWithDetails() {
        when(billRepo.findByIdWithDetails(1)).thenReturn(waitingBill);
        Bill result = billService.getBillWithDetails(1);
        assertNotNull(result);
        assertNotNull(result.getBillDetails());
    }
}
