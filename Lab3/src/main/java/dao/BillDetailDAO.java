package dao;

import entity.BillDetail;
import util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BillDetailDAO implements CrudDAO<BillDetail, Integer> {

    @Override
    public Integer create(BillDetail entity) {
        String sql = "INSERT INTO bill_details(bill_id, drink_id, quantity, price) VALUES (?, ?, ?, ?)";
        try {
            return JdbcUtil.executeInsert(sql,
                    entity.getBillId(),
                    entity.getDrinkId(),
                    entity.getQuantity(),
                    entity.getPrice());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(BillDetail entity) {
        String sql = "UPDATE bill_details SET bill_id = ?, drink_id = ?, quantity = ?, price = ? WHERE id = ?";
        try {
            JdbcUtil.executeUpdate(sql,
                    entity.getBillId(),
                    entity.getDrinkId(),
                    entity.getQuantity(),
                    entity.getPrice(),
                    entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteById(Integer id) {
        String sql = "DELETE FROM bill_details WHERE id = ?";
        try {
            JdbcUtil.executeUpdate(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<BillDetail> findAll() {
        List<BillDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM bill_details";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                BillDetail billDetail = new BillDetail(
                        rs.getInt("id"),
                        rs.getInt("bill_id"),
                        rs.getInt("drink_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("price")
                );
                list.add(billDetail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public BillDetail findById(Integer id) {
        String sql = "SELECT * FROM bill_details WHERE id = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                return new BillDetail(
                        rs.getInt("id"),
                        rs.getInt("bill_id"),
                        rs.getInt("drink_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("price")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}