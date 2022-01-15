package users;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Customer extends AbstractUser {

    @Override
    public void printOptions() {
        System.out.println("1. Browse games\n2. Get details about game\n3. Buy game \n4. Exit");
        try {
            executeInput(reader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void executeInput(String input) {
        switch (input) {
            case "1":
                browseGames();
                break;
            case "2":
                getGameDetails();
                break;
            case "3":
                buyGame();
                break;
            case "4":
                System.exit(0);
            default:
                System.out.println("No such command");
                printOptions();
        }
    }

    private void buyGame() {
        //TODO
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
            System.out.println("Tytuł: "+gameTitle+ " Producent: "+producent);
            
            printOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void browseGames() {
        ResultSet gamesSet = null;
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
