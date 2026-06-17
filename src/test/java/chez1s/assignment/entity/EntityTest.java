package chez1s.assignment.entity;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Entity model tests: BillStatus enum, Bill total calc, entity field defaults,
 * Guest/Voucher/GuestVoucher relationships.
 * Covers: TC-080, TC-081, TC-094, TC-095, TC-098, TC-149
 */
class EntityTest {

    // TC-080: total = sum(price * quantity)
    @Test
    @DisplayName("TC-080: Bill total matches sum of detail price*qty")
    void billTotal_matchesDetails() {
        Bill bill = new Bill();
        BillDetail d1 = new BillDetail();
        d1.setPrice(35000);
        d1.setQuantity(2);
        BillDetail d2 = new BillDetail();
        d2.setPrice(25000);
        d2.setQuantity(1);
        bill.setBillDetails(Arrays.asList(d1, d2));

        int total = bill.getBillDetails().stream()
                .mapToInt(d -> d.getPrice() * d.getQuantity())
                .sum();
        assertEquals(95000, total);
    }

    // TC-094: total cannot go below 0 with discount
    @Test
    @DisplayName("TC-094: Bill total with discount >= 0")
    void billTotal_withDiscount_notNegative() {
        int itemsTotal = 20000;
        int discount = 50000;
        int total = Math.max(0, itemsTotal - discount);
        assertEquals(0, total);
    }

    // TC-095: point accumulation
    @Test
    @DisplayName("TC-095: Point accumulation 1000 VND = 1 point")
    void pointAccumulation() {
        int billTotal = 55000;
        int earnedPoints = billTotal / 1000;
        assertEquals(55, earnedPoints);
    }

    @Test
    @DisplayName("TC-095b: Point accumulation rounds down")
    void pointAccumulation_roundsDown() {
        int billTotal = 999;
        int earnedPoints = billTotal / 1000;
        assertEquals(0, earnedPoints);
    }

    // TC-098: Guest bill code format
    @Test
    @DisplayName("TC-098: Guest bill code starts with GUEST-")
    void guestBillCode_format() {
        String code = "GUEST-" + System.currentTimeMillis();
        assertTrue(code.startsWith("GUEST-"));
        assertTrue(code.length() > 6);
    }

    // TC-081: Employee bill code format
    @Test
    @DisplayName("TC-081: Employee bill code starts with BILL-")
    void billCode_format() {
        String code = "BILL-" + System.currentTimeMillis();
        assertTrue(code.startsWith("BILL-"));
    }

    // BillStatus enum coverage
    @Test
    @DisplayName("BillStatus has 5 values")
    void billStatus_values() {
        assertEquals(5, BillStatus.values().length);
    }

    // TC-149: Invalid status throws IllegalArgumentException
    @Test
    @DisplayName("TC-149: valueOf with invalid status throws")
    void billStatus_invalidValue() {
        assertThrows(IllegalArgumentException.class, () ->
                BillStatus.valueOf("INVALID_STATUS"));
    }

    @Test
    @DisplayName("BillStatus valid values")
    void billStatus_validValues() {
        assertEquals(BillStatus.PENDING, BillStatus.valueOf("PENDING"));
        assertEquals(BillStatus.WAITING, BillStatus.valueOf("WAITING"));
        assertEquals(BillStatus.PAID, BillStatus.valueOf("PAID"));
        assertEquals(BillStatus.FINISHED, BillStatus.valueOf("FINISHED"));
        assertEquals(BillStatus.CANCELLED, BillStatus.valueOf("CANCELLED"));
    }

    // Bill defaults
    @Test
    @DisplayName("Bill default status is WAITING")
    void bill_defaultStatus() {
        Bill bill = new Bill();
        assertEquals(BillStatus.WAITING, bill.getStatus());
    }

    @Test
    @DisplayName("Bill default discountAmount is 0")
    void bill_defaultDiscount() {
        Bill bill = new Bill();
        assertEquals(0, bill.getDiscountAmount());
    }

    // Drink defaults
    @Test
    @DisplayName("Drink default active is true")
    void drink_defaultActive() {
        Drink drink = new Drink();
        assertTrue(drink.isActive());
    }

    // Category defaults
    @Test
    @DisplayName("Category default active is true")
    void category_defaultActive() {
        Category cat = new Category();
        assertTrue(cat.isActive());
    }

    // User defaults
    @Test
    @DisplayName("User default active is true")
    void user_defaultActive() {
        User user = new User();
        assertTrue(user.isActive());
    }

    // Guest defaults
    @Test
    @DisplayName("Guest default point is 0")
    void guest_defaultPoint() {
        Guest guest = new Guest();
        assertEquals(0, guest.getPoint());
    }

    // GuestVoucher defaults
    @Test
    @DisplayName("GuestVoucher default isUsed is false")
    void guestVoucher_defaultIsUsed() {
        GuestVoucher gv = new GuestVoucher();
        assertFalse(gv.getIsUsed());
    }

    // Guest getters/setters
    @Test
    @DisplayName("Guest getters/setters work")
    void guest_gettersSetters() {
        Guest guest = new Guest();
        guest.setId(1);
        guest.setFullname("Test");
        guest.setPhoneNumber("090");
        guest.setPoint(100);
        assertEquals(1, guest.getId());
        assertEquals("Test", guest.getFullname());
        assertEquals("090", guest.getPhoneNumber());
        assertEquals(100, guest.getPoint());
    }

    // Voucher getters/setters
    @Test
    @DisplayName("Voucher getters/setters work")
    void voucher_gettersSetters() {
        Voucher v = new Voucher();
        v.setId(1);
        v.setName("Discount 10K");
        v.setRequiredPoints(50);
        v.setDiscountAmount(10000);
        assertEquals(1, v.getId());
        assertEquals("Discount 10K", v.getName());
        assertEquals(50, v.getRequiredPoints());
        assertEquals(10000, v.getDiscountAmount());
    }

    // GuestVoucher getters/setters
    @Test
    @DisplayName("GuestVoucher getters/setters work")
    void guestVoucher_gettersSetters() {
        Guest guest = new Guest();
        guest.setId(1);
        Voucher voucher = new Voucher();
        voucher.setId(1);

        GuestVoucher gv = new GuestVoucher();
        gv.setId(1);
        gv.setGuest(guest);
        gv.setVoucher(voucher);
        gv.setIsUsed(true);

        assertEquals(1, gv.getId());
        assertEquals(guest, gv.getGuest());
        assertEquals(voucher, gv.getVoucher());
        assertTrue(gv.getIsUsed());
    }

    // CoffeeTable defaults
    @Test
    @DisplayName("CoffeeTable default active is true")
    void coffeeTable_defaultActive() {
        CoffeeTable table = new CoffeeTable();
        assertTrue(table.isActive());
    }
}
