package com.poly.lab4.dao;

import com.poly.lab4.entity.Category;
import com.poly.lab4.util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> findAll() {

        List<Category> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM categories";

            ResultSet rs = JdbcUtil.executeQuery(sql);

            while (rs.next()) {
                Category c = new Category();

                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Category findById(int id) {

        try {

            String sql = "SELECT * FROM categories WHERE id=?";

            ResultSet rs = JdbcUtil.executeQuery(sql, id);

            if (rs.next()) {
                Category c = new Category();

                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));

                return c;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public void insert(Category c) {

        try {

            String sql = "INSERT INTO categories(name) VALUES(?)";

            JdbcUtil.executeUpdate(sql, c.getName());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(Category c) {

        try {

            String sql = "UPDATE categories SET name=? WHERE id=?";

            JdbcUtil.executeUpdate(sql, c.getName(), c.getId());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        try {
            String sql = "DELETE FROM categories WHERE id=?";
            JdbcUtil.executeUpdate(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
