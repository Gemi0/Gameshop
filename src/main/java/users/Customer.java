package users;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Customer extends AbstractUser {

    @Override
    public void printOptions() {
        System.out.println("1. Browse games\n2. Advanced browsing games\n3. Get details about game\n4. Buy game \n5. Exit");
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
            case "5" -> System.exit(0);
            default -> {
                System.out.println("No such command");
                printOptions();
            }
        }
    }

    private void advancedBrowseGames() {
        try {
            final Set<String> values = new HashSet<>(Arrays.asList("developers", "publishers", "genres"));


            System.out.println("'developers' -  Browse by developer\n'publishers' - Browse by publisher\n'genres' - Browse by genre ");
            String browseOption = reader.readLine();
            if (!values.contains(browseOption)) {
                System.out.println("No such option");
                advancedBrowseGames();
                return;
            }
            printTable(browseOption);
            System.out.println("Specify the "+browseOption);
            String filter = reader.readLine();
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM games WHERE ? = ?");
            stmt.setString(1,browseOption);
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
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM aparat WHERE model = ?");
            stmt.setString(1, gameTitle);
            ResultSet rs = stmt.executeQuery();
            String producentId = "";
            while(rs.next()) {
                producentId = rs.getString("producent");
            }

            stmt = connection.prepareStatement("SELECT * FROM producent WHERE ID = ?");
            stmt.setString(1, producentId);
            rs = stmt.executeQuery();
            String producent = "";
            while (rs.next()) {
                producent = rs.getString("nazwa");
            }
            System.out.println("Title: "+gameTitle+ " Producent: "+producent);
            
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
            gamesSet = statement.executeQuery("select * from aparat");
            while(gamesSet.next()) {
                System.out.println(gamesSet.getString("model"));
            }
            printOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
