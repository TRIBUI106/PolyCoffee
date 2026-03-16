package chez1s.assignment.filter;

import chez1s.assignment.util.AuthUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter({ "/manager/*", "/employee/*" })
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String path = req.getServletPath();

        if (!AuthUtil.isAuthenticated(req)) {
            // Store the full URI (including query string if needed) for post-login redirect
            String uri = req.getRequestURI();
            String query = req.getQueryString();
            if (query != null) uri += "?" + query;
            
            req.getSession().setAttribute("REDIRECT_URL", uri);
            res.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        if (path.startsWith("/manager/") && !AuthUtil.isManager(req)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Managers Only");
            return;
        }

        chain.doFilter(req, res);
    }
}
