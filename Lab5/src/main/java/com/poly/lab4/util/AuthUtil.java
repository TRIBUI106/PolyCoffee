package com.poly.lab4.util;

import com.poly.lab4.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AuthUtil {

    private static final String USER_SESSION = "user";

    public static void setUser(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setAttribute(USER_SESSION, user);
    }

    public static User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if(session == null) return null;

        return (User) session.getAttribute(USER_SESSION);
    }

    public static boolean isAuthenticated(HttpServletRequest request) {
        return getUser(request) != null;
    }

    public static boolean isManager(HttpServletRequest request) {

        User user = getUser(request);

        if(user == null) return false;

        return "manager".equalsIgnoreCase(user.getRole())
                || "admin".equalsIgnoreCase(user.getRole());
    }

    public static void clear(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if(session != null){
            session.invalidate();
        }
    }
}
