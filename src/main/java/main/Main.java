package main;

import database.DBConnector;
import org.springframework.security.crypto.bcrypt.BCrypt;
import users.Admin;
import users.Customer;
import users.Developer;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;


public class Main {

    private static Connection connection;
    private static CallableStatement stmt;
    private static ResultSet rs;
    private static BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

    public static void main(String[] args) {
        connect();
        printOptions();
    }

    public static void clearConsole() {
        System.out.println(System.lineSeparator().repeat(50));
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
            System.out.print("Command: ");
            executeInput(reader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void executeInput(String input) {
        System.out.println();
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
        System.out.println("Register new user");
        System.out.print("Login: ");
        try {
            String login = reader.readLine();
            System.out.print("Password: ");
            String password = reader.readLine();
            if(login.equals("") || password.equals("")) {
                System.out.println("Invalid login or password");
                printOptions();
            }
            stmt = connection.prepareCall("{call registerUser(?,?)}");
            stmt.setString(1, login);
            stmt.setString(2, BCrypt.hashpw(password, BCrypt.gensalt(10)));
            stmt.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        printOptions();
    }

    private static boolean checkPwd(String log, String pwd) throws SQLException {
        stmt = connection.prepareCall("{call getUserPassword(?)}");
        stmt.setString(1, log);
        rs = stmt.executeQuery();
        String dbPwd = null;
        while(rs.next()) {
            dbPwd = rs.getString("password");
        }
        return dbPwd != null && BCrypt.checkpw(pwd, dbPwd);
    }

    private static void login(){
        System.out.println("Login into existing user");
        System.out.print("Login: ");
        try {
            String login = reader.readLine();
            System.out.print("Password: ");
            String password = reader.readLine();
            try {
                if (!checkPwd(login, password)) {
                    System.out.println("Log or password incorrect");
                    printOptions();
                }
            } catch(Exception e) {
                System.out.println("Bcrypt failed");
                printOptions();
            }
            stmt = connection.prepareCall("{call login(?)}");
            stmt.setString(1, login);
            stmt.executeQuery();
            rs = stmt.executeQuery();
            int id = -1;
            while (rs.next()) {
                id= rs.getInt("id");
            }
            createUser(id, login);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static void createUser(int id, String login) {
        try {
            stmt = connection.prepareCall("{call getUserType(?)}");
            stmt.setInt(1, id);
            stmt.executeQuery();
            rs = stmt.executeQuery();
            String type = "";
            while (rs.next()) {
                type= rs.getString("type").strip();
            }
            switch (type) {
                case "admin" -> {
                    Admin admin = new Admin();
                    admin.setUser_id(id);
                    admin.setUsername(login);
                    admin.printOptions();
                }
                case "dev" -> {
                    Developer developer = new Developer();
                    developer.setUser_id(id);
                    developer.setUsername(login);
                    developer.printOptions();
                }
                case "client" -> {
                    Customer customer = new Customer();
                    customer.setUser_id(id);
                    customer.setUsername(login);
                    customer.printOptions();
                }
                default -> {
                    System.out.println("Error");
                    printOptions();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
