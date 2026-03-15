package com.poly.lab4.filter;

import com.poly.lab4.util.AuthUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;
@WebFilter("/manager/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        if(!AuthUtil.isAuthenticated(req)){

            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if(!AuthUtil.isManager(req)){

            resp.sendRedirect(req.getContextPath() + "/access-denied");
            return;
        }

        chain.doFilter(request, response);
    }
}
