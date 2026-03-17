package com.poly.lab5.dao;

import com.poly.lab5.entity.User;
import com.poly.lab5.util.JdbcUtil;

import java.sql.ResultSet;

public class AuthDAO {

    public User findByEmail(String email){

        try{

            String sql = "SELECT * FROM users WHERE email=?";

            ResultSet rs = JdbcUtil.executeQuery(sql,email);

            if(rs.next()){

                User u = new User();

                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setFullname(rs.getString("fullname"));
                u.setRole(rs.getString("role"));

                return u;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return null;
    }
}
