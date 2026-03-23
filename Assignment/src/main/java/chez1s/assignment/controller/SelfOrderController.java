package chez1s.assignment.controller;

import chez1s.assignment.dto.CheckoutRequest;
import chez1s.assignment.entity.Category;
import chez1s.assignment.entity.Drink;
import chez1s.assignment.entity.Guest;
import chez1s.assignment.entity.Bill;
import chez1s.assignment.service.BillService;
import chez1s.assignment.service.CategoryService;
import chez1s.assignment.service.DrinkService;
import chez1s.assignment.service.GuestService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/guest/order", "/guest/order/checkout"})
public class SelfOrderController extends HttpServlet {
    private final DrinkService drinkService = new DrinkService();
    private final CategoryService categoryService = new CategoryService();
    private final GuestService guestService = new GuestService();
    private final BillService billService = new BillService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.endsWith("/order")) {
            List<Category> categories = categoryService.getAllCategories();
            List<Drink> drinks = drinkService.getActiveDrinks();
            
            req.setAttribute("categories", categories);
            req.setAttribute("drinks", drinks);
            
            req.getRequestDispatcher("/views/guest/self-order.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.endsWith("/checkout")) {
            try {
                CheckoutRequest checkoutRequest = gson.fromJson(req.getReader(), CheckoutRequest.class);
                
                String fullname = checkoutRequest.getGuestName();
                String phone = checkoutRequest.getGuestPhone();
                
                if (fullname == null || fullname.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
                    resp.setStatus(400);
                    resp.getWriter().write("{\"success\":false,\"message\":\"Fullname and Phone number are required\"}");
                    return;
                }

                // Create or find guest
                Guest guest = guestService.findOrCreateGuest(fullname, phone);
                
                // Create order for guest via BillService
                Bill bill = billService.checkoutGuestBill(checkoutRequest, guest);
                
                // Add points to guest: total amount / 1000
                int earnedPoints = bill.getTotal() / 1000;
                guest.setPoint(guest.getPoint() + earnedPoints);
                chez1s.assignment.repository.GuestRepository guestRepository = new chez1s.assignment.repository.GuestRepository();
                guestRepository.update(guest);
                
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write(String.format("{\"success\":true,\"billCode\":\"%s\",\"total\":%d,\"pointsEarned\":%d,\"totalPoints\":%d}",
                        bill.getCode(), bill.getTotal(), earnedPoints, guest.getPoint()));

            } catch (Exception e) {
                e.printStackTrace();
                resp.setStatus(500);
                resp.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
