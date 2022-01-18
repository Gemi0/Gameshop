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
