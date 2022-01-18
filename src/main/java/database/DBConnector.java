package database;

import java.sql.*;

public class DBConnector {

    public static Connection getConnection() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_gameshop", "root", "");
        return connection;
    }
}
