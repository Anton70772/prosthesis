-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: prosthesis
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,'2024-04-25 14:10:00',124,'Запись назначена',4,7,2),(2,'2024-04-25 14:10:00',124,'Запись назначена',2,3,4),(3,'2024-04-25 14:10:00',124,'Запись назначена',1,2,1),(4,'2024-04-25 14:10:00',123,'Запись назначена',3,1,3),(5,'2024-04-25 15:10:00',124,'Запись назначена',3,1,3),(6,'2024-04-27 14:10:00',103,'Запись назначена',4,2,1),(7,'2024-04-25 15:00:00',120,'Запись назначена',5,5,5);
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
  `work_experience` year NOT NULL,
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
INSERT INTO `doctors` VALUES (1,'Адамс Юлия Сергеевна','Главный хирург-протезист',2015,'+71234567892'),(2,'Михайлов Владимир Петрович','Врач-хирург',2010,'+71234167892'),(3,'Коваленко Олег Васильевич','Врач-протезист',2012,'+71294567892'),(4,'Иванова Анна Николаевна','Главный хирург-протезист',2008,'+71234567893'),(5,'Петрова Елена Дмитриевна','Врач-хирург',2006,'+71234567894'),(6,'Смирнов Сергей Игоревич','Главный хирург-протезист',2010,'+71234567895'),(7,'Козлова Мария Алексеевна','Техник-протезист',2007,'+71234567896'),(8,'Никитина Антонина Владимировна','Ассистент хирурга',2009,'+71234567897'),(9,'Соколов Игорь Александрович','Специалист по наноимплантам',2011,'+71234567898'),(10,'Федорова Татьяна Сергеевна','Ассистент хирурга',2013,'+71234567899');
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
  `price` decimal(10,2) NOT NULL,
  `count` int NOT NULL,
  `date` date NOT NULL,
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
INSERT INTO `orders` VALUES (1,'Протеза глаза: \"Cognitive interface prosthesis system\"',27000.00,2,'2024-04-15','Создан',1,1),(2,'Установка мозгового чипа: \"Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)\"',17000.00,1,'2024-04-18','В пути',2,2),(3,'Установка протеза кисти: \"Isoiay\"',12000.00,2,'2024-04-20','Создан',3,3),(4,'Установка аугментированного интеллектуального анализатора: \"SmartVision X4\"',34000.00,1,'2024-04-22','В пути',4,4),(5,'Нейро-сетевой интерфейс: \"NeuralLink Pro\"',38000.00,1,'2024-04-25','Получен',5,5),(6,'Бионическая рука: \"TitanArm Mk.II\"',36000.00,1,'2024-04-25','Создан',7,9);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'Сидоров Артем Николаевич','1988-08-15','М','111-222-3333','artem@example.com'),(2,'Петрова Мария Дмитриевна','1975-03-20','Ж','444-555-6666','maria@example.com'),(3,'Козлов Александр Александрович','1995-12-28','М','777-888-9999','alexander@example.com'),(4,'Тест Тестович Тестов','2005-09-25','М','+79806261774','anton@yandex.ru'),(5,'Тестов Тест Тестович','2007-07-07','М','+79801739423','test@yandex.ru'),(6,'Тестова Теста Тестовна','2004-07-19','Ж','+79308361724','testova@yandex.ru');
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
  `count` int DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prosthetics`
--

LOCK TABLES `prosthetics` WRITE;
/*!40000 ALTER TABLE `prosthetics` DISABLE KEYS */;
INSERT INTO `prosthetics` VALUES (1,'Кибернетический протез глаза: \"Cognitive interface prosthesis system\"','Sarif Industries',27000.00,5,'Аугментация глаз для улучшения зрения и ночного видения.'),(2,'Кибернетический мозговой чип: \"Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)\"','Tai Yong Medical',17000.00,2,'Инновационный мозговой чип, способствующий улучшению когнитивных функций и оптимизации работы мозга.'),(3,'Кибернетический протез кисти: \"Isoiay\"','VersaLife',12000.00,9,'Протез \"Isoiay\" обеспечивает точное и естественное движение кисти, позволяя пациенту вернуться к повседневным делам с комфортом и уверенностью.'),(4,'Аугментированный интеллектуальный анализатор: \"SmartVision X4\"','Sarif Industries',34000.00,7,'Расширяет обзор и улучшает понимание окружающего мира.'),(5,'Кибернетическая кожа: \"DermaFlex Mk.IV\"','Picus Group',25000.00,8,'Предоставляет высокий уровень защиты и улучшает чувствительность кожи.'),(6,'Нейро-сетевой интерфейс: \"NeuralLink Pro\"','VersaLife',38000.00,3,'Обеспечивает прямое взаимодействие между мозгом и технологическими устройствами.'),(7,'Кибернетический имплантат ноги: \"PowerStride Plus\"','LIMB International',29000.00,0,'Повышает скорость и маневренность при движении.'),(8,'Микро-нейроинтерфейс: \"NeuroLink Nano\"','Tai Yong Medical',41000.00,1,'Миниатюрный имплантат, улучшающий память и когнитивные способности.'),(9,'Бионическая рука: \"TitanArm Mk.II\"','Sarif Industries',36000.00,4,'Обеспечивает силу и гибкость в повседневных задачах и экстремальных условиях.'),(10,'Кибернетический слуховой аппарат: \"AudioEnhance Bionic Ear\"','Picus Group',31000.00,0,'Улучшает слух и фильтрует внешние звуки для комфортного восприятия окружающего мира.');
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
  `price` decimal(10,2) NOT NULL,
  `required_documents` varchar(255) NOT NULL,
  `doctors_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_doctors_services` (`doctors_id`),
  CONSTRAINT `fk_doctors_services` FOREIGN KEY (`doctors_id`) REFERENCES `doctors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Установка киберпротеза \"Синергия\" с консультацией врача-протезиста.','Сложная операция по установке киберпротеза с последующими консультациями по эксплуатации и реабилитации.',15000.00,'Удостоверение личности, медицинская карта',4),(2,'Процедура аугментации глаз \"Соколиный Взгляд\" с диагностикой и контрольными обследованиями.','Процедура аугментации глаз с использованием передовых технологий и контролями для обеспечения оптимального результата.',20000.00,'Удостоверение личности, медицинская карта',2),(3,'Наноимплантация мозгового чипа \"Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)\" с последующим реабилитационным курсом.','Хирургическая процедура установки наноимпланта для улучшения социального взаимодействия, с последующим реабилитационным курсом.',25000.00,'Удостоверение личности, медицинская карта',3),(4,'Установка кибернетического протеза кисти \"Isoiay\" с реабилитационными процедурами.','Операция по установке кибернетического протеза для восстановления функциональности кисти с последующим реабилитационным курсом.',12000.00,'Удостоверение личности, медицинская карта',1),(5,'Аугментация глаз \"Кибернетический протез глаза: \"Cognitive interface prosthesis system\"\" с комплексным медицинским обследованием и дополнительными настройками.','Услуга по аугментации глаз с использованием передовых технологий и индивидуальным подбором параметров для максимального комфорта.',18000.00,'Удостоверение личности, медицинская карта',NULL),(6,'Наноимплантация \"Серебряный Орел\" с индивидуальной подборкой протеза и послепроцедурным обслуживанием.','Хирургическая процедура установки наноимпланта с индивидуальным подбором протеза и дальнейшим техническим обслуживанием.',22000.00,'Удостоверение личности, медицинская карта',NULL),(7,'Установка кибернетического мозгового чипа \"Neural SubNet Processor\" с консультацией врача-хирурга.','Хирургическая процедура установки кибернетического мозгового чипа с последующей консультацией врача-хирурга.',20000.00,'Удостоверение личности, медицинская карта',NULL),(8,'Аугментация конечности \"Титановый Рукав\" с индивидуальным планированием и реабилитацией.','Комплексная процедура аугментации конечности с индивидуальным планированием и последующей реабилитацией.',18000.00,'Удостоверение личности, медицинская карта',NULL),(9,'Наноимплантация спинного мозга \"Нейросеть: Интеллектуальная Доска\" с комплексным нейрологическим обследованием.','Хирургическая процедура установки наноимпланта для улучшения работы спинного мозга с последующим комплексным нейрологическим обследованием.',25000.00,'Удостоверение личности, медицинская карта',NULL),(10,'Установка кибернетического протеза сердца \"Синтетический Эндокринный Сердечный Агрегат\" с последующим мониторингом состояния и дистанционным управлением.','Хирургическая процедура установки кибернетического протеза сердца с последующим мониторингом и управлением через сеть.',30000.00,'Удостоверение личности, медицинская карта',NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_reports`
--

LOCK TABLES `services_reports` WRITE;
/*!40000 ALTER TABLE `services_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `testview`
--

DROP TABLE IF EXISTS `testview`;
/*!50001 DROP VIEW IF EXISTS `testview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `testview` AS SELECT 
 1 AS `appointment_id`,
 1 AS `appointment_date`,
 1 AS `room`,
 1 AS `status`,
 1 AS `patient_id`,
 1 AS `patient_name`,
 1 AS `patient_birthday`,
 1 AS `patient_gender`,
 1 AS `patient_phone`,
 1 AS `patient_email`,
 1 AS `doctor_id`,
 1 AS `doctor_name`,
 1 AS `doctor_position`,
 1 AS `service_id`,
 1 AS `service_name`,
 1 AS `service_price`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'prosthesis'
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
/*!50003 DROP PROCEDURE IF EXISTS `AddNewPatient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewPatient`(
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
-- Final view structure for view `testview`
--

/*!50001 DROP VIEW IF EXISTS `testview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `testview` AS select `appointments`.`id` AS `appointment_id`,`appointments`.`dateTime` AS `appointment_date`,`appointments`.`room` AS `room`,`appointments`.`status` AS `status`,`patients`.`id` AS `patient_id`,`patients`.`fullName` AS `patient_name`,`patients`.`birthday` AS `patient_birthday`,`patients`.`gender` AS `patient_gender`,`patients`.`phone` AS `patient_phone`,`patients`.`email` AS `patient_email`,`doctors`.`id` AS `doctor_id`,`doctors`.`fullName` AS `doctor_name`,`doctors`.`position` AS `doctor_position`,`services`.`id` AS `service_id`,`services`.`name` AS `service_name`,`services`.`price` AS `service_price` from (((`appointments` join `patients` on((`appointments`.`patients_id` = `patients`.`id`))) join `doctors` on((`appointments`.`doctors_id` = `doctors`.`id`))) join `services` on((`appointments`.`services_id` = `services`.`id`))) */;
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

-- Dump completed on 2024-04-25 11:01:36
