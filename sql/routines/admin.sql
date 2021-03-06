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