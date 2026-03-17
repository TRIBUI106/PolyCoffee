package com.poly.lab6.controller;

import com.poly.lab6.dao.BillDAO;
import com.poly.lab6.dao.BillDetailDAO;
import com.poly.lab6.entity.Bill;
import com.poly.lab6.entity.BillDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/manager/bill")
public class BillServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAO();
    private BillDetailDAO detailDAO = new BillDetailDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "detail":
                showDetail(req, resp);
                break;

            case "cancel":
                cancel(req, resp);
                break;

            default:
                list(req, resp);
                break;
        }

    }

    // ================= LIST =================
    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int page = 1;

        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }

        int limit = 10;

        List<Bill> list = billDAO.findAll(page, limit);

        System.out.println("SIZE = " + list.size());
        req.setAttribute("list", list);
        req.setAttribute("page", page);

        req.getRequestDispatcher("/manager/bills.jsp")
                .forward(req, resp);
    }

    // ================= DETAIL =================
    private void showDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        List<BillDetail> details = detailDAO.findByBill(id);

        req.setAttribute("details", details);

        req.getRequestDispatcher("/manager/bill-detail.jsp")
                .forward(req, resp);
    }

    // ================= CANCEL =================
    private void cancel(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        billDAO.cancel(id);

        resp.sendRedirect("bill?action=list");
    }


}
