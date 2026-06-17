package chez1s.assignment.dto;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * DTO model tests: CheckoutRequest, DashboardDTO, BestSellingDrinkDTO, RevenueByDayDTO
 * Covers: TC-125 to TC-131 (DTO shapes for statistics)
 */
class DtoTest {

    // CheckoutRequest
    @Test
    @DisplayName("CheckoutRequest getters/setters")
    void checkoutRequest() {
        CheckoutRequest req = new CheckoutRequest();
        req.setGuestName("Test");
        req.setGuestPhone("090");
        req.setTableId(1);
        req.setPaymentMethod("CASH");
        req.setGuestVoucherId(5);

        assertEquals("Test", req.getGuestName());
        assertEquals("090", req.getGuestPhone());
        assertEquals(1, req.getTableId());
        assertEquals("CASH", req.getPaymentMethod());
        assertEquals(5, req.getGuestVoucherId());
    }

    @Test
    @DisplayName("CheckoutRequest items list")
    void checkoutRequest_items() {
        CheckoutRequest req = new CheckoutRequest();
        CheckoutRequest.CartItem item1 = new CheckoutRequest.CartItem();
        item1.setDrinkId(1);
        item1.setQuantity(2);
        item1.setNote("note");

        CheckoutRequest.CartItem item2 = new CheckoutRequest.CartItem();
        item2.setDrinkId(3);
        item2.setQuantity(1);

        req.setItems(Arrays.asList(item1, item2));
        assertEquals(2, req.getItems().size());
    }

    @Test
    @DisplayName("CheckoutRequest null fields")
    void checkoutRequest_nullFields() {
        CheckoutRequest req = new CheckoutRequest();
        assertNull(req.getGuestName());
        assertNull(req.getGuestPhone());
        assertNull(req.getTableId());
        assertNull(req.getPaymentMethod());
        assertNull(req.getGuestVoucherId());
        assertNull(req.getItems());
    }

    // DashboardDTO
    @Test
    @DisplayName("TC-125/126: DashboardDTO today stats")
    void dashboardDto_todayStats() {
        DashboardDTO dto = new DashboardDTO();
        dto.setTodayRevenue(500000);
        dto.setTodayOrders(10);
        assertEquals(500000, dto.getTodayRevenue());
        assertEquals(10, dto.getTodayOrders());
    }

    @Test
    @DisplayName("TC-127: DashboardDTO week revenue")
    void dashboardDto_weekRevenue() {
        DashboardDTO dto = new DashboardDTO();
        dto.setWeekRevenue(2000000);
        assertEquals(2000000, dto.getWeekRevenue());
    }

    @Test
    @DisplayName("TC-128: DashboardDTO total bills")
    void dashboardDto_totalBills() {
        DashboardDTO dto = new DashboardDTO();
        dto.setTotalBills(1000);
        assertEquals(1000, dto.getTotalBills());
    }

    @Test
    @DisplayName("TC-129: DashboardDTO top drinks")
    void dashboardDto_topDrinks() {
        DashboardDTO dto = new DashboardDTO();
        List<BestSellingDrinkDTO> top = new ArrayList<>();
        dto.setTopDrinks(top);
        assertNotNull(dto.getTopDrinks());
    }

    @Test
    @DisplayName("TC-130: DashboardDTO revenue by day")
    void dashboardDto_revenueByDay() {
        DashboardDTO dto = new DashboardDTO();
        List<RevenueByDayDTO> revenue = new ArrayList<>();
        dto.setRevenueByDay(revenue);
        assertNotNull(dto.getRevenueByDay());
    }
}
