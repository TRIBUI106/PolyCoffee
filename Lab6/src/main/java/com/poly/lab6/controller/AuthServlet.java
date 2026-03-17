package com.poly.lab6.controller;

import com.poly.lab6.dao.AuthDAO;
import com.poly.lab6.entity.User;
import com.poly.lab6.util.AuthUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/login")
public class AuthServlet extends HttpServlet {

    AuthDAO dao = new AuthDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/auth/login.jsp")
                .forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = dao.findByEmail(email);

        if(user != null && user.getPassword().equals(password)){

            AuthUtil.setUser(request,user);

            response.sendRedirect(request.getContextPath() + "/manager/category");

        }else{

            request.setAttribute("error","Sai tài khoản hoặc mật khẩu");

            request.getRequestDispatcher("/auth/login.jsp")
                    .forward(request,response);
        }
    }
}