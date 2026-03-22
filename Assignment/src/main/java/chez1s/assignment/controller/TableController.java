package chez1s.assignment.controller;

import chez1s.assignment.service.TableService;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({"/manager/tables", "/manager/tables/save", "/manager/tables/delete"})
public class TableController extends HttpServlet {
    private final TableService tableService = new TableService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/delete")) {
            tableService.deleteTable(ParamUtil.getInt(req, "id"));
            String referer = req.getHeader("referer");
            resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/employee/pos?tab=tables");
            return;
        }
        
        req.setAttribute("tables", tableService.getAllTables());
        req.getRequestDispatcher("/views/staff/tables.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id = ParamUtil.getInt(req, "id");
        String name = ParamUtil.getString(req, "name");
        String code = ParamUtil.getString(req, "code");
        
        if (id != null && id > 0) {
            tableService.updateTable(id, name, code);
        } else {
            tableService.createTable(name, code);
        }
        
        String referer = req.getHeader("referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/employee/pos?tab=tables");
    }
}
