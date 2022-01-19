package users;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Developer extends AbstractUser {

    @Override
    public void printOptions(){
        System.out.println("1. Add new game\n2. Delete game\n3. Edit price of game\n4. Edit game\n5. Exit");
        try {
            executeInput(reader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    void executeInput(String input) {
        switch (input) {
            case "1" -> addGame();
            case "2" -> deleteGame();
            case "3" -> editPrice();
            case "4" -> editGame();
            case "5" -> System.exit(0);
            default -> {
                System.out.println("No such command");
                printOptions();
            }
        }
    }

    private String checkIfOwnGame() {
        int dev_id = getDevId();
        String gameTitle = getGameTitle();
        int id_from_query =-1;
        try {
            CallableStatement stmt = this.connection.prepareCall("{call getGameByTitle(?)}");
            stmt.setString(1, gameTitle);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                id_from_query = rs.getInt("id_developer");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (dev_id == id_from_query) {
            return gameTitle;
        }
        return null;
    }

    private String getDevName() {
        String name ="";
        try {
            CallableStatement stmt = this.connection.prepareCall("{call getUserById(?)}");
            stmt.setInt(1, user_id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                name= rs.getString("login");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return name;
    }

    private int getDevId() {
        String name = getDevName();
        int id = -1;
        try {
            CallableStatement stmt = this.connection.prepareCall("{call getDevByName(?)}");
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                id= rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }

    private void editGame() {
        try {
            String gameTitle = null;
            while(gameTitle == null){
                gameTitle = checkIfOwnGame();
                if (gameTitle == null) {
                    System.out.println("You are not developer of such game");
                }
            }

            System.out.println("Give the new title: ");
            String new_title = reader.readLine();
            printTable("Publisher");
            System.out.println("Give the new publisher id: ");
            int pub_id = Integer.parseInt(reader.readLine());
            System.out.println("Specify the new price: ");
            int price = Integer.parseInt(reader.readLine());

            CallableStatement stmt = this.connection.prepareCall("{call editGame(?,?,?,?)}");
            stmt.setString(1, new_title);
            stmt.setInt(3, pub_id);
            stmt.setInt(2, price);
            stmt.setString(4,gameTitle);
            stmt.executeUpdate();

            printOptions();

            printOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteGame() {
        try {
            String gameTitle = null;
            while(gameTitle == null){
                gameTitle = checkIfOwnGame();
                if (gameTitle == null) {
                    System.out.println("You are not developer of such game");
                }
            }
            CallableStatement stmt = this.connection.prepareCall("{call deleteGame(?)}");
            stmt.setString(1, gameTitle);
            stmt.execute();

            printOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void editPrice() {
        try {
            String gameTitle = null;
            while(gameTitle == null){
                gameTitle = checkIfOwnGame();
                if (gameTitle == null) {
                    System.out.println("You are not developer of such game");
                }
            }
            System.out.println("Specify new price: ");
            String price = reader.readLine();
            CallableStatement stmt = this.connection.prepareCall("{call editPrice(?)}");
            stmt.setString(1, price);
            stmt.setString(2, gameTitle);
            stmt.executeUpdate();

            printOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addGame() {
        try {
            String gameTitle = null;
            while (gameTitle == null) {
                gameTitle = makeNewTitle();
            }

            printTable("Publisher");
            System.out.println("Give the publisher id: ");
            String pub_id = reader.readLine();
            printTable("Genre");
            System.out.println("Give the genre id: ");
            int gen_id = Integer.parseInt(reader.readLine());
            System.out.println("Specify the price: ");
            int price = Integer.parseInt(reader.readLine());

            CallableStatement stmt = this.connection.prepareCall("{call addGame(?,?,?,?)}");
            stmt.setString(1, gameTitle);
            stmt.setInt(2, getDevId());
            stmt.setString(3, pub_id);
            stmt.setInt(4, price);
            stmt.executeUpdate();

            stmt = this.connection.prepareCall("{call getGameByTitle(?)}");
            stmt.setString(1, gameTitle);
            ResultSet rs = stmt.executeQuery();
            int game_id = -1;
            while (rs.next()) {
                game_id = rs.getInt("id");
            }

            stmt = this.connection.prepareCall("{call insertGenre(?,?)}");
            stmt.setInt(1, game_id);
            stmt.setInt(1, gen_id);
            stmt.executeUpdate();

            printOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String makeNewTitle() {
        String title = null;
        try {
            System.out.println("Specify game title: ");
            title = reader.readLine();
            CallableStatement stmt = this.connection.prepareCall("{call getGameByTitle(?)}");
            stmt.setString(1, title);
            ResultSet rs = stmt.executeQuery();
            String dummy = "";
            while(rs.next()) {
                dummy = rs.getString("title");
            }
            if (dummy.equals("")) {
                return title;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
