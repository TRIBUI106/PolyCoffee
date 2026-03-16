package util;

import java.sql.*;

public class JdbcUtil {
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=PolyCoffee;encrypt=true;trustServerCertificate=true";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "123";

    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
    }

    public static PreparedStatement createPreparedStatement(String sql, Object... values) throws SQLException {
        Connection connection = getConnection();
        PreparedStatement stmt = sql.trim().startsWith("{")
                ? connection.prepareCall(sql)
                : connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        for (int i = 0; i < values.length; i++) {
            stmt.setObject(i + 1, values[i]);
        }
        return stmt;
    }

    public static ResultSet executeQuery(String sql, Object... values) throws SQLException {
        PreparedStatement stmt = createPreparedStatement(sql, values);
        return stmt.executeQuery();
    }

    public static int executeUpdate(String sql, Object... values) throws SQLException {
        PreparedStatement stmt = createPreparedStatement(sql, values);
        return stmt.executeUpdate();
    }

    public static Integer executeInsert(String sql, Object... values) throws SQLException {
        PreparedStatement stmt = createPreparedStatement(sql, values);
        int affectedRows = stmt.executeUpdate();

        if (affectedRows > 0) {
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return null;
    }
}