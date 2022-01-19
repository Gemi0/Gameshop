package database;

import java.sql.*;

public class DBConnector {

    public static Connection getAuthConnection() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_gameshop?noAccessToProcedureBodies=true", "auth", "verysecretauth");
        return connection;
    }

    public static Connection getCustomerConnection() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_gameshop?noAccessToProcedureBodies=true", "client", "verysecretclient");
        return connection;
    }

    public static Connection getAdminConnection() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_gameshop?noAccessToProcedureBodies=true", "admin", "verysecretadmin");
        return connection;
    }

    public static Connection getDevConnection() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_gameshop?noAccessToProcedureBodies=true", "developer", "verysecretdeveloper");
        return connection;
    }
}
