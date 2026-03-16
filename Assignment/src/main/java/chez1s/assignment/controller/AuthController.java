package chez1s.assignment.controller;

import chez1s.assignment.entity.User;
import chez1s.assignment.service.AuthService;
import chez1s.assignment.util.AuthUtil;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/auth/login", "/auth/logout"})
public class AuthController extends HttpServlet {
    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/logout")) {
            AuthUtil.clear(req);
            resp.sendRedirect(req.getContextPath() + "/auth/login");
        } else {
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = ParamUtil.getString(req, "email");
        String password = ParamUtil.getString(req, "password");

        User user = authService.login(email, password);
        if (user != null) {
            AuthUtil.setUser(req, user);
            String redirectUrl = (String) req.getSession().getAttribute("REDIRECT_URL");
            if (redirectUrl == null) {
                redirectUrl = req.getContextPath() + (user.isRole() ? "/manager/statistics" : "/employee/pos");
            }
            req.getSession().removeAttribute("REDIRECT_URL");
            resp.sendRedirect(redirectUrl);
        } else {
            req.setAttribute("errorKey", "login.error");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }
}
