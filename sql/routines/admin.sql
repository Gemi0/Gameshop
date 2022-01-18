#####################################################################
# Gameshop database user entity routines                            #
# Authors: Maciej Bazela 261743                                     #
#          Dominik Gorgosch 261701                                  #
# Below code will generate all routines needed for admin entity.    #
#                                                                   #
# THIS FILE ASSUMES YOU HAVE ROOT PRIVILEGES ON YOUR SQL MACHINE.   #
#####################################################################

-- Changes prices of all games at once by given percent.
CREATE PROCEDURE figureInflation(in percent float)
BEGIN
START TRANSACTION;
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

-- TODO: modify/delete other entities