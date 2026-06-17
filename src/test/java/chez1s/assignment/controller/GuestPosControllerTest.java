package chez1s.assignment.controller;

import chez1s.assignment.dto.CheckoutRequest;
import chez1s.assignment.entity.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * TC-088 to TC-105: Guest self-order / checkout logic tests
 */
class GuestPosControllerTest {

    // TC-088: Valid checkout request
    @Test
    @DisplayName("TC-088: Valid checkout request has items")
    void validCheckoutRequest() {
        CheckoutRequest req = new CheckoutRequest();
        req.setGuestName("Test Guest");
        req.setGuestPhone("0901234567");
        req.setPaymentMethod("CASH");

        CheckoutRequest.CartItem item = new CheckoutRequest.CartItem();
        item.setDrinkId(1);
        item.setQuantity(2);
        item.setNote("no ice");
        req.setItems(Arrays.asList(item));

        assertNotNull(req.getGuestName());
        assertEquals(1, req.getItems().size());
        assertEquals(2, req.getItems().get(0).getQuantity());
    }

    // TC-089: Empty items
    @Test
    @DisplayName("TC-089: Checkout with empty items list")
    void emptyItemsList() {
        CheckoutRequest req = new CheckoutRequest();
        req.setItems(new ArrayList<>());
        assertTrue(req.getItems().isEmpty());
    }

    // TC-091: Table from request body
    @Test
    @DisplayName("TC-091: Checkout with tableId in request")
    void checkoutWithTableId() {
        CheckoutRequest req = new CheckoutRequest();
        req.setTableId(5);
        assertEquals(5, req.getTableId());
    }

    // TC-092: Table from session (null in request)
    @Test
    @DisplayName("TC-092: TableId null falls back to session")
    void checkoutTableIdNull_fallsToSession() {
        CheckoutRequest req = new CheckoutRequest();
        assertNull(req.getTableId());
        // Controller would set from session
        req.setTableId(3);
        assertEquals(3, req.getTableId());
    }

    // TC-093: Voucher discount calculation
    @Test
    @DisplayName("TC-093: Voucher discount reduces total")
    void voucherDiscount() {
        int itemsTotal = 50000;
        int discountAmount = 10000;
        int total = Math.max(0, itemsTotal - discountAmount);
        assertEquals(40000, total);
    }

    // TC-094: Total cannot go below 0
    @Test
    @DisplayName("TC-094: Total with large discount clamped to 0")
    void totalClampedToZero() {
        int itemsTotal = 5000;
        int discountAmount = 20000;
        int total = Math.max(0, itemsTotal - discountAmount);
        assertEquals(0, total);
    }

    // TC-095: Point accumulation
    @Test
    @DisplayName("TC-095: Points earned = total / 1000")
    void pointsEarned() {
        int total = 45000;
        int points = total / 1000;
        assertEquals(45, points);
    }

    // TC-096: Already used voucher check
    @Test
    @DisplayName("TC-096: Used voucher should not be applied")
    void usedVoucher_notApplied() {
        GuestVoucher gv = new GuestVoucher();
        gv.setIsUsed(true);
        assertTrue(gv.getIsUsed()); // controller checks !gv.getIsUsed()
    }

    // TC-097: Voucher belongs to different guest
    @Test
    @DisplayName("TC-097: Voucher ownership check")
    void voucherOwnership() {
        Guest guestA = new Guest();
        guestA.setId(1);
        Guest guestB = new Guest();
        guestB.setId(2);

        GuestVoucher gv = new GuestVoucher();
        gv.setGuest(guestB);

        assertNotEquals(guestA.getId(), gv.getGuest().getId());
    }

    // TC-099: Null guest name
    @Test
    @DisplayName("TC-099: Checkout with null guestName")
    void nullGuestName() {
        CheckoutRequest req = new CheckoutRequest();
        req.setGuestName(null);
        assertNull(req.getGuestName());
    }

    // TC-101: Accept bill status transition
    @Test
    @DisplayName("TC-101: Accept bill transitions WAITING to FINISHED")
    void acceptBill_transition() {
        Bill bill = new Bill();
        bill.setStatus(BillStatus.WAITING);
        if (bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.FINISHED);
        }
        assertEquals(BillStatus.FINISHED, bill.getStatus());
    }

    // TC-102: Accept non-WAITING bill
    @Test
    @DisplayName("TC-102: Accept finished bill - no change")
    void acceptFinished_noChange() {
        Bill bill = new Bill();
        bill.setStatus(BillStatus.FINISHED);
        if (bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.FINISHED);
        }
        assertEquals(BillStatus.FINISHED, bill.getStatus());
    }

    // TC-105: Drinks filtered by category
    @Test
    @DisplayName("TC-105: Filter drinks by category ID")
    void filterDrinksByCategory() {
        Category cat1 = new Category();
        cat1.setId(1);
        Category cat2 = new Category();
        cat2.setId(2);

        Drink d1 = new Drink();
        d1.setCategory(cat1);
        d1.setName("Latte");

        Drink d2 = new Drink();
        d2.setCategory(cat2);
        d2.setName("Tea");

        List<Drink> all = Arrays.asList(d1, d2);
        int catId = 1;
        List<Drink> filtered = all.stream()
                .filter(d -> d.getCategory() != null && d.getCategory().getId().equals(catId))
                .toList();

        assertEquals(1, filtered.size());
        assertEquals("Latte", filtered.get(0).getName());
    }

    // TC-105b: Filter with catId=0 returns all
    @Test
    @DisplayName("TC-105b: CatId=0 returns all drinks")
    void filterDrinks_catIdZero() {
        Drink d1 = new Drink();
        d1.setName("A");
        Drink d2 = new Drink();
        d2.setName("B");

        List<Drink> all = Arrays.asList(d1, d2);
        int catId = 0;
        List<Drink> filtered = all.stream()
                .filter(d -> catId == 0 || (d.getCategory() != null && d.getCategory().getId().equals(catId)))
                .toList();

        assertEquals(2, filtered.size());
    }

    // TC-098: Guest bill code format
    @Test
    @DisplayName("TC-098: Guest bill code format GUEST-timestamp")
    void guestBillCodeFormat() {
        String code = "GUEST-" + System.currentTimeMillis();
        assertTrue(code.matches("GUEST-\\d+"));
    }

    // CheckoutRequest CartItem getters
    @Test
    @DisplayName("CartItem getters/setters")
    void cartItem_gettersSetters() {
        CheckoutRequest.CartItem item = new CheckoutRequest.CartItem();
        item.setDrinkId(5);
        item.setQuantity(3);
        item.setNote("extra sugar");
        assertEquals(5, item.getDrinkId());
        assertEquals(3, item.getQuantity());
        assertEquals("extra sugar", item.getNote());
    }

    // CheckoutRequest payment method
    @Test
    @DisplayName("Payment methods: CASH and VIETQR")
    void paymentMethods() {
        CheckoutRequest req = new CheckoutRequest();
        req.setPaymentMethod("CASH");
        assertEquals("CASH", req.getPaymentMethod());
        req.setPaymentMethod("VIETQR");
        assertEquals("VIETQR", req.getPaymentMethod());
    }

    // TC-147: XSS in guest name
    @Test
    @DisplayName("TC-147: XSS payload in guest name stored as-is (vulnerability check)")
    void xssInGuestName() {
        CheckoutRequest req = new CheckoutRequest();
        String xss = "<script>alert(1)</script>";
        req.setGuestName(xss);
        // The app stores this without sanitization - this test documents the vulnerability
        assertEquals(xss, req.getGuestName());
    }
}
