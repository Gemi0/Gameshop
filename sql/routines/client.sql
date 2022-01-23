#####################################################################
# Gameshop database client entity routines                          #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will generate all routines needed for client entity.   #
#                                                                   #
# THIS FILE ASSUMES YOU HAVE ROOT PRIVILEGES ON YOUR SQL MACHINE.   #
#####################################################################

-- Returns specific developer's games
drop procedure if exists browseDeveloperGames;
create procedure browseDeveloperGames(in id_developer int)
begin
    select * from Game g where g.id_developer = id_developer;
end;

-- Returns specific publisher's games
drop procedure if exists browsePublisherGames;
create procedure browsePublisherGames(in id_publisher int)
begin
    select * from Game g where g.id_publisher = id_publisher;
end;

-- Returns specific genres's games
drop procedure if exists browseGenreGames;
create procedure browseGenreGames(in id_genre int)
begin
    select * from Game g
    join Game_genre Gg on g.id = Gg.id_game
    where Gg.id_game_genre = id_genre;
end;

-- Returns all developers
drop procedure if exists browseDevelopers;
create procedure browseDevelopers()
begin
    select id, name, headquarters from Developer;
end;

-- Returns all publishers
drop procedure if exists browsePublishers;
create procedure browsePublishers()
begin
    select id, name, headquarters from Publisher;
end;

-- Returns all genres
drop procedure if exists browseGenres;
create procedure browseGenres()
begin
    select id, name from Genre;
end;

-- Get game info by it's title
drop procedure if exists getGameByTitle;
CREATE PROCEDURE getGameByTitle(in gameTitle varchar(100))
begin
    SELECT * FROM Game WHERE title = gameTitle;
end;

-- Get dev info by their id
drop procedure if exists getDevById;
CREATE PROCEDURE getDevById(in devID int)
begin
    SELECT d.name, d.headquarters FROM Developer d WHERE d.id = devID;
end;

-- Get publisher info by their id
drop procedure if exists getPubById;
CREATE PROCEDURE getPubById(in pubID int)
begin
    SELECT p.name, p.headquarters FROM Publisher p WHERE p.id = pubID;
end;

-- Returns user's games
drop procedure if exists getUserGames;
CREATE PROCEDURE getUserGames(in user_id int)
begin
    SELECT *
    FROM User_game ug
             JOIN Game g ON g.id = ug.id_game
    WHERE ug.id_user = user_id;
end;

-- Returns info about all the games in the system
drop procedure if exists browseGames;
CREATE PROCEDURE browseGames()
begin
    SELECT * FROM Game;
end;

-- Place a new order for specific user
-- Returns order id
drop procedure if exists placeOrder;
create procedure placeOrder(in user_id int)
begin
    start transaction;
    if (select u.id from User u where u.id = user_id) is null then
        rollback;
    end if;
    insert into Orders(id_user, date) value (user_id, now());
    commit;
    select o.id from Orders o where o.date = now();
end;

-- Adds game to order
drop procedure if exists addGameToOrder;
create procedure addGameToOrder(in order_id int, in game_id int)
begin
    start transaction;
    if (select o.id from Orders o where o.id = order_id) is null then
        rollback;
    end if;
    if (select g.id from Game g where g.id = game_id) is null then
        rollback;
    end if;
    insert into Orders_game(id_order, id_game) value (order_id, game_id);
    commit;
    select order_id;
end;

-- Finalize order
-- Determine sum of bought items and decrease user's balance if the amount is sufficient.
-- If price_sum is too high, delete order and do nothing.
drop procedure if exists finalizeOrder;
create procedure finalizeOrder(in order_id int, in user_id int)
begin
    declare curr_game_id int;
    declare done, price_sum int default 0;
    declare orderGameCur cursor for select id_game from Orders_game where id_order = order_id;
    declare continue handler for not found set done = 1;

    start transaction;
    open orderGameCur;
    orderGameCur:
    loop
        fetch orderGameCur into curr_game_id;
        if done = 1 then leave orderGameCur; end if;
        insert into User_game(id_user, id_game) value (user_id, curr_game_id);
        set price_sum = price_sum + (select price from Game where id = curr_game_id);
    end loop;
    close orderGameCur;
    if (select balance from User_info where id_user = user_id) < price_sum or price_sum = 0 then
        rollback;
        delete from Orders where id = order_id;
        select -1;
    else
        commit;
        call decreaseUserBalance(user_id, price_sum);
        select price_sum;
    end if;
end;
