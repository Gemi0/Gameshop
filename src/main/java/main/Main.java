package main;

import database.DBConnector;
import users.Customer;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;


public class Main {

    private static Statement statement;
    private static BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

    public static void main(String[] args) throws IOException {
        connect();
        login();
    }

    private static void connect() {
        try {
            Connection connection = DBConnector.getConnection();

            statement = connection.createStatement();
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private static void login() throws IOException {
        System.out.println("Login: ");
        String login = reader.readLine();
        System.out.println("Password: ");
        String password = reader.readLine();
        //TODO check if login and password correct
        //TODO check what type is the user and create correct instance
        Customer customer = new Customer();
        customer.printOptions();
    }
}
