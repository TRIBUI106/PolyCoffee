package com.poly.lab4.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.poly.lab4.entity.Drink;
import com.poly.lab4.util.JdbcUtil;

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
                d.setImage(rs.getString("image"));
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

}
