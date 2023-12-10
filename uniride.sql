-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: uniride
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `friendship`
--

DROP TABLE IF EXISTS `friendship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friendship` (
  `FriendshipId` int NOT NULL AUTO_INCREMENT,
  `StudentId1` int NOT NULL,
  `StudentId2` int NOT NULL,
  `Status` varchar(20) DEFAULT 'pending',
  PRIMARY KEY (`FriendshipId`),
  UNIQUE KEY `StudentId1` (`StudentId1`,`StudentId2`),
  KEY `StudentId2` (`StudentId2`),
  CONSTRAINT `friendship_ibfk_1` FOREIGN KEY (`StudentId1`) REFERENCES `users` (`UserId`),
  CONSTRAINT `friendship_ibfk_2` FOREIGN KEY (`StudentId2`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendship`
--

LOCK TABLES `friendship` WRITE;
/*!40000 ALTER TABLE `friendship` DISABLE KEYS */;
INSERT INTO `friendship` VALUES (10,1,2,'pending'),(11,1,5,'pending'),(12,3,1,'pending'),(13,2,8,'pending'),(14,3,9,'pending'),(15,4,10,'pending'),(16,5,11,'pending'),(17,6,12,'pending'),(18,7,13,'pending'),(19,8,14,'pending'),(20,9,15,'pending'),(21,10,11,'pending'),(22,12,13,'pending'),(23,14,15,'pending'),(24,16,17,'pending'),(25,18,19,'pending'),(26,20,21,'pending'),(27,22,23,'pending'),(28,24,25,'pending');
/*!40000 ALTER TABLE `friendship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `NotifId` int NOT NULL AUTO_INCREMENT,
  `RideId` int NOT NULL,
  `ReceiverId` int NOT NULL,
  `SenderId` int NOT NULL,
  `Message` text NOT NULL,
  `NotificationType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`NotifId`),
  KEY `RideId` (`RideId`),
  KEY `ReceiverId` (`ReceiverId`),
  KEY `SenderId` (`SenderId`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`RideId`) REFERENCES `rides` (`RideId`),
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`ReceiverId`) REFERENCES `users` (`UserId`),
  CONSTRAINT `notifications_ibfk_3` FOREIGN KEY (`SenderId`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,1,1,2,'I\'ll be waiting outside the library.','Message'),(2,2,4,5,'I\'m at the pickup point.','Pickup Alert'),(3,3,3,6,'Thanks for the ride!','Thank you Message'),(4,4,8,10,'Are you on your way?','Query'),(5,5,7,9,'Thanks for the lift!','Appreciation'),(6,6,11,1,'I\'m near the pickup location.','Pickup Alert'),(7,7,12,2,'Running a bit late, sorry!','Delay Alert'),(8,8,13,3,'See you soon.','Message'),(9,9,14,4,'Can you wait for 5 minutes?','Query'),(10,10,15,5,'Thanks for choosing me.','Appreciation'),(11,11,16,12,'On my way to the pickup spot.','Pickup Alert'),(12,12,17,13,'Stuck in traffic, sorry!','Delay Alert'),(13,13,18,14,'Thank you for choosing me.','Thank You'),(14,14,19,15,'See you soon at the pickup location.','Pickup Confirmation'),(15,15,20,16,'Let\'s meet at the usual spot.','Meeting Point');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `RequestId` int NOT NULL AUTO_INCREMENT,
  `RideId` int NOT NULL,
  `PassengerId` int NOT NULL,
  `Status` varchar(50) NOT NULL,
  PRIMARY KEY (`RequestId`),
  KEY `RideId` (`RideId`),
  KEY `PassengerId` (`PassengerId`),
  CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`RideId`) REFERENCES `rides` (`RideId`),
  CONSTRAINT `requests_ibfk_2` FOREIGN KEY (`PassengerId`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` VALUES (2,1,3,'Pending'),(3,2,5,'Accepted'),(4,3,6,'Accepted'),(5,3,7,'Declined'),(6,4,10,'Pending'),(7,5,9,'Accepted'),(11,6,1,'Pending'),(12,7,2,'Accepted'),(13,8,3,'Rejected'),(14,9,4,'Pending'),(15,10,5,'Accepted'),(16,6,6,'Accepted'),(17,7,7,'Pending'),(18,8,8,'Rejected'),(19,11,12,'Pending'),(20,12,13,'Accepted'),(21,13,14,'Rejected'),(22,14,15,'Pending'),(23,15,16,'Accepted'),(24,11,17,'Accepted'),(25,12,18,'Pending'),(26,13,19,'Rejected'),(27,14,20,'Accepted'),(28,15,21,'Pending');
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `ReviewId` int NOT NULL AUTO_INCREMENT,
  `RideId` int NOT NULL,
  `Feedback` text,
  `Rating` int NOT NULL,
  PRIMARY KEY (`ReviewId`),
  KEY `RideId` (`RideId`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`RideId`) REFERENCES `rides` (`RideId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,'Great ride!',5),(2,2,'Smooth journey, thanks!',4),(3,3,'Quick and comfortable!',5),(4,4,'Driver was late.',3),(5,5,'Pleasant trip.',4),(6,6,'Excellent service!',5),(7,7,'Very friendly driver.',4),(8,8,'Comfortable ride.',4),(9,9,'Driver was a bit late.',3),(10,10,'Good experience overall.',4),(11,11,'Very punctual.',5),(12,12,'Comfortable car.',4),(13,13,'Nice conversation.',4),(14,14,'A bit crowded.',3),(15,15,'Easygoing driver.',4);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rides`
--

DROP TABLE IF EXISTS `rides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rides` (
  `RideId` int NOT NULL AUTO_INCREMENT,
  `DriverId` int NOT NULL,
  `Time` time NOT NULL,
  `PickupLocation` varchar(255) NOT NULL,
  `DropoffLocation` varchar(255) NOT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`RideId`),
  KEY `DriverId` (`DriverId`),
  CONSTRAINT `rides_ibfk_1` FOREIGN KEY (`DriverId`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rides`
--

LOCK TABLES `rides` WRITE;
/*!40000 ALTER TABLE `rides` DISABLE KEYS */;
INSERT INTO `rides` VALUES (1,1,'15:00:00','Downtown San Jose','SJSU','Scheduled',NULL),(2,4,'17:30:00','SJSU','Santa Clara','In Progress',NULL),(3,8,'14:00:00','Santa Clara University','De Anza College','Scheduled',NULL),(4,3,'09:00:00','De Anza College','SJSU','Completed',NULL),(5,7,'12:00:00','SJSU Library','De Anza','In Progress',NULL),(6,11,'08:30:00','Downtown Cupertino','Apple Park','Scheduled','2023-01-20'),(7,12,'10:00:00','San Jose Airport','SJSU','In Progress','2023-01-21'),(8,13,'13:00:00','De Anza College','Downtown San Jose','Completed','2023-01-22'),(9,14,'16:00:00','SJSU','San Jose Airport','Scheduled','2023-01-23'),(10,15,'18:00:00','Santa Clara','SCU','In Progress','2023-01-24'),(11,16,'07:15:00','Cupertino','SJSU','Scheduled','2023-02-01'),(12,17,'09:30:00','San Jose','SCU','In Progress','2023-02-02'),(13,18,'11:45:00','Santa Clara','De Anza','Completed','2023-02-03'),(14,19,'13:15:00','SJSU','Cupertino','Scheduled','2023-02-04'),(15,20,'15:30:00','SCU','San Jose','In Progress','2023-02-05'),(16,21,'17:45:00','De Anza','Santa Clara','Completed','2023-02-06'),(17,22,'19:00:00','Cupertino','SJSU','Scheduled','2023-02-07'),(18,23,'20:30:00','San Jose','SCU','In Progress','2023-02-08'),(19,24,'22:00:00','Santa Clara','De Anza','Completed','2023-02-09'),(20,25,'23:30:00','SJSU','Cupertino','Scheduled','2023-02-10');
/*!40000 ALTER TABLE `rides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduledrides`
--

DROP TABLE IF EXISTS `scheduledrides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduledrides` (
  `ScheduleId` int NOT NULL AUTO_INCREMENT,
  `RideId` int NOT NULL,
  `ScheduledDate` date NOT NULL,
  `ScheduledTime` time NOT NULL,
  PRIMARY KEY (`ScheduleId`),
  KEY `RideId` (`RideId`),
  CONSTRAINT `scheduledrides_ibfk_1` FOREIGN KEY (`RideId`) REFERENCES `rides` (`RideId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduledrides`
--

LOCK TABLES `scheduledrides` WRITE;
/*!40000 ALTER TABLE `scheduledrides` DISABLE KEYS */;
INSERT INTO `scheduledrides` VALUES (1,1,'2023-12-20','15:00:00'),(2,2,'2023-12-21','17:30:00'),(3,3,'2023-12-22','09:00:00'),(4,4,'2023-12-23','12:00:00'),(5,5,'2023-12-24','13:00:00'),(6,6,'2023-12-25','14:00:00'),(7,7,'2023-12-26','14:30:00'),(8,8,'2023-12-27','15:00:00'),(9,9,'2023-12-28','15:30:00'),(10,10,'2023-12-29','16:00:00'),(11,11,'2023-12-30','16:30:00'),(12,12,'2023-12-31','17:00:00'),(13,13,'2024-01-01','17:30:00'),(14,14,'2024-01-02','18:00:00'),(15,15,'2024-01-03','18:30:00');
/*!40000 ALTER TABLE `scheduledrides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university`
--

DROP TABLE IF EXISTS `university`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `university` (
  `UniversityId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  PRIMARY KEY (`UniversityId`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university`
--

LOCK TABLES `university` WRITE;
/*!40000 ALTER TABLE `university` DISABLE KEYS */;
INSERT INTO `university` VALUES (1,'San Jose State University','1 Washington Sq, San Jose, CA 95192'),(2,'Santa Clara University','500 El Camino Real, Santa Clara, CA 95053'),(3,'De Anza College','21250 Stevens Creek Blvd, Cupertino, CA 95014');
/*!40000 ALTER TABLE `university` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpreferences` (
  `PreferenceId` int NOT NULL AUTO_INCREMENT,
  `UserId` int NOT NULL,
  `Pref_Name` varchar(255) NOT NULL,
  `Pref_Value` varchar(255) NOT NULL,
  PRIMARY KEY (`PreferenceId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `userpreferences_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
INSERT INTO `userpreferences` VALUES (2,2,'Notification Frequency','Weekly'),(3,3,'Privacy','Public'),(4,4,'Language','Spanish'),(5,5,'Notification Frequency','Daily'),(6,6,'Privacy','Friends Only'),(7,7,'Language','English'),(8,8,'Notification Frequency','Never'),(9,9,'Privacy','Public'),(10,10,'Language','English'),(15,1,'test','test'),(16,11,'Language','French'),(17,12,'Notification Frequency','Monthly'),(18,13,'Privacy','Private'),(19,14,'Language','German'),(20,15,'Notification Frequency','Weekly'),(21,16,'Language','English'),(22,17,'Notification Frequency','Weekly'),(23,18,'Privacy','Public'),(24,19,'Language','Spanish'),(25,20,'Notification Frequency','Daily'),(26,11,'Music','No Preference'),(27,11,'Smoke-free','Yes');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserId` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` varchar(50) DEFAULT NULL,
  `UniversityId` int DEFAULT NULL,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `Email` (`Email`),
  KEY `UniversityId` (`UniversityId`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`UniversityId`) REFERENCES `university` (`UniversityId`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'john.doe@sjsu.edu','John Doe','123','Driver',1),(2,'mary.smith@scu.edu','Mary Smith','hashedpassword2','Passenger',2),(3,'alex.jones@deanza.edu','Alex Jones','hashedpassword3','Both',3),(4,'lucy.white@sjsu.edu','Lucy White','hashedpassword4','Driver',1),(5,'james.brown@scu.edu','James Brown','hashedpassword5','Passenger',2),(6,'chris.taylor@sjsu.edu','Chris Taylor','hashedpassword6','Both',1),(7,'emma.wilson@deanza.edu','Emma Wilson','hashedpassword7','Passenger',3),(8,'olivia.green@scu.edu','Olivia Green','hashedpassword8','Driver',2),(9,'sophia.harris@sjsu.edu','Sophia Harris','hashedpassword9','Both',1),(10,'isabella.jackson@sjsu.edu','Isabella Jackson','hashedpassword10','Passenger',1),(11,'lisa.martin@sjsu.edu','Lisa Martin','hashedpassword11','Passenger',1),(12,'david.lee@scu.edu','David Lee','hashedpassword12','Driver',2),(13,'sara.clark@deanza.edu','Sara Clark','hashedpassword13','Both',3),(14,'mike.wilson@sjsu.edu','Mike Wilson','hashedpassword14','Driver',1),(15,'rachel.kim@scu.edu','Rachel Kim','hashedpassword15','Passenger',2),(16,'sam.roberts@sjsu.edu','Sam Roberts','hashedpassword16','Driver',1),(17,'diana.prince@scu.edu','Diana Prince','hashedpassword17','Passenger',2),(18,'clark.kent@deanza.edu','Clark Kent','hashedpassword18','Both',3),(19,'bruce.wayne@sjsu.edu','Bruce Wayne','hashedpassword19','Driver',1),(20,'lois.lane@scu.edu','Lois Lane','hashedpassword20','Passenger',2),(21,'peter.parker@deanza.edu','Peter Parker','hashedpassword21','Both',3),(22,'natasha.romanoff@sjsu.edu','Natasha Romanoff','hashedpassword22','Driver',1),(23,'tony.stark@scu.edu','Tony Stark','hashedpassword23','Passenger',2),(24,'steve.rogers@deanza.edu','Steve Rogers','hashedpassword24','Both',3),(25,'gwen.stacy@sjsu.edu','Gwen Stacy','hashedpassword25','Driver',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `LicensePlate` varchar(255) NOT NULL,
  `UserId` int NOT NULL,
  `Manufacturer` varchar(255) NOT NULL,
  `Model` varchar(255) NOT NULL,
  `Color` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LicensePlate`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES ('ABC789',4,'Honda','Civic','Red'),('BCD444',16,'Audi','A4','Black'),('CDE333',25,'Tesla','Model 3','White'),('DEF012',7,'Chevrolet','Impala','Silver'),('EFG555',17,'Mercedes','C Class','Silver'),('GHI345',3,'Hyundai','Elantra','Green'),('HIJ666',18,'BMW','X5','White'),('JKL678',11,'Nissan','Altima','Grey'),('KLM777',19,'Audi','Q7','Blue'),('LMN456',8,'Ford','Focus','Black'),('MNO910',12,'Subaru','Outback','White'),('NOP888',20,'Tesla','Model S','Red'),('PQR111',13,'Volkswagen','Jetta','Black'),('QRS999',21,'Lexus','RX','Black'),('STU222',14,'Mazda','CX-5','Red'),('TUV000',22,'Porsche','Cayenne','Green'),('VWX333',15,'BMW','3 Series','Blue'),('WXY111',23,'BMW','5 Series','Grey'),('XYZ123',1,'Toyota','Camry','Blue'),('ZAB222',24,'Audi','A6','Blue');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-09 16:38:48
