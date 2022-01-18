package users;

import java.io.IOException;
import java.sql.PreparedStatement;

public class Admin extends AbstractUser{
    @Override
    void setUser_id() {

    }

    @Override
    void printOptions() {
        System.out.println("1. View table\n2. Delete game\n3. Figure inflation in prices \n4. Exit");
        try {
            executeInput(reader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    void executeInput(String input) {
        switch (input) {
            case "1" -> viewTable();
            case "2" -> deleteGame();
            case "3" -> figureInflation();
            case "4" -> System.exit(0);
            default -> {
                System.out.println("No such command");
                printOptions();
            }
        }
    }

    private void figureInflation() {
        //TODO using transaction/procedure
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
            PreparedStatement stmt = connection.prepareStatement("DELETE FROM Game where title = ?");
            stmt.setString(1, gameTitle);
            stmt.execute();

            printOptions();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void viewTable() {
        try {
            System.out.println("Specify table name: ");
            printTable(reader.readLine());
        } catch (IOException e) {
            e.printStackTrace();
        }
        printOptions();
    }
}
