package com.polycoffee.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.dao.BillDAO;
import com.polycoffee.dao.BillDetailDAO;
import com.polycoffee.dao.DrinkDAO;
import com.polycoffee.entity.Bill;
import com.polycoffee.entity.BillDetail;
import com.polycoffee.entity.Drink;
import com.polycoffee.util.AuthUtil;
import com.polycoffee.util.ParamUtil;

@WebServlet({ "/employee/pos", "/employee/pos/init", "/employee/pos/add-item", "/employee/pos/update-quantity",
		"/employee/pos/checkout", "/employee/pos/cancel" })
public class PosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DrinkDAO drinkDAO = new DrinkDAO();
	private BillDAO billDAO = new BillDAO();
	private BillDetailDAO billDetailDAO = new BillDetailDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String sql = "SELECT * FROM drinks WHERE active = ?";
		List<Drink> drinks = drinkDAO.findBySql(sql, 1);

		Integer billId = ParamUtil.getInt(req, "billId");

		Integer userId = AuthUtil.getUser(req).getId();

		if (billId != 0) {
			Bill bill = billDAO.findByIdAndUserId(billId, userId);
			if (bill != null) {
				List<BillDetail> billDetail = billDetailDAO.findByBillId(billId);
			}
		}

		req.getRequestDispatcher("/views/pos/view.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}

	public void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer billId = ParamUtil.getInt(req, "billId");
		Integer userId = AuthUtil.getUser(req).getId();
		Integer drinkId = ParamUtil.getInt(req, "drinkId");
		Drink drink = drinkDAO.findById(drinkId);

		if (billId == 0) {
			Date now = new Date();
			Bill bill = new Bill();
			bill.setUserId(userId);
			bill.setCode("BILL-" + now.getTime());
			bill.setCreatedAt(now);
			bill.setTotal(drink.getPrice());
			bill.setStatus(BillDAO.STATUS_WAITING);

			List<BillDetail> billDetails = List.of(new BillDetail(null, null, drinkId, 1, drink.getPrice()));

			int billIdDB = billDAO.createWithBillDetails(bill, billDetails);
			if (billIdDB > 0) {
				resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billIdDB);
			}
		} else {
			int rs = billDetailDAO.addDrinkToBill(billId, drinkId);
			if (rs > 0) {
				resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId);
			}
		}

	}

	public void updateOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer billId = ParamUtil.getInt(req, "billId");
		Integer billDetailId = ParamUtil.getInt(req, "billDetailId");
		String action = ParamUtil.getString(req, "action");

		if (action.equals("increase")) {
			BillDetail billDetail = billDetailDAO.findById(billDetailId);
			if (billDetail != null) {
				billDetailDAO.updateQuantity(billId, billDetail.getDrinkId(), billDetail.getQuantity() + 1);
			}
		} else if (action.equals("decrease")) {
			BillDetail billDetail = billDetailDAO.findById(billDetailId);
			if (billDetail != null) {
				billDetailDAO.updateQuantity(billId, billDetail.getDrinkId(), billDetail.getQuantity() - 1);
			}
		} else if (action.equals("remove")) {
			BillDetail billDetail = billDetailDAO.findById(billDetailId);
			if (billDetail != null) {
				billDetailDAO.updateQuantity(billId, billDetail.getDrinkId(), 0);
			}
		}
		resp.sendRedirect(req.getContextPath() + "/employee/pos?billId=" + billId);
	}

	public void checkout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer billId = ParamUtil.getInt(req, "billId");
		Integer userId = AuthUtil.getUser(req).getId();

		Bill bill = billDAO.findByIdAndUserId(billId, userId);
		if (bill != null) {
			billDAO.updateStatus(billId, BillDAO.STATUS_FINISH);
			resp.sendRedirect(req.getContextPath() + "/employee/pos");
		}
	}

	public void cancel(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer billId = ParamUtil.getInt(req, "billId");
		Integer userId = AuthUtil.getUser(req).getId();

		Bill bill = billDAO.findByIdAndUserId(billId, userId);
		if (bill != null) {
			billDAO.updateStatus(billId, BillDAO.STATUS_CANCEL);
			resp.sendRedirect(req.getContextPath() + "/employee/pos");
		}
	}
}
