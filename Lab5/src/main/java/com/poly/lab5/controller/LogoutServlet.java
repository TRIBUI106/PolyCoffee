package com.poly.lab5.controller;

import com.poly.lab5.util.AuthUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        AuthUtil.clear(request);

        response.sendRedirect(request.getContextPath() + "/login");
    }
}
