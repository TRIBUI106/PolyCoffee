package dao;

import entity.Drink;
import util.JdbcUtil;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DrinkDAO implements CrudDAO<Drink, Integer> {

    @Override
    public Integer create(Drink entity) {
        String sql = "INSERT INTO drinks(name, price, category_id, active) VALUES (?, ?, ?, ?)";
        try {
            return JdbcUtil.executeInsert(sql,
                    entity.getName(),
                    entity.getPrice(),
                    entity.getCategoryId(),
                    entity.isActive());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void update(Drink entity) {
        String sql = "UPDATE drinks SET name = ?, price = ?, category_id = ?, active = ? WHERE id = ?";
        try {
            JdbcUtil.executeUpdate(sql,
                    entity.getName(),
                    entity.getPrice(),
                    entity.getCategoryId(),
                    entity.isActive(),
                    entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteById(Integer id) {
        String sql = "DELETE FROM drinks WHERE id = ?";
        try {
            JdbcUtil.executeUpdate(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Drink> findAll() {
        List<Drink> list = new ArrayList<>();
        String sql = "SELECT * FROM drinks";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql);
            while (rs.next()) {
                Drink drink = new Drink(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getBoolean("active")
                );
                list.add(drink);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Drink findById(Integer id) {
        String sql = "SELECT * FROM drinks WHERE id = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, id);
            if (rs.next()) {
                return new Drink(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getBoolean("active")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}