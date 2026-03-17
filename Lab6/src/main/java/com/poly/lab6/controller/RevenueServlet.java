package com.poly.lab6.controller;

import com.poly.lab6.dao.RevenueDAO;
import com.poly.lab6.entity.Revenue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/revenue")
public class RevenueServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String from = req.getParameter("from");
        String to = req.getParameter("to");

        RevenueDAO dao = new RevenueDAO();
        List<Revenue> list = dao.getRevenue(from, to);

        req.setAttribute("list", list);

        req.getRequestDispatcher("/manager/revenue.jsp")
                .forward(req, resp);
    }
}
