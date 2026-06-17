package com.polycoffee.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.polycoffee.dao.CategoryDAO;
import com.polycoffee.dao.DrinkDAO;
import com.polycoffee.entity.Drink;
import com.polycoffee.util.FileUtil;
import com.polycoffee.util.ParamUtil;

@MultipartConfig
@WebServlet({ "/manager/drinks", "/manager/drinks/add", "/manager/drinks/edit", "/manager/drinks/delete" })
public class DrinkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DrinkDAO drinkDAO = new DrinkDAO();
	private CategoryDAO categoryDAO = new CategoryDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uriString = req.getRequestURI();
		if (uriString.contains("add") || uriString.contains("edit")) {
			req.getRequestDispatcher("/views/drink/drink-form.jsp").forward(req, resp);
			return;
		}
		if (uriString.contains("/manager/drinks")) {
			getDrinksManager(req);
			req.getRequestDispatcher("/views/drink/manager-list.jsp").forward(req, resp);
			return;
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uriString = req.getRequestURI();
		if (uriString.contains("add")) {
			create(req, resp);
			return;
		}
		if (uriString.contains("edit")) {
			edit(req, resp);
			return;
		}
		if (uriString.contains("delete")) {
			delete(req, resp);
			return;
		}
	}

	// Danh sách đồ uống cho Manager
	private void getDrinksManager(HttpServletRequest request) {
		List<Drink> list = drinkDAO.findAll();
		request.setAttribute("drinks", list);
	}

	// Thêm mới đồ uống
	private void create(HttpServletRequest request, HttpServletResponse response) {
		try {
			Drink drink = getDrinkFromRequestAndValidate(request, response);
			if (drink != null) {
				int rs = drinkDAO.create(drink);

				if (rs > 0) {
					response.sendRedirect(request.getContextPath() + "/manager/drinks?error=true");
				} else {
					response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
				}

			}
		} catch (IOException | ServletException e) {
			e.printStackTrace();
		}
	}

	// Chỉnh sửa đồ uống
	private void edit(HttpServletRequest request, HttpServletResponse response) {
		try {
			Drink drink = getDrinkFromRequestAndValidate(request, response);
			if (drink != null) {
				int drinkId = ParamUtil.getInt(request, "drinkId");
				drink.setId(drinkId);
				int rs = drinkDAO.update(drink);

				if (rs > 0) {
					response.sendRedirect(request.getContextPath() + "/manager/drinks?error=true");
				} else {
					response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
				}

			}
		} catch (IOException | ServletException e) {
			e.printStackTrace();
		}
	}

	// Xóa đồ uống
	private void delete(HttpServletRequest request, HttpServletResponse response) {
		try {
			int drinkId = ParamUtil.getInt(request, "drinkId");
			int rs = drinkDAO.delete(drinkId);

			if (rs > 0) {
				response.sendRedirect(request.getContextPath() + "/manager/drinks?error=true");
			} else {
				response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// Lấy dữ liệu từ form và validate
	private Drink getDrinkFromRequestAndValidate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		Lấy dữ liệu từ form
		int categoryId = ParamUtil.getInt(request, "categoryId");
		String name = ParamUtil.getString(request, "name");
		String description = ParamUtil.getString(request, "description");
		int price = ParamUtil.getInt(request, "price");
		int active = ParamUtil.getInt(request, "active");
		Part imagePart = request.getPart("image");

//		Validate dữ liệu
		boolean hasError = false;
		if (categoryId == 0) {
			request.setAttribute("errCat", "Vui lòng chọn danh mục");
			hasError = true;
		}
		if (name == null || name.isBlank()) {
			request.setAttribute("errName", "Vui lòng nhập tên đồ uống");
			hasError = true;
		}
		if (price <= 0) {
			request.setAttribute("errPrice", "Giá phải lớn hơn 0");
			hasError = true;
		}
		if (description == null || description.isBlank()) {
			request.setAttribute("errDesc", "Vui lòng nhập mô tả");
			hasError = true;
		}
		if (imagePart == null || imagePart.getSize() == 0) {
			request.setAttribute("errImage", "Vui lòng chọn hình ảnh");
			hasError = true;
		}
		if (hasError) {
			request.getRequestDispatcher("/views/drink/drink-form.jsp").forward(request, response);
			return null;
		}

//		Xử lý upload hình ảnh
		String imageName = FileUtil.upload(request, "image");
//		Lưu dữ liệu vào đối tượng Drink
		Drink drink = new Drink();
		drink.setCategoryId(categoryId);
		drink.setName(name);
		drink.setDescription(description);
		drink.setPrice(price);
		drink.setActive(active == 1);
		drink.setImage(imageName);

		return drink;
	}
}
