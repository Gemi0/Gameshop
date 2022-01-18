CREATE TRIGGER deleteTrigger AFTER DELETE ON game
    FOR EACH ROW
BEGIN
    DELETE FROM game_genre
        WHERE id_game = OLD.id;
    DELETE FROM user_game
        WHERE id_game = OLD.id;
    DELETE FROM orders_game
        WHERE id_game = OLD.id;
end;