package users;

import main.Main;

import java.io.IOException;
import java.sql.*;
import java.util.*;

public class Customer extends AbstractUser {

    protected static CallableStatement stmt;
    protected static ResultSet rs;


    @Override
    public void printOptions() {
        clientOptions();
    }

    public void clientOptions() {
        System.out.println("""
                
                1. Browse games
                2. Advanced browsing
                3. Get details about a game
                4. Buy games
                5. Show your games
                6. Return
                7. Exit""");
        try {
            System.out.print("Command: ");
            switch (reader.readLine()) {
                case "1" -> browseGames();
                case "2" -> advancedBrowseGames();
                case "3" -> getGameDetails();
                case "4" -> buyGame();
                case "5" -> getUserGames();
                case "6" -> printOptions();
                case "7" -> {
                    System.out.println(" ");
                    exit();
                }
                default -> {
                    System.out.println("No such command");
                    clientOptions();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void advancedBrowseGames() {
        try {
            System.out.println("""
                    
                    1. Browse publishers
                    2. Browse developers
                    3. Browse genres
                    4. Browse games by developer
                    5. Browse games by publisher
                    6. Browse games by genre
                    7. Return""");
            System.out.print("Command: ");
            String browseOption = reader.readLine();

            switch (browseOption) {
                case "1"-> {
                    stmt = connection.prepareCall("{call browsePublishers()}");
                    rs = stmt.executeQuery();
                    System.out.println();
                    System.out.println("Publishers");
                    while(rs.next()) {
                        System.out.println("ID: " + rs.getString("id") + " NAME: " + rs.getString("name") + " HEADQUARTERS: " + rs.getString("headquarters"));
                    }
                    advancedBrowseGames();
                }
                case "2"-> {
                    stmt = connection.prepareCall("{call browseDevelopers()}");
                    rs = stmt.executeQuery();
                    System.out.println();
                    System.out.println("Developers");
                    while(rs.next()) {

                        System.out.println("ID: " + rs.getString("id") + " NAME: " + rs.getString("name") + " HEADQUARTERS: " + rs.getString("headquarters"));
                    }
                    advancedBrowseGames();
                }
                case "3"-> {
                    stmt = connection.prepareCall("{call browseGenres()}");
                    rs = stmt.executeQuery();
                    System.out.println();
                    System.out.println("Genres");
                    while(rs.next()) {
                        System.out.println("ID: " + rs.getString("id") + " NAME: " + rs.getString("name"));
                    }
                    advancedBrowseGames();
                }
                case "4"-> {
                    System.out.print("Developer id: ");
                    String devId = reader.readLine();
                    stmt = connection.prepareCall("{call browseDeveloperGames(?)}");
                    stmt.setString(1, devId);
                    rs = stmt.executeQuery();
                    while(rs.next()) {
                        System.out.println("ID: " + rs.getString("id") + " TITLE: " + rs.getString("title") + " PRICE: " + rs.getString("price"));
                    }
                    advancedBrowseGames();
                }
                case "5"-> {
                    System.out.print("Publisher id: ");
                    String pubId = reader.readLine();
                    stmt = connection.prepareCall("{call browsePublisherGames(?)}");
                    stmt.setString(1, pubId);
                    rs = stmt.executeQuery();
                    while(rs.next()) {
                        System.out.println("ID: " + rs.getString("id") + " TITLE: " + rs.getString("title") + " PRICE: " + rs.getString("price"));
                    }
                    advancedBrowseGames();
                }
                case "6"-> {
                    System.out.print("Genre id: ");
                    String genId = reader.readLine();
                    stmt = connection.prepareCall("{call browseGenreGames(?)}");
                    stmt.setString(1, genId);
                    rs = stmt.executeQuery();
                    while(rs.next()) {
                        System.out.println("ID: " + rs.getString("id") + " TITLE: " + rs.getString("title") + " PRICE: " + rs.getString("price"));
                    }
                    advancedBrowseGames();
                }
                case "7" -> clientOptions();

                default -> {
                    System.out.println("No such command");
                    advancedBrowseGames();
                }
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void buyGame() {
        try {
            stmt = this.connection.prepareCall("{call placeOrder(?)}");
            stmt.setInt(1, user_id);
            rs = stmt.executeQuery();
            int order = -1;
            while(rs.next()) {
                order = rs.getInt("id");
            }
            if(order == -1) {
                System.out.println("Error while placing a new order");
            }

            System.out.println("Buy games");
            System.out.println("Type \"q\" to finish selecting game ids");
            String game_id;
            int temp;
            System.out.print("Game id: ");
            while(!(game_id = reader.readLine()).equals("q")) {
                try {
                    temp = Integer.parseInt(game_id);
                } catch(Exception e) {
                    System.out.println("Invalid game id");
                    System.out.print("Game id: ");
                    continue;
                }
                stmt = this.connection.prepareCall("{call addGameToOrder(?, ?)}");
                stmt.setInt(1, order);
                stmt.setInt(2, temp);
                stmt.executeQuery();
                System.out.print("Game id: ");
            }

            stmt = this.connection.prepareCall("{call finalizeOrder(?, ?)}");
            stmt.setInt(1, order);
            stmt.setInt(2, user_id);
            rs = stmt.executeQuery();

            if(!rs.next()) {
                System.out.println("Error while finalizing the order");
            }
            int result_price = rs.getInt(1);
            if(result_price == -1) {
                System.out.println("Order couldn't have been completed due to insufficient balance/no games selected.");
            } else System.out.println("Order completed! Total sum: " + result_price);
            clientOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void getGameDetails() {
        try {
            System.out.println("Details about the game");
            System.out.print("Game title: ");
            String gameTitle = reader.readLine();
            stmt = connection.prepareCall("{call getGameByTitle(?)}");
            stmt.setString(1, gameTitle);

            rs = stmt.executeQuery();
            String developerId = "";
            String publisherId = "";
            int price = -1;
            int id = -1;

            while(rs.next()) {
                id = rs.getInt("id");
                price = rs.getInt("price");
                developerId = rs.getString("id_developer");
                publisherId = rs.getString("id_publisher");
            }

            if(id == -1) {
                System.out.println("Game not found");
                clientOptions();
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

            System.out.println("ID: " + id + " TITLE: " + gameTitle + " DEVELOPER: " + developer + " PUBLISHER: " + publisher + " PRICE: " + price);
            clientOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void browseGames() {
        try {
            stmt = this.connection.prepareCall("{call browseGames()}");
            rs = stmt.executeQuery();
            while(rs.next()) {
                System.out.println("ID: " + rs.getString("id") + " TITLE: " + rs.getString("title") + " PRICE: " + rs.getString("price"));
            }
            clientOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //TODO: TEST IT
    private void getUserGames() {
        try {
            System.out.println();
            System.out.println("Your games: ");
            stmt = this.connection.prepareCall("{call getUserGames(?)}");
            stmt.setInt(1, user_id);
            rs = stmt.executeQuery();
            int i = 0;
            while (rs.next()) {
                System.out.println("ID: " + rs.getString("id") + " TITLE: " + rs.getString("title"));
                i++;
            }
            if(i == 0) {
                System.out.println("No games found on your account");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        clientOptions();
    }

    protected String getGameTitle() {
        try {
            String title = reader.readLine();
            CallableStatement stmt = this.connection.prepareCall("{call getGameByTitle(?)}");
            stmt.setString(1, title);
            rs = stmt.executeQuery();
            String dummy = "";
            while(rs.next()) {
                dummy = rs.getString("title");
            }
            if (dummy.equals(title)) {
                return title;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
