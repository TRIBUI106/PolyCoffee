package com.poly.lab6.controller;

import com.poly.lab6.dao.BillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/statistic")
public class StatisticServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String from = req.getParameter("from");
        String to = req.getParameter("to");

        BillDAO dao = new BillDAO();
        List<Object[]> list = dao.top5Drinks(from, to);

        req.setAttribute("list", list);

        req.getRequestDispatcher("/manager/statistic.jsp")
                .forward(req, resp);
    }
}
