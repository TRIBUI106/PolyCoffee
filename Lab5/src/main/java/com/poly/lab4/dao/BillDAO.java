package com.poly.lab4.dao;

import com.poly.lab4.entity.Bill;
import com.poly.lab4.util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public List<Bill> findAll() {

        List<Bill> list = new ArrayList<>();

        try {

            String sql = "SELECT * FROM bills";

            ResultSet rs = JdbcUtil.executeQuery(sql);

            while (rs.next()) {

                Bill b = new Bill();

                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setCreatedDate(rs.getTimestamp("created_date"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void insert(Bill b) {

        try {

            String sql = "INSERT INTO bills(user_id,created_date) VALUES(?,?)";

            JdbcUtil.executeUpdate(sql,
                    b.getUserId(),
                    b.getCreatedDate());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getLastId(){

        try{

            String sql = "SELECT MAX(id) as id FROM bills";

            ResultSet rs = JdbcUtil.executeQuery(sql);

            if(rs.next()){
                return rs.getInt("id");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return 0;
    }

}