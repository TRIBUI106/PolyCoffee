package chez1s.assignment.controller;

import chez1s.assignment.entity.Category;
import chez1s.assignment.service.CategoryService;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/manager/categories", "/manager/categories/create", "/manager/categories/update", "/manager/categories/delete", "/manager/categories/save"})
public class CategoryController extends HttpServlet {
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/delete")) {
            categoryService.deleteCategory(ParamUtil.getInt(req, "id"));
            resp.sendRedirect(req.getContextPath() + "/employee/pos?tab=categories");
            return;
        }
        
        req.setAttribute("categories", categoryService.getAllCategories());
        Integer id = ParamUtil.getInt(req, "id");
        if (id > 0) {
            req.setAttribute("category", categoryService.getCategoryById(id));
        }
        req.getRequestDispatcher("/views/categories/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = ParamUtil.getString(req, "name");
        Integer id = ParamUtil.getInt(req, "id");

        if (id > 0) {
            categoryService.updateCategory(id, name);
        } else {
            categoryService.createCategory(name);
        }
        resp.sendRedirect(req.getContextPath() + "/employee/pos?tab=categories");
    }
}
