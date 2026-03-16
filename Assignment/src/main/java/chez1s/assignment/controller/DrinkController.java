package chez1s.assignment.controller;

import chez1s.assignment.entity.Drink;
import chez1s.assignment.service.CategoryService;
import chez1s.assignment.service.DrinkService;
import chez1s.assignment.util.FileUtil;
import chez1s.assignment.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/manager/drinks", "/manager/drinks/form", "/manager/drinks/save", "/manager/drinks/delete"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 15    // 15 MB
)
public class DrinkController extends HttpServlet {
    private final DrinkService drinkService = new DrinkService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/delete")) {
            drinkService.deleteDrink(ParamUtil.getInt(req, "id"));
            resp.sendRedirect(req.getContextPath() + "/employee/pos?tab=drinks");
            return;
        }
        
        if (uri.contains("/form")) {
            int id = ParamUtil.getInt(req, "id");
            if (id > 0) req.setAttribute("drink", drinkService.getDrinkById(id));
            req.setAttribute("categories", categoryService.getAllCategories());
            req.getRequestDispatcher("/views/drink/drink-form.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("drinks", drinkService.getAllDrinks());
        req.getRequestDispatcher("/views/drink/manager-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = ParamUtil.getInt(req, "id");
        Drink drink = (id > 0) ? drinkService.getDrinkById(id) : new Drink();
        
        drink.setName(ParamUtil.getString(req, "name"));
        drink.setDescription(ParamUtil.getString(req, "description"));
        drink.setPrice(ParamUtil.getInt(req, "price"));
        drink.setActive(ParamUtil.getInt(req, "active") == 1);
        drink.setCategory(categoryService.getCategoryById(ParamUtil.getInt(req, "categoryId")));
        
        String image = FileUtil.upload(req, "image");
        if (!image.isEmpty()) {
            // Delete old image if updating
            if (id > 0 && drink.getImage() != null && !drink.getImage().isEmpty()) {
                FileUtil.delete(req, drink.getImage());
            }
            drink.setImage(image);
        }

        try {
            if (id > 0) drinkService.updateDrink(drink);
            else drinkService.createDrink(drink);
            req.getSession().setAttribute("message", "Product saved successfully!");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error saving product: " + e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/employee/pos?tab=drinks");
    }
}
