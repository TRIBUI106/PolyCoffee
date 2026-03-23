package chez1s.assignment.controller;

import chez1s.assignment.entity.Guest;
import chez1s.assignment.service.PointShopService;
import chez1s.assignment.repository.GuestRepository;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet({"/guest/pointshop/status", "/guest/pointshop/vouchers", "/guest/pointshop/redeem"})
public class PointShopController extends HttpServlet {
    private final PointShopService pointShopService = new PointShopService();
    private final GuestRepository guestRepo = new GuestRepository();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (uri.endsWith("/status")) {
            String phone = req.getParameter("phone");
            Guest guest = guestRepo.findByPhoneNumber(phone);
            if (guest != null) {
                var myVouchers = pointShopService.getGuestVouchers(phone);
                java.util.Map<String, Object> responseData = new java.util.HashMap<>();
                responseData.put("success", true);
                responseData.put("points", guest.getPoint());
                
                java.util.List<java.util.Map<String, Object>> voucherList = new java.util.ArrayList<>();
                for (var gv : myVouchers) {
                    java.util.Map<String, Object> vo = new java.util.HashMap<>();
                    vo.put("id", gv.getId());
                    vo.put("name", gv.getVoucher().getName());
                    vo.put("discountAmount", gv.getVoucher().getDiscountAmount());
                    voucherList.add(vo);
                }
                responseData.put("vouchers", voucherList);
                resp.getWriter().write(gson.toJson(responseData));
            } else {
                resp.getWriter().write("{\"success\":false,\"message\":\"Không tìm thấy số điện thoại.\"}");
            }
        } else if (uri.endsWith("/vouchers")) {
            // Get all catalog
            resp.getWriter().write(gson.toJson(pointShopService.getAvailableVouchers()));
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (uri.endsWith("/redeem")) {
            try {
                String payload = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
                var body = gson.fromJson(payload, RedeemRequest.class);
                
                pointShopService.redeemVoucher(body.phone, body.voucherId);
                
                resp.getWriter().write("{\"success\":true}");
            } catch (Exception e) {
                resp.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private static class RedeemRequest {
        String phone;
        Integer voucherId;
    }
}
