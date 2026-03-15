package com.poly.lab4.dao;


import com.poly.lab4.entity.User;
import com.poly.lab4.util.JdbcUtil;

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


}
