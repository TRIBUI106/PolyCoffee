package com.poly.lab6.dao;

import com.poly.lab6.entity.Bill;
import com.poly.lab6.util.JdbcUtil;

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
            String sql = "INSERT INTO bills(user_id, created_date, total, status) VALUES(?,?,?,?)";

            JdbcUtil.executeUpdate(sql,
                    b.getUserId(),
                    b.getCreatedDate(),
                    b.getTotal(),
                    b.getStatus());

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

    public List<Bill> findAll(int page, int limit) {

        List<Bill> list = new ArrayList<>();

        try {

            String sql = "SELECT b.id, b.user_id, b.total, b.status, b.created_date, u.username " +
                    "FROM bills b LEFT JOIN users u ON b.user_id = u.id " +
                    "ORDER BY b.created_date DESC LIMIT ? OFFSET ?";

            ResultSet rs = JdbcUtil.executeQuery(sql,
                    limit,
                    (page - 1) * limit);

            while (rs.next()) {
                Bill b = new Bill();

                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setTotal(rs.getDouble("total"));
                b.setStatus(rs.getString("status"));
                b.setCreatedDate(rs.getTimestamp("created_date"));
                b.setUserName(rs.getString("username"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void cancel(int id) {

        try {
            String sql = "UPDATE bills SET status = 'CANCELLED' WHERE id = ?";

            JdbcUtil.executeUpdate(sql, id);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Object[]> top5Drinks(String from, String to) {

        List<Object[]> list = new ArrayList<>();

        try {

            String sql = "SELECT d.name, SUM(bd.quantity) AS total_sold " +
                    "FROM bill_details bd " +
                    "JOIN drinks d ON bd.drink_id = d.id " +
                    "JOIN bills b ON bd.bill_id = b.id " +
                    "WHERE DATE(b.created_date) BETWEEN ? AND ? " +
                    "GROUP BY d.name " +
                    "ORDER BY total_sold DESC " +
                    "LIMIT 5";

            ResultSet rs = JdbcUtil.executeQuery(sql, from, to);

            while (rs.next()) {
                list.add(new Object[]{
                        rs.getString("name"),
                        rs.getInt("total_sold")
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}