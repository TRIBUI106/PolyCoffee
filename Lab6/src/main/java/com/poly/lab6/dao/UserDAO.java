package com.poly.lab6.dao;


import com.poly.lab6.entity.User;
import com.poly.lab6.util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public List<User> findAll() {

        List<User> list = new ArrayList<>();

        try {

            String sql = "SELECT * FROM users";

            ResultSet rs = JdbcUtil.executeQuery(sql);

            while (rs.next()) {

                User u = new User();

                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullname(rs.getString("fullname"));
                u.setRole(rs.getString("role"));
                u.setEmail(rs.getString("email"));


                list.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void insert(User u) {

        try {

            String sql = "INSERT INTO users(username,password,fullname,role,email) VALUES(?,?,?,?,?)";

            JdbcUtil.executeUpdate(sql,
                    u.getUsername(),
                    u.getPassword(),
                    u.getFullname(),
                    u.getRole(),
                    u.getEmail());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void delete(int id) {

        try {

            String sql = "DELETE FROM users WHERE id=?";

            JdbcUtil.executeUpdate(sql, id);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public User findById(int id){

        try{

            String sql = "SELECT * FROM users WHERE id=?";

            ResultSet rs = JdbcUtil.executeQuery(sql,id);

            if(rs.next()){

                User u = new User();

                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullname(rs.getString("fullname"));
                u.setRole(rs.getString("role"));
                u.setEmail(rs.getString("email"));

                return u;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return null;
    }


    public void update(User u){

        try{

            String sql = "UPDATE users SET username=?,password=?,fullname=?,role=?,email=? WHERE id=?";

            JdbcUtil.executeUpdate(sql,
                    u.getUsername(),
                    u.getPassword(),
                    u.getFullname(),
                    u.getRole(),
                    u.getEmail(),
                    u.getId());

        }catch(Exception e){
            e.printStackTrace();
        }

    }

    // Thêm vào UserDAO.java
    public List<User> search(String fullname, String email, Boolean status, int page, int pageSize) {
        List<User> list = new ArrayList<>();
        // SQL lọc theo nhiều tiêu chí, hỗ trợ giá trị null/rỗng
        String sql = "SELECT * FROM users WHERE (fullname LIKE ? OR ? IS NULL OR ? = '') " +
                "AND (email LIKE ? OR ? IS NULL OR ? = '') " +
                "AND (status = ? OR ? IS NULL) " +
                "LIMIT ? OFFSET ?";
        try {
            int offset = (page - 1) * pageSize;
            ResultSet rs = JdbcUtil.executeQuery(sql,
                    "%" + fullname + "%", fullname, fullname,
                    "%" + email + "%", email, email,
                    status, status,
                    pageSize, offset);
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setFullname(rs.getString("fullname"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                u.setStatus(rs.getBoolean("status"));
                list.add(u);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public int count(String fullname, String email, Boolean status) {
        String sql = "SELECT COUNT(*) FROM users WHERE (fullname LIKE ? OR ? IS NULL OR ? = '') " +
                "AND (email LIKE ? OR ? IS NULL OR ? = '') " +
                "AND (status = ? OR ? IS NULL)";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql,
                    "%" + fullname + "%", fullname, fullname,
                    "%" + email + "%", email, email,
                    status, status);
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}
