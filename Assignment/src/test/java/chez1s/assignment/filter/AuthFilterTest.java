package chez1s.assignment.filter;

import chez1s.assignment.entity.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import static org.mockito.Mockito.*;

/**
 * TC-009 to TC-015, TC-030, TC-042, TC-062, TC-124, TC-132, TC-145: AuthFilter tests
 */
@ExtendWith(MockitoExtension.class)
class AuthFilterTest {

    private AuthFilter filter;
    private HttpServletRequest req;
    private HttpServletResponse resp;
    private FilterChain chain;
    private HttpSession session;

    @BeforeEach
    void setUp() {
        filter = new AuthFilter();
        req = mock(HttpServletRequest.class);
        resp = mock(HttpServletResponse.class);
        chain = mock(FilterChain.class);
        session = mock(HttpSession.class);
    }

    // TC-009
    @Test
    @DisplayName("TC-009: Unauthenticated access to /employee/* redirects to login")
    void unauthenticated_employee_redirects() throws Exception {
        when(req.getServletPath()).thenReturn("/employee/pos");
        when(req.getSession(false)).thenReturn(null);
        when(req.getSession()).thenReturn(session);
        when(req.getRequestURI()).thenReturn("/employee/pos");
        when(req.getQueryString()).thenReturn(null);
        when(req.getContextPath()).thenReturn("");

        filter.doFilter(req, resp, chain);

        verify(resp).sendRedirect("/auth/login");
        verify(chain, never()).doFilter(any(), any());
    }

    // TC-010
    @Test
    @DisplayName("TC-010: Unauthenticated access to /manager/* redirects to login")
    void unauthenticated_manager_redirects() throws Exception {
        when(req.getServletPath()).thenReturn("/manager/bills");
        when(req.getSession(false)).thenReturn(null);
        when(req.getSession()).thenReturn(session);
        when(req.getRequestURI()).thenReturn("/manager/bills");
        when(req.getQueryString()).thenReturn(null);
        when(req.getContextPath()).thenReturn("");

        filter.doFilter(req, resp, chain);

        verify(resp).sendRedirect("/auth/login");
    }

    // TC-011
    @Test
    @DisplayName("TC-011: Authenticated staff accesses /employee/*")
    void authenticated_staff_employee_allowed() throws Exception {
        User staff = new User();
        staff.setRole(false);
        when(req.getServletPath()).thenReturn("/employee/pos");
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(staff);

        filter.doFilter(req, resp, chain);

        verify(chain).doFilter(req, resp);
    }

    // TC-012
    @Test
    @DisplayName("TC-012: Staff blocked from /manager/*")
    void staff_manager_forbidden() throws Exception {
        User staff = new User();
        staff.setRole(false);
        when(req.getServletPath()).thenReturn("/manager/staff");
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(staff);

        filter.doFilter(req, resp, chain);

        verify(resp).sendError(eq(HttpServletResponse.SC_FORBIDDEN), anyString());
        verify(chain, never()).doFilter(any(), any());
    }

    // TC-013
    @Test
    @DisplayName("TC-013: Manager accesses /manager/*")
    void manager_manager_allowed() throws Exception {
        User manager = new User();
        manager.setRole(true);
        when(req.getServletPath()).thenReturn("/manager/staff");
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(manager);

        filter.doFilter(req, resp, chain);

        verify(chain).doFilter(req, resp);
    }

    // TC-014
    @Test
    @DisplayName("TC-014: AuthFilter stores redirect URL with query string")
    void storesRedirectUrl_withQuery() throws Exception {
        when(req.getServletPath()).thenReturn("/employee/pos");
        when(req.getSession(false)).thenReturn(null);
        when(req.getSession()).thenReturn(session);
        when(req.getRequestURI()).thenReturn("/employee/pos");
        when(req.getQueryString()).thenReturn("billId=5");
        when(req.getContextPath()).thenReturn("");

        filter.doFilter(req, resp, chain);

        verify(session).setAttribute("REDIRECT_URL", "/employee/pos?billId=5");
    }

    // TC-145
    @Test
    @DisplayName("TC-145: Staff privilege escalation to /manager/categories blocked")
    void staff_managerCategories_forbidden() throws Exception {
        User staff = new User();
        staff.setRole(false);
        when(req.getServletPath()).thenReturn("/manager/categories");
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(staff);

        filter.doFilter(req, resp, chain);

        verify(resp).sendError(eq(HttpServletResponse.SC_FORBIDDEN), anyString());
    }

    // TC-145b
    @Test
    @DisplayName("TC-145b: Staff privilege escalation to /manager/statistics blocked")
    void staff_managerStatistics_forbidden() throws Exception {
        User staff = new User();
        staff.setRole(false);
        when(req.getServletPath()).thenReturn("/manager/statistics");
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(staff);

        filter.doFilter(req, resp, chain);

        verify(resp).sendError(eq(HttpServletResponse.SC_FORBIDDEN), anyString());
    }

    // TC-013b: Manager on /employee/* also allowed
    @Test
    @DisplayName("Manager can access /employee/*")
    void manager_employee_allowed() throws Exception {
        User manager = new User();
        manager.setRole(true);
        when(req.getServletPath()).thenReturn("/employee/pos");
        when(req.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(manager);

        filter.doFilter(req, resp, chain);

        verify(chain).doFilter(req, resp);
    }
}
