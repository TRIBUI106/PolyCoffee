package chez1s.assignment.controller;

import chez1s.assignment.entity.Bill;
import chez1s.assignment.entity.User;
import chez1s.assignment.service.BillService;
import chez1s.assignment.service.CategoryService;
import chez1s.assignment.service.DrinkService;
import chez1s.assignment.util.AuthUtil;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/employee/pos", "/employee/pos/add", "/employee/pos/update", "/employee/pos/note", "/employee/pos/checkout", "/employee/pos/cancel"})
public class PosController extends HttpServlet {
    private final BillService billService = new BillService();
    private final DrinkService drinkService = new DrinkService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        Integer billId = ParamUtil.getInt(req, "billId");
        User user = AuthUtil.getUser(req);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        if (uri.contains("/add")) {
            Integer drinkId = ParamUtil.getInt(req, "drinkId");
            if (drinkId > 0) {
                Integer newBillId = billService.addDrinkToBill(billId, user.getId(), drinkId, user);
                resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + (newBillId > 0 ? newBillId : ""));
            } else {
                resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + (billId > 0 ? billId : ""));
            }
            return;
        }

        if (uri.contains("/update")) {
            Integer drinkId = ParamUtil.getInt(req, "drinkId");
            int quantity = ParamUtil.getInt(req, "quantity");
            if (billId > 0 && drinkId > 0) {
                billService.updateQuantity(billId, drinkId, quantity);
            }
            resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + (billId > 0 ? billId : ""));
            return;
        }

        if (uri.contains("/note")) {
            Integer drinkId = ParamUtil.getInt(req, "drinkId");
            String note = ParamUtil.getString(req, "note");
            if (billId > 0 && drinkId > 0) {
                billService.updateNote(billId, drinkId, note);
            }
            resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + (billId > 0 ? billId : ""));
            return;
        }

        if (uri.contains("/checkout")) {
            if (billId > 0) billService.checkout(billId);
            resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId + "&checkout=true");
            return;
        }

        if (uri.contains("/cancel")) {
            if (billId > 0) billService.cancel(billId);
            resp.sendRedirect(req.getContextPath() + "/employee/pos");
            return;
        }

        // Default: View POS
        String tab = ParamUtil.getString(req, "tab");
        if (tab.isEmpty()) tab = "pos";
        req.setAttribute("activeTab", tab);
        
        req.setAttribute("drinks", drinkService.getActiveDrinks());
        req.setAttribute("categories", categoryService.getAllCategories());
        
        // Populate specific data for management tabs if User is Manager
        if (user.isRole()) { // Role == true (Manager)
            switch (tab) {
                case "drinks":
                    req.setAttribute("allDrinks", drinkService.getAllDrinks());
                    break;
                case "categories":
                    // categories already fetched
                    break;
                case "users":
                    req.setAttribute("staffList", new chez1s.assignment.service.StaffService().getAllStaff());
                    break;
                case "bills":
                    req.setAttribute("billHistory", billService.getAllBills());
                    break;
                case "stats":
                    chez1s.assignment.service.StatisticService statService = new chez1s.assignment.service.StatisticService();
                    req.setAttribute("topDrinks", statService.getTopSellingDrinks(null, null));
                    req.setAttribute("revenueReport", statService.getRevenueReport(null, null));
                    break;
            }
        } else {
            // Force non-managers to stay on pos tab
            if (!tab.equals("pos")) {
                resp.sendRedirect(req.getContextPath() + "/employee/pos");
                return;
            }
        }
        
        if (billId > 0) {
            Bill currentBill = billService.getBill(billId, user.getId());
            if (currentBill != null) {
                req.setAttribute("currentBill", currentBill);
            }
        }
        
        req.getRequestDispatcher("/views/pos/view.jsp").forward(req, resp);
    }
}
