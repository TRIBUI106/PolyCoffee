package com.poly.lab4.controller;


import com.poly.lab4.dao.CategoryDAO;
import com.poly.lab4.entity.Category;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/manager/category")
public class CategoryServlet extends HttpServlet {

    CategoryDAO dao = new CategoryDAO();

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
        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        String name = req.getParameter("name");
        // --- BƯỚC KIỂM TRA (VALIDATION) ---
        if (("add".equals(action) || "update".equals(action)) && (name == null || name.trim().isEmpty())) {
            req.setAttribute("errorMessage", "⚠️ Tên danh mục không được để trống!");

            req.getRequestDispatcher("/manager/category.jsp").forward(req, resp);
            return;
        }
        // --- LUỒNG XỬ LÝ CHÍNH ---
        switch (action) {
            case "add":
                add(req, resp);
                break;
            case "update":
                update(req, resp);
                break;
            case "delete":
                break;
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Category> list = dao.findAll();

        req.setAttribute("list", list);

        req.getRequestDispatcher("/manager/category.jsp")
                .forward(req,resp);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập tên danh mục!");

            req.getRequestDispatcher("/manager/category.jsp").forward(req,resp);
        }
        Category c = new Category();

        c.setName(req.getParameter("name"));

        dao.insert(c);

        resp.sendRedirect("category");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Category c = new Category();

        c.setId(Integer.parseInt(req.getParameter("id")));
        c.setName(req.getParameter("name"));

        dao.update(c);

        resp.sendRedirect("category");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        dao.delete(id);

        resp.sendRedirect("category");
    }

    private void edit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        Category c = dao.findById(id);

        req.setAttribute("category", c);

        list(req, resp);
    }

}

