package chez1s.assignment.controller;

import chez1s.assignment.entity.Bill;
import chez1s.assignment.entity.CoffeeTable;
import chez1s.assignment.service.BillService;
import chez1s.assignment.service.DrinkService;
import chez1s.assignment.service.CategoryService;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/guest/pos", "/guest/pos/drinks", "/guest/pos/checkout", "/guest/pos/accept"})
public class GuestPosController extends HttpServlet {

    private final BillService billService = new BillService();
    private final DrinkService drinkService = new DrinkService();
    private final CategoryService categoryService = new CategoryService();
    private final com.google.gson.Gson gson = new com.google.gson.Gson();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        // 1️⃣ Render guest POS UI
        if (uri.equals(req.getContextPath() + "/guest/pos")) {
            req.setAttribute("categories", categoryService.getAllCategories());
            req.setAttribute("drinks", drinkService.getActiveDrinks());
            
            // Handle table session
            String tableIdStr = req.getParameter("tableId");
            if (tableIdStr != null) {
                req.getSession().setAttribute("tableId", tableIdStr);
            }
            
            req.getRequestDispatcher("/views/guest/pos.jsp").forward(req, resp);
            return;
        }

        // 2️⃣ Lazy‑load drinks (JSON)
        if (uri.equals(req.getContextPath() + "/guest/pos/drinks")) {
            Integer catId = ParamUtil.getInt(req, "catId");
            List<chez1s.assignment.entity.Drink> matched = drinkService.getActiveDrinks().stream()
                    .filter(d -> catId == null || catId == 0 || (d.getCategory() != null && d.getCategory().getId().equals(catId)))
                    .toList();
            
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(gson.toJson(matched));
            return;
        }

        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String uri = req.getRequestURI();
        
        // 3️⃣ Checkout (JSON)
        if (uri.equals(req.getContextPath() + "/guest/pos/checkout")) {
            try {
                chez1s.assignment.dto.CheckoutRequest checkoutRequest = gson.fromJson(req.getReader(), chez1s.assignment.dto.CheckoutRequest.class);
                if (checkoutRequest.getTableId() == null) {
                    Object sessionTableId = req.getSession().getAttribute("tableId");
                    if (sessionTableId != null) {
                        checkoutRequest.setTableId(Integer.parseInt(sessionTableId.toString()));
                    }
                }
                
                chez1s.assignment.entity.Bill bill = billService.checkoutGuestBill(checkoutRequest);
                
                resp.setContentType("application/json");
                resp.getWriter().write("{\"success\":true,\"billId\":" + bill.getId() + ",\"billCode\":\"" + bill.getCode() + "\",\"total\":" + bill.getTotal() + "}");
            } catch (Exception e) {
                resp.setStatus(500);
                resp.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
            }
            return;
        }

        if (uri.contains("/accept")) {
            Integer billId = ParamUtil.getInt(req, "billId");
            billService.acceptBill(billId);
            resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
