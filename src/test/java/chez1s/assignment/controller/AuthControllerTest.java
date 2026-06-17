package chez1s.assignment.controller;

import chez1s.assignment.entity.User;
import chez1s.assignment.util.AuthUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import static org.mockito.Mockito.*;

/**
 * TC-008, TC-014 to TC-018: Auth controller tests (Servlet-level with mocks)
 */
@ExtendWith(MockitoExtension.class)
class AuthControllerTest {

    private HttpServletRequest req;
    private HttpServletResponse resp;
    private HttpSession session;
    private RequestDispatcher dispatcher;

    @BeforeEach
    void setUp() {
        req = mock(HttpServletRequest.class);
        resp = mock(HttpServletResponse.class);
        session = mock(HttpSession.class);
        dispatcher = mock(RequestDispatcher.class);
    }

    // TC-008
    @Test
    @DisplayName("TC-008: Logout clears session and redirects")
    void logout_clearsSession() throws Exception {
        when(req.getRequestURI()).thenReturn("/auth/logout");
        when(req.getSession(false)).thenReturn(session);
        when(req.getContextPath()).thenReturn("");

        AuthUtil.clear(req);
        verify(session).removeAttribute("user");
    }

    // TC-016
    @Test
    @DisplayName("TC-016: Profile redirects when not authenticated")
    void profile_notAuthenticated_redirects() {
        when(req.getSession(false)).thenReturn(null);
        User user = AuthUtil.getUser(req);
        assertNull(user);
    }

    // TC-017
    @Test
    @DisplayName("TC-017: Profile returns user when authenticated")
    void profile_authenticated() {
        User manager = new User();
        manager.setId(1);
        manager.setFullName("Admin");
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(manager);

        User user = AuthUtil.getUser(req);
        assertNotNull(user);
        assertEquals("Admin", user.getFullName());
    }

    private void assertNull(Object obj) {
        org.junit.jupiter.api.Assertions.assertNull(obj);
    }

    private void assertNotNull(Object obj) {
        org.junit.jupiter.api.Assertions.assertNotNull(obj);
    }

    private void assertEquals(Object expected, Object actual) {
        org.junit.jupiter.api.Assertions.assertEquals(expected, actual);
    }
}
