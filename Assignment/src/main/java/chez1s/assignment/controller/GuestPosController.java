package chez1s.assignment.controller;

import chez1s.assignment.entity.Bill;
import chez1s.assignment.service.BillService;
import chez1s.assignment.service.DrinkService;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Public POS for Guest users (no authentication required).
 * URL mappings:
 *   /guest/pos               – render UI
 *   /guest/pos/add           – create a new bill (status = PENDING)
 *   /guest/pos/drinks        – lazy‑load drinks by category (JSON)
 *   /guest/pos/accept        – employee accepts a pending bill (POST)
 */
@WebServlet({"/guest/pos", "/guest/pos/add", "/guest/pos/drinks", "/guest/pos/accept"})
public class GuestPosController extends HttpServlet {

    private final BillService billService = new BillService();
    private final DrinkService drinkService = new DrinkService();
    private final chez1s.assignment.service.CategoryService categoryService = new chez1s.assignment.service.CategoryService();
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        // -------------------------------------------------
        // 1️⃣ Render guest POS UI
        // -------------------------------------------------
        if (uri.equals(req.getContextPath() + "/guest/pos")) {
            req.setAttribute("categories", categoryService.getAllCategories());
            // initial drinks (fallback) – will be replaced by lazy loading
            req.setAttribute("drinks", drinkService.getActiveDrinks());
            req.getRequestDispatcher("/views/guest/pos.jsp")
               .forward(req, resp);
            return;
        }

        // -------------------------------------------------
        // 2️⃣ Lazy‑load drinks for a category (JSON)
        // -------------------------------------------------
        if (uri.equals(req.getContextPath() + "/guest/pos/drinks")) {
            Integer catId = ParamUtil.getInt(req, "catId");
            List<chez1s.assignment.entity.Drink> allDrinks = drinkService.getActiveDrinks();
            List<chez1s.assignment.entity.Drink> matched = new java.util.ArrayList<>();
            for (chez1s.assignment.entity.Drink d : allDrinks) {
                if (catId == null || catId == 0 || (d.getCategory() != null && d.getCategory().getId().equals(catId))) {
                    matched.add(d);
                }
            }
            
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            // Generate JSON manually to avoid Gson dependency
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < matched.size(); i++) {
                chez1s.assignment.entity.Drink d = matched.get(i);
                json.append("{")
                    .append("\"id\":").append(d.getId()).append(",")
                    .append("\"name\":\"").append(d.getName().replace("\"", "\\\"")).append("\",")
                    .append("\"price\":").append(d.getPrice()).append(",")
                    .append("\"image\":\"").append(d.getImage() != null ? d.getImage().replace("\"", "\\\"") : "").append("\"")
                    .append("}");
                if (i < matched.size() - 1) json.append(",");
            }
            json.append("]");
            
            resp.getWriter().write(json.toString());
            return;
        }

        // -------------------------------------------------
        // 3️⃣ Add a drink to a new guest bill (creates PENDING bill)
        // -------------------------------------------------
        if (uri.contains("/add")) {
            Integer drinkId = ParamUtil.getInt(req, "drinkId");
            String guestName = ParamUtil.getString(req, "guestName");
            String guestPhone = ParamUtil.getString(req, "guestPhone");
            Integer newBillId = billService.createGuestBill(guestName, guestPhone, drinkId);
            resp.sendRedirect(req.getContextPath() + "/guest/pos?billId=" + newBillId);
            return;
        }

        // fallback – 404
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    // -------------------------------------------------
    // POST – employee accepts a pending bill (status → PAID)
    // -------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/accept")) {
            Integer billId = ParamUtil.getInt(req, "billId");
            billService.acceptBill(billId);
            resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
