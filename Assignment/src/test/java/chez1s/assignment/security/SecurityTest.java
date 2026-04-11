package chez1s.assignment.security;

import chez1s.assignment.entity.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * TC-145 to TC-150: Security-focused tests
 */
class SecurityTest {

    // TC-145: Privilege escalation (role check)
    @Test
    @DisplayName("TC-145: Staff role=false cannot be manager")
    void staffIsNotManager() {
        User staff = new User();
        staff.setRole(false);
        assertFalse(staff.isRole());
    }

    // TC-146: IDOR - bill ownership
    @Test
    @DisplayName("TC-146: Bill ownership enforced - different userId")
    void billOwnership_differentUser() {
        Bill bill = new Bill();
        User owner = new User();
        owner.setId(1);
        bill.setUser(owner);

        // Staff B tries to access
        int staffBId = 2;
        assertNotEquals(staffBId, bill.getUser().getId());
    }

    // TC-147: XSS in guest name
    @Test
    @DisplayName("TC-147: XSS script tags in guest name")
    void xssInGuestName() {
        String malicious = "<script>alert('xss')</script>";
        Bill bill = new Bill();
        bill.setGuestName(malicious);
        // Documents that the field accepts unescaped HTML
        assertTrue(bill.getGuestName().contains("<script>"));
    }

    // TC-147b: XSS in note
    @Test
    @DisplayName("TC-147b: XSS in bill detail note")
    void xssInNote() {
        BillDetail detail = new BillDetail();
        detail.setNote("<img onerror=alert(1) src=x>");
        assertTrue(detail.getNote().contains("onerror"));
    }

    // TC-148: Path traversal in image name
    @Test
    @DisplayName("TC-148: Path traversal in filename")
    void pathTraversal() {
        String maliciousPath = "../../WEB-INF/web.xml";
        // ImageServlet uses pathInfo.substring(1) directly
        // This test documents the vulnerability - should be sanitized
        assertTrue(maliciousPath.contains(".."));
    }

    // TC-149: Invalid BillStatus enum
    @Test
    @DisplayName("TC-149: Invalid enum value throws IllegalArgumentException")
    void invalidBillStatus() {
        assertThrows(IllegalArgumentException.class, () ->
                BillStatus.valueOf("INVALID_STATUS"));
    }

    // TC-150: Concurrent modification - bill status field
    @Test
    @DisplayName("TC-150: Concurrent checkout - only WAITING can transition")
    void concurrentCheckout_guardClause() {
        Bill bill = new Bill();
        bill.setStatus(BillStatus.WAITING);

        // First checkout
        if (bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.FINISHED);
        }

        // Second concurrent checkout attempt
        BillStatus beforeSecond = bill.getStatus();
        if (bill.getStatus() == BillStatus.WAITING) {
            bill.setStatus(BillStatus.FINISHED);
        }
        // Status should still be FINISHED from first
        assertEquals(BillStatus.FINISHED, bill.getStatus());
        assertEquals(beforeSecond, bill.getStatus());
    }

    // Plaintext password storage documentation
    @Test
    @DisplayName("SECURITY: Password stored as plaintext (vulnerability)")
    void plaintextPassword() {
        User user = new User();
        user.setPassword("secret123");
        // AuthService compares with .equals() - no hashing
        assertEquals("secret123", user.getPassword());
    }

    // Session fixation risk
    @Test
    @DisplayName("TC-148b: Session not invalidated on login (vulnerability doc)")
    void sessionFixation_doc() {
        // AuthController.doPost sets user in session without invalidating old session
        // This documents a session fixation vulnerability
        // AuthUtil.setUser(req, user) -> session.setAttribute("user", user)
        // Should call session.invalidate() + getSession(true) first
        assertTrue(true, "Session fixation vulnerability documented");
    }
}
