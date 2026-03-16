package dao;

import entity.Category;
import util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO implements CrudDAO<Category, Integer> {

    @Override
    public Integer create(Category entity) {
        String sql = "INSERT INTO categories(name, active) VALUES (?, ?)";
        try {
            return JdbcUtil.executeInsert(sql, entity.getName(), entity.isActive());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(Category entity) {
        String sql = "UPDATE categories SET name = ?, active = ? WHERE id = ?";
        try {
            JdbcUtil.executeUpdate(sql, entity.getName(), entity.isActive(), entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteById(Integer id) {
        String sql = "DELETE FROM categories WHERE id = ?";
        try {
            JdbcUtil.executeUpdate(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getBoolean("active")
                );
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Category findById(Integer id) {
        String sql = "SELECT * FROM categories WHERE id = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                return new Category(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getBoolean("active")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}