#####################################################################
# Gameshop database user entity routines                            #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will generate all routines needed for user entity.     #
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
insert into User_info(id_user, type, balance) value(registeredId, 'client', 0);
commit;
select registeredId;
end if;
end $$
delimiter ;

call registerUser('test', 'test');

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

-- Changes user password
drop procedure if exists changeUserPassword;
delimiter $$
create procedure changeUserPassword(in log varchar(60), in newpwd varchar(100))
begin
    declare userLogin varchar(60);
start transaction;
set userLogin = (select u.login from User u where u.login = log);
    if userLogin is null then -- no such user found
        rollback;
else
update User u set u.password = newpwd where u.login = log;
commit;
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

-- Get user games
-- Returns: Rows user game's id
drop procedure if exists getUserBalance;
delimiter $$
create procedure getUserBalance(in id int)
begin
select u.id_game from User_game u where id_user = id;
end $$
delimiter ;

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
SELECT ug.id_game
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

-- TODO: buy transaction
CREATE PROCEDURE buyGame(in gameTitle varchar(30), user_id int)
begin

end;
