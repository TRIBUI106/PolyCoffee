package com.polycoffee.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.polycoffee.entity.Bill;
import com.polycoffee.entity.BillDetail;
import com.polycoffee.util.JdbcUtil;

public class BillDAO implements CrudDAO<Bill, Integer> {
	BillDetailDAO billDetailDAO = new BillDetailDAO();

	@Override
	public int create(Bill entity) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO bills(user_id, code, created_at, total, status) values (?, ?, ?, ?, ?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getUserId(), entity.getCode(), entity.getCreatedAt(),
					entity.getTotal(), entity.getStatus());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int update(Bill entity) {
		// TODO Auto-generated method stub
		String sql = "UPDATE bills SET user_id = ?, code = ?, created_at = ?, total = ?, status = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getUserId(), entity.getCode(), entity.getCreatedAt(),
					entity.getTotal(), entity.getStatus(), entity.getId());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Bill> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Bill findById(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Bill> findBySql(String sql, Object... value) {
		// TODO Auto-generated method stub
		return null;
	}

//	Trạng thái hóa đơn
	public static final String STATUS_WAITING = "waiting";
	public static final String STATUS_FINISH = "finish";
	public static final String STATUS_CANCEL = "cancel";

	public Bill findByIdAndUserId(Integer id, Integer userId) {
		String sql = "SELECT * FROM bills WHERE id = ? AND user_id = ?";
		try {
			List<Bill> bills = this.findBySql(sql, id, userId);
			if (!bills.isEmpty()) {
				return bills.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

//	Tạo hóa đơn cùng với chi tiết hóa đơn
	public int createWithBillDetails(Bill bill, List<BillDetail> billDetails) {
		String sqlBill = "INSERT INTO bills(user_id, code, created_at, total, status) values (?, ?, ?, ?, ?)";
		try {
			PreparedStatement stmt = JdbcUtil.createPreStmt(sqlBill, bill.getUserId(), bill.getCode(),
					bill.getCreatedAt(), bill.getTotal(), bill.getStatus());
			int rs = stmt.executeUpdate();
			if (rs > 0) {
				ResultSet generatedKeys = stmt.getGeneratedKeys();
				if (generatedKeys.next()) {
					int billId = generatedKeys.getInt(1);
					for (BillDetail billDetail : billDetails) {
						billDetail.setBillId(billId);
						billDetailDAO.create(billDetail);
					}
					updateTotal(billId);
					return billId;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

//	Cập nhật trạng thái hóa đơn
	public int updateStatus(Integer billId, String status) {
		Bill bill = this.findById(billId);
		if (bill.getStatus().equals(STATUS_WAITING)) {
			if (status.equals(STATUS_FINISH) || status.equals(STATUS_CANCEL)) {
				String sql = "UPDATE bills SET status = ? WHERE id = ?";
				try {
					return JdbcUtil.executeUpdate(sql, status, billId);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else if (bill.getStatus().equals(STATUS_FINISH)) {
			if (status.equals(STATUS_CANCEL)) {
				String sql = "UPDATE bills SET status = ? WHERE id = ?";
				try {
					return JdbcUtil.executeUpdate(sql, status, billId);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return 0;
	}

//	Cập nhật tổng tiền hóa đơn
	public int updateTotal(Integer billId) {
		List<BillDetail> billDetails = billDetailDAO.findByBillId(billId);
		int total = 0;
		for (BillDetail billDetail : billDetails) {
			total += billDetail.getPrice() * billDetail.getQuantity();
		}
		String sql = "UPDATE bills SET total = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, total, billId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

//	Lấy danh sách hóa đơn của user theo userId
	public List<Bill> findByUserId(Integer userId) {
//		Lấy danh sách hóa đơn của user, sắp xếp theo trạng thái: waiting, finish, cancel
		String sql = "SELECT * FROM bills WHERE user_id = ? ORDER BY CASE status WHEN 'waiting' THEN 1 WHEN 'finish' THEN 2 WHEN 'cancel' THEN 3 END";
		try {
			return this.findBySql(sql, userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<Bill>();
	}

}
