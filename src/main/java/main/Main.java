package main;

import database.DBConnector;
import users.Admin;
import users.Customer;
import users.Developer;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;


public class Main {

    private static Connection connection;
    private static BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

    public static void main(String[] args) {
        connect();
        printOptions();
    }

    private static void connect() {
        try {
            connection = DBConnector.getAuthConnection();

        }
        catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private static void printOptions() {
        System.out.println("""
                1. Register
                2. Login
                3. Exit""");
        try {
            executeInput(reader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void executeInput(String input) {
        switch (input) {
            case "1" -> register();
            case "2" -> login();
            case "3" -> System.exit(0);
            default -> {
                System.out.println("No such command");
                printOptions();
            }
        }
    }

    private static void register() {
        System.out.println("Login: ");
        try {
            String login = reader.readLine();
            System.out.println("Password: ");
            String password = reader.readLine();

            CallableStatement stmt = connection.prepareCall("{call registerUser(?,?)}");
            stmt.setString(1, login);
            stmt.setString(2,password);
            stmt.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        printOptions();
    }

    private static void login(){
        System.out.println("Login: ");
        try {
            String login = reader.readLine();
            System.out.println("Password: ");
            String password = reader.readLine();
            //TODO check if login and password correct
            if (true) { //logged in succesfully
                CallableStatement stmt = connection.prepareCall("{call getUserByName(?)}");
                stmt.setString(1, login);
                stmt.executeQuery();
                ResultSet rs = stmt.executeQuery();

                int id = -1;
                while (rs.next()) {
                    id= rs.getInt("id");
                }
                createUser(id);
            }
            else {
                System.out.println("Login or password incorrect");
                printOptions();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static void createUser(int id) {
        try {
            CallableStatement stmt = connection.prepareCall("{call getUserType(?)}");
            stmt.setInt(1, id);
            stmt.executeQuery();
            ResultSet rs = stmt.executeQuery();
            String type = "";
            while (rs.next()) {
                type= rs.getString("type");
            }
            switch (type) {
                case "admin":
                    Admin admin = new Admin();
                    admin.setUser_id(id);
                case "dev":
                    Developer developer = new Developer();
                    developer.setUser_id(id);
                case "client":
                    Customer customer = new Customer();
                    customer.setUser_id(id);
                default:
                    System.out.println("Error");
                    printOptions();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
