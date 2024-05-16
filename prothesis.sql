-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: prothesis
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateTime` datetime NOT NULL,
  `room` int NOT NULL,
  `status` enum('Запись назначена','Запись отменена','Прием завершен') NOT NULL,
  `patients_id` int NOT NULL,
  `doctors_id` int NOT NULL,
  `services_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_appointments_patients1_idx` (`patients_id`),
  KEY `fk_appointments_doctors1_idx` (`doctors_id`),
  KEY `fk_appointments_services1_idx` (`services_id`),
  CONSTRAINT `fk_appointments_doctors1` FOREIGN KEY (`doctors_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `fk_appointments_patients1` FOREIGN KEY (`patients_id`) REFERENCES `patients` (`id`),
  CONSTRAINT `fk_appointments_services1` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DuplicateAppointments` BEFORE INSERT ON `appointments` FOR EACH ROW BEGIN
    DECLARE appointment_count INT;
    
    SELECT COUNT(*) INTO appointment_count
    FROM appointments
    WHERE dateTime = NEW.dateTime
    AND doctors_id = NEW.doctors_id;
    
    IF appointment_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Запись уже существует';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullName` varchar(45) NOT NULL,
  `position` varchar(45) NOT NULL,
  `work_experience_start_day` date NOT NULL,
  `phone` char(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  UNIQUE KEY `fullName_UNIQUE` (`fullName`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Адамс Юлия Сергеевна','Главный хирург-протезист','2015-09-21','+71234567892'),(2,'Михайлов Владимир Петрович','Врач-хирург','2010-04-15','+71234167892'),(3,'Коваленко Олег Васильевич','Врач-протезист','2012-07-27','+71294567892'),(4,'Иванова Анна Николаевна','Главный хирург-протезист','2016-04-15','+71234567893'),(5,'Петрова Елена Дмитриевна','Врач-хирург','2018-05-17','+71234567894'),(6,'Смирнов Сергей Игоревич','Главный хирург-протезист','2014-11-15','+71234567895'),(7,'Козлова Мария Алексеевна','Техник-протезист','2017-08-25','+71234567896'),(8,'Никитина Антонина Владимировна','Ассистент хирурга','2015-01-10','+71234567897'),(9,'Соколов Игорь Александрович','Специалист по наноимплантам','2013-12-03','+71234567898'),(10,'Федорова Татьяна Сергеевна','Ассистент хирурга','2011-05-27','+71234567899');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_name` varchar(100) NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL,
  `count` int unsigned NOT NULL,
  `date` datetime NOT NULL,
  `status` enum('Создан','В пути','Получен','Отменен') NOT NULL,
  `doctors_id` int NOT NULL,
  `prosthetics_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orders_doctors1_idx` (`doctors_id`),
  KEY `fk_orders_prosthetics1_idx` (`prosthetics_id`),
  CONSTRAINT `fk_orders_doctors1` FOREIGN KEY (`doctors_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `fk_orders_prosthetics1` FOREIGN KEY (`prosthetics_id`) REFERENCES `prosthetics` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'Протеза глаза: \"Cognitive interface prosthesis system\"',27000.00,2,'2024-04-15 00:00:00','Создан',1,1),(2,'Установка мозгового чипа: \"Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)\"',17000.00,1,'2024-04-18 00:00:00','В пути',2,2),(3,'Установка протеза кисти: \"Isoiay\"',12000.00,2,'2024-04-20 00:00:00','Создан',3,3),(4,'Установка аугментированного интеллектуального анализатора: \"SmartVision X4\"',34000.00,1,'2024-04-22 00:00:00','В пути',4,4),(5,'Нейро-сетевой интерфейс: \"NeuralLink Pro\"',38000.00,1,'2024-04-25 00:00:00','Получен',5,5),(6,'Бионическая рука: \"TitanArm Mk.II\"',36000.00,1,'2024-04-25 00:00:00','Создан',7,9);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patienthistory`
--

DROP TABLE IF EXISTS `patienthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patienthistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `state` varchar(45) NOT NULL,
  `patients_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_patientHistory_patients1_idx` (`patients_id`),
  CONSTRAINT `fk_patientHistory_patients1` FOREIGN KEY (`patients_id`) REFERENCES `patients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patienthistory`
--

LOCK TABLES `patienthistory` WRITE;
/*!40000 ALTER TABLE `patienthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `patienthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullName` varchar(255) NOT NULL,
  `birthday` date NOT NULL,
  `gender` char(1) NOT NULL,
  `phone` char(12) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'Сидоров Артем Николаевич','2001-08-15','М','+71234567893','artem@yandex.ru'),(2,'Петрова Мария Дмитриевна','1998-03-20','Ж','+71294567893','maria@yandex.ru'),(3,'Козлов Александр Александрович','1995-12-28','М','+71231567893','alexander@yandex.ru'),(4,'Иванов Иван Иванович','2005-07-07','М','+79807359872','ivanov@yandex.ru');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prosthetics`
--

DROP TABLE IF EXISTS `prosthetics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prosthetics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `manufacturer` varchar(45) NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL,
  `count` int unsigned DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prosthetics`
--

LOCK TABLES `prosthetics` WRITE;
/*!40000 ALTER TABLE `prosthetics` DISABLE KEYS */;
INSERT INTO `prosthetics` VALUES (1,'Кибернетический протез глаза: \"Cognitive interface prosthesis system\"','Sarif Industries',27000.00,NULL,'Аугментация глаз для улучшения зрения и ночного видения.'),(2,'Кибернетический мозговой чип: \"Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)\"','Tai Yong Medical',17000.00,NULL,'Инновационный мозговой чип, способствующий улучшению когнитивных функций и оптимизации работы мозга.'),(3,'Кибернетический протез кисти: \"Isoiay\"','VersaLife',12000.00,NULL,'Протез \"Isoiay\" обеспечивает точное и естественное движение кисти, позволяя пациенту вернуться к повседневным делам с комфортом и уверенностью.'),(4,'Аугментированный интеллектуальный нейроинтерфейс: \"SmartVision X4\"','Sarif Industries',34000.00,NULL,'Расширяет обзор и улучшает понимание окружающего мира.'),(5,'Кибернетическая кожа: \"DermaFlex Mk.IV\"','Picus Group',25000.00,NULL,'Предоставляет высокий уровень защиты и улучшает чувствительность кожи.'),(6,'Нейро-сетевой интерфейс: \"NeuralLink Pro\"','VersaLife',38000.00,NULL,'Обеспечивает прямое взаимодействие между мозгом и технологическими устройствами.'),(7,'Кибернетический имплантат ноги: \"PowerStride Plus\"','LIMB International',29000.00,NULL,'Повышает скорость и маневренность при движении.'),(8,'Микро-нейроинтерфейс: \"NeuroLink Nano\"','Tai Yong Medical',41000.00,NULL,'Миниатюрный имплантат, улучшающий память и когнитивные способности.'),(9,'Бионическая рука: \"TitanArm Mk.II\"','Sarif Industries',36000.00,NULL,'Обеспечивает силу и гибкость в повседневных задачах и экстремальных условиях.'),(10,'Кибернетический слуховой аппарат: \"AudioEnhance Bionic Ear\"','Picus Group',31000.00,NULL,'Улучшает слух и фильтрует внешние звуки для комфортного восприятия окружающего мира.');
/*!40000 ALTER TABLE `prosthetics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL,
  `required_documents` varchar(255) NOT NULL,
  `doctors_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_services_doctors1_idx` (`doctors_id`),
  CONSTRAINT `fk_services_doctors1` FOREIGN KEY (`doctors_id`) REFERENCES `doctors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Установка киберпротеза \"Sinenergy\" с консультацией врача-протезиста.','Сложная операция по установке киберпротеза с последующими консультациями по эксплуатации и реабилитации.',15000.00,'Удостоверение личности, медицинская карта',1),(2,'Процедура аугментации глаз \"Соколиный Взгляд\" с диагностикой и контрольными обследованиями.','Процедура аугментации глаз с использованием передовых технологий и контролями для обеспечения оптимального результата.',20000.00,'Удостоверение личности, медицинская карта',3),(3,'Наноимплантация мозгового чипа \"Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)\" с последующим реабилитационным курсом.','Хирургическая процедура установки наноимпланта для улучшения социального взаимодействия, с последующим реабилитационным курсом.',25000.00,'Удостоверение личности, медицинская карта',2),(4,'Установка кибернетического протеза кисти \"Isoiay\" с реабилитационными процедурами.','Операция по установке кибернетического протеза для восстановления функциональности кисти с последующим реабилитационным курсом.',12000.00,'Удостоверение личности, медицинская карта',4),(5,'Аугментация глаз \"Кибернетический протез глаза: \"Cognitive interface prosthesis system\"\" с комплексным медицинским обследованием и дополнительными настройками.','Услуга по аугментации глаз с использованием передовых технологий и индивидуальным подбором параметров для максимального комфорта.',18000.00,'Удостоверение личности, медицинская карта',5),(6,'Наноимплантация \"Серебряный Орел\" с индивидуальной подборкой протеза и послепроцедурным обслуживанием.','Хирургическая процедура установки наноимпланта с индивидуальным подбором протеза и дальнейшим техническим обслуживанием.',22000.00,'Удостоверение личности, медицинская карта',6),(7,'Установка кибернетического мозгового чипа \"Neural SubNet Processor\" с консультацией врача-хирурга.','Хирургическая процедура установки кибернетического мозгового чипа с последующей консультацией врача-хирурга.',20000.00,'Удостоверение личности, медицинская карта',7),(8,'Аугментация конечности \"Titan Hand\" с индивидуальным планированием и реабилитацией.','Комплексная процедура аугментации конечности с индивидуальным планированием и последующей реабилитацией.',18000.00,'Удостоверение личности, медицинская карта',8),(9,'Наноимплантация спинного мозга \"Neuro\" с комплексным нейрологическим обследованием.','Хирургическая процедура установки наноимпланта для улучшения работы спинного мозга с последующим комплексным нейрологическим обследованием.',25000.00,'Удостоверение личности, медицинская карта',9),(10,'Установка кибернетического протеза сердца \"Синтетический Эндокринный Сердечный Агрегат\" с последующим мониторингом состояния и дистанционным управлением.','Хирургическая процедура установки кибернетического протеза сердца с последующим мониторингом и управлением через сеть.',30000.00,'Удостоверение личности, медицинская карта',10);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_reports`
--

DROP TABLE IF EXISTS `services_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `services` varchar(100) NOT NULL,
  `notes` varchar(255) NOT NULL,
  `doctors_id` int NOT NULL,
  `services_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reports_doctors1_idx` (`doctors_id`),
  KEY `fk_services_reports_services1_idx` (`services_id`),
  CONSTRAINT `fk_reports_doctors1` FOREIGN KEY (`doctors_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `fk_services_reports_services1` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_reports`
--

LOCK TABLES `services_reports` WRITE;
/*!40000 ALTER TABLE `services_reports` DISABLE KEYS */;
INSERT INTO `services_reports` VALUES (1,'2024-04-15 00:00:00','Протеза глаза \"Cognitive interface prosthesis system\"','Операция прошла успешно, пациент себя чувствует хорошо, рекомендован курс реабилитации.',1,1),(2,'2024-05-18 00:00:00','Установка мозгового чипа \"Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)\"','Пациенту требуется последующее наблюдение и курс восстановительных мероприятий.',2,2),(3,'2024-06-20 00:00:00','Установка протеза кисти \"Isoiay\"','Ожидается полное восстановление функций кисти, а так же необходимо пройти курс реабилитации.',3,3),(4,'2024-07-22 00:00:00','Установка аугментированного интеллектуального нейроинтерфейса \"SmartVision X4\"','Процесс адаптации к новым возможностям проходит без осложнений.',4,4),(5,'2024-08-25 00:00:00','Нейро-сетевой интерфейс \"NeuralLink Pro\"','Пациент замечает улучшения в памяти и внимании после установки интерфейса.',5,5),(6,'2024-09-25 00:00:00','Бионическая рука \"TitanArm Mk.II\"','Процесс адаптации проходит успешно, все функции работают в норме',7,9),(7,'2024-10-16 00:00:00','Аугментация глаз \"Кибернетический протез глаза: \"Cognitive interface prosthesis system\"','Пациент четко видит слова на расстоянии более 500 метров, оттаржения не наблюдается',1,5),(8,'2024-11-19 00:00:00','Наноимплантация мозгового чипа: \"Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)\"','Требуется дополнительная исследовательская работа для оптимизации параметров.',2,3),(9,'2024-12-21 00:00:00','Установка кибернетического протеза сердца \"Синтетический Эндокринный Сердечный Агрегат\"','Наблюдается улучшение функций сердца после процедуры.',4,9),(10,'2024-12-23 00:00:00','Аугментация конечности \"Титановый Рукав\"','Наблюдается значительное увеличение мобильности после процедуры.',1,8);
/*!40000 ALTER TABLE `services_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_operations`
--

DROP TABLE IF EXISTS `view_operations`;
/*!50001 DROP VIEW IF EXISTS `view_operations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_operations` AS SELECT 
 1 AS `date`,
 1 AS `doctor`,
 1 AS `patient`,
 1 AS `service`,
 1 AS `notes`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'prothesis'
--

--
-- Dumping routines for database 'prothesis'
--
/*!50003 DROP FUNCTION IF EXISTS `GetTotalAppointments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetTotalAppointments`(patient_id INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE total_appointments INT;
    
    SELECT COUNT(*) INTO total_appointments
    FROM appointments
    WHERE patients_id = patient_id;
    
    RETURN total_appointments;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addAppointment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addAppointment`(
    IN p_patient_id INT,
    IN p_doctor INT,
    IN p_service INT,
    IN p_date DATETIME,
    IN p_room INT
)
BEGIN
    DECLARE appointment_id INT;

    INSERT INTO appointments (dateTime, room, status, patients_id, doctors_id, services_id)
    VALUES (p_date, p_room, 'Запись назначена', p_patient_id, p_doctor, p_service);

    SET appointment_id = LAST_INSERT_ID();

    SELECT 'Вы успешно записались на прием' AS Message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `NewPatient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `NewPatient`(
    IN p_fullName VARCHAR(255),
    IN p_birthday DATE,
    IN p_gender CHAR(1),
    IN p_phone CHAR(12),
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE v_patientExists INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        SELECT CONCAT('Error occurred: ', @p1, ': ', @p2);
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*) INTO v_patientExists 
    FROM Patients 
    WHERE fullName = p_fullName 
    AND birthday = p_birthday 
    AND gender = p_gender 
    AND phone = p_phone 
    AND email = p_email;
    
    IF v_patientExists = 0 THEN
        INSERT INTO Patients (fullName, birthday, gender, phone, email)
        VALUES (p_fullName, p_birthday, p_gender, p_phone, p_email);
        
        COMMIT;
        SELECT 'Клиент успешно добавлен';
    ELSE
        ROLLBACK;
        SELECT 'Клиент уже существует';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_operations`
--

/*!50001 DROP VIEW IF EXISTS `view_operations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_operations` AS select `services_reports`.`date` AS `date`,`doctors`.`fullName` AS `doctor`,`patients`.`fullName` AS `patient`,`services`.`name` AS `service`,`services_reports`.`notes` AS `notes` from (((`services_reports` join `doctors` on((`services_reports`.`doctors_id` = `doctors`.`id`))) join `services` on((`services_reports`.`services_id` = `services`.`id`))) join `patients` on((`services`.`id` = `patients`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-16 12:16:16
