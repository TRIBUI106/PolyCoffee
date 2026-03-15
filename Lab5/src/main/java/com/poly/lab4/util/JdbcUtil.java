package com.poly.lab4.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JdbcUtil {

    private static Connection conn;

    static {
        try {
            Class.forName(DatabaseConfig.getDriver());

            conn = DriverManager.getConnection(
                    DatabaseConfig.getUrl(),
                    DatabaseConfig.getUsername(),
                    DatabaseConfig.getPassword()
            );

            System.out.println("Kết nối database thành công!");

        } catch (Exception e) {
            System.out.println("Kết nối database thất bại!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        return conn;
    }

    public static ResultSet executeQuery(String sql, Object... args) throws Exception {

        PreparedStatement ps = conn.prepareStatement(sql);

        for (int i = 0; i < args.length; i++) {
            ps.setObject(i + 1, args[i]);
        }

        return ps.executeQuery();
    }

    public static int executeUpdate(String sql, Object... args) throws Exception {

        PreparedStatement ps = conn.prepareStatement(sql);

        for (int i = 0; i < args.length; i++) {
            ps.setObject(i + 1, args[i]);
        }

        return ps.executeUpdate();
    }
}