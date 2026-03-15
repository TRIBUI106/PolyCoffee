package com.poly.lab4.util;

public class DatabaseConfig {


    public static final String DB_TYPE = "MYSQL";

    public static String getDriver() {
        switch (DB_TYPE) {
            case "MYSQL":
                return "com.mysql.cj.jdbc.Driver";

            case "SQLSERVER":
                return "com.microsoft.sqlserver.jdbc.SQLServerDriver";

            default:
                throw new RuntimeException("Database không hỗ trợ!");
        }
    }

    public static String getUrl() {
        switch (DB_TYPE) {
            case "MYSQL":
                return "jdbc:mysql://localhost:3306/PolyCoffee?useSSL=false&serverTimezone=UTC";

            case "SQLSERVER":
                return "jdbc:sqlserver://localhost:1433;databaseName=PolyCoffee";

            default:
                throw new RuntimeException("Database không hỗ trợ!");
        }
    }

    public static String getUsername() {
        return "root";
    }

    public static String getPassword() {
        return "123";
    }
}