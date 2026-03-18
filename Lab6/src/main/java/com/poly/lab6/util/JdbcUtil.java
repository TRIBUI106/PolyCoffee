package com.poly.lab6.util;

import java.sql.*;

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

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        if (conn == null || conn.isClosed()) {
            Class.forName(DatabaseConfig.getDriver());
            conn = DriverManager.getConnection(
                    DatabaseConfig.getUrl(),
                    DatabaseConfig.getUsername(),
                    DatabaseConfig.getPassword()
            );
        }
        return conn;
    }

    // Sửa lại các hàm executeQuery và executeUpdate để dùng getConnection() mới
    public static ResultSet executeQuery(String sql, Object... args) throws Exception {
        // Luôn gọi getConnection() thay vì dùng trực tiếp biến conn
        PreparedStatement ps = getConnection().prepareStatement(sql);
        for (int i = 0; i < args.length; i++) {
            ps.setObject(i + 1, args[i]);
        }

        return ps.executeQuery();

    }

    public static int executeUpdate(String sql, Object... args) throws Exception {
        PreparedStatement ps = getConnection().prepareStatement(sql);
        for (int i = 0; i < args.length; i++) {
            ps.setObject(i + 1, args[i]);
        }
        return ps.executeUpdate();
    }
}