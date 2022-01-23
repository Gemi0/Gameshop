#####################################################################
# Gameshop database setup                                           #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will generate all table schemas and setup constraints. #
# Data generation will be performed in another file.                #
# THIS FILE ASSUMES YOU HAVE ROOT PRIVILEGES ON YOUR SQL MACHINE.   #
#####################################################################

-- Create database
# create database db_gameshop;
# use db_gameshop;

-- Drop in case tables already exist
drop table if exists Orders_game;
drop table if exists Game_genre;
drop table if exists User_info;
drop table if exists User_game;
drop table if exists Game;
drop table if exists Developer;
drop table if exists Publisher;
drop table if exists Genre;
drop table if exists Orders;
drop table if exists User;

-- Create tables
-- Tables have been already normalized to 4NF form.

create table if not exists Developer
(
    id           int unsigned not null auto_increment,
    name         varchar(50)  not null check(name <> ''),
    headquarters varchar(80)  not null check(headquarters <> ''),
    primary key (id)
);

create table if not exists Publisher
(
    id           int unsigned not null auto_increment,
    name         varchar(50)  not null check(name <> ''),
    headquarters varchar(80)  not null check(headquarters <> ''),
    primary key (id)
);

create table if not exists Genre
(
    id   int unsigned not null auto_increment,
    name varchar(50)  not null check(name <> ''),
    primary key (id)
);

create table if not exists Game
(
    id           int unsigned not null auto_increment,
    title        varchar(100) not null check(title <> ''),
    id_developer int unsigned not null,
    id_publisher int unsigned not null,
    price        int unsigned not null,
    primary key (id),
    foreign key (id_developer) references Developer (id),
    foreign key (id_publisher) references Publisher (id)
);

create table if not exists Game_genre
(
    id_game       int unsigned not null,
    id_game_genre int unsigned not null,
    foreign key (id_game) references Game (id),
    foreign key (id_game_genre) references Genre (id)
);


create table if not exists User
(
    id       int unsigned not null auto_increment,
    login    varchar(60)  not null check(login <> ''),
    password varchar(100) not null check(password <> ''),
    primary key (id)
);

create table if not exists User_info
(
    id_user int unsigned                    not null,
    type    enum ('admin', 'dev', 'client') not null,
    balance int unsigned                    not null,
    foreign key (id_user) references User (id)
);

create table if not exists User_game
(
    id_user int unsigned not null,
    id_game int unsigned not null,
    foreign key (id_user) references User (id),
    foreign key (id_game) references Game (id)
);

create table if not exists Orders
(
    id      int unsigned not null auto_increment,
    id_user int unsigned not null,
    date    datetime     not null,
    primary key (id),
    foreign key (id_user) references User (id)
);

create table if not exists Orders_game
(
    id_order int unsigned not null,
    id_game  int unsigned not null,
    foreign key (id_order) references Orders (id),
    foreign key (id_game) references Game (id)
);

#####################################################################
# Gameshop dummy data generation                                    #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will generate data for previously created tables.      #
#                                                                   #
# THIS FILE ASSUMES YOU HAVE ROOT PRIVILEGES ON YOUR SQL MACHINE.   #
#####################################################################

-- Developer

insert ignore into Developer(name, headquarters)
values ('Trylma', 'China'),
       ('Sigma', 'Turkey'),
       ('Ligma', 'Czech Republic'),
       ('Simp', 'Poland'),
       ('Synthol', 'Norway'),
       ('Square', 'Germany'),
       ('Dani', 'UK'),
       ('Flowyh', 'USA'),
       ('OhCanada', 'Canada'),
       ('Klei', 'Japan'),
       ('CaptainAlex', 'Uganda'),
       ('Right', 'India'),
       ('Tex', 'Chile'),
       ('Mordekaiser', 'Brasil'),
       ('UpsideDown', 'Australia');

-- Publisher

insert ignore into Publisher(name, headquarters)
values ('Revolution', 'Lithuania'),
       ('Albino', 'Sweden'),
       ('Shrigma', 'Switzerland'),
       ('GameFiesta', 'Spain'),
       ('RabbiRibbi', 'Israel'),
       ('Kong', 'DRC'),
       ('NotChina', 'Taiwan'),
       ('TacosLocos', 'Mexico'),
       ('Stronk', 'Serbia'),
       ('GucciXUomo', 'Italy'),
       ('Alpha', 'Romania'),
       ('Vladof', 'Russia'),
       ('NotExists', 'Finland'),
       ('FrogLeapStudios', 'France'),
       ('Lambda', 'Greece');

-- Genre

insert ignore into Genre(name)
values ('Action'),
       ('Roguelike'),
       ('RPG'),
       ('Dating sim'),
       ('Adventure'),
       ('Puzzle'),
       ('Platformer'),
       ('4X'),
       ('Racing'),
       ('TCG'),
       ('Tower defense'),
       ('Sandbox'),
       ('TPS'),
       ('Turn-based strategy'),
       ('Visual novel'),
       ('Fighting'),
       ('FPS'),
       ('Arcade'),
       ('Real-time strategy'),
       ('Battle Royale');


-- Games

drop table if exists game_names;
create table if not exists game_names
(
    adjective varchar(50),
    noun     varchar(50),
    suffix    varchar(50)
);

insert ignore into game_names(adjective, noun, suffix)
values ('Mesmerizing', ' Car ', 'II'),
       ('Super', ' Human Simulator ', 'Ultimate'),
       ('Jumping', ' HunterXOranges ', 'Super'),
       ('Hidden', ' Craftmine ', 'Three'),
       ('Biggest', ' Dora the Explorer ', 'III'),
       ('Hollow', ' Hot Potato ', ''),
       ('Endless', ' Cafe ', 'GOTY'),
       ('Clicker', ' Dragon Slayer ', 'Sequel'),
       ('Darkest', ' Valley ', 'HD'),
       ('Apex', ' Heroes ', 'Prequel'),
       ('Stardew', ' Dungeon ', 'Remaster'),
       ('Tricky', ' Wizards ', 'Prepare to die edition'),
       ('Freaky', ' King ', 'Party'),
       ('Risky', ' Heroes ', 'Box'),
       ('Amazing', ' Clash of Tribes ', '2');

drop procedure if  exists generateRandomGames;
delimiter $$
create procedure generateRandomGames()
begin
    declare i int default 1;
    declare adj varchar(30);
    declare noun varchar(30);
    declare suffix varchar(30);
    declare max_genres int default 5;
    declare j int default max_genres;
    declare publisher_count int default (select count(*) from Publisher);
    declare developer_count int default (select count(*) from Developer);
    declare genres_count int default (select count(*) from Genre);
    declare price_min int default 5000;
    declare price_max int default 50000;
    while i < 201
        do
            set adj = (select g.adjective from game_names g order by RAND() limit 1);
            set noun = (select g.noun from game_names g order by RAND() limit 1);
            set suffix = (select g.suffix from game_names g order by RAND() limit 1);
            set j = floor(rand() * max_genres + 1);
            insert ignore into Game(id, title, id_developer, id_publisher, price)
            values (i,
                    concat(adj, noun, suffix),
                    floor(rand() * developer_count + 1), -- from 1 to dev_count
                    floor(rand() * publisher_count + 1), -- from 1 to pub_count
                    floor(rand() * (price_max - price_min + 1) + price_min)); -- from price_min to price_max
            while j > 0
                do
                    insert ignore into Game_genre(id_game, id_game_genre)
                    values (i, floor(rand() * genres_count + 1));
                    set j = j - 1;
                end while;
            set i = i + 1;
        end while;
end $$

call generateRandomGames();
drop procedure generateRandomGames;
drop table game_names;

#####################################################################
# Gameshop database triggers                                        #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will generate triggers.                                #
#                                                                   #
# THIS FILE ASSUMES YOU HAVE ROOT PRIVILEGES ON YOUR SQL MACHINE.   #
#####################################################################

-- Cleans up tables related with game before game deletion.
drop trigger if exists deleteGameTrigger;
CREATE TRIGGER deleteGameTrigger
    before DELETE
    ON Game
    FOR EACH ROW
BEGIN
    DELETE
    FROM Game_genre
    WHERE id_game = OLD.id;
    DELETE
    FROM User_game
    WHERE id_game = OLD.id;
    DELETE
    FROM Orders_game
    WHERE id_game = OLD.id;
end;

-- Cleans up tables related with orders before order deletion.
drop trigger if exists deleteUserOrderTrigger;
create trigger deleteUserOrderTrigger
    before delete
    on Orders
    for each row
begin
    delete
    from Orders_game
    where id_order = OLD.id;
end;

-- Cleans up tables related with user before user deletion.
drop trigger if exists deleteUserTrigger;
create trigger deleteUserTrigger
    before delete
    on User
    for each row
begin
    delete
    from User_info
    where id_user = OLD.id;
    delete
    from User_game
    where id_user = OLD.id;
    delete
    from Orders
    where id_user = OLD.id;
end;

#####################################################################
# Gameshop database admin entity routines                           #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will generate all routines needed for admin entity.    #
#                                                                   #
# THIS FILE ASSUMES YOU HAVE ROOT PRIVILEGES ON YOUR SQL MACHINE.   #
#####################################################################

-- Changes prices of all games at once by given percent.
drop procedure if exists figureInflation;
create procedure figureInflation(in percent float)
begin
    start transaction;
    if percent < 0.5 or percent > 3.0 then
        rollback;
    end if;
    update Game set price = price * percent;
    commit;
end;

-- Delete given game instantly.
drop procedure if exists deleteGame;
create procedure deleteGame(in gameTitle varchar(100))
begin
    declare game_id int;
    start transaction;
    set game_id = (select g.id from Game g where g.title = gameTitle);
    if game_id is null then
        rollback;
    end if;
    delete from Game where title = gameTitle;
    commit;
    select game_id;
end;

-- Changes specified user's type ('user' or 'dev')
drop procedure if exists changeUserType;
create procedure changeUserType(in id_new int, in newtype enum ('dev', 'client'))
begin
    start transaction;
    if (select u.id from User u where u.id = id_new) is null or newtype is null then
        rollback;
    end if;
    update User_info ui set ui.type = newtype where ui.id_user = id_new;
    commit;
    select id_new;
end;

-- Changes user password
drop procedure if exists changeUserPassword;
delimiter $$
create procedure changeUserPassword(in uid int, in newpwd varchar(100))
begin
    declare userLogin varchar(60);
    start transaction;
    set userLogin = (select u.login from User u where u.id = uid);
    if userLogin is null then -- no such user found
        rollback;
    else
        update User u set u.password = newpwd where u.id = uid;
        commit;
        select uid;
    end if;
end $$
delimiter ;

-- Gets user's balance
-- Returns: user's balance from User_info table
drop procedure if exists getUserBalance;
delimiter $$
create procedure getUserBalance(in id int)
begin
    select u.balance from User_info u where id_user = id;
end $$
delimiter ;

-- Adds credits to user's balance
drop procedure if exists increaseUserBalance;
delimiter $$
create procedure increaseUserBalance(in id int, in increase int)
begin
    update User_info u set u.balance = u.balance + increase where u.id_user = id;
end $$
delimiter ;

-- Decreases user's balance
drop procedure if exists decreaseUserBalance;
delimiter $$
create procedure decreaseUserBalance(in id int, in decrease int)
begin
    update User_info u set u.balance = u.balance - decrease where u.id_user = id;
end $$
delimiter ;

-- Add user to developer table
drop procedure if exists addDeveloper;
delimiter $$
create procedure addDeveloper(in id_user int, in hq varchar(80))
begin
    declare dev_name varchar(50) default (select u.login from User u where u.id = id_user);
    declare dev_id int default (select id from Developer where name = dev_name);
    start transaction;
    if dev_name is null or dev_id is not null then
        rollback;
    else
        insert ignore into Developer(name, headquarters) value(dev_name, hq);
        commit;
        select dev_name;
    end if;
end $$
delimiter ;

-- Add user to developer table
drop procedure if exists removeDeveloper;
delimiter $$
create procedure removeDeveloper(in dev_name varchar(50))
begin
    delete from Developer where name = dev_name;
end $$
delimiter ;

#####################################################################
# Gameshop database auth routines                                   #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will generate all routines needed for proper auth.     #
#                                                                   #
# THIS FILE ASSUMES YOU HAVE ROOT PRIVILEGES ON YOUR SQL MACHINE.   #
#####################################################################


-- Add user to User table
-- If provided login is already present, stop transaction.
-- On succesful transaction return new id.
-- Returns: new user's id
drop procedure if exists registerUser;
delimiter $$
create procedure registerUser(in log varchar(60), in pwd varchar(100))
begin
    declare userLogin varchar(60);
    declare registeredId int;
    start transaction;
    set userLogin = (select u.login from User u where u.login = log);
    if userLogin is not null then
        rollback;
    else
        insert into User(login, password) value (log, pwd);
        set registeredId = (select u.id from User u where login = log);
        insert into User_info(id_user, type, balance) value (registeredId, 'client', 0);
        commit;
        select registeredId;
    end if;
end $$
delimiter ;

-- Get given user's password (using login)
-- Used to comapre bcrypt hashes with given user password in client app
-- Returns: user's password
delimiter $$
drop procedure if exists getUserPassword;
create procedure getUserPassword(in log varchar(60))
begin
    select u.password from User u where login = log;
end $$
delimiter ;

-- Retrieve user's id
-- Returns: id
delimiter $$
drop procedure if exists login;
create procedure login(in log varchar(60))
begin
    select u.id from User u where login = log;
end $$
delimiter ;

-- Retrieve uses's name
-- Returns: username
delimiter $$
drop procedure if exists getUsername;
create procedure getUsername(in id int)
begin
    select u.login from User u where u.id = id;
end $$
delimiter ;

-- Retrieve uses's type
-- Returns: username
delimiter $$
drop procedure if exists getUserType;
create procedure getUserType(in id int)
begin
    select u.type from User_info u where u.id_user = id;
end $$
delimiter ;

#####################################################################
# Gameshop database developer entity routines                       #
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
create procedure deleteGame(in gameTitle varchar(100))
begin
    declare game_id int;
    start transaction;
    set game_id = (select g.id from Game g where g.title = gameTitle);
    if game_id is null then
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
    if (select id from Developer where id = dev_id) is null then
        rollback;
    end if;
    if (select id from Publisher where id = pub_id) is null then
        rollback;
    end if;
    if new_price is null or new_price < 0 then
        rollback;
    end if;
    insert into Game (title, id_developer, id_publisher, price) VALUE (gameTitle, dev_id, pub_id, new_price);
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

#####################################################################
# Gameshop database create user roles                               #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will create users and grant them privileges based      #
# on our db project.                                                #
# THIS FILE ASSUMES YOU HAVE ROOT PRIVILEGES ON YOUR SQL MACHINE.   #
#####################################################################

use db_gameshop;
drop user if exists 'auth'@'%';
create user 'auth'@'%' identified by 'verysecretauth';
grant execute on procedure registerUser to 'auth'@'%';
grant execute on procedure getUserPassword to 'auth'@'%';
grant execute on procedure login to 'auth'@'%';
grant execute on procedure getUsername to 'auth'@'%';
grant execute on procedure getUserType to 'auth'@'%';

drop user if exists 'client'@'%';
create user 'client'@'%' identified by 'verysecretclient';
-- CLIENT:
grant execute on procedure browseDeveloperGames to 'client'@'%';
grant execute on procedure browsePublisherGames to 'client'@'%';
grant execute on procedure browseGenreGames to 'client'@'%';
grant execute on procedure browseDevelopers to 'client'@'%';
grant execute on procedure browsePublishers to 'client'@'%';
grant execute on procedure browseGenres to 'client'@'%';
grant execute on procedure getGameByTitle to 'client'@'%';
grant execute on procedure getDevById to 'client'@'%';
grant execute on procedure getPubById to 'client'@'%';
grant execute on procedure getUserGames to 'client'@'%';
grant execute on procedure browseGames to 'client'@'%';
grant execute on procedure placeOrder to 'client'@'%';
grant execute on procedure addGameToOrder to 'client'@'%';
grant execute on procedure finalizeOrder to 'client'@'%';

drop user if exists 'developer'@'%';
create user 'developer'@'%' identified by 'verysecretdeveloper';
-- INHERITED FROM CLIENT
grant execute on procedure browseDeveloperGames to 'developer'@'%';
grant execute on procedure browsePublisherGames to 'developer'@'%';
grant execute on procedure browseGenreGames to 'developer'@'%';
grant execute on procedure browseDevelopers to 'developer'@'%';
grant execute on procedure browsePublishers to 'developer'@'%';
grant execute on procedure browseGenres to 'developer'@'%';
grant execute on procedure getGameByTitle to 'developer'@'%';
grant execute on procedure getDevById to 'developer'@'%';
grant execute on procedure getPubById to 'developer'@'%';
grant execute on procedure getUserGames to 'developer'@'%';
grant execute on procedure browseGames to 'developer'@'%';
grant execute on procedure placeOrder to 'developer'@'%';
grant execute on procedure addGameToOrder to 'developer'@'%';
grant execute on procedure finalizeOrder to 'developer'@'%';
-- DEVELOPER:
grant execute on procedure deleteGame to 'developer'@'%';
grant execute on procedure editGame to 'developer'@'%';
grant execute on procedure editPrice to 'developer'@'%';
grant execute on procedure addGame to 'developer'@'%';
grant execute on procedure insertGameGenre to 'developer'@'%';
grant execute on procedure getDevByName to 'developer'@'%';

drop user if exists 'admin'@'%';
create user 'admin'@'%' identified by 'verysecretadmin';
-- INHERITED FROM CLIENT
grant execute on procedure browseDeveloperGames to 'admin'@'%';
grant execute on procedure browsePublisherGames to 'admin'@'%';
grant execute on procedure getGameByTitle to 'admin'@'%';
grant execute on procedure getDevById to 'admin'@'%';
grant execute on procedure getPubById to 'admin'@'%';
grant execute on procedure getUserGames to 'admin'@'%';
grant execute on procedure browseGames to 'admin'@'%';
grant execute on procedure placeOrder to 'admin'@'%';
grant execute on procedure addGameToOrder to 'admin'@'%';
grant execute on procedure finalizeOrder to 'admin'@'%';
-- INHERITED FROM DEVELOPER
grant execute on procedure deleteGame to 'admin'@'%';
grant execute on procedure getDevByName to 'admin'@'%';
-- INHERITED FROM AUTH
grant execute on procedure getUsername to 'admin'@'%';
grant execute on procedure getUserType to 'admin'@'%';
-- ADMIN:
grant execute on procedure figureInflation to 'admin'@'%';
grant execute on procedure deleteGame to 'admin'@'%';
grant execute on procedure changeUserPassword to 'admin'@'%';
grant execute on procedure getUserBalance to 'admin'@'%';
grant execute on procedure increaseUserBalance to 'admin'@'%';
grant execute on procedure decreaseUserBalance to 'admin'@'%';
grant execute on procedure changeUserType to 'admin'@'%';
grant execute on procedure addDeveloper to 'admin'@'%';
grant execute on procedure removeDeveloper to 'admin'@'%';

flush privileges;