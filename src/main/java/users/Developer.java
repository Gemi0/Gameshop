package users;

import database.DBConnector;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.SQLException;

public class Developer extends Customer {

    {
        try {
            connection = DBConnector.getDevConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void printOptions(){
        System.out.println("""
                
                1. Customer options
                2. Developer options
                3. Exit""");
        try {
            System.out.print("Command: ");
            switch(reader.readLine()) {
                case "1" -> clientOptions();
                case "2" -> developerOptions();
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

    public void developerOptions() {
        System.out.println("""
                
                1. Add new game
                2. Delete game
                3. Edit price of game
                4. Edit game
                5. Return
                6. Exit""");
        try {
            System.out.print("Command: ");
            switch (reader.readLine()) {
                case "1" -> addGame();
                case "2" -> deleteGame();
                case "3" -> editPrice();
                case "4" -> editGame();
                case "5" -> printOptions();
                case "6" -> exit();
                default -> {
                    System.out.println("No such command");
                    developerOptions();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String checkIfOwnGame() {
        int dev_id = getDevId();
        String gameTitle = getGameTitle();
        int id_from_query =-1;
        try {
            CallableStatement stmt = connection.prepareCall("{call getGameByTitle(?)}");
            stmt.setString(1, gameTitle);
            rs = stmt.executeQuery();
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

    private int getDevId() {
        String name = getDevName();
        int id = -1;
        try {
            CallableStatement stmt = connection.prepareCall("{call getDevByName(?)}");
            stmt.setString(1, name);
            rs = stmt.executeQuery();
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
            System.out.println();
            System.out.println("Edit game");
            System.out.print("Game title: ");
            String gameTitle = checkIfOwnGame();
            if (gameTitle == null) {
                System.out.println("You are not the developer of this game");
                developerOptions();
            }

            System.out.print("New title: ");
            String new_title = reader.readLine();
            System.out.print("New publisher id: ");
            int pub_id = -1;
            try {
               pub_id = Integer.parseInt(reader.readLine());
            } catch(Exception e) {
                System.out.println("Invalid publisher id");
                developerOptions();
            }
            System.out.print("New price: ");
            int price = -1;
            try {
                price = Integer.parseInt(reader.readLine());
            } catch(Exception e) {
                System.out.println("Invalid price");
                developerOptions();
            }

            CallableStatement stmt = connection.prepareCall("{call editGame(?,?,?,?)}");
            stmt.setString(1, gameTitle);
            stmt.setString(2, new_title);
            stmt.setInt(3, pub_id);
            stmt.setInt(4, price);
            rs = stmt.executeQuery();
            int game_id = -1;
            while (rs.next()) {
                System.out.println("Game edited!");
                game_id = rs.getInt(1);
            }
            if(game_id == -1) {
                System.out.println("Error while editing the game");
                developerOptions();
            }
            developerOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteGame() {
        try {
            System.out.println();
            System.out.println("Delete game");
            System.out.print("Game title: ");
            String gameTitle = checkIfOwnGame();
            if (gameTitle == null) {
                System.out.println("You are not the developer of this game");
                developerOptions();
            }

            CallableStatement stmt = connection.prepareCall("{call deleteGame(?)}");
            stmt.setString(1, gameTitle);
            rs = stmt.executeQuery();
            int game_id = -1;
            while (rs.next()) {
                System.out.println("Game deleted!");
                game_id = rs.getInt(1);
            }
            if(game_id == -1) {
                System.out.println("Error while deleting the game");
                developerOptions();
            }
            developerOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void editPrice() {
        try {
            System.out.println();
            System.out.println("Edit price");
            System.out.print("Game title: ");
            String gameTitle = checkIfOwnGame();
            if (gameTitle == null) {
                System.out.println("You are not the developer of this game");
                developerOptions();
            }
            System.out.print("Price: ");
            int price = -1;
            try {
                price = Integer.parseInt(reader.readLine());
            } catch(Exception e) {
                System.out.println("Invalid price");
                developerOptions();
            }
            CallableStatement stmt = connection.prepareCall("{call editPrice(?, ?)}");
            stmt.setInt(1, price);
            stmt.setString(2, gameTitle);
            rs = stmt.executeQuery();
            int game_id = -1;
            while (rs.next()) {
                System.out.println("Game price changed!");
                game_id = rs.getInt(1);
            }
            if(game_id == -1) {
                System.out.println("Error while editing the price");
                developerOptions();
            }
            developerOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addGame() {
        stmt = null;
        try {
            System.out.println();
            System.out.println("Add new game");
            System.out.print("Game title: ");
            String gameTitle = makeNewTitle();
            if(gameTitle == null) {
                System.out.println("Game with this title already exists!");
                developerOptions();
            }

            System.out.print("Publisher id: ");
            String pub_id = reader.readLine();
            System.out.print("Price: ");
            String price_str = reader.readLine();
            int price = -1;
            int temp = -1;
            try {
                temp = Integer.parseInt(pub_id);
                price = Integer.parseInt(price_str);
            } catch(Exception e) {
                System.out.println("Invalid integer");
                developerOptions();
            }
            if(temp == -1 || price == -1) developerOptions();

            CallableStatement stmt = connection.prepareCall("call addGame(?, ?, ?, ?)");
            stmt.setString(1, gameTitle);
            stmt.setInt(2, getDevId());
            stmt.setInt(3, temp);
            stmt.setInt(4, price);
            rs = stmt.executeQuery();

            int game_id = -1;
            while (rs.next()) {
                System.out.println("Game added!");
                game_id = rs.getInt(1);
            }
            if(game_id == -1) {
                System.out.println("Error while adding the game");
                developerOptions();
            }

            System.out.println("Genres");
            System.out.println("Type \"q\" to finish selecting genre ids");
            String gen_id;

            System.out.print("Genre id: ");
            while(!(gen_id = reader.readLine()).equals("q")) {
                try {
                    temp = Integer.parseInt(gen_id);
                } catch(Exception e) {
                    System.out.println("Invalid genre id");
                    System.out.print("Genre id: ");
                    continue;
                }
                stmt = connection.prepareCall("{call insertGameGenre(?, ?)}");
                stmt.setInt(1, game_id);
                stmt.setInt(2, temp);
                stmt.executeQuery();
                System.out.println("Game genre added!");
                System.out.print("Genre id: ");
            }
            developerOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String makeNewTitle() {
        String title;
        try {
            title = reader.readLine();
            CallableStatement stmt = connection.prepareCall("{call getGameByTitle(?)}");
            stmt.setString(1, title);
            rs = stmt.executeQuery();
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
