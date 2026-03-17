package com.poly.lab6.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.poly.lab6.entity.Drink;
import com.poly.lab6.util.JdbcUtil;

public class DrinkDAO {

    public List<Drink> findAll() {

        List<Drink> list = new ArrayList<>();

        try {

            String sql = "SELECT * FROM drinks";

            ResultSet rs = JdbcUtil.executeQuery(sql);

            while (rs.next()) {

                Drink d = new Drink();

                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getDouble("price"));
                d.setCategoryId(rs.getInt("category_id"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void insert(Drink d) {

        try {

            String sql = "INSERT INTO drinks(name,price,image,category_id) VALUES(?,?,?,?)";

            JdbcUtil.executeUpdate(sql,
                    d.getName(),
                    d.getPrice(),
                    d.getImage(),
                    d.getCategoryId());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(Drink d) {

        try {

            String sql = "UPDATE drinks SET name=?,price=?,image=?,category_id=? WHERE id=?";

            JdbcUtil.executeUpdate(sql,
                    d.getName(),
                    d.getPrice(),
                    d.getImage(),
                    d.getCategoryId(),
                    d.getId());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {

        try {

            String sql = "DELETE FROM drinks WHERE id=?";

            JdbcUtil.executeUpdate(sql, id);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public Drink findById(int id){

        try{

            String sql = "SELECT * FROM drinks WHERE id=?";

            ResultSet rs = JdbcUtil.executeQuery(sql, id);

            if(rs.next()){

                Drink d = new Drink();

                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getDouble("price"));
                d.setImage(rs.getString("image"));
                d.setCategoryId(rs.getInt("category_id"));

                return d;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return null;
    }
    // Thêm vào DrinkDAO.java
    public List<Drink> search(String name, Integer categoryId, Boolean status, int page, int pageSize) {
        List<Drink> list = new ArrayList<>();
        // Câu lệnh SQL linh hoạt: Nếu tham số null thì bỏ qua điều kiện đó
        String sql = "SELECT * FROM drinks WHERE (name LIKE ? OR ? IS NULL) " +
                "AND (category_id = ? OR ? = 0) " +
                "AND (status = ? OR ? IS NULL) " +
                "ORDER BY id DESC LIMIT ? OFFSET ?";
        try {
            int offset = (page - 1) * pageSize;
            // Giả sử JdbcUtil.executeQuery hỗ trợ tham số biến đổi (varargs)
            ResultSet rs = JdbcUtil.executeQuery(sql,
                    "%" + name + "%", name,
                    categoryId, categoryId,
                    status, status,
                    pageSize, offset);
            while (rs.next()) {
                Drink d = new Drink();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getDouble("price"));
                d.setImage(rs.getString("image"));
                d.setCategoryId(rs.getInt("category_id"));
                d.setStatus(rs.getBoolean("status"));
                list.add(d);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public int count(String name, Integer categoryId, Boolean status) {
        String sql = "SELECT COUNT(*) FROM drinks WHERE (name LIKE ? OR ? IS NULL) " +
                "AND (category_id = ? OR ? = 0) " +
                "AND (status = ? OR ? IS NULL)";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, "%" + name + "%", name, categoryId, categoryId, status, status);
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

}
