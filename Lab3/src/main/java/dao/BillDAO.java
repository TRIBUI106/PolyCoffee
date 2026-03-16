package dao;

import entity.Bill;
import util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BillDAO implements CrudDAO<Bill, Integer> {

    @Override
    public Integer create(Bill entity) {
        String sql = "INSERT INTO bills(user_id, created_date, status) VALUES (?, ?, ?)";
        try {
            java.sql.Timestamp timestamp = new java.sql.Timestamp(entity.getCreatedDate().getTime());
            return JdbcUtil.executeInsert(sql,
                    entity.getUserId(),
                    timestamp,
                    entity.getStatus());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(Bill entity) {
        String sql = "UPDATE bills SET user_id = ?, created_date = ?, status = ? WHERE id = ?";
        try {
            java.sql.Timestamp timestamp = new java.sql.Timestamp(entity.getCreatedDate().getTime());
            JdbcUtil.executeUpdate(sql,
                    entity.getUserId(),
                    timestamp,
                    entity.getStatus(),
                    entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteById(Integer id) {
        String sql = "DELETE FROM bills WHERE id = ?";
        try {
            JdbcUtil.executeUpdate(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Bill> findAll() {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT * FROM bills";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                Bill bill = new Bill(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        new Date(rs.getTimestamp("created_date").getTime()),
                        rs.getString("status")
                );
                list.add(bill);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Bill findById(Integer id) {
        String sql = "SELECT * FROM bills WHERE id = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                return new Bill(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        new Date(rs.getTimestamp("created_date").getTime()),
                        rs.getString("status")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}