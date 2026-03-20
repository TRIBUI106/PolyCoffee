package chez1s.assignment.controller;

import chez1s.assignment.entity.User;
import chez1s.assignment.service.BillService;
import chez1s.assignment.util.AuthUtil;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/manager/bills")
public class BillController extends HttpServlet {
    private final BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = AuthUtil.getUser(req);
        Integer userId = user.getId();
        
        String query = req.getParameter("query");
        String status = req.getParameter("status");
        
        if (user.isRole()) {
            req.setAttribute("bills", billService.searchBills(query, status));
        } else {
            req.setAttribute("bills", billService.searchUserBills(userId, query, status));
        }
        
        Integer detailId = ParamUtil.getInt(req, "id");
        if (detailId > 0) {
            if (user.isRole()) {
                req.setAttribute("bill", billService.getBillById(detailId));
            } else {
                req.setAttribute("bill", billService.getBill(detailId, userId));
            }
        }
        
        req.getRequestDispatcher("/views/bills/list.jsp").forward(req, resp);
    }
}
