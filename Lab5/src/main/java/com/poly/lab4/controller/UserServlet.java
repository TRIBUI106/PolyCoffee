package com.poly.lab4.controller;

import com.poly.lab4.dao.UserDAO;
import com.poly.lab4.entity.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/manager/user")
public class UserServlet extends HttpServlet {

    UserDAO dao = new UserDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if(action == null) action = "list";

        switch (action){

            case "delete":
                delete(req,resp);
                break;

            case "edit":
                edit(req,resp);
                break;

            default:
                list(req,resp);
        }

    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        switch (action){

            case "add":
                add(req,resp);
                break;

            case "update":
                update(req,resp);
                break;
        }
    }


    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<User> list = dao.findAll();

        req.setAttribute("list", list);

        req.getRequestDispatcher("/manager/user.jsp")
                .forward(req,resp);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        User u = new User();

        u.setUsername(req.getParameter("username"));
        u.setPassword(req.getParameter("password"));
        u.setFullname(req.getParameter("fullname"));
        u.setRole(req.getParameter("role"));
        u.setEmail(req.getParameter("email"));

        dao.insert(u);

        resp.sendRedirect("user");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        dao.delete(id);

        resp.sendRedirect("user");
    }
    private void edit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        User u = dao.findById(id);

        req.setAttribute("user", u);

        list(req,resp);
    }


    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        User u = new User();

        u.setId(Integer.parseInt(req.getParameter("id")));
        u.setUsername(req.getParameter("username"));
        u.setPassword(req.getParameter("password"));
        u.setFullname(req.getParameter("fullname"));
        u.setRole(req.getParameter("role"));
        u.setEmail(req.getParameter("email"));

        dao.update(u);

        resp.sendRedirect("user");
    }

}

