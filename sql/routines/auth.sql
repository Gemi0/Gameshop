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

delimiter $$
drop procedure if exists getUserByName;
create procedure getUserByName(in login varchar(30))
begin
    select u.id from User u where u.login = login;
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

-- Retrieve uses's type
-- Returns: username
delimiter $$
drop procedure if exists getUserType;
create procedure getUserType(in id int)
begin
select u.type from User_info u where u.id_user = id;
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