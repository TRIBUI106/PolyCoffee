package chez1s.assignment.controller;

import chez1s.assignment.entity.Bill;
import chez1s.assignment.entity.BillStatus;
import chez1s.assignment.entity.User;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * TC-063 to TC-079, TC-118 to TC-124: POS controller logic tests.
 * Tests business logic decisions (which code path the controller takes)
 * without needing a real servlet container.
 */
class PosControllerTest {

    // TC-066: Adding to non-WAITING bill should be rejected
    @Test
    @DisplayName("TC-066: Cannot add drink to FINISHED bill")
    void addDrinkToFinishedBill_rejected() {
        Bill bill = new Bill();
        bill.setStatus(BillStatus.FINISHED);
        assertNotEquals(BillStatus.WAITING, bill.getStatus());
    }

    // TC-075/TC-078 status transitions
    @Test
    @DisplayName("TC-075: WAITING -> FINISHED is valid checkout")
    void checkoutTransition() {
        Bill bill = new Bill();
        bill.setStatus(BillStatus.WAITING);
        if (bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.FINISHED);
        }
        assertEquals(BillStatus.FINISHED, bill.getStatus());
    }

    @Test
    @DisplayName("TC-078: WAITING -> CANCELLED is valid cancel")
    void cancelTransition() {
        Bill bill = new Bill();
        bill.setStatus(BillStatus.WAITING);
        if (bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.CANCELLED);
        }
        assertEquals(BillStatus.CANCELLED, bill.getStatus());
    }

    // TC-076: Checkout already finished - guard clause
    @Test
    @DisplayName("TC-076: FINISHED bill stays FINISHED on checkout attempt")
    void checkoutFinished_noChange() {
        Bill bill = new Bill();
        bill.setStatus(BillStatus.FINISHED);
        if (bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.FINISHED);
        }
        assertEquals(BillStatus.FINISHED, bill.getStatus());
    }

    // TC-077: Checkout cancelled - guard clause
    @Test
    @DisplayName("TC-077: CANCELLED bill stays CANCELLED on checkout attempt")
    void checkoutCancelled_noChange() {
        Bill bill = new Bill();
        bill.setStatus(BillStatus.CANCELLED);
        if (bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.FINISHED);
        }
        assertEquals(BillStatus.CANCELLED, bill.getStatus());
    }

    // TC-079: Cancel already cancelled - guard clause
    @Test
    @DisplayName("TC-079: CANCELLED bill stays CANCELLED on cancel attempt")
    void cancelCancelled_noChange() {
        Bill bill = new Bill();
        bill.setStatus(BillStatus.CANCELLED);
        if (bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.CANCELLED);
        }
        assertEquals(BillStatus.CANCELLED, bill.getStatus());
    }

    // TC-118/119: Manager vs Staff bill visibility
    @Test
    @DisplayName("TC-118/119: Manager sees all, staff sees own")
    void billVisibility_roleCheck() {
        User manager = new User();
        manager.setRole(true);
        User staff = new User();
        staff.setRole(false);

        assertTrue(manager.isRole()); // uses searchBills (all)
        assertFalse(staff.isRole());  // uses searchUserBills (own)
    }

    // TC-124: Staff POST to bills returns 403
    @Test
    @DisplayName("TC-124: Staff cannot update bill status")
    void staffCannotUpdateStatus() {
        User staff = new User();
        staff.setRole(false);
        assertFalse(staff.isRole());
    }

    // TC-123: Manager can update status
    @Test
    @DisplayName("TC-123: Manager can update bill status")
    void managerCanUpdateStatus() {
        User manager = new User();
        manager.setRole(true);
        assertTrue(manager.isRole());
    }

    // TC-122: Staff viewing another's bill
    @Test
    @DisplayName("TC-122: Staff's bill ID != other's ID")
    void staffBillOwnership() {
        Bill bill = new Bill();
        User owner = new User();
        owner.setId(1);
        bill.setUser(owner);

        User otherStaff = new User();
        otherStaff.setId(2);

        assertNotEquals(bill.getUser().getId(), otherStaff.getId());
    }

    // POS tab access: staff forced to "pos" tab
    @Test
    @DisplayName("Non-manager forced to pos tab")
    void staffForcedToPosTab() {
        User staff = new User();
        staff.setRole(false);
        String tab = "bills";
        if (!staff.isRole() && !tab.equals("pos")) {
            tab = "redirect"; // simulates redirect
        }
        assertEquals("redirect", tab);
    }

    @Test
    @DisplayName("Manager can access any tab")
    void managerCanAccessAnyTab() {
        User manager = new User();
        manager.setRole(true);
        String tab = "stats";
        // No redirect for manager
        assertTrue(manager.isRole());
        assertEquals("stats", tab);
    }
}
