package database;

import java.sql.*;

public class DBConnector {

    public static Connection getAuthConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/db_gameshop?noAccessToProcedureBodies=true", "auth", "verysecretauth");
    }

    public static Connection getCustomerConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/db_gameshop?noAccessToProcedureBodies=true", "client", "verysecretclient");
    }

    public static Connection getAdminConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/db_gameshop?noAccessToProcedureBodies=true", "admin", "verysecretadmin");
    }

    public static Connection getDevConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/db_gameshop?noAccessToProcedureBodies=true", "developer", "verysecretdeveloper");
    }
}
