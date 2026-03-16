package dao;

import entity.User;
import util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements CrudDAO<User, Integer> {

    @Override
    public Integer create(User entity) {
        String sql = "INSERT INTO users(username, password, fullname, role, active) VALUES (?, ?, ?, ?, ?)";
        try {
            return JdbcUtil.executeInsert(sql,
                    entity.getUsername(),
                    entity.getPassword(),
                    entity.getFullname(),
                    entity.getRole(),
                    entity.isActive());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(User entity) {
        String sql = "UPDATE users SET username = ?, password = ?, fullname = ?, role = ?, active = ? WHERE id = ?";
        try {
            JdbcUtil.executeUpdate(sql,
                    entity.getUsername(),
                    entity.getPassword(),
                    entity.getFullname(),
                    entity.getRole(),
                    entity.isActive(),
                    entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteById(Integer id) {
        String sql = "DELETE FROM users WHERE id = ?";
        try {
            JdbcUtil.executeUpdate(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                User user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("fullname"),
                        rs.getString("role"),
                        rs.getBoolean("active")
                );
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public User findById(Integer id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("fullname"),
                        rs.getString("role"),
                        rs.getBoolean("active")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}