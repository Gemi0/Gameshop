package users;

import database.DBConnector;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;

public abstract class AbstractUser {

    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

    Connection connection;

    {
        try {
            connection = DBConnector.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    abstract void printOptions();

    abstract void executeInput(String input);

    protected String getGameTitle() {
        try {
            System.out.println("Specify game title: ");
            String title = reader.readLine();
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM aparat WHERE model = ?");
            stmt.setString(1, title);
            ResultSet rs = stmt.executeQuery();
            String dummy = "";
            while(rs.next()) {
                dummy = rs.getString("model");
            }
            if (dummy.equals(title)) {
                return title;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    protected void printTable(String table) {
        String sql = "SELECT * FROM " +table;
        Statement stmt = null;
        try {
            stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            ResultSetMetaData metadata = rs.getMetaData();
            int columnCount = metadata.getColumnCount();
            while (rs.next()) {
                String row = "";
                for (int i = 1; i <= columnCount; i++) {
                    row += rs.getString(i) + ", ";
                }
                System.out.println(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
