package users;

import database.DBConnector;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.*;

public abstract class AbstractUser {

    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

    public Connection connection;
    {
        try {
            connection = DBConnector.getCustomerConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    int user_id;
    String username;

    public void setUsername(String name) { username = name; }
    public void setUser_id(int id) {
        user_id = id;
    }
    abstract void printOptions();

    protected void exit() {
        System.out.println("Goodbye!");
        System.exit(1);
    }
}
