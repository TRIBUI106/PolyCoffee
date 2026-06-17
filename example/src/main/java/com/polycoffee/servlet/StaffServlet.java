package com.polycoffee.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.dao.UserDAO;
import com.polycoffee.entity.User;
import com.polycoffee.util.ParamUtil;

@WebServlet({ "/manager/staff", "/manager/staff/add", "/manager/staff/edit", "/manager/staff/update-status" })
public class StaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}

//	Phương thức lấy danh sách nhân viên
	public void listStaff(HttpServletRequest req, HttpServletResponse resp) {
		List<User> staffList = userDAO.findByRole(false);
		req.setAttribute("staffList", staffList);
	}

//	Phương thức tạo mới nhân viên
	public void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User staff = getStaffFromRequestAndValidate(req, resp);
		if (staff != null) {
//			Kiểm tra email đã tồn tại chưa
			User existingUser = userDAO.findByEmail(staff.getEmail());
			if (existingUser != null) {
				req.setAttribute("emailError", "Email đã được sử dụng.");
				req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
				return;
			}
			int rs = userDAO.create(staff);
			if (rs > 0) {
				resp.sendRedirect(req.getContextPath() + "/manager/staff?error=true");
			} else {
				resp.sendRedirect(req.getContextPath() + "/manager/staff?error=false");
			}
		}
	}

//	Phương thức chỉnh sửa thông tin nhân viên
	public void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		User staff = getStaffFromRequestAndValidate(req, resp);
		if (staff != null) {
			int userId = ParamUtil.getInt(req, "userId");
			staff.setId(userId);
			int rs = userDAO.updateUserInfo(staff);
			if (rs > 0) {
				resp.sendRedirect(req.getContextPath() + "/manager/staff?error=true");
			} else {
				resp.sendRedirect(req.getContextPath() + "/manager/staff?error=false");
			}
		}
	}

//	Phương thức cập nhật trạng thái nhân viên
	public void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		int userId = ParamUtil.getInt(req, "userId");
		int status = ParamUtil.getInt(req, "status");
		int rs = userDAO.updateStatus(userId, status == 1);
		if (rs > 0) {
			resp.sendRedirect(req.getContextPath() + "/manager/staff?error=true");
		} else {
			resp.sendRedirect(req.getContextPath() + "/manager/staff?error=false");
		}
	}

//	Phương thức lấy thông tin nhân viên từ request và xác thực dữ liệu
	public User getStaffFromRequestAndValidate(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String email = ParamUtil.getString(req, "email");
		String password = ParamUtil.getString(req, "password");
		String fullName = ParamUtil.getString(req, "fullName");
		String phone = ParamUtil.getString(req, "phone");
		int active = ParamUtil.getInt(req, "active");

		boolean hasError = false;
		if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
			req.setAttribute("emailError", "Email không hợp lệ.");
			hasError = true;
		}
		if (password == null || password.length() < 6) {
			req.setAttribute("passwordError", "Mật khẩu phải có ít nhất 6 ký tự.");
			hasError = true;
		}
		if (fullName == null || fullName.isBlank()) {
			req.setAttribute("fullNameError", "Họ và tên không được để trống.");
			hasError = true;
		}
		if (phone == null || !phone.matches("^0\\d{9}$")) {
			req.setAttribute("phoneError", "Số điện thoại không hợp lệ.");
			hasError = true;
		}
		if (hasError) {
			req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
			return null;
		}

		User staff = new User();
		staff.setEmail(email);
		staff.setPassword(password);
		staff.setFullName(fullName);
		staff.setPhone(phone);
		staff.setActive(active == 1);
		staff.setRole(false);
		return staff;
	}
}
