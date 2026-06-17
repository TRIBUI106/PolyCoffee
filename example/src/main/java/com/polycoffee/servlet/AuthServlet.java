package com.polycoffee.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.dao.UserDAO;
import com.polycoffee.entity.User;
import com.polycoffee.util.AuthUtil;
import com.polycoffee.util.ParamUtil;

/**
 * Servlet implementation class AuthServlet
 */
@WebServlet("/dang-nhap")
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO userDAO = new UserDAO();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response)
					throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/views/auth/login.jsp")
			   .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, 
						  HttpServletResponse response) 
						  throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = ParamUtil.getString(request, "email");
		String password = ParamUtil.getString(request, "password");
		User user = userDAO.findByEmail(email);
		if (user != null && user.isActive()) {
			//Lưu trạng thái đăng nhập
			AuthUtil.setUser(request, user);
			String redirectUrl = request.getContextPath() + "/trang-chu";
			if (request.getSession().getAttribute("REDIRECT_URL") != null) {
				redirectUrl = (String) request.getSession().getAttribute("REDIRECT_URL");
			}
			System.out.println(redirectUrl);
			response.sendRedirect(redirectUrl);
			return;
		}
		if (user == null || !user.getPassword().equals(password)) {
			request.setAttribute("message", "Tài khoản không đúng!");
		}
		if (user != null && !user.isActive()) {
			request.setAttribute("message", "Tài khoản đã bị khóa!");
		}
		request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
	}
}
