package chez1s.assignment.controller;

import com.google.gson.Gson;
import chez1s.assignment.service.StatisticService;
import chez1s.assignment.util.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/api/stats")
public class StatisticApiController extends HttpServlet {
    private final StatisticService statisticService = new StatisticService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (AuthUtil.getUser(req) == null || !AuthUtil.getUser(req).isRole()) {
            resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(gson.toJson(statisticService.getDashboardData()));
    }
}
