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