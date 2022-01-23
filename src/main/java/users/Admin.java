package users;

import database.DBConnector;
import org.springframework.security.crypto.bcrypt.BCrypt;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Admin extends Customer {
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
                2. Admin options
                3. Exit""");
        try {
            System.out.print("Command: ");
            switch(reader.readLine()) {
                case "1" -> clientOptions();
                case "2" -> adminOptions();
                case "3" -> exit();
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
                case "3" -> adminOptions();
                default -> {
                    System.out.println("No such command");
                    changeUserType();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void changeToDev() {
        try {
            System.out.print("User ID: ");
            int id  = Integer.parseInt(reader.readLine());
            CallableStatement stmt = this.connection.prepareCall("{call changeUserType(?,?)}");
            stmt.setInt(1,id);
            stmt.setString(2,"dev");
            rs = stmt.executeQuery();
            int user = -1;
            while (rs.next()) {
                user = rs.getInt(1);
                System.out.println("User type changed to dev!");
            }
            if(user == -1) {
                System.out.println("Error while changing the user's type");
                adminOptions();
            }
            System.out.print("Dev headquarters: ");
            String headquarters = reader.readLine();
            stmt = this.connection.prepareCall("{call addDeveloper(?,?)}");
            stmt.setInt(1, id);
            stmt.setString(2, headquarters);
            stmt.execute();
            rs = stmt.getResultSet();
            if(rs == null) {
                System.out.println("Omitting insert, dev already exists");
                adminOptions();
            }
            System.out.println("Developer successfully added!");
            adminOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void changeToCustomer() {
        try {
            System.out.print("User ID: ");
            int id  = Integer.parseInt(reader.readLine());
            CallableStatement stmt = this.connection.prepareCall("{call changeUserType(?,?)}");
            stmt.setFloat(1,id);
            stmt.setString(2,"client");
            rs = stmt.executeQuery();
            int user = -1;
            while (rs.next()) {
                user = rs.getInt(1);
                System.out.println("User type changed to client!");
            }
            if(user == -1) {
                System.out.println("Error while changing the user's type");
                adminOptions();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void decreaseUserBalance() {
        try {
            System.out.print("User ID: ");
            int id  = -1;
            try {
                id = Integer.parseInt(reader.readLine());
            } catch(Exception e) {
                System.out.println("Invalid id");
                adminOptions();
            }
            System.out.print("Amount to decrease: ");
            int amount = -1;
            try {
                amount = Integer.parseInt(reader.readLine());
            } catch(Exception e) {
                System.out.println("Invalid amount");
                adminOptions();
            }
            CallableStatement stmt = this.connection.prepareCall("{call decreaseUserBalance(?,?)}");
            stmt.setFloat(1,id);
            stmt.setInt(2,amount);
            stmt.executeQuery();
            System.out.println("User id=" + id + " balance decreased (-" + amount + ")!");
        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void increaseUserBalance() {
        try {
            System.out.print("User ID: ");
            int id  = -1;
            try {
                id = Integer.parseInt(reader.readLine());
            } catch(Exception e) {
                System.out.println("Invalid id");
                adminOptions();
            }
            System.out.print("Amount to increase: ");
            int amount = -1;
            try {
                amount = Integer.parseInt(reader.readLine());
            } catch(Exception e) {
                System.out.println("Invalid amount");
                adminOptions();
            }
            CallableStatement stmt = this.connection.prepareCall("{call increaseUserBalance(?,?)}");
            stmt.setInt(1,id);
            stmt.setInt(2,amount);
            stmt.executeQuery();
            System.out.println("User id=" + id + " balance increased (+" + amount + ")!");
        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void changeUserPassword() {
        try {
            System.out.print("User ID: ");
            int id  = -1;
            try {
                id = Integer.parseInt(reader.readLine());
            } catch(Exception e) {
                System.out.println("Invalid id");
                adminOptions();
            }
            CallableStatement stmt = this.connection.prepareCall("{call getUsername(?)}");
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if(!rs.next()) {
                System.out.println("Invalid user id provided");
                adminOptions();
            }

            System.out.print("New password: ");
            String pass = reader.readLine();
            stmt = this.connection.prepareCall("{call changeUserPassword(?,?)}");
            stmt.setInt(1,id);
            stmt.setString(2, BCrypt.hashpw(pass, BCrypt.gensalt(10)));
            stmt.executeQuery();
            System.out.println("User id=" + id + " password changed!");
            adminOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
        adminOptions();
    }

    private void figureInflation() {
        try {
            System.out.print("How big is the inflation (give input in format: 1.05): ");
            float inf = Float.parseFloat(reader.readLine());
            CallableStatement stmt = this.connection.prepareCall("{call figureInflation(?)}");
            stmt.setFloat(1,inf);
            stmt.executeQuery();
            System.out.println("Prices changed!");
            adminOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteGame() {
        try {
            System.out.println();
            System.out.println("Delete game");
            System.out.print("Game title: ");
            String gameTitle = getGameTitle();
            if (gameTitle == null) {
                System.out.println("There is no such game");
                adminOptions();
            }
            CallableStatement stmt = this.connection.prepareCall("{call deleteGame(?)}");
            stmt.setString(1, gameTitle);
            rs = stmt.executeQuery();
            int game_id = -1;
            while (rs.next()) {
                game_id = rs.getInt(1);
                System.out.println("Game deleted!");
            }
            if(game_id == -1) {
                System.out.println("Error while deleting the game");
                adminOptions();
            }
            adminOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
