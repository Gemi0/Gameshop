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