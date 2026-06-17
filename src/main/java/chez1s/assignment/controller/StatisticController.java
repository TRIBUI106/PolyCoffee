package chez1s.assignment.controller;

import chez1s.assignment.service.StatisticService;
import chez1s.assignment.util.DateUtil;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet("/manager/statistics")
public class StatisticController extends HttpServlet {
    private final StatisticService statisticService = new StatisticService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Date fromDate = ParamUtil.getDate(req, "from", "yyyy-MM-dd");
        Date toDate = ParamUtil.getDate(req, "to", "yyyy-MM-dd");

        req.setAttribute("topDrinks", statisticService.getTopSellingDrinks(fromDate, toDate));
        req.setAttribute("revenueReport", statisticService.getRevenueReport(fromDate, toDate));
        
        req.getRequestDispatcher("/views/statistics/report.jsp").forward(req, resp);
    }
}
