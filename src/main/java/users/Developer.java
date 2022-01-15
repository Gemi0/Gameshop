package users;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Developer extends AbstractUser {
    @Override
    void printOptions(){
        System.out.println("1. Add new game\n2. Edit price of game\n3. Exit");
        try {
            executeInput(reader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    void executeInput(String input) {
        switch (input) {
            case "1":
                addGame();
                break;
            case "2":
                editPrice();
                break;
            case "3":
                System.exit(0);
            default:
                System.out.println("No such command");
                printOptions();
        }
    }

    private void editPrice() {
        //TODO
    }

    private void addGame() {
        try {
            String gameTitle = "dummy";
            while (gameTitle != null) {
                gameTitle = getGameTitle();
                if (gameTitle != null) {
                    System.out.println("There is already such game");
                }
            }
            printTable("developers");
            System.out.println("Give the developer id: ");
            String dev_id = reader.readLine();
            printTable("publishers");
            System.out.println("Give the publisher id: ");
            String pub_id = reader.readLine();
            printTable("genres");
            System.out.println("Give the genre id: ");
            String gen_id = reader.readLine();
            System.out.println("Specify the price: ");
            String price = reader.readLine();
            PreparedStatement stmt = connection.prepareStatement("INSERT INTO games VALUE (?,?,?,?,?)");
            stmt.setString(1, gameTitle);
            stmt.setString(2, dev_id);
            stmt.setString(3, pub_id);
            stmt.setString(4, gen_id);
            stmt.setString(5, price);
            ResultSet rs = stmt.executeQuery();

            printOptions();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
