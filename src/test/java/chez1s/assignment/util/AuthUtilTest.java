package chez1s.assignment.util;

import chez1s.assignment.entity.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * TC-139 to TC-144: Utility tests
 */
@ExtendWith(MockitoExtension.class)
class AuthUtilTest {

    private HttpServletRequest req;
    private HttpSession session;
    private User manager;
    private User staff;

    @BeforeEach
    void setUp() {
        req = mock(HttpServletRequest.class);
        session = mock(HttpSession.class);

        manager = new User();
        manager.setId(1);
        manager.setRole(true);

        staff = new User();
        staff.setId(2);
        staff.setRole(false);
    }

    // TC-139
    @Test
    @DisplayName("TC-139: setUser stores and getUser retrieves")
    void setUser_getUser() {
        when(req.getSession()).thenReturn(session);
        AuthUtil.setUser(req, manager);
        verify(session).setAttribute("user", manager);
    }

    // TC-140
    @Test
    @DisplayName("TC-140: isAuthenticated false when no session")
    void isAuthenticated_noSession() {
        when(req.getSession(false)).thenReturn(null);
        assertFalse(AuthUtil.isAuthenticated(req));
    }

    @Test
    @DisplayName("TC-140b: isAuthenticated false when session has no user")
    void isAuthenticated_noUser() {
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(null);
        assertFalse(AuthUtil.isAuthenticated(req));
    }

    @Test
    @DisplayName("TC-140c: isAuthenticated true when user present")
    void isAuthenticated_withUser() {
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(manager);
        assertTrue(AuthUtil.isAuthenticated(req));
    }

    // TC-141
    @Test
    @DisplayName("TC-141: isManager true for role=true")
    void isManager_true() {
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(manager);
        assertTrue(AuthUtil.isManager(req));
    }

    // TC-142
    @Test
    @DisplayName("TC-142: isManager false for staff")
    void isManager_false() {
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(staff);
        assertFalse(AuthUtil.isManager(req));
    }

    @Test
    @DisplayName("isManager false when no session")
    void isManager_noSession() {
        when(req.getSession(false)).thenReturn(null);
        assertFalse(AuthUtil.isManager(req));
    }

    // TC-008
    @Test
    @DisplayName("TC-008: clear removes user from session")
    void clear_removesUser() {
        when(req.getSession(false)).thenReturn(session);
        AuthUtil.clear(req);
        verify(session).removeAttribute("user");
    }

    @Test
    @DisplayName("clear with no session does not throw")
    void clear_noSession() {
        when(req.getSession(false)).thenReturn(null);
        assertDoesNotThrow(() -> AuthUtil.clear(req));
    }
}
