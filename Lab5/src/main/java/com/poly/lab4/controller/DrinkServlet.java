package com.poly.lab4.controller;


import com.poly.lab4.dao.DrinkDAO;
import com.poly.lab4.entity.Drink;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/manager/drink")
public class DrinkServlet extends HttpServlet {

    DrinkDAO dao = new DrinkDAO();

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

        List<Drink> list = dao.findAll();

        req.setAttribute("list", list);

        req.getRequestDispatcher("/manager/drink.jsp")
                .forward(req,resp);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Drink d = new Drink();

        d.setName(req.getParameter("name"));
        d.setPrice(Double.parseDouble(req.getParameter("price")));
        d.setImage(req.getParameter("image"));
        d.setCategoryId(Integer.parseInt(req.getParameter("category")));

        dao.insert(d);

        resp.sendRedirect("drink");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Drink d = new Drink();

        d.setId(Integer.parseInt(req.getParameter("id")));
        d.setName(req.getParameter("name"));
        d.setPrice(Double.parseDouble(req.getParameter("price")));
        d.setImage(req.getParameter("image"));
        d.setCategoryId(Integer.parseInt(req.getParameter("category")));

        dao.update(d);

        resp.sendRedirect("drink");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        dao.delete(id);

        resp.sendRedirect("drink");
    }
    private void edit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        Drink d = dao.findById(id);

        req.setAttribute("drink", d);

        list(req, resp);
    }

}
