-- MariaDB dump 10.19  Distrib 10.4.21-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: db_gameshop
-- ------------------------------------------------------
-- Server version	10.4.21-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `developer`
--

DROP TABLE IF EXISTS `developer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `developer` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `name` varchar(50) NOT NULL CHECK (`name` <> ''),
                             `headquarters` varchar(80) NOT NULL CHECK (`headquarters` <> ''),
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `developer`
--

LOCK TABLES `developer` WRITE;
/*!40000 ALTER TABLE `developer` DISABLE KEYS */;
INSERT INTO `developer` VALUES (1,'Trylma','China'),(2,'Sigma','Turkey'),(3,'Ligma','Czech Republic'),(4,'Simp','Poland'),(5,'Synthol','Norway'),(6,'Square','Germany'),(7,'Dani','UK'),(8,'Flowyh','USA'),(9,'OhCanada','Canada'),(10,'Klei','Japan'),(11,'CaptainAlex','Uganda'),(12,'Right','India'),(13,'Tex','Chile'),(14,'Mordekaiser','Brasil'),(15,'UpsideDown','Australia'),(16,'Trylma','China'),(17,'Lol','Turkey'),(18,'Ligma','Czech Republic'),(19,'Simp','Poland'),(20,'Synthol','Norway'),(21,'Square','Germany'),(22,'Dani','UK'),(23,'Flowyh','USA'),(24,'OhCanada','Canada'),(25,'Klei','Japan'),(26,'CaptainAlex','Uganda'),(27,'Right','India'),(28,'Tex','Chile'),(29,'Mordekaiser','Brasil'),(30,'UpsideDown','Australia');
/*!40000 ALTER TABLE `developer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
                        `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                        `title` varchar(100) NOT NULL CHECK (`title` <> ''),
                        `id_developer` int(10) unsigned NOT NULL,
                        `id_publisher` int(10) unsigned NOT NULL,
                        `price` int(10) unsigned NOT NULL,
                        PRIMARY KEY (`id`),
                        KEY `id_developer` (`id_developer`),
                        KEY `id_publisher` (`id_publisher`),
                        CONSTRAINT `game_ibfk_1` FOREIGN KEY (`id_developer`) REFERENCES `developer` (`id`),
                        CONSTRAINT `game_ibfk_2` FOREIGN KEY (`id_publisher`) REFERENCES `publisher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,'Mesmerizing Valley Remaster',2,15,33457),(3,'Jumping HunterXOranges Prequel',9,12,17055),(4,'Hollow Heroes Box',2,7,51337),(5,'Amazing Hot Potato 2',15,14,31246),(6,'Biggest HunterXOranges Super',10,14,44001),(7,'Risky Hot Potato Sequel',15,8,39181),(8,'Darkest King Three',11,12,36829),(9,'Super Human Simulator Prequel',12,13,47134),(10,'Jumping Hot Potato Box',12,10,7047),(11,'Biggest King ',15,7,24352),(12,'Clicker King Prepare to die edition',5,12,51282),(13,'Amazing Dora the Explorer Party',3,15,29536),(14,'Mesmerizing Dungeon Super',14,12,6230),(15,'Freaky Valley Sequel',10,15,52235),(16,'Jumping Dungeon Prequel',12,14,22238),(17,'Endless King GOTY',8,14,54413),(18,'Jumping Clash of Tribes HD',12,14,6474),(19,'Hidden Dora the Explorer GOTY',1,2,29643),(20,'Endless King 2',2,14,22084),(21,'Super King 2',11,9,39525),(22,'Amazing Car HD',4,3,21380),(23,'Stardew Clash of Tribes HD',2,5,7430),(24,'Tricky Dragon Slayer Ultimate',6,2,35371),(25,'Biggest King Sequel',8,12,19571),(26,'Risky Cafe Remaster',7,2,12271),(27,'Risky Heroes Super',4,4,37024),(28,'Hidden Cafe ',8,2,8586),(29,'Darkest King Party',3,14,50423),(30,'Tricky Valley Party',5,3,10505),(31,'Clicker Clash of Tribes Box',10,5,31985),(32,'Tricky Heroes Remaster',11,10,6504),(33,'Clicker Craftmine Sequel',3,13,39832),(34,'Freaky Heroes II',6,13,16764),(35,'Darkest Wizards Box',10,1,12412),(36,'Biggest Car Ultimate',5,8,32011),(37,'Endless Clash of Tribes Remaster',13,7,47043),(38,'Risky Craftmine Ultimate',14,8,45802),(39,'Apex Clash of Tribes Sequel',10,12,52443),(40,'Hollow Craftmine GOTY',14,14,51675),(41,'Amazing Clash of Tribes Box',6,13,17678),(42,'Freaky Dungeon Super',4,11,49933),(43,'Tricky Wizards Sequel',5,5,29118),(44,'Jumping Wizards GOTY',4,9,16918),(45,'Stardew Heroes Sequel',14,10,33549),(46,'Endless Dragon Slayer II',6,13,17381),(47,'Hidden Hot Potato HD',9,9,55295),(48,'Biggest Dragon Slayer GOTY',2,11,22572),(49,'Amazing Dora the Explorer HD',10,8,29948),(50,'Mesmerizing Craftmine Ultimate',8,11,7571),(51,'Apex HunterXOranges Prepare to die edition',4,9,19767),(52,'Clicker Craftmine Ultimate',9,6,55004),(53,'Hidden Heroes Prequel',14,14,35530),(54,'Clicker Human Simulator Prequel',4,9,18061),(55,'Jumping HunterXOranges ',8,4,32292),(56,'Hidden Car Prequel',3,11,52763),(57,'Amazing Craftmine GOTY',1,3,37334),(58,'Clicker Clash of Tribes Three',8,8,14449),(59,'Risky Craftmine ',9,1,32388),(60,'Mesmerizing King GOTY',9,8,43048),(61,'Biggest Wizards II',5,8,31440),(62,'Apex HunterXOranges II',13,1,39610),(63,'Hollow Human Simulator Prepare to die edition',14,15,8013),(64,'Hidden Dungeon Prequel',11,5,20193),(65,'Endless Heroes Remaster',2,9,26630),(66,'Mesmerizing Cafe Prequel',7,9,34452),(67,'Jumping Dungeon Sequel',4,3,13097),(68,'Darkest Hot Potato Super',3,3,26118),(69,'Super HunterXOranges Prequel',14,1,37000),(70,'Mesmerizing Human Simulator Party',15,4,9426),(71,'Amazing Valley Three',8,3,25280),(72,'Tricky Dragon Slayer Remaster',10,3,49302),(73,'Mesmerizing Clash of Tribes 2',10,7,27178),(74,'Hidden Heroes II',11,8,15170),(75,'Darkest Dragon Slayer 2',2,4,51372),(76,'Clicker Hot Potato Prepare to die edition',10,8,31130),(77,'Darkest King Remaster',6,7,8998),(78,'Amazing Car Remaster',8,14,7140),(79,'Mesmerizing Dora the Explorer ',1,8,18105),(80,'Hollow King Sequel',12,8,9321),(81,'Biggest King Prequel',13,7,42677),(82,'Apex Human Simulator Box',2,5,17841),(83,'Freaky Cafe GOTY',13,3,26019),(84,'Mesmerizing Hot Potato Remaster',8,5,50077),(85,'Stardew King Three',4,9,11763),(86,'Amazing Craftmine Super',15,10,11236),(87,'Jumping Wizards Three',10,8,33901),(88,'Stardew Dungeon Box',2,10,49279),(89,'Jumping Valley Box',11,13,15057),(90,'Hidden Valley Party',9,7,19243),(91,'Stardew Hot Potato Party',10,4,24171),(92,'Super Human Simulator III',14,8,53696),(93,'Biggest Craftmine HD',9,3,51580),(94,'Tricky Cafe Party',2,11,7204),(95,'Apex Wizards Prequel',6,7,53731),(96,'Super Human Simulator Party',2,13,52307),(97,'Biggest Heroes ',13,2,52441),(98,'Hollow Clash of Tribes Party',8,1,34994),(99,'Super Dungeon Prequel',2,12,41130),(100,'Jumping Craftmine Super',2,3,24096),(101,'Hidden Dragon Slayer HD',6,7,8779),(102,'Tricky Craftmine Super',2,8,7645),(103,'Risky Car Super',6,11,25371),(104,'Stardew Valley 2',7,11,18810),(105,'Mesmerizing HunterXOranges Remaster',15,5,25556),(106,'Mesmerizing Wizards Prequel',5,3,53706),(107,'Hollow King Sequel',10,5,35343),(108,'Endless Valley Three',14,2,54119),(109,'Risky Wizards Three',13,3,16811),(110,'Amazing Dungeon Ultimate',12,8,13059),(111,'Super Dora the Explorer HD',12,4,50436),(112,'Hidden Cafe 2',13,15,28845),(113,'Super Human Simulator Prequel',9,15,17184),(114,'Risky Dora the Explorer Party',7,6,37116),(115,'Jumping Dora the Explorer Sequel',3,9,24449),(116,'Darkest HunterXOranges ',6,13,52855),(117,'Jumping Valley Party',15,3,6375),(118,'Biggest Human Simulator III',2,3,41265),(119,'Hollow HunterXOranges Super',11,8,23627),(120,'Hidden Craftmine HD',13,1,37563),(121,'Darkest Dragon Slayer ',3,10,39006),(122,'Freaky Cafe ',1,2,31366),(123,'Jumping Heroes GOTY',3,4,29410),(124,'Darkest Dungeon Ultimate',6,2,27866),(125,'Hidden Hot Potato Remaster',4,7,29939),(126,'Endless Hot Potato II',15,15,52072),(127,'Hidden Dragon Slayer Ultimate',9,7,33520),(128,'Risky Heroes Prequel',4,3,15390),(129,'Darkest Heroes II',2,7,47278),(130,'Hollow Car GOTY',11,9,42068),(131,'Risky Craftmine ',9,1,29385),(132,'Darkest King Remaster',12,9,35930),(133,'Jumping Dungeon Remaster',9,5,43627),(134,'Tricky King ',14,7,33628),(135,'Hollow Car III',7,11,16335),(136,'Hollow HunterXOranges GOTY',9,6,17633),(137,'Mesmerizing Cafe ',9,2,39058),(138,'Super Wizards Prepare to die edition',4,1,29906),(139,'Mesmerizing Hot Potato Prepare to die edition',6,2,19576),(140,'Endless Car Party',3,14,7937),(141,'Amazing Dungeon Box',10,10,22635),(142,'Hidden Dora the Explorer Box',6,11,31503),(143,'Stardew Dungeon Prequel',11,2,24879),(144,'Hollow Wizards Party',1,15,41778),(145,'Amazing Heroes Three',13,8,15624),(146,'Hollow Heroes Ultimate',8,5,52846),(147,'Stardew Dungeon Sequel',10,8,34773),(148,'Jumping Craftmine HD',3,6,23265),(149,'Risky Hot Potato III',13,1,40441),(150,'Jumping Car Remaster',1,10,49280),(151,'Jumping Car Prequel',5,8,34701),(152,'Clicker Cafe III',6,13,13830),(153,'Darkest Craftmine 2',11,7,15996),(154,'Hollow Valley Ultimate',11,15,50763),(155,'Freaky HunterXOranges HD',12,12,30133),(156,'Endless Wizards Box',13,4,29407),(157,'Biggest King Ultimate',1,14,25723),(158,'Apex Dungeon Box',15,13,10159),(159,'Amazing HunterXOranges GOTY',13,13,37405),(160,'Apex Human Simulator Prequel',4,4,35489),(161,'Amazing Craftmine GOTY',3,14,8786),(162,'Biggest Car Sequel',7,15,38198),(163,'Amazing Human Simulator Ultimate',3,6,15975),(164,'Hidden Car III',4,7,31612),(165,'Risky Dragon Slayer Box',10,5,43212),(166,'Freaky Heroes Box',13,1,37934),(167,'Endless Heroes Three',2,3,23338),(168,'Stardew Dora the Explorer GOTY',9,12,21878),(169,'Stardew Dungeon II',11,8,31321),(170,'Risky Cafe Three',11,10,54186),(171,'Endless Heroes Prequel',11,4,10569),(172,'Endless Dragon Slayer Remaster',6,3,42734),(173,'Clicker Dora the Explorer Prepare to die edition',8,10,47205),(174,'Tricky Cafe Sequel',5,3,50983),(175,'Apex Human Simulator Sequel',6,15,50874),(176,'Mesmerizing King Three',12,15,29009),(177,'Stardew Hot Potato Party',10,11,43210),(178,'Jumping HunterXOranges Sequel',11,12,48556),(179,'Clicker Dragon Slayer Party',1,13,49325),(180,'Jumping Car III',7,15,30723),(181,'Jumping Dragon Slayer III',2,4,5782),(182,'Freaky Valley Sequel',4,7,20950),(183,'Amazing Heroes Prequel',14,4,22387),(184,'Hidden Wizards Three',5,10,13121),(185,'Risky Clash of Tribes GOTY',11,5,25383),(186,'Darkest Car Sequel',4,3,6197),(187,'Clicker Car ',12,5,10507),(188,'Endless Dungeon HD',9,2,40909),(189,'Amazing HunterXOranges Sequel',10,11,26379),(190,'Super Craftmine II',13,7,36118),(191,'Risky Car Ultimate',10,12,6781),(192,'Hollow Car Party',9,7,28264),(193,'Hollow Car ',15,2,26751),(194,'Endless Valley 2',7,5,21948),(195,'Amazing Valley II',10,6,52754),(196,'Endless HunterXOranges 2',14,5,34681),(197,'Apex Clash of Tribes Sequel',3,5,53546),(198,'Jumping Heroes Ultimate',11,3,47013),(199,'Freaky Heroes Ultimate',2,8,13112),(200,'Stardew Dora the Explorer HD',11,9,27999),(201,'siema',5,5,130),(203,'re',2,5,588),(205,'new',2,3,123),(206,'new game',2,2,123);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER deleteGameTrigger
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
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER deleteTrigger AFTER DELETE ON game
    FOR EACH ROW
BEGIN
    DELETE FROM game_genre
    WHERE id_game = OLD.id;
    DELETE FROM user_game
    WHERE id_game = OLD.id;
    DELETE FROM orders_game
    WHERE id_game = OLD.id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `game_genre`
--

DROP TABLE IF EXISTS `game_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_genre` (
                              `id_game` int(10) unsigned NOT NULL,
                              `id_game_genre` int(10) unsigned NOT NULL,
                              KEY `id_game` (`id_game`),
                              KEY `id_game_genre` (`id_game_genre`),
                              CONSTRAINT `game_genre_ibfk_1` FOREIGN KEY (`id_game`) REFERENCES `game` (`id`),
                              CONSTRAINT `game_genre_ibfk_2` FOREIGN KEY (`id_game_genre`) REFERENCES `genre` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_genre`
--

LOCK TABLES `game_genre` WRITE;
/*!40000 ALTER TABLE `game_genre` DISABLE KEYS */;
INSERT INTO `game_genre` VALUES (1,17),(1,8),(1,11),(1,10),(1,16),(3,17),(3,8),(4,5),(4,9),(4,9),(4,16),(5,20),(5,6),(5,9),(5,6),(6,1),(7,16),(8,18),(8,13),(8,9),(9,15),(9,2),(10,4),(10,14),(10,18),(10,9),(11,11),(12,6),(12,15),(12,16),(12,14),(12,20),(13,8),(13,11),(13,10),(13,16),(13,10),(14,16),(14,19),(14,4),(14,5),(15,17),(15,5),(16,19),(16,13),(16,7),(16,15),(17,5),(18,10),(19,2),(20,19),(20,11),(20,19),(20,20),(20,2),(21,15),(21,15),(21,6),(21,8),(21,19),(22,1),(22,4),(22,15),(22,4),(23,8),(23,16),(23,17),(23,15),(24,12),(24,3),(25,3),(25,16),(25,12),(25,13),(25,5),(26,9),(27,8),(27,19),(28,1),(28,19),(28,10),(28,15),(29,17),(30,19),(30,7),(30,16),(30,1),(31,16),(31,4),(31,14),(31,18),(31,7),(32,4),(32,16),(32,7),(32,6),(33,18),(33,5),(34,12),(34,5),(35,14),(35,18),(35,10),(35,17),(36,4),(37,16),(37,7),(38,12),(38,7),(38,2),(38,5),(38,2),(39,8),(40,18),(40,11),(40,3),(40,1),(40,14),(41,13),(41,7),(41,17),(41,2),(42,6),(43,10),(43,1),(43,14),(44,8),(44,2),(44,7),(45,18),(45,14),(45,16),(46,13),(46,8),(46,2),(46,4),(46,16),(47,8),(47,16),(47,18),(47,2),(48,12),(48,17),(49,19),(49,6),(49,9),(49,10),(50,1),(50,3),(51,13),(51,8),(51,1),(51,18),(51,8),(52,18),(52,8),(52,7),(52,8),(52,20),(53,8),(53,2),(54,11),(54,17),(54,13),(54,11),(54,17),(55,1),(55,12),(55,15),(55,18),(56,13),(56,6),(56,9),(57,15),(57,17),(57,19),(57,1),(57,10),(58,6),(58,19),(59,12),(59,3),(60,5),(61,2),(61,19),(62,6),(62,9),(63,8),(63,16),(63,14),(64,12),(64,1),(64,9),(64,1),(65,9),(65,18),(66,4),(67,5),(67,12),(68,10),(68,1),(68,17),(68,1),(68,11),(69,20),(70,15),(70,11),(71,10),(71,3),(71,3),(71,8),(72,17),(72,13),(72,11),(72,15),(73,16),(73,13),(73,15),(74,12),(74,4),(75,18),(76,1),(76,15),(76,8),(76,18),(76,2),(77,20),(78,10),(78,8),(78,10),(78,3),(78,6),(79,16),(79,5),(79,17),(80,19),(80,10),(80,11),(80,3),(81,8),(81,12),(81,18),(81,12),(81,8),(82,7),(82,18),(83,12),(83,11),(84,12),(84,6),(84,11),(85,18),(85,1),(85,11),(85,12),(85,6),(86,16),(86,9),(86,17),(86,20),(87,7),(87,17),(87,5),(88,11),(88,20),(88,5),(88,5),(88,8),(89,8),(89,8),(89,15),(90,4),(90,20),(90,10),(90,8),(90,12),(91,2),(91,4),(91,16),(91,4),(92,5),(92,6),(93,4),(93,4),(94,4),(94,14),(94,20),(94,18),(94,10),(95,12),(95,20),(95,2),(95,10),(95,3),(96,2),(96,13),(97,9),(98,18),(98,15),(98,20),(99,4),(99,15),(99,4),(100,9),(100,1),(100,19),(100,10),(100,11),(101,2),(101,3),(101,7),(102,16),(102,16),(102,10),(102,2),(103,18),(103,3),(104,4),(105,4),(105,13),(105,11),(105,17),(105,11),(106,5),(106,7),(106,18),(107,3),(107,18),(107,19),(107,2),(107,14),(108,10),(109,13),(109,10),(109,10),(109,20),(110,7),(111,17),(111,7),(111,5),(112,8),(113,4),(113,6),(113,17),(113,7),(113,2),(114,1),(114,5),(114,1),(115,3),(116,6),(116,11),(116,17),(116,9),(117,10),(117,8),(117,7),(118,20),(118,17),(118,2),(119,7),(119,9),(119,6),(119,2),(120,2),(121,8),(122,5),(123,16),(123,7),(124,18),(124,20),(124,8),(124,19),(124,10),(125,3),(125,4),(125,9),(126,15),(126,15),(127,8),(127,6),(127,6),(128,8),(129,18),(129,17),(130,18),(130,6),(131,5),(131,14),(131,13),(131,4),(132,6),(132,13),(132,7),(133,18),(133,5),(133,8),(134,9),(135,20),(135,7),(135,15),(135,11),(136,1),(136,8),(136,17),(137,3),(137,12),(137,12),(137,3),(137,19),(138,7),(139,4),(139,2),(140,11),(140,12),(141,16),(141,16),(141,11),(142,10),(142,17),(143,12),(143,17),(143,6),(143,20),(143,2),(144,15),(144,10),(145,9),(145,11),(145,7),(145,20),(145,20),(146,17),(147,8),(147,3),(147,12),(147,10),(147,15),(148,14),(148,8),(148,19),(149,7),(150,11),(150,2),(150,15),(150,9),(150,20),(151,10),(151,11),(151,6),(151,17),(152,5),(152,15),(152,20),(152,12),(153,14),(153,14),(154,12),(155,4),(156,16),(157,8),(157,12),(157,17),(157,10),(158,1),(159,15),(159,16),(159,12),(159,13),(160,5),(160,7),(160,18),(160,9),(161,12),(161,16),(161,3),(161,7),(161,3),(162,7),(162,15),(163,20),(163,5),(163,5),(163,10),(163,14),(164,5),(164,13),(164,9),(164,4),(164,15),(165,16),(165,15),(166,3),(167,8),(167,16),(167,17),(168,5),(168,6),(168,12),(168,2),(169,20),(169,9),(170,1),(170,2),(170,10),(170,3),(170,3),(171,17),(172,5),(173,4),(173,9),(173,12),(174,1),(174,10),(174,8),(174,7),(175,12),(175,3),(176,11),(176,3),(176,2),(176,19),(176,10),(177,12),(178,20),(178,6),(178,9),(179,20),(179,3),(179,17),(179,17),(179,12),(180,12),(180,8),(180,3),(181,5),(181,3),(181,19),(182,7),(182,12),(183,2),(183,6),(183,3),(184,19),(184,6),(184,11),(184,15),(184,1),(185,1),(186,12),(186,19),(186,20),(186,19),(187,14),(187,2),(187,7),(187,10),(187,6),(188,5),(188,2),(188,15),(188,8),(188,12),(189,2),(189,1),(189,19),(190,15),(190,18),(190,3),(190,19),(191,17),(191,20),(191,8),(192,19),(192,7),(192,16),(192,17),(192,19),(193,19),(193,6),(194,15),(194,12),(194,17),(194,7),(194,2),(195,11),(195,19),(196,2),(196,14),(196,1),(196,5),(197,19),(197,17),(197,7),(198,11),(198,6),(198,14),(198,11),(199,7),(199,2),(1,17),(3,36),(3,28),(3,32),(3,37),(3,6),(4,10),(4,20),(5,20),(5,35),(5,32),(5,17),(5,27),(6,20),(7,3),(7,10),(8,31),(8,5),(8,12),(9,23),(9,20),(10,11),(10,36),(10,28),(11,37),(11,35),(11,23),(11,9),(11,14),(12,38),(12,30),(13,18),(13,18),(13,37),(13,10),(14,24),(15,21),(15,23),(15,10),(15,20),(15,32),(16,3),(16,3),(16,7),(17,10),(18,36),(18,33),(19,5),(20,7),(20,28),(21,39),(21,14),(21,29),(21,26),(22,39),(22,30),(22,31),(22,25),(23,16),(23,32),(23,34),(24,28),(24,19),(24,13),(25,13),(25,26),(25,8),(25,3),(26,19),(26,31),(27,3),(27,14),(28,6),(28,33),(29,32),(29,8),(29,22),(29,8),(30,15),(30,2),(31,14),(31,28),(31,16),(31,36),(32,3),(32,34),(33,27),(33,16),(34,24),(34,1),(34,13),(35,1),(36,5),(36,33),(37,38),(37,39),(38,39),(38,9),(38,6),(39,36),(39,18),(40,32),(41,27),(41,15),(42,10),(42,2),(42,17),(42,40),(42,29),(43,25),(43,18),(43,16),(44,10),(45,37),(45,39),(45,3),(45,17),(45,36),(46,29),(47,25),(47,1),(47,11),(47,9),(48,5),(49,4),(49,17),(49,33),(49,34),(49,31),(50,27),(50,3),(50,14),(50,18),(50,8),(51,21),(51,24),(51,17),(51,13),(51,11),(52,35),(52,25),(52,16),(52,6),(53,35),(53,23),(53,10),(54,22),(54,9),(54,17),(54,19),(54,4),(55,28),(55,22),(55,25),(56,13),(57,18),(57,28),(57,7),(57,28),(58,9),(58,20),(58,34),(58,29),(59,8),(59,31),(60,13),(60,2),(60,11),(61,7),(61,16),(61,16),(61,30),(62,36),(63,28),(64,3),(64,1),(65,39),(65,35),(65,20),(66,30),(67,18),(67,10),(68,26),(69,9),(69,15),(69,9),(69,38),(70,4),(70,13),(70,10),(70,12),(71,25),(71,38),(71,35),(71,19),(72,37),(72,36),(73,30),(73,21),(74,4),(74,33),(74,31),(74,16),(74,26),(75,31),(75,1),(75,32),(76,4),(76,17),(76,30),(77,22),(77,40),(78,6),(78,40),(78,20),(78,20),(79,36),(79,32),(79,10),(79,34),(80,16),(80,22),(81,18),(81,17),(81,30),(82,15),(83,32),(83,12),(83,6),(84,27),(84,20),(84,19),(84,34),(85,19),(85,4),(85,1),(85,36),(85,14),(86,17),(86,20),(87,39),(88,32),(88,18),(89,1),(89,17),(89,3),(90,17),(90,17),(91,14),(91,39),(91,31),(92,38),(92,35),(92,23),(93,40),(94,27),(94,33),(94,5),(94,5),(95,32),(95,21),(95,8),(95,16),(96,9),(96,5),(96,37),(96,9),(96,15),(97,12),(97,10),(97,13),(97,35),(97,17),(98,14),(99,29),(99,25),(99,38),(100,13),(101,12),(101,32),(101,3),(101,38),(102,12),(102,29),(102,30),(103,2),(103,24),(103,34),(104,25),(104,14),(104,35),(104,15),(105,1),(105,20),(105,15),(105,13),(106,17),(107,1),(107,6),(107,29),(107,3),(107,10),(108,37),(108,39),(108,4),(108,24),(109,28),(109,34),(109,6),(109,8),(110,5),(110,4),(111,8),(112,28),(113,16),(113,15),(113,24),(113,33),(114,1),(114,17),(115,21),(115,16),(115,17),(115,38),(116,32),(117,36),(118,32),(118,31),(118,17),(118,34),(118,36),(119,3),(119,7),(119,28),(120,4),(120,30),(120,20),(120,9),(120,25),(121,6),(121,1),(121,24),(121,37),(122,16),(122,16),(122,34),(122,38),(123,6),(124,24),(124,6),(124,37),(124,9),(125,40),(125,30),(126,31),(126,6),(127,25),(127,6),(127,34),(127,31),(127,12),(128,2),(128,17),(128,39),(129,2),(130,32),(130,36),(130,2),(131,24),(131,30),(131,38),(132,35),(132,4),(132,34),(132,38),(133,24),(133,30),(133,37),(133,14),(134,13),(134,17),(134,6),(135,31),(135,16),(135,28),(135,12),(136,1),(136,14),(136,26),(137,14),(137,26),(137,7),(137,39),(137,10),(138,28),(138,17),(138,2),(139,22),(139,40),(140,9),(140,6),(140,3),(140,35),(140,7),(141,23),(141,7),(141,9),(142,7),(142,6),(142,8),(142,24),(143,1),(143,28),(143,18),(144,9),(144,1),(144,20),(144,14),(145,31),(145,1),(145,33),(145,40),(146,17),(146,14),(146,18),(146,9),(146,29),(147,38),(147,11),(147,18),(148,28),(148,13),(148,21),(148,26),(149,10),(149,28),(149,27),(150,10),(150,29),(150,38),(150,20),(150,28),(151,21),(151,29),(151,39),(152,1),(152,38),(152,28),(152,22),(152,25),(153,18),(153,25),(153,29),(153,28),(153,15),(154,5),(154,10),(154,37),(154,33),(154,13),(155,17),(155,35),(155,3),(156,36),(156,19),(156,27),(156,36),(156,21),(157,29),(158,22),(158,40),(158,13),(159,10),(159,25),(159,14),(159,36),(159,15),(160,20),(160,22),(160,11),(161,27),(161,14),(161,27),(161,14),(162,5),(162,33),(162,32),(162,18),(162,34),(163,39),(163,3),(164,21),(164,6),(164,5),(164,7),(164,17),(165,35),(165,10),(165,28),(166,11),(166,32),(167,1),(167,20),(168,17),(168,40),(168,28),(169,23),(169,36),(170,10),(170,32),(171,3),(172,26),(172,16),(172,40),(172,34),(172,8),(173,12),(173,36),(173,23),(173,5),(173,35),(174,6),(174,4),(174,3),(174,40),(174,33),(175,16),(175,33),(175,36),(176,16),(176,32),(176,32),(177,18),(177,37),(178,34),(178,15),(178,12),(179,28),(179,35),(179,9),(179,19),(179,29),(180,11),(180,5),(180,34),(180,33),(180,23),(181,7),(181,3),(181,33),(181,38),(182,4),(182,29),(182,15),(182,26),(182,4),(183,39),(184,17),(184,23),(184,23),(185,1),(185,38),(185,27),(185,20),(185,17),(186,32),(187,35),(187,13),(187,37),(187,24),(188,25),(188,4),(188,26),(188,36),(189,34),(189,28),(189,35),(189,13),(190,27),(191,30),(191,34),(191,38),(191,7),(191,2),(192,26),(192,2),(192,14),(193,9),(193,19),(193,27),(193,38),(193,28),(194,25),(194,30),(194,33),(195,24),(196,39),(196,25),(196,8),(197,31),(197,4),(197,8),(197,26),(197,26),(198,32),(198,17),(198,28),(198,10),(199,30),(199,18),(199,38),(199,18),(200,20),(205,3),(206,3);
/*!40000 ALTER TABLE `game_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genre` (
                         `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                         `name` varchar(50) NOT NULL CHECK (`name` <> ''),
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Action'),(2,'Roguelike'),(3,'RPG'),(4,'Dating sim'),(5,'Adventure'),(6,'Puzzle'),(7,'Platformer'),(8,'4X'),(9,'Racing'),(10,'TCG'),(11,'Tower defense'),(12,'Sandbox'),(13,'TPS'),(14,'Turn-based strategy'),(15,'Visual novel'),(16,'Fighting'),(17,'FPS'),(18,'Arcade'),(19,'Real-time strategy'),(20,'Battle Royale'),(21,'Action'),(22,'Roguelike'),(23,'RPG'),(24,'Dating sim'),(25,'Adventure'),(26,'Puzzle'),(27,'Platformer'),(28,'4X'),(29,'Racing'),(30,'TCG'),(31,'Tower defense'),(32,'Sandbox'),(33,'TPS'),(34,'Turn-based strategy'),(35,'Visual novel'),(36,'Fighting'),(37,'FPS'),(38,'Arcade'),(39,'Real-time strategy'),(40,'Battle Royale');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
                          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                          `id_user` int(10) unsigned NOT NULL,
                          `date` datetime NOT NULL,
                          PRIMARY KEY (`id`),
                          KEY `id_user` (`id_user`),
                          CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger deleteUserOrderTrigger
    before delete
    on Orders
    for each row
begin
    delete
    from Orders_game
    where id_order = OLD.id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orders_game`
--

DROP TABLE IF EXISTS `orders_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_game` (
                               `id_order` int(10) unsigned NOT NULL,
                               `id_game` int(10) unsigned NOT NULL,
                               KEY `id_order` (`id_order`),
                               KEY `id_game` (`id_game`),
                               CONSTRAINT `orders_game_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`),
                               CONSTRAINT `orders_game_ibfk_2` FOREIGN KEY (`id_game`) REFERENCES `game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_game`
--

LOCK TABLES `orders_game` WRITE;
/*!40000 ALTER TABLE `orders_game` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `name` varchar(50) NOT NULL CHECK (`name` <> ''),
                             `headquarters` varchar(80) NOT NULL CHECK (`headquarters` <> ''),
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (1,'Revolution','Lithuania'),(2,'Albino','Sweden'),(3,'Shrigma','Switzerland'),(4,'GameFiesta','Spain'),(5,'RabbiRibbi','Israel'),(6,'Kong','DRC'),(7,'NotChina','Taiwan'),(8,'TacosLocos','Mexico'),(9,'Stronk','Serbia'),(10,'GucciXUomo','Italy'),(11,'Alpha','Romania'),(12,'Vladof','Russia'),(13,'NotExists','Finland'),(14,'FrogLeapStudios','France'),(15,'Lambda','Greece'),(16,'Revolution','Lithuania'),(17,'Albino','Sweden'),(18,'Shrigma','Switzerland'),(19,'GameFiesta','Spain'),(20,'RabbiRibbi','Israel'),(21,'Kong','DRC'),(22,'NotChina','Taiwan'),(23,'TacosLocos','Mexico'),(24,'Stronk','Serbia'),(25,'GucciXUomo','Italy'),(26,'Alpha','Romania'),(27,'Vladof','Russia'),(28,'NotExists','Finland'),(29,'FrogLeapStudios','France'),(30,'Lambda','Greece');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
                        `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                        `login` varchar(60) NOT NULL CHECK (`login` <> ''),
                        `password` varchar(100) NOT NULL CHECK (`password` <> ''),
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'test','test'),(2,'a','a'),(3,'f','f'),(4,'r','r'),(5,'q','$2a$10$DhDyFZOcx5D9TdEn9Otj5.GV.gl68sXtN4ommxMRrlEdHJz5T7wFi'),(6,'Sigma','$2a$10$DWy0KxOWrxBY8X9Zd0.tb.DwpLM8lw3Dshe5KTBPCi3S3Xkg9NqkK');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger deleteUserTrigger
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
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_game`
--

DROP TABLE IF EXISTS `user_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_game` (
                             `id_user` int(10) unsigned NOT NULL,
                             `id_game` int(10) unsigned NOT NULL,
                             KEY `id_user` (`id_user`),
                             KEY `id_game` (`id_game`),
                             CONSTRAINT `user_game_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
                             CONSTRAINT `user_game_ibfk_2` FOREIGN KEY (`id_game`) REFERENCES `game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_game`
--

LOCK TABLES `user_game` WRITE;
/*!40000 ALTER TABLE `user_game` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_info` (
                             `id_user` int(10) unsigned NOT NULL,
                             `type` enum('admin','dev','client') NOT NULL,
                             `balance` int(10) unsigned NOT NULL,
                             KEY `id_user` (`id_user`),
                             CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (1,'client',100),(2,'dev',0),(3,'client',0),(4,'client',0),(5,'admin',0),(6,'dev',0);
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-22 22:30:12
