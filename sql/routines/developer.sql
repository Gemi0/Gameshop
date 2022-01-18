#####################################################################
# Gameshop database user entity routines                            #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will generate all routines needed for developer entity.#
#                                                                   #
# THIS FILE ASSUMES YOU HAVE ROOT PRIVILEGES ON YOUR SQL MACHINE.   #
#####################################################################

-- Delete developer's game
-- If user_id doesn't match game developer_id, rollback;
-- Returns deleted game's id
drop procedure if exists deleteGame;
create procedure deleteGame(in user_id int, in gameTitle varchar(100))
begin
    declare game_id int;
start transaction;
set game_id = (select g.id from Game g where g.title = gameTitle);
    if game_id is null then
        rollback;
end if;
    if user_id != (select g.id_developer from Game g where g.title = gameTitle) then
        rollback;
end if;
delete from Game where title = gameTitle;
commit;
select game_id;
end;

-- Edits developer's game
-- If one of the fields wasn't specified it is replaced by the old one.
drop procedure if exists editGame;
CREATE PROCEDURE editGame(in gameTitle varchar(100), in new_title varchar(100), in pub_id int, in new_price int)
begin
    declare id_game int;
    declare old_pub_id int;
    declare old_price int;
start transaction;
set id_game = (select g.id from Game g where g.title = gameTitle);
    set old_pub_id = (select g.id_publisher from Game g where g.id = id_game);
    set old_price = (select g.price from Game g where g.id = id_game);
    if id_game is null then
        rollback;
end if;
    if new_title is null then
        set new_title = gameTitle;
end if;
    if pub_id is null then
        set pub_id = old_pub_id;
end if;
    if new_price is null or new_price < 0 then
        set new_price = old_price;
end if;
UPDATE Game SET title = new_title, price = new_price, id_publisher = pub_id WHERE title = gameTitle;
commit;
select id_game;
end;

-- Edit developer game's price
-- If price was null or invalid - nothing is changed
drop procedure if exists editPrice;
CREATE PROCEDURE editPrice(in new_price int, in gameTitle varchar(100))
begin
    declare id_game int;
start transaction;
set id_game = (select g.id from Game g where g.title = gameTitle);
    if id_game is null then
        rollback;
end if;
    if new_price is null or new_price < 0 then
        rollback;
end if;
UPDATE Game SET price = new_price WHERE title = gameTitle;
commit;
select id_game;
end;

-- Add new game to the system
-- If id_developer/id_publisher or price was invalid - rollback
drop procedure if exists addGame;
CREATE PROCEDURE addGame(in gameTitle varchar(100), in dev_id int, in pub_id int, in new_price int)
begin
    declare id_game int;
start transaction;
if (select * from Developer where id = dev_id) is null then
        rollback;
end if;
    if (select * from Publisher where id = pub_id) is null then
        rollback;
end if;
    if new_price is null or new_price < 0 then
        rollback;
end if;
insert into Game(title, id_developer, id_publisher, price) VALUE (gameTitle, dev_id, pub_id, new_price);
set id_game = (select g.id from Game g where g.title = gameTitle);
commit;
select id_game;
end;

-- Inserts new game genre to given game
-- If id_game or id_genre was invalid - rollback
drop procedure if exists insertGameGenre;
CREATE PROCEDURE insertGameGenre(game_id int, genre_id int)
begin
start transaction;
if (select g.id from Game g where g.id = game_id) is null then
        rollback;
end if;
    if (select g.id from Genre g where g.id = genre_id) is null then
        rollback;
end if;
INSERT INTO Game_genre VALUE (game_id, genre_id);
commit;
end;

-- Returns dev info by their name
drop procedure if exists getDevByName;
CREATE PROCEDURE getDevByName(in dev_name varchar(50))
begin
SELECT d.id, d.headquarters FROM Developer d WHERE d.name = dev_name;
end;