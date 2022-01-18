CREATE PROCEDURE figureInflation(procent float)
BEGIN
    SET autocommit = 0;
    START TRANSACTION;
    UPDATE game
    SET price = price*procent;
    COMMIT;
end;

CREATE PROCEDURE buyGame(gameTitle varchar(30), user_id int)
begin

end;

CREATE PROCEDURE deleteGame(gameTitle varchar(50))
BEGIN
    DELETE FROM Game where title = gameTitle;
end;

CREATE PROCEDURE  advancedBrowseGames(browseOption varchar(30), filters varchar(30))
begin
    SELECT * FROM Game WHERE browseOption = filters;
end;

CREATE PROCEDURE getGameByTitle(gameTitle varchar(50))
begin
    SELECT * FROM Game WHERE title = gameTitle;
end;

CREATE PROCEDURE getDevById(devID int)
begin
    SELECT * FROM Developer WHERE id = devID;
end;

CREATE PROCEDURE getPubById(pubID int)
begin
    SELECT * FROM publisher WHERE id = pubID;
end;

CREATE PROCEDURE getUserGames(user_id int)
begin
    SELECT * FROM User_game JOIN Game ON Game.id = User_game.id_game WHERE id_user = user_id;
end;

CREATE PROCEDURE browseGames()
begin
    SELECT * FROM game;
end;

CREATE PROCEDURE getUserById(user_id int)
begin
    SELECT * FROM User WHERE id = user_id;
end;

CREATE PROCEDURE getDevByName(dev_name varchar(30))
begin
    SELECT * FROM Developer WHERE name = dev_name;
end;

CREATE PROCEDURE editGame(new_title varchar(30), pub_id varchar(30), new_price int, gameTitle varchar(30))
begin
    UPDATE Game SET title = new_title, price = new_price, id_publisher = pub_id WHERE title = gameTitle;
end;

CREATE PROCEDURE editPrice(new_price int, gameTitle varchar(30))
begin
    UPDATE Game SET price = new_price WHERE title = gameTitle;
end;

CREATE PROCEDURE addGame(gameTitle varchar(30), dev_id int, pub_id int, new_price int)
begin
    INSERT INTO Game VALUE (DEFAULT,gameTitle,dev_id,pub_id,new_price);
end;

CREATE PROCEDURE insertGenre(game_id int, genre_id int)
begin
    INSERT INTO Game_genre VALUE (game_id,genre_id);
end;