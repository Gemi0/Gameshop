package users;

import database.DBConnector;
import org.springframework.security.crypto.bcrypt.BCrypt;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Admin extends Developer {
    {
        try {
            connection = DBConnector.getAdminConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void printOptions(){
        System.out.println("""
                
                1. Customer options
                2. Developer options
                3. Admin options
                4. Exit""");
        try {
            System.out.print("Command: ");
            switch(reader.readLine()) {
                case "1" -> clientOptions();
                case "2" -> developerOptions();
                case "3" -> adminOptions();
                case "4" -> exit();
                default -> {
                    System.out.println("No such command");
                    printOptions();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void adminOptions() {
        System.out.println("""
                
                1. Delete game
                2. Figure inflation in prices
                3. Change user's password
                4. Increase user's balance
                5. Decrease user's balance
                6. Change user's type
                7. Return
                8. Exit""");
        try {
            System.out.print("Command: ");
            switch (reader.readLine()) {
                case "1" -> deleteGame();
                case "2" -> figureInflation();
                case "3" -> changeUserPassword();
                case "4" -> increaseUserBalance();
                case "5" -> decreaseUserBalance();
                case "6" -> changeUserType();
                case "7" -> printOptions();
                case "8" -> exit();
                default -> {
                    System.out.println("No such command");
                    adminOptions();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void changeUserType() {
        System.out.println("""
                
                1. Change to customer
                2. Change to developer
                3. Return
                """);
        try {
            System.out.print("Command: ");
            switch (reader.readLine()) {
                case "1" -> changeToCustomer();
                case "2" -> changeToDev();
                case "3" -> printOptions();
                default -> {
                    System.out.println("No such command");
                    adminOptions();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void changeToDev() {
        try {
            System.out.println("User ID: ");
            int id  = Integer.parseInt(reader.readLine());
            CallableStatement stmt = this.connection.prepareCall("{call changeUserType(?,?)}");
            stmt.setFloat(1,id);
            stmt.setString(2,"dev");
            stmt.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void changeToCustomer() {
        try {
            System.out.println("User ID: ");
            int id  = Integer.parseInt(reader.readLine());
            CallableStatement stmt = this.connection.prepareCall("{call changeUserType(?,?)}");
            stmt.setFloat(1,id);
            stmt.setString(2,"client");
            stmt.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void decreaseUserBalance() {
        try {
            System.out.println("User ID: ");
            int id  = Integer.parseInt(reader.readLine());
            System.out.println("Amount to decrease: ");
            int amount = Integer.parseInt(reader.readLine());
            CallableStatement stmt = this.connection.prepareCall("{call decreaseUserBalance(?,?)}");
            stmt.setFloat(1,id);
            stmt.setInt(2,amount);
            stmt.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void increaseUserBalance() {
        try {
            System.out.println("User ID: ");
            int id  = Integer.parseInt(reader.readLine());
            System.out.println("Amount to increase: ");
            int amount = Integer.parseInt(reader.readLine());
            CallableStatement stmt = this.connection.prepareCall("{call increaseUserBalance(?,?)}");
            stmt.setFloat(1,id);
            stmt.setInt(2,amount);
            stmt.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void changeUserPassword() {
        try {
            System.out.println("User ID: ");
            int id  = Integer.parseInt(reader.readLine());
            System.out.println("New password: ");
            String pass = reader.readLine();
            CallableStatement stmt = this.connection.prepareCall("{call changeUserPassword(?,?)}");
            stmt.setFloat(1,id);
            stmt.setString(2, BCrypt.hashpw(pass, BCrypt.gensalt(10)));
            stmt.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void figureInflation() {
        try {
            System.out.println("How big is the inflation (give input in format: 1.05): ");
            float inf = Float.parseFloat(reader.readLine());
            CallableStatement stmt = this.connection.prepareCall("{call figureInflation(?)}");
            stmt.setFloat(1,inf);
            stmt.executeQuery();

            adminOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteGame() {
        try {
            String gameTitle = null;
            while (gameTitle == null) {
                gameTitle = getGameTitle();
                if (gameTitle == null) {
                    System.out.println("There is no such game");
                }
            }
            CallableStatement stmt = this.connection.prepareCall("{call deleteGame(?)}");
            stmt.setString(1, gameTitle);
            stmt.executeQuery();

            adminOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
