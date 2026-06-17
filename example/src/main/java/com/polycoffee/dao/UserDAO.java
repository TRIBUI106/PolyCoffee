package com.polycoffee.dao;

import java.sql.ResultSet;
import java.util.List;

import com.polycoffee.entity.User;
import com.polycoffee.util.JdbcUtil;

public class UserDAO implements CrudDAO<User, Integer> {

	@Override
	public int update(User entity) {
		// TODO Auto-generated method stub
		String sql = "UPDATE users SET email = ?, password = ?, full_name = ?, phone = ?, role = ?, active = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getEmail(), entity.getPassword(), entity.getFullName(),
					entity.getPhone(), entity.isRole(), entity.isActive(), entity.getId());
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
	public List<User> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User findById(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> findBySql(String sql, Object... value) {
		// TODO Auto-generated method stub
		return null;
	}

	public User findByEmail(String email) {
		// TODO Auto-generated method stub
		User user = null;
		String sql = "select * from users where active = 1 and email = ?";
		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, email);
			while (rs.next()) {
				Integer id = rs.getInt("id");
				String password = rs.getString("password");
				String fullName = rs.getString("full_name");
				String phone = rs.getString("phone");
				boolean role = rs.getBoolean("role");
				boolean active = rs.getBoolean("active");
				user = new User(id, email, password, fullName, phone, role, active);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return user;
	}

	public List<User> findByRole(boolean role) {
		String sql = "SELECT * FROM users WHERE role = ?";
		try {
			return findBySql(sql, role);
		} catch (Exception e) {
		}
		return null;
	}

	@Override
	public int create(User entity) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO users(email, password, full_name, phone, role, active) values (?, ?, ?, ?, ?, ?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getEmail(), entity.getPassword(), entity.getFullName(),
					entity.getPhone(), entity.isRole(), entity.isActive());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return 0;
	}

	public int updateUserInfo(User entity) {
		String sql = "UPDATE users SET full_name = ?, phone = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getFullName(), entity.getPhone(), entity.getId());
		} catch (Exception e) {
			// TODO: handle exception
		}

		return 0;
	}

	public int updateStatus(Integer id, boolean active) {
		String sql = "UPDATE users SET active = ? WHERE id = ?";
		try {
			return JdbcUtil.executeUpdate(sql, active, id);
		} catch (Exception e) {

		}
		return 0;
	}
}
