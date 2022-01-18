-- Cleans up tables related with game before game deletion.
drop trigger if exists deleteGameTrigger;
create trigger deleteGameTrigger before delete on Game
    for each row
begin
    delete from Game_genre
    where id_game = OLD.id;
    delete from User_game
    where id_game = OLD.id;
    delete from Orders_game
    where id_game = OLD.id;
end;

-- Cleans up tables related with orders before order deletion.
drop trigger if exists deleteUserOrderTrigger;
create trigger deleteUserOrderTrigger before delete on Orders
    for each row
begin
    delete from Orders_game
    where id_order = OLD.id;
end;

-- Cleans up tables related with user before user deletion.
drop trigger if exists deleteUserTrigger;
create trigger deleteUserTrigger before delete on User
    for each row
begin
    delete from User_info
    where id_user = OLD.id;
    delete from User_game
    where id_user = OLD.id;
    delete from Orders
    where id_user = OLD.id;
end;