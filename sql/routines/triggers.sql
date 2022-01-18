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