package com.poly.lab4.dao;

import com.poly.lab4.entity.BillDetail;
import com.poly.lab4.util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BillDetailDAO {

    public List<BillDetail> findAll() {

        List<BillDetail> list = new ArrayList<>();

        try {

            String sql = "SELECT * FROM bill_details";

            ResultSet rs = JdbcUtil.executeQuery(sql);

            while (rs.next()) {

                BillDetail bd = new BillDetail();

                bd.setId(rs.getInt("id"));
                bd.setBillId(rs.getInt("bill_id"));
                bd.setDrinkId(rs.getInt("drink_id"));
                bd.setQuantity(rs.getInt("quantity"));
                bd.setPrice(rs.getDouble("price"));

                list.add(bd);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void insert(BillDetail bd) {

        try {

            String sql = "INSERT INTO bill_details(bill_id,drink_id,quantity,price) VALUES(?,?,?,?)";

            JdbcUtil.executeUpdate(sql,
                    bd.getBillId(),
                    bd.getDrinkId(),
                    bd.getQuantity(),
                    bd.getPrice());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<BillDetail> findByBill(int billId){

        List<BillDetail> list = new ArrayList<>();

        try{

            String sql = "SELECT * FROM bill_details WHERE bill_id=?";

            ResultSet rs = JdbcUtil.executeQuery(sql,billId);

            while(rs.next()){

                BillDetail bd = new BillDetail();

                bd.setId(rs.getInt("id"));
                bd.setBillId(rs.getInt("bill_id"));
                bd.setDrinkId(rs.getInt("drink_id"));
                bd.setQuantity(rs.getInt("quantity"));
                bd.setPrice(rs.getDouble("price"));

                list.add(bd);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

}