package com.poly.lab6.dao;

import com.poly.lab6.entity.Revenue;
import com.poly.lab6.util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RevenueDAO {
    public List<Revenue> getRevenue(String from, String to) {
        List<Revenue> list = new ArrayList<>();

        try {
            String sql = """
                SELECT DATE(b.created_date) AS date,
                       SUM(bd.quantity * bd.price) AS revenue
                FROM bill_details bd
                JOIN bills b ON bd.bill_id = b.id
                WHERE DATE(b.created_date) BETWEEN ? AND ?
                GROUP BY DATE(b.created_date)
                ORDER BY DATE(b.created_date)
            """;

            ResultSet rs = JdbcUtil.executeQuery(sql, from, to);

            while (rs.next()) {
                Revenue r = new Revenue();
                r.setDate(rs.getString("date"));
                r.setRevenue(rs.getDouble("revenue"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
