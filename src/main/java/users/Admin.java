package users;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Admin extends AbstractUser{

    @Override
    public void printOptions() {
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
        try {
            System.out.println("How big is the inflation (give input in format: 1.05): ");
            float inf = Float.parseFloat(reader.readLine());
            CallableStatement cs = this.connection.prepareCall("{call figureInflation(?)}");
            cs.setFloat(1,inf);
            cs.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
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
            CallableStatement stmt = this.connection.prepareCall("{call deleteGame(?)}");
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
