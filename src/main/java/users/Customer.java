package users;

import java.io.IOException;
import java.sql.*;
import java.util.*;

public class Customer extends AbstractUser {

    @Override
    public void printOptions() {
        System.out.println("""
                1. Browse games
                2. Advanced browsing games
                3. Get details about game
                4. Buy game\s
                5. Show your games
                6. Exit""");
        try {
            executeInput(reader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void executeInput(String input) {
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
            CallableStatement stmt = this.connection.prepareCall("{call advancedBrowseGames(?,?)}");
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

            printOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void buyGame() {
        try {
            String gameTitle = null;
            while (gameTitle == null) {
                gameTitle = getGameTitle();
                if (gameTitle == null) {
                    System.out.println("There is no such game");
                }
            }
            CallableStatement stmt = this.connection.prepareCall("{call buyGame(?,?)}");
            stmt.setString(1, gameTitle);
            stmt.setInt(2,user_id);
            stmt.executeQuery();

            printOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
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
            CallableStatement stmt = this.connection.prepareCall("{call getGameByTitle(?)}");
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

            stmt = connection.prepareCall("{call getDevById(?)}");
            stmt.setString(1, developerId);
            rs = stmt.executeQuery();
            String developer = "";
            while (rs.next()) {
                developer = rs.getString("name");
            }

            stmt = connection.prepareCall("{call getPubById(?)}");
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
            CallableStatement statement = this.connection.prepareCall("{call browseGames()}");
            gamesSet = statement.executeQuery();
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
            CallableStatement stmt = this.connection.prepareCall("{call getUserGames(?)}");
            stmt.setInt(1,user_id);
            ResultSet games = stmt.executeQuery();
            while (games.next()) {
                System.out.println(games.getString("title"));
            }
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
        printOptions();
    }
}
