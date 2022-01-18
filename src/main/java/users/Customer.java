package users;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class Customer extends AbstractUser {

    @Override
    void setUser_id() {
        //TODO set this while creating user
    }

    @Override
    public void printOptions() {
        System.out.println("1. Browse games\n2. Advanced browsing games\n3. Get details about game" +
                "\n4. Buy game \n5. Show your games\n6. Exit");
        try {
            executeInput(reader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void executeInput(String input) {
        switch (input) {
            case "1" -> browseGames();
            case "2" -> advancedBrowseGames();
            case "3" -> getGameDetails();
            case "4" -> buyGame();
            case "5" -> getUserGames();
            case "6" -> System.exit(0);
            default -> {
                System.out.println("No such command");
                printOptions();
            }
        }
    }

    private void advancedBrowseGames() {
        try {
            final Set<String> values = new HashSet<>(Arrays.asList("Developer", "Publisher"));

            System.out.println("'Developer' -  Browse by developer\n'Publisher' - Browse by publisher\n'Genre' - Browse by genre ");
            String browseOption = reader.readLine();
            if (!values.contains(browseOption)) {
                System.out.println("No such option");
                advancedBrowseGames();
                return;
            }
            printTable(browseOption);
            System.out.println("Specify the "+browseOption +" id: ");
            String filter = reader.readLine();
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM Game WHERE ? = ?");
            if (browseOption.equals("Developer")) {
                stmt.setString(1,"id_developer");
            }
            else {
                stmt.setString(1,"id_publisher");
            }
            stmt.setString(2,filter);
            ResultSet games = stmt.executeQuery();
            while (games.next()) {
                System.out.println(games.getString("title"));
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void buyGame() {
        //TODO using transaction
    }

    private void getGameDetails() {
        try {
            String gameTitle = null;
            while(gameTitle == null){
                gameTitle = getGameTitle();
                if (gameTitle == null) {
                    System.out.println("There is no such game");
                }
            }
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM Game WHERE title = ?");
            stmt.setString(1, gameTitle);
            ResultSet rs = stmt.executeQuery();
            String developerId = "";
            String publisherId = "";
            int price =0;

            while(rs.next()) {
                price = rs.getInt("price");
                developerId = rs.getString("id_developer");
                publisherId = rs.getString("id_publisher");
            }

            stmt = connection.prepareStatement("SELECT * FROM Developer WHERE id = ?");
            stmt.setString(1, developerId);
            rs = stmt.executeQuery();
            String developer = "";
            while (rs.next()) {
                developer = rs.getString("name");
            }

            stmt = connection.prepareStatement("SELECT * FROM Publisher WHERE id = ?");
            stmt.setString(1, publisherId);
            rs = stmt.executeQuery();
            String publisher = "";
            while (rs.next()) {
                publisher = rs.getString("name");
            }

            System.out.println("Title: "+gameTitle+ " Developer: "+developer + " Publisher: "+ publisher+" Price: "+price);
            
            printOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void browseGames() {
        ResultSet gamesSet;
        try {
            Statement statement = connection.createStatement();
            gamesSet = statement.executeQuery("select * from Game");
            while(gamesSet.next()) {
                System.out.println(gamesSet.getString("title"));
            }
            printOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void getUserGames() {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM User_game " +
                    "JOIN Game ON Game.id = User_game.id_game WHERE id_user = ?");
            stmt.setInt(1,user_id);
            ResultSet games = stmt.executeQuery();
            while (games.next()) {
                System.out.println(games.getString("title"));
            }
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
    }
}
