/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.20-11.8.9-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ucp
-- ------------------------------------------------------
-- Server version	11.8.9-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(249) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `industry` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sic_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `stream_updated_at` datetime DEFAULT NULL,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_NAME` (`name`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `account_contact`
--

DROP TABLE IF EXISTS `account_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_inactive` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ACCOUNT_ID_CONTACT_ID` (`account_id`,`contact_id`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_contact`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `account_contact` WRITE;
/*!40000 ALTER TABLE `account_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_contact` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `account_document`
--

DROP TABLE IF EXISTS `account_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ACCOUNT_ID_DOCUMENT_ID` (`account_id`,`document_id`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_DOCUMENT_ID` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_document`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `account_document` WRITE;
/*!40000 ALTER TABLE `account_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_document` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `account_portal_user`
--

DROP TABLE IF EXISTS `account_portal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_portal_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ID_ACCOUNT_ID` (`user_id`,`account_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_ACCOUNT_ID` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_portal_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `account_portal_user` WRITE;
/*!40000 ALTER TABLE `account_portal_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_portal_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `account_target_list`
--

DROP TABLE IF EXISTS `account_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_target_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ACCOUNT_ID_TARGET_LIST_ID` (`account_id`,`target_list_id`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_target_list`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `account_target_list` WRITE;
/*!40000 ALTER TABLE `account_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_target_list` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `action_history_record`
--

DROP TABLE IF EXISTS `action_history_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `action_history_record` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `number` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `ip_address` varchar(39) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_token_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_log_record_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_TARGET` (`target_type`,`target_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_AUTH_TOKEN_ID` (`auth_token_id`),
  KEY `IDX_AUTH_LOG_RECORD_ID` (`auth_log_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_history_record`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `action_history_record` WRITE;
/*!40000 ALTER TABLE `action_history_record` DISABLE KEYS */;
INSERT INTO `action_history_record` VALUES
('6ae338f3b1e1546a5',0,1,'User',NULL,'read','2026-10-29 12:15:47','172.18.0.1','6ae269f1404188a4c','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3cb761be8bfa75',0,2,'User',NULL,'read','2026-10-29 22:40:54','172.18.0.1','6ae269f1404188a4c','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3cb809727d2d09',0,3,'User',NULL,'read','2026-10-29 22:41:04','172.18.0.1','6ae269f1404188a4c','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3d895ccac00e29',0,4,'User',NULL,'create','2026-10-29 23:36:53','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3d89607b39b245',0,5,'User',NULL,'read','2026-10-29 23:36:54','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3da9e1371bca11',0,6,'User',NULL,'read','2026-10-29 23:45:34','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3db53d5ab11cca',0,7,'Role',NULL,'create','2026-10-29 23:48:35','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3db54012be327a',0,8,'Role',NULL,'read','2026-10-29 23:48:36','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dbcb24eb41b9e',0,9,'Role',NULL,'read','2026-10-29 23:50:35','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dc105e1c5c367',0,10,'Role',NULL,'read','2026-10-29 23:51:44','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dc15d28c31f03',0,11,'Role',NULL,'read','2026-10-29 23:51:49','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dc463b6797cf7',0,12,'Role',NULL,'read','2026-10-29 23:52:38','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dc54ccabecfad',0,13,'Role',NULL,'read','2026-10-29 23:52:52','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dd2db8d7bb96b',0,14,'Role',NULL,'read','2026-10-29 23:56:29','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dd6e049bbfd64',0,15,'Role',NULL,'read','2026-10-29 23:57:34','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dd7a06b9c1b95',0,16,'Role',NULL,'read','2026-10-29 23:57:46','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dd9f0f1ac7657',0,17,'Role',NULL,'read','2026-10-29 23:58:23','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3dda4c29d6781a',0,18,'Role',NULL,'read','2026-10-29 23:58:28','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3de24147343717',0,19,'Role',NULL,'read','2026-10-30 00:00:36','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3de3ceb561c720',0,20,'Role',NULL,'read','2026-10-30 00:01:00','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3de6799cfcb063',0,21,'Role',NULL,'update','2026-10-30 00:01:43','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3de67b36509e82',0,22,'Role',NULL,'read','2026-10-30 00:01:43','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3de9944602ad3d',0,23,'Role',NULL,'read','2026-10-30 00:02:33','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3def238e4b84bc',0,24,'User',NULL,'read','2026-10-30 00:04:02','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3def7c8a2b1a93',0,25,'User',NULL,'read','2026-10-30 00:04:07','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3df0f8a9fc3a00',0,26,'User',NULL,'update','2026-10-30 00:04:31','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3df0fa72dfec38',0,27,'User',NULL,'read','2026-10-30 00:04:31','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3df524d71799a7',0,28,'User',NULL,'read','2026-10-30 00:05:38','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e022dfd740497',0,29,'User',NULL,'read','2026-10-30 00:09:06','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e02e8c8130458',0,30,'User',NULL,'read','2026-10-30 00:09:18','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e073e0b03439f',0,31,'User',NULL,'read','2026-10-30 00:10:27','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e084f07a51be0',0,32,'User',NULL,'read','2026-10-30 00:10:44','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e09e28f7a6691',0,33,'User',NULL,'read','2026-10-30 00:11:10','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e0a030db30309',0,34,'User',NULL,'read','2026-10-30 00:11:12','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e0a9246de05dd',0,35,'User',NULL,'read','2026-10-30 00:11:21','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e0b18b27aa2aa',0,36,'Role',NULL,'read','2026-10-30 00:11:29','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e0c143c014ef6',0,37,'Role',NULL,'read','2026-10-30 00:11:45','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e142e69fae0c2',0,38,'Role',NULL,'update','2026-10-30 00:13:54','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e1430bfc5ab4e',0,39,'Role',NULL,'read','2026-10-30 00:13:55','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e26135342c44f',0,40,'User',NULL,'read','2026-10-30 00:18:41','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e32aac7612d3d',0,41,'User',NULL,'read','2026-10-30 00:22:02','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e3471c5684700',0,42,'User',NULL,'read','2026-10-30 00:22:31','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e353046e589f6',0,43,'User',NULL,'read','2026-10-30 00:22:43','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e35debe61f2b7',0,44,'User',NULL,'read','2026-10-30 00:22:53','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e36e2310214b5',0,45,'Role',NULL,'read','2026-10-30 00:23:10','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e3714c40bf2b9',0,46,'Role',NULL,'read','2026-10-30 00:23:13','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e5e055069895b',0,47,'Role',NULL,'read','2026-10-30 00:33:36','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e5e689829053d',0,48,'Role',NULL,'read','2026-10-30 00:33:42','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e5ec4d4785bc9',0,49,'Role',NULL,'read','2026-10-30 00:33:48','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e60423169ea81',0,50,'Role',NULL,'read','2026-10-30 00:34:12','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e60f5675dc9cb',0,51,'User',NULL,'read','2026-10-30 00:34:23','172.18.0.1','6ae269f1404188a4c','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e6214aa29c738',0,52,'Role',NULL,'read','2026-10-30 00:34:41','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e62f4cd3988ac',0,53,'User',NULL,'read','2026-10-30 00:34:55','172.18.0.1','6ae269f1404188a4c','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e63d42d314601',0,54,'Role',NULL,'read','2026-10-30 00:35:09','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e63f22d6a2f0e',0,55,'Role',NULL,'read','2026-10-30 00:35:11','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e642a85a22397',0,56,'Role',NULL,'read','2026-10-30 00:35:14','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e6a04d642faa4',0,57,'Role',NULL,'read','2026-10-30 00:36:48','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e6a8ca216c9b6',0,58,'Role',NULL,'read','2026-10-30 00:36:56','172.18.0.1','6ae3db53ce46ceb39','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3e6b642b12e3c4',0,59,'User',NULL,'read','2026-10-30 00:37:10','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3ec2d9f438b120',0,60,'User',NULL,'read','2026-10-30 01:00:29','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3ed1f55919e637',0,61,'User',NULL,'read','2026-10-30 01:04:31','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae3ef1029d1ae9b8',0,62,'User',NULL,'read','2026-10-30 01:12:48','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9'),
('6ae4f81bc2b4f78cc',0,63,'User',NULL,'read','2026-10-30 20:03:39','172.18.0.1','6ae3d895b6044ff7b','6ae269f1404188a4c','6ae276e43b705edb9','6ae276e43becc9ea9');
/*!40000 ALTER TABLE `action_history_record` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `address_country`
--

DROP TABLE IF EXISTS `address_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_country` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_preferred` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NAME` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_country`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `address_country` WRITE;
/*!40000 ALTER TABLE `address_country` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_country` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `app_log_record`
--

DROP TABLE IF EXISTS `app_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_log_record` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `number` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `exception_class` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line` int(11) DEFAULT NULL,
  `request_method` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_resource_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_LEVEL` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_log_record`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `app_log_record` WRITE;
/*!40000 ALTER TABLE `app_log_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_log_record` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `app_secret`
--

DROP TABLE IF EXISTS `app_secret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_secret` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `delete_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NAME_DELETE_ID` (`name`,`delete_id`),
  KEY `IDX_NAME` (`name`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_secret`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `app_secret` WRITE;
/*!40000 ALTER TABLE `app_secret` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_secret` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `array_value`
--

DROP TABLE IF EXISTS `array_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `array_value` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_TYPE_VALUE` (`entity_type`,`value`),
  KEY `IDX_ENTITY_VALUE` (`entity_type`,`entity_id`,`value`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `array_value`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `array_value` WRITE;
/*!40000 ALTER TABLE `array_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `array_value` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachment` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `field` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_being_uploaded` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `role` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_file_path` varchar(260) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `global` tinyint(1) NOT NULL DEFAULT 0,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_PARENT` (`parent_type`,`parent_id`),
  KEY `IDX_RELATED` (`related_id`,`related_type`),
  KEY `IDX_SOURCE` (`source_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `attachment` WRITE;
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `auth_log_record`
--

DROP TABLE IF EXISTS `auth_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_log_record` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `is_denied` tinyint(1) NOT NULL DEFAULT 0,
  `denial_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_time` double DEFAULT NULL,
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_method` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authentication_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portal_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_token_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IP_ADDRESS` (`ip_address`),
  KEY `IDX_IP_ADDRESS_REQUEST_TIME` (`ip_address`,`request_time`),
  KEY `IDX_REQUEST_TIME` (`request_time`),
  KEY `IDX_USERNAME_IP_ADDRESS` (`username`,`ip_address`),
  KEY `IDX_PORTAL_ID` (`portal_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_AUTH_TOKEN_ID` (`auth_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_log_record`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `auth_log_record` WRITE;
/*!40000 ALTER TABLE `auth_log_record` DISABLE KEYS */;
INSERT INTO `auth_log_record` VALUES
('6ae26a4f22bb5e8ee',0,'admin','192.168.65.1','2026-10-28 21:34:07',0,NULL,1793223246.9652,'http://localhost/api/v1/App/user','GET','Espo',NULL,'6ae269f1404188a4c','6ae26a4f220389a70'),
('6ae276e43becc9ea9',0,'admin','172.18.0.1','2026-10-28 22:27:48',0,NULL,1793226468.0795,'http://localhost/api/v1/App/user','GET','Espo',NULL,'6ae269f1404188a4c','6ae276e43b705edb9'),
('6ae3c83bd6cd4e728',0,'api_user','172.18.0.4','2026-10-29 22:27:07',1,'CREDENTIALS',1793312827.8449,'http://espocrm/api/v1/Appointment','GET','Espo',NULL,NULL,NULL),
('6ae3c84d3d1578c06',0,'api_user','172.18.0.4','2026-10-29 22:27:25',1,'CREDENTIALS',1793312845.216,'http://espocrm/api/v1/Appointment','GET','Espo',NULL,NULL,NULL),
('6ae3c8b0952f2372d',0,'api_user','172.18.0.1','2026-10-29 22:29:04',1,'CREDENTIALS',1793312944.5752,'http://localhost/api/v1/Appointment','GET','Espo',NULL,NULL,NULL),
('6ae3ca633a3688781',0,'api_user','172.18.0.1','2026-10-29 22:36:19',1,'CREDENTIALS',1793313378.9596,'http://localhost/api/v1/Appointment','GET','Espo',NULL,NULL,NULL),
('6ae3cc6118b693ca1',0,'api_user','172.18.0.4','2026-10-29 22:44:49',1,'CREDENTIALS',1793313889.0707,'http://espocrm/api/v1/Appointment','GET','Espo',NULL,NULL,NULL),
('6ae3d90f6d6e92765',0,NULL,'172.18.0.1','2026-10-29 23:38:55',1,'CREDENTIALS',1793317135.4185,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3d98298e0b76e4',0,'api_user','172.18.0.1','2026-10-29 23:40:50',0,NULL,1793317250.5907,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3d999f0732c0e3',0,'api_user','172.18.0.1','2026-10-29 23:41:13',0,NULL,1793317273.9491,'http://localhost/api/v1/Appointment','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3d9b42f6b7a985',0,'api_user','172.18.0.1','2026-10-29 23:41:40',0,NULL,1793317300.1599,'http://localhost/api/v1/Contact','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3da5153991a47c',0,'api_user','172.18.0.1','2026-10-29 23:44:17',0,NULL,1793317457.1842,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3daf36c5eee0b4',0,'api_user','172.18.0.1','2026-10-29 23:46:59',0,NULL,1793317619.4106,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3de6fcfe94cf7c',0,'api_user','172.18.0.1','2026-10-30 00:01:51',0,NULL,1793318511.6866,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3e4c22f4d3760a',0,'api_user','172.18.0.1','2026-10-30 00:28:50',0,NULL,1793320130.1552,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3e4d85a49ce1e0',0,'api_user','172.18.0.1','2026-10-30 00:29:12',0,NULL,1793320152.3345,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3e70dacf9ed73b',0,NULL,'172.18.0.1','2026-10-30 00:38:37',1,'CREDENTIALS',1793320717.6793,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3e776c805c0c24',0,'api_user','172.18.0.1','2026-10-30 00:40:22',0,NULL,1793320822.788,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3e78b96af14e04',0,'api_user','172.18.0.1','2026-10-30 00:40:43',0,NULL,1793320843.5821,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae3eedd2fed0745d',0,NULL,'172.18.0.1','2026-10-30 01:11:57',1,'CREDENTIALS',1793322717.165,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3eedd383a1c6f1',0,NULL,'172.18.0.1','2026-10-30 01:11:57',1,'CREDENTIALS',1793322717.2026,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3ef3cd53492125',0,NULL,'172.18.0.1','2026-10-30 01:13:32',1,'CREDENTIALS',1793322812.8447,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3ef3cdd804235c',0,NULL,'172.18.0.1','2026-10-30 01:13:32',1,'CREDENTIALS',1793322812.8794,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3ef47b399eeb78',0,NULL,'172.18.0.1','2026-10-30 01:13:43',1,'CREDENTIALS',1793322823.7067,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3ef47bba7417e5',0,NULL,'172.18.0.1','2026-10-30 01:13:43',1,'CREDENTIALS',1793322823.7408,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3efc6cd9d4c634',0,NULL,'172.18.0.1','2026-10-30 01:15:50',1,'CREDENTIALS',1793322950.8148,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3efc6d5c28e116',0,NULL,'172.18.0.1','2026-10-30 01:15:50',1,'CREDENTIALS',1793322950.8482,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3f0e0ab8fd29cf',0,NULL,'172.18.0.1','2026-10-30 01:20:32',1,'CREDENTIALS',1793323232.6741,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3f0e0b40b00023',0,NULL,'172.18.0.1','2026-10-30 01:20:32',1,'CREDENTIALS',1793323232.7091,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3f26672ec78fd0',0,NULL,'172.18.0.1','2026-10-30 01:27:02',1,'CREDENTIALS',1793323622.4378,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3f2667b8c059fe',0,NULL,'172.18.0.1','2026-10-30 01:27:02',1,'CREDENTIALS',1793323622.477,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3f2eb630065937',0,NULL,'172.18.0.1','2026-10-30 01:29:15',1,'CREDENTIALS',1793323755.3772,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3f2eb6b5fe6ed1',0,NULL,'172.18.0.1','2026-10-30 01:29:15',1,'CREDENTIALS',1793323755.4118,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3fc99d1c697ff4',0,NULL,'172.18.0.1','2026-10-30 02:10:33',1,'CREDENTIALS',1793326233.5738,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae3fc99ddde4151b',0,NULL,'172.18.0.1','2026-10-30 02:10:33',1,'CREDENTIALS',1793326233.8677,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae400626c4319b34',0,NULL,'172.18.0.1','2026-10-30 02:26:42',1,'CREDENTIALS',1793327202.3991,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae40062757859bea',0,NULL,'172.18.0.1','2026-10-30 02:26:42',1,'CREDENTIALS',1793327202.45,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae498c3216a059bc',0,NULL,'172.18.0.1','2026-10-30 13:16:51',1,'CREDENTIALS',1793366211.1019,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae498c32a44211ba',0,NULL,'172.18.0.1','2026-10-30 13:16:51',1,'CREDENTIALS',1793366211.1433,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4b24914c3e5155',0,NULL,'172.18.0.1','2026-10-30 15:05:45',1,'CREDENTIALS',1793372745.0487,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4b2491dcc6944b',0,NULL,'172.18.0.1','2026-10-30 15:05:45',1,'CREDENTIALS',1793372745.0913,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4ddf3154f931aa',0,NULL,'172.18.0.1','2026-10-30 18:12:03',1,'CREDENTIALS',1793383923.0543,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4ddf31e6e7b2e1',0,NULL,'172.18.0.1','2026-10-30 18:12:03',1,'CREDENTIALS',1793383923.0943,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4f0e76c8da1b86',0,NULL,'172.18.0.1','2026-10-30 19:32:55',1,'CREDENTIALS',1793388775.4116,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4f0e775a8b07be',0,NULL,'172.18.0.1','2026-10-30 19:32:55',1,'CREDENTIALS',1793388775.4511,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4fe990643170f6',0,NULL,'172.18.0.1','2026-10-30 20:31:21',1,'CREDENTIALS',1793392280.9903,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4fe990fa41a097',0,NULL,'172.18.0.1','2026-10-30 20:31:21',1,'CREDENTIALS',1793392281.0341,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4feaec4cc216a7',0,NULL,'172.18.0.1','2026-10-30 20:31:42',1,'CREDENTIALS',1793392302.7728,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4feaecdf094d4d',0,NULL,'172.18.0.1','2026-10-30 20:31:42',1,'CREDENTIALS',1793392302.814,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4feb1ddfbecbd8',0,NULL,'172.18.0.1','2026-10-30 20:31:45',1,'CREDENTIALS',1793392305.8756,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4feb1e67daf2b3',0,NULL,'172.18.0.1','2026-10-30 20:31:45',1,'CREDENTIALS',1793392305.9146,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4feb3b8156ef73',0,NULL,'172.18.0.1','2026-10-30 20:31:47',1,'CREDENTIALS',1793392307.7243,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4fed45c4c1a278',0,'api_user','172.18.0.1','2026-10-30 20:32:20',0,NULL,1793392340.337,'http://localhost/api/v1/App/user','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae4fefaf2f4f0aee',0,NULL,'172.18.0.1','2026-10-30 20:32:58',1,'CREDENTIALS',1793392378.9623,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4fefb07b93f625',0,NULL,'172.18.0.1','2026-10-30 20:32:59',1,'CREDENTIALS',1793392379.0012,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4fefe364ad2f6c',0,NULL,'172.18.0.1','2026-10-30 20:33:02',1,'CREDENTIALS',1793392382.1892,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae4fefe3f74b6a47',0,NULL,'172.18.0.1','2026-10-30 20:33:02',1,'CREDENTIALS',1793392382.229,'http://localhost/api/v1/Session','GET','ApiKey',NULL,NULL,NULL),
('6ae5008374b5e1b6b',0,'api_user','172.18.0.1','2026-10-30 20:39:31',0,NULL,1793392771.4404,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae5009c7ad909900',0,'api_user','172.18.0.1','2026-10-30 20:39:56',0,NULL,1793392796.4642,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae500a1369d26769',0,'api_user','172.18.0.1','2026-10-30 20:40:01',0,NULL,1793392801.1897,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae500a566089ec23',0,'api_user','172.18.0.1','2026-10-30 20:40:05',0,NULL,1793392805.3816,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae503b105d754a9e',0,'api_user','172.18.0.1','2026-10-30 20:53:05',0,NULL,1793393584.987,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae503b119f123285',0,'api_user','172.18.0.1','2026-10-30 20:53:05',0,NULL,1793393585.0659,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae503e29d2984fe5',0,'api_user','172.18.0.1','2026-10-30 20:53:54',0,NULL,1793393634.6091,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae503e2ab8991c67',0,'api_user','172.18.0.1','2026-10-30 20:53:54',0,NULL,1793393634.6705,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae503e6438e39ed3',0,'api_user','172.18.0.1','2026-10-30 20:53:58',0,NULL,1793393638.2422,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae503e6520a9cca1',0,'api_user','172.18.0.1','2026-10-30 20:53:58',0,NULL,1793393638.3042,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae503ea8239e1a47',0,'api_user','172.18.0.1','2026-10-30 20:54:02',0,NULL,1793393642.5007,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae503ea900779ec5',0,'api_user','172.18.0.1','2026-10-30 20:54:02',0,NULL,1793393642.5593,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae5a6309aba847b3',0,'api_user','192.168.65.1','2026-10-31 08:26:24',0,NULL,1793435184.371,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae5a6651d821eb1e',0,'api_user','192.168.65.1','2026-10-31 08:27:17',0,NULL,1793435237.0673,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL),
('6ae5a69120b7a89e6',0,'api_user','192.168.65.1','2026-10-31 08:28:01',0,NULL,1793435281.0969,'http://localhost/api/v1/Session','GET','ApiKey',NULL,'6ae3d895b6044ff7b',NULL);
/*!40000 ALTER TABLE `auth_log_record` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `auth_token`
--

DROP TABLE IF EXISTS `auth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_token` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `token` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hash` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `password_version` int(11) NOT NULL DEFAULT 0,
  `last_access` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portal_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_TOKEN` (`token`,`deleted`),
  KEY `IDX_HASH` (`hash`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_token`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `auth_token` WRITE;
/*!40000 ALTER TABLE `auth_token` DISABLE KEYS */;
INSERT INTO `auth_token` VALUES
('6ae26a4f220389a70',0,'95e9988007c1fd70112fbdabadaa4dc5',NULL,'233a607b719bd949d42e60d1a86bc10a','192.168.65.1',0,1,'2026-10-28 22:27:46','2026-10-28 21:34:07','2026-10-28 22:27:46','6ae269f1404188a4c',NULL),
('6ae276e43b705edb9',0,'2b298aff906ab57412013fd0fd370616',NULL,'982025e37642d2703c4faab68a953a6f','172.18.0.1',1,1,'2026-10-31 20:05:20','2026-10-28 22:27:48','2026-10-31 20:05:20','6ae269f1404188a4c',NULL);
/*!40000 ALTER TABLE `auth_token` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `authentication_provider`
--

DROP TABLE IF EXISTS `authentication_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `authentication_provider` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oidc_client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oidc_client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oidc_authorization_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oidc_user_info_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oidc_token_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oidc_jwks_endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oidc_jwt_signature_algorithm_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `oidc_scopes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `oidc_create_user` tinyint(1) NOT NULL DEFAULT 0,
  `oidc_username_claim` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'sub',
  `oidc_sync` tinyint(1) NOT NULL DEFAULT 0,
  `oidc_logout_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oidc_authorization_prompt` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oidc_authorization_pkce` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authentication_provider`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `authentication_provider` WRITE;
/*!40000 ALTER TABLE `authentication_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `authentication_provider` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `autofollow`
--

DROP TABLE IF EXISTS `autofollow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `autofollow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT 0,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_TYPE` (`entity_type`),
  KEY `IDX_USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autofollow`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `autofollow` WRITE;
/*!40000 ALTER TABLE `autofollow` DISABLE KEYS */;
/*!40000 ALTER TABLE `autofollow` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `beauty_appointment_details`
--

DROP TABLE IF EXISTS `beauty_appointment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `beauty_appointment_details` (
  `order_id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `master_resource_id` char(36) DEFAULT NULL,
  `duration_minutes` int(11) NOT NULL DEFAULT 60,
  `source` varchar(64) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`order_id`),
  KEY `fk_beauty_organization` (`organization_id`),
  KEY `fk_beauty_master` (`master_resource_id`),
  CONSTRAINT `fk_beauty_master` FOREIGN KEY (`master_resource_id`) REFERENCES `resources` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_beauty_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_beauty_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beauty_appointment_details`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `beauty_appointment_details` WRITE;
/*!40000 ALTER TABLE `beauty_appointment_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `beauty_appointment_details` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `c_master`
--

DROP TABLE IF EXISTS `c_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_master` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_NAME` (`name`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CREATED_AT` (`created_at`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_master`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `c_master` WRITE;
/*!40000 ALTER TABLE `c_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `c_master` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `c_service`
--

DROP TABLE IF EXISTS `c_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `c_service` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` int(11) DEFAULT 60,
  `price` double DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_NAME` (`name`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CREATED_AT` (`created_at`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_service`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `c_service` WRITE;
/*!40000 ALTER TABLE `c_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `c_service` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `call`
--

DROP TABLE IF EXISTS `call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `call` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Planned',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `direction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Outbound',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DATE_START_STATUS` (`date_start`,`status`),
  KEY `IDX_DATE_START` (`date_start`,`deleted`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_UID` (`uid`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `call` WRITE;
/*!40000 ALTER TABLE `call` DISABLE KEYS */;
/*!40000 ALTER TABLE `call` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `call_contact`
--

DROP TABLE IF EXISTS `call_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `call_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CALL_ID_CONTACT_ID` (`call_id`,`contact_id`),
  KEY `IDX_CALL_ID` (`call_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_contact`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `call_contact` WRITE;
/*!40000 ALTER TABLE `call_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_contact` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `call_lead`
--

DROP TABLE IF EXISTS `call_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_lead` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `call_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CALL_ID_LEAD_ID` (`call_id`,`lead_id`),
  KEY `IDX_CALL_ID` (`call_id`),
  KEY `IDX_LEAD_ID` (`lead_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_lead`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `call_lead` WRITE;
/*!40000 ALTER TABLE `call_lead` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_lead` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `call_user`
--

DROP TABLE IF EXISTS `call_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `call_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ID_CALL_ID` (`user_id`,`call_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_CALL_ID` (`call_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `call_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `call_user` WRITE;
/*!40000 ALTER TABLE `call_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Planning',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Email',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `budget` double DEFAULT NULL,
  `mail_merge_only_with_address` tinyint(1) NOT NULL DEFAULT 1,
  `budget_currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contacts_template_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `leads_template_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accounts_template_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `users_template_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CONTACTS_TEMPLATE_ID` (`contacts_template_id`),
  KEY `IDX_LEADS_TEMPLATE_ID` (`leads_template_id`),
  KEY `IDX_ACCOUNTS_TEMPLATE_ID` (`accounts_template_id`),
  KEY `IDX_USERS_TEMPLATE_ID` (`users_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `campaign_log_record`
--

DROP TABLE IF EXISTS `campaign_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_log_record` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_date` datetime DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `string_data` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `string_additional_data` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `application` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Espo',
  `created_at` datetime DEFAULT NULL,
  `is_test` tinyint(1) NOT NULL DEFAULT 0,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `object_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `object_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `queue_item_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ACTION_DATE` (`action_date`,`deleted`),
  KEY `IDX_ACTION` (`action`,`deleted`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_OBJECT` (`object_id`,`object_type`),
  KEY `IDX_QUEUE_ITEM_ID` (`queue_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_log_record`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `campaign_log_record` WRITE;
/*!40000 ALTER TABLE `campaign_log_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_log_record` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `campaign_target_list`
--

DROP TABLE IF EXISTS `campaign_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_target_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CAMPAIGN_ID_TARGET_LIST_ID` (`campaign_id`,`target_list_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_target_list`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `campaign_target_list` WRITE;
/*!40000 ALTER TABLE `campaign_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_target_list` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `campaign_target_list_excluding`
--

DROP TABLE IF EXISTS `campaign_target_list_excluding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_target_list_excluding` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CAMPAIGN_ID_TARGET_LIST_ID` (`campaign_id`,`target_list_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_target_list_excluding`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `campaign_target_list_excluding` WRITE;
/*!40000 ALTER TABLE `campaign_target_list_excluding` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_target_list_excluding` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `campaign_tracking_url`
--

DROP TABLE IF EXISTS `campaign_tracking_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_tracking_url` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Redirect',
  `message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_tracking_url`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `campaign_tracking_url` WRITE;
/*!40000 ALTER TABLE `campaign_tracking_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_tracking_url` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `case`
--

DROP TABLE IF EXISTS `case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `case` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `number` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'New',
  `priority` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Normal',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_internal` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `stream_updated_at` datetime DEFAULT NULL,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_LEAD_ID` (`lead_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  FULLTEXT KEY `IDX_SYSTEM_FULL_TEXT_SEARCH` (`name`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `case` WRITE;
/*!40000 ALTER TABLE `case` DISABLE KEYS */;
/*!40000 ALTER TABLE `case` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `case_contact`
--

DROP TABLE IF EXISTS `case_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `case_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CASE_ID_CONTACT_ID` (`case_id`,`contact_id`),
  KEY `IDX_CASE_ID` (`case_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_contact`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `case_contact` WRITE;
/*!40000 ALTER TABLE `case_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `case_contact` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `case_knowledge_base_article`
--

DROP TABLE IF EXISTS `case_knowledge_base_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_knowledge_base_article` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `case_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `knowledge_base_article_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CASE_ID_KNOWLEDGE_BASE_ARTICLE_ID` (`case_id`,`knowledge_base_article_id`),
  KEY `IDX_CASE_ID` (`case_id`),
  KEY `IDX_KNOWLEDGE_BASE_ARTICLE_ID` (`knowledge_base_article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_knowledge_base_article`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `case_knowledge_base_article` WRITE;
/*!40000 ALTER TABLE `case_knowledge_base_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `case_knowledge_base_article` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `catalog_items`
--

DROP TABLE IF EXISTS `catalog_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalog_items` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `type` enum('service','product','bundle','subscription') NOT NULL DEFAULT 'service',
  `name` varchar(255) NOT NULL,
  `sku` varchar(128) DEFAULT NULL,
  `price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cost` decimal(12,2) NOT NULL DEFAULT 0.00,
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`)),
  `status` enum('active','draft','archived') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_catalog_org_type` (`organization_id`,`type`),
  CONSTRAINT `fk_catalog_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_items`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `catalog_items` WRITE;
/*!40000 ALTER TABLE `catalog_items` DISABLE KEYS */;
INSERT INTO `catalog_items` VALUES
('44444444-4444-4444-4444-444444444444','11111111-1111-1111-1111-111111111111','service','Стрижка женская',NULL,2500.00,500.00,NULL,'active','2026-10-31 07:56:20','2026-10-31 07:57:46'),
('55555555-5555-5555-5555-555555555555','11111111-1111-1111-1111-111111111111','service','Окрашивание',NULL,6000.00,1500.00,NULL,'active','2026-10-31 07:56:20','2026-10-31 07:57:46');
/*!40000 ALTER TABLE `catalog_items` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `salutation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `do_not_call` tinyint(1) NOT NULL DEFAULT 0,
  `address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `middle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stream_updated_at` datetime DEFAULT NULL,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_consent` tinyint(1) NOT NULL DEFAULT 0,
  `consent_date` date DEFAULT NULL,
  `deposit_balance` double DEFAULT NULL,
  `deposit_balance_currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_FIRST_NAME` (`first_name`,`deleted`),
  KEY `IDX_NAME` (`first_name`,`last_name`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `contact_document`
--

DROP TABLE IF EXISTS `contact_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CONTACT_ID_DOCUMENT_ID` (`contact_id`,`document_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_DOCUMENT_ID` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_document`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `contact_document` WRITE;
/*!40000 ALTER TABLE `contact_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_document` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `contact_meeting`
--

DROP TABLE IF EXISTS `contact_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_meeting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meeting_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CONTACT_ID_MEETING_ID` (`contact_id`,`meeting_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_MEETING_ID` (`meeting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_meeting`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `contact_meeting` WRITE;
/*!40000 ALTER TABLE `contact_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_meeting` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `contact_opportunity`
--

DROP TABLE IF EXISTS `contact_opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_opportunity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opportunity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CONTACT_ID_OPPORTUNITY_ID` (`contact_id`,`opportunity_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_OPPORTUNITY_ID` (`opportunity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_opportunity`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `contact_opportunity` WRITE;
/*!40000 ALTER TABLE `contact_opportunity` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_opportunity` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `contact_target_list`
--

DROP TABLE IF EXISTS `contact_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_target_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CONTACT_ID_TARGET_LIST_ID` (`contact_id`,`target_list_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_target_list`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `contact_target_list` WRITE;
/*!40000 ALTER TABLE `contact_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_target_list` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency` (
  `id` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES
('USD',1);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `currency_record`
--

DROP TABLE IF EXISTS `currency_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_record` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `code` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `delete_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CODE_DELETE_ID` (`code`,`delete_id`),
  KEY `IDX_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_record`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `currency_record` WRITE;
/*!40000 ALTER TABLE `currency_record` DISABLE KEYS */;
INSERT INTO `currency_record` VALUES
('6ae269f1302cbc8ca',0,'USD','Active','0');
/*!40000 ALTER TABLE `currency_record` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `currency_record_rate`
--

DROP TABLE IF EXISTS `currency_record_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_record_rate` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `base_code` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `delete_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `record_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` decimal(20,8) DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_RECORD_ID_BASE_CODE_DATE` (`record_id`,`base_code`,`date`,`delete_id`),
  KEY `IDX_RECORD_ID` (`record_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_record_rate`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `currency_record_rate` WRITE;
/*!40000 ALTER TABLE `currency_record_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `currency_record_rate` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contacts` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`contacts`)),
  `segment` varchar(64) DEFAULT NULL,
  `owner_user_id` char(36) DEFAULT NULL,
  `status` enum('active','inactive','blocked') NOT NULL DEFAULT 'active',
  `external_id` varchar(128) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_customers_org` (`organization_id`),
  CONSTRAINT `fk_customers_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `dashboard_template`
--

DROP TABLE IF EXISTS `dashboard_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_template` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `layout` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashlets_options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_template`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `dashboard_template` WRITE;
/*!40000 ALTER TABLE `dashboard_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_template` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `file_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_FOLDER_ID` (`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `document_folder`
--

DROP TABLE IF EXISTS `document_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_folder` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_folder`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `document_folder` WRITE;
/*!40000 ALTER TABLE `document_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_folder` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `document_folder_path`
--

DROP TABLE IF EXISTS `document_folder_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_folder_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ascendor_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descendor_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASCENDOR_ID` (`ascendor_id`),
  KEY `IDX_DESCENDOR_ID` (`descendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_folder_path`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `document_folder_path` WRITE;
/*!40000 ALTER TABLE `document_folder_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_folder_path` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `document_lead`
--

DROP TABLE IF EXISTS `document_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_lead` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `document_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_DOCUMENT_ID_LEAD_ID` (`document_id`,`lead_id`),
  KEY `IDX_DOCUMENT_ID` (`document_id`),
  KEY `IDX_LEAD_ID` (`lead_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_lead`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `document_lead` WRITE;
/*!40000 ALTER TABLE `document_lead` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_lead` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `document_opportunity`
--

DROP TABLE IF EXISTS `document_opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_opportunity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `document_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opportunity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_DOCUMENT_ID_OPPORTUNITY_ID` (`document_id`,`opportunity_id`),
  KEY `IDX_DOCUMENT_ID` (`document_id`),
  KEY `IDX_OPPORTUNITY_ID` (`opportunity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_opportunity`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `document_opportunity` WRITE;
/*!40000 ALTER TABLE `document_opportunity` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_opportunity` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `from_string` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_to_string` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_name_map` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_replied` tinyint(1) NOT NULL DEFAULT 0,
  `message_id` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message_id_internal` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body_plain` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_html` tinyint(1) NOT NULL DEFAULT 1,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Archived',
  `has_attachment` tinyint(1) NOT NULL DEFAULT 0,
  `date_sent` datetime DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `send_at` datetime DEFAULT NULL,
  `is_auto_reply` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT 0,
  `ics_contents` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ics_event_uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_status_folder` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_email_address_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `replied_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_event_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_event_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_folder_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_DATE_SENT` (`date_sent`,`deleted`),
  KEY `IDX_DATE_SENT_STATUS` (`date_sent`,`status`,`deleted`),
  KEY `IDX_MESSAGE_ID` (`message_id`),
  KEY `IDX_ICS_EVENT_UID` (`ics_event_uid`),
  KEY `IDX_GROUP_STATUS_FOLDER` (`group_status_folder`),
  KEY `IDX_FROM_EMAIL_ADDRESS_ID` (`from_email_address_id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_SENT_BY_ID` (`sent_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_REPLIED_ID` (`replied_id`),
  KEY `IDX_CREATED_EVENT` (`created_event_id`,`created_event_type`),
  KEY `IDX_GROUP_FOLDER_ID` (`group_folder_id`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  FULLTEXT KEY `IDX_SYSTEM_FULL_TEXT_SEARCH` (`name`,`body_plain`,`body`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_account`
--

DROP TABLE IF EXISTS `email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_account` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `email_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` int(11) DEFAULT 993,
  `security` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'SSL',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monitored_folders` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `sent_folder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_map` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_sent_emails` tinyint(1) NOT NULL DEFAULT 0,
  `keep_fetched_emails_unread` tinyint(1) NOT NULL DEFAULT 0,
  `fetch_validity_number` int(11) DEFAULT 0,
  `fetch_since` date DEFAULT NULL,
  `fetch_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `connected_at` datetime DEFAULT NULL,
  `use_imap` tinyint(1) NOT NULL DEFAULT 1,
  `use_smtp` tinyint(1) NOT NULL DEFAULT 0,
  `smtp_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_port` int(11) DEFAULT 587,
  `smtp_auth` tinyint(1) NOT NULL DEFAULT 1,
  `smtp_security` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TLS',
  `smtp_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_auth_mechanism` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'login',
  `imap_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_folder_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EMAIL_FOLDER_ID` (`email_folder_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_account`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_account` WRITE;
/*!40000 ALTER TABLE `email_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_account` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_address`
--

DROP TABLE IF EXISTS `email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_address` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `lower` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invalid` tinyint(1) NOT NULL DEFAULT 0,
  `opt_out` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_LOWER` (`lower`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_address`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_address` WRITE;
/*!40000 ALTER TABLE `email_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_address` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_email_account`
--

DROP TABLE IF EXISTS `email_email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_email_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EMAIL_ID_EMAIL_ACCOUNT_ID` (`email_id`,`email_account_id`),
  KEY `IDX_EMAIL_ID` (`email_id`),
  KEY `IDX_EMAIL_ACCOUNT_ID` (`email_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_email_account`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_email_account` WRITE;
/*!40000 ALTER TABLE `email_email_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_email_account` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_email_address`
--

DROP TABLE IF EXISTS `email_email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_email_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_address_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EMAIL_ID_EMAIL_ADDRESS_ID_ADDRESS_TYPE` (`email_id`,`email_address_id`,`address_type`),
  KEY `IDX_EMAIL_ID` (`email_id`),
  KEY `IDX_EMAIL_ADDRESS_ID` (`email_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_email_address`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_email_address` WRITE;
/*!40000 ALTER TABLE `email_email_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_email_address` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_filter`
--

DROP TABLE IF EXISTS `email_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_filter` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `from` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body_contains` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `body_contains_all` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `is_global` tinyint(1) NOT NULL DEFAULT 0,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Skip',
  `mark_as_read` tinyint(1) NOT NULL DEFAULT 0,
  `skip_notification` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_folder_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_email_folder_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_EMAIL_FOLDER_ID` (`email_folder_id`),
  KEY `IDX_GROUP_EMAIL_FOLDER_ID` (`group_email_folder_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_filter`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_filter` WRITE;
/*!40000 ALTER TABLE `email_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_filter` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_folder`
--

DROP TABLE IF EXISTS `email_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_folder` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `order` int(11) DEFAULT NULL,
  `skip_notifications` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_folder`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_folder` WRITE;
/*!40000 ALTER TABLE `email_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_folder` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_inbound_email`
--

DROP TABLE IF EXISTS `email_inbound_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_inbound_email` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EMAIL_ID_INBOUND_EMAIL_ID` (`email_id`,`inbound_email_id`),
  KEY `IDX_EMAIL_ID` (`email_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_inbound_email`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_inbound_email` WRITE;
/*!40000 ALTER TABLE `email_inbound_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_inbound_email` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_queue_item`
--

DROP TABLE IF EXISTS `email_queue_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_queue_item` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attempt_count` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `email_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_test` tinyint(1) NOT NULL DEFAULT 0,
  `mass_email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_SENT_AT` (`sent_at`),
  KEY `IDX_MASS_EMAIL_ID` (`mass_email_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_queue_item`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_queue_item` WRITE;
/*!40000 ALTER TABLE `email_queue_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_queue_item` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_template`
--

DROP TABLE IF EXISTS `email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_template` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_html` tinyint(1) NOT NULL DEFAULT 1,
  `status` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `one_off` tinyint(1) NOT NULL DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `category_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_CATEGORY_ID` (`category_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_template`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_template` WRITE;
/*!40000 ALTER TABLE `email_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_template` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_template_category`
--

DROP TABLE IF EXISTS `email_template_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_template_category` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `order` int(11) DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_template_category`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_template_category` WRITE;
/*!40000 ALTER TABLE `email_template_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_template_category` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_template_category_path`
--

DROP TABLE IF EXISTS `email_template_category_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_template_category_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ascendor_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descendor_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASCENDOR_ID` (`ascendor_id`),
  KEY `IDX_DESCENDOR_ID` (`descendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_template_category_path`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_template_category_path` WRITE;
/*!40000 ALTER TABLE `email_template_category_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_template_category_path` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `email_user`
--

DROP TABLE IF EXISTS `email_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `is_important` tinyint(1) DEFAULT 0,
  `in_trash` tinyint(1) DEFAULT 0,
  `in_archive` tinyint(1) DEFAULT 0,
  `folder_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_EMAIL_ID_USER_ID` (`email_id`,`user_id`),
  KEY `IDX_EMAIL_ID` (`email_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `email_user` WRITE;
/*!40000 ALTER TABLE `email_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entity_collaborator`
--

DROP TABLE IF EXISTS `entity_collaborator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_collaborator` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ENTITY_ID_USER_ID_ENTITY_TYPE` (`entity_id`,`user_id`,`entity_type`),
  KEY `IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_collaborator`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entity_collaborator` WRITE;
/*!40000 ALTER TABLE `entity_collaborator` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_collaborator` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entity_email_address`
--

DROP TABLE IF EXISTS `entity_email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_email_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_address_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ENTITY_ID_EMAIL_ADDRESS_ID_ENTITY_TYPE` (`entity_id`,`email_address_id`,`entity_type`),
  KEY `IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_EMAIL_ADDRESS_ID` (`email_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_email_address`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entity_email_address` WRITE;
/*!40000 ALTER TABLE `entity_email_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_email_address` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entity_phone_number`
--

DROP TABLE IF EXISTS `entity_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_phone_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ENTITY_ID_PHONE_NUMBER_ID_ENTITY_TYPE` (`entity_id`,`phone_number_id`,`entity_type`),
  KEY `IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_PHONE_NUMBER_ID` (`phone_number_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_phone_number`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entity_phone_number` WRITE;
/*!40000 ALTER TABLE `entity_phone_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_phone_number` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entity_team`
--

DROP TABLE IF EXISTS `entity_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_team` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ENTITY_ID_TEAM_ID_ENTITY_TYPE` (`entity_id`,`team_id`,`entity_type`),
  KEY `IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_TEAM_ID` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_team`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entity_team` WRITE;
/*!40000 ALTER TABLE `entity_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_team` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `entity_user`
--

DROP TABLE IF EXISTS `entity_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `entity_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ENTITY_ID_USER_ID_ENTITY_TYPE` (`entity_id`,`user_id`,`entity_type`),
  KEY `IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `entity_user` WRITE;
/*!40000 ALTER TABLE `entity_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `entity_type` varchar(64) NOT NULL,
  `entity_id` char(36) NOT NULL,
  `type` varchar(128) NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_events_org_entity` (`organization_id`,`entity_type`,`entity_id`),
  KEY `idx_events_org_type` (`organization_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `expense`
--

DROP TABLE IF EXISTS `expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `amount` double DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'other',
  `date` date DEFAULT NULL,
  `is_personal` tinyint(1) NOT NULL DEFAULT 0,
  `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `expense` WRITE;
/*!40000 ALTER TABLE `expense` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `export`
--

DROP TABLE IF EXISTS `export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `export` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `notify_on_finish` tinyint(1) NOT NULL DEFAULT 0,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_ATTACHMENT` (`attachment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `export`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `export` WRITE;
/*!40000 ALTER TABLE `export` DISABLE KEYS */;
/*!40000 ALTER TABLE `export` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `extension`
--

DROP TABLE IF EXISTS `extension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `extension` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license_status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license_status_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_installed` tinyint(1) NOT NULL DEFAULT 0,
  `check_version_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_LICENSE_STATUS` (`license_status`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extension`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `extension` WRITE;
/*!40000 ALTER TABLE `extension` DISABLE KEYS */;
/*!40000 ALTER TABLE `extension` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `external_account`
--

DROP TABLE IF EXISTS `external_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_account` (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `is_locked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_account`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `external_account` WRITE;
/*!40000 ALTER TABLE `external_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_account` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `financial_records`
--

DROP TABLE IF EXISTS `financial_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `financial_records` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `type` enum('income','expense','transfer','liability') NOT NULL,
  `amount` decimal(14,2) NOT NULL DEFAULT 0.00,
  `currency` varchar(8) NOT NULL DEFAULT 'RUB',
  `category` varchar(128) DEFAULT NULL,
  `order_id` char(36) DEFAULT NULL,
  `occurred_at` datetime NOT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_financial_org_date` (`organization_id`,`occurred_at`),
  KEY `fk_financial_order` (`order_id`),
  CONSTRAINT `fk_financial_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_financial_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financial_records`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `financial_records` WRITE;
/*!40000 ALTER TABLE `financial_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `financial_records` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `group_email_folder`
--

DROP TABLE IF EXISTS `group_email_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_email_folder` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `order` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_email_folder`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `group_email_folder` WRITE;
/*!40000 ALTER TABLE `group_email_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_email_folder` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `group_email_folder_team`
--

DROP TABLE IF EXISTS `group_email_folder_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_email_folder_team` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_email_folder_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_GROUP_EMAIL_FOLDER_ID_TEAM_ID` (`group_email_folder_id`,`team_id`),
  KEY `IDX_GROUP_EMAIL_FOLDER_ID` (`group_email_folder_id`),
  KEY `IDX_TEAM_ID` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_email_folder_team`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `group_email_folder_team` WRITE;
/*!40000 ALTER TABLE `group_email_folder_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_email_folder_team` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `import`
--

DROP TABLE IF EXISTS `import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `import` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `entity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_index` int(11) DEFAULT NULL,
  `params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `file_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `import` WRITE;
/*!40000 ALTER TABLE `import` DISABLE KEYS */;
/*!40000 ALTER TABLE `import` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `import_entity`
--

DROP TABLE IF EXISTS `import_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_entity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT 0,
  `is_imported` tinyint(1) NOT NULL DEFAULT 0,
  `is_updated` tinyint(1) NOT NULL DEFAULT 0,
  `is_duplicate` tinyint(1) NOT NULL DEFAULT 0,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `import_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_IMPORT` (`import_id`,`entity_type`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`),
  KEY `IDX_IMPORT` (`import_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_entity`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `import_entity` WRITE;
/*!40000 ALTER TABLE `import_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_entity` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `import_error`
--

DROP TABLE IF EXISTS `import_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_error` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `row_index` int(11) DEFAULT NULL,
  `export_row_index` int(11) DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validation_failures` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `import_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ROW_INDEX` (`row_index`),
  KEY `IDX_IMPORT_ROW_INDEX` (`import_id`,`row_index`),
  KEY `IDX_IMPORT_ID` (`import_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_error`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `import_error` WRITE;
/*!40000 ALTER TABLE `import_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_error` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `inbound_email`
--

DROP TABLE IF EXISTS `inbound_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inbound_email` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `email_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` int(11) DEFAULT 993,
  `security` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'SSL',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monitored_folders` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `fetch_validity_number` int(11) DEFAULT 0,
  `fetch_since` date DEFAULT NULL,
  `fetch_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `add_all_team_users` tinyint(1) NOT NULL DEFAULT 1,
  `sent_folder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_sent_emails` tinyint(1) NOT NULL DEFAULT 0,
  `keep_fetched_emails_unread` tinyint(1) NOT NULL DEFAULT 0,
  `connected_at` datetime DEFAULT NULL,
  `exclude_from_reply` tinyint(1) NOT NULL DEFAULT 0,
  `use_imap` tinyint(1) NOT NULL DEFAULT 1,
  `use_smtp` tinyint(1) NOT NULL DEFAULT 0,
  `smtp_is_shared` tinyint(1) NOT NULL DEFAULT 0,
  `smtp_is_for_mass_email` tinyint(1) NOT NULL DEFAULT 0,
  `smtp_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_port` int(11) DEFAULT 587,
  `smtp_auth` tinyint(1) NOT NULL DEFAULT 1,
  `smtp_security` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TLS',
  `smtp_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_auth_mechanism` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'login',
  `create_case` tinyint(1) NOT NULL DEFAULT 0,
  `case_distribution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Direct-Assignment',
  `target_user_position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply` tinyint(1) NOT NULL DEFAULT 0,
  `reply_from_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_to_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imap_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `smtp_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `assign_to_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_email_template_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_email_folder_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASSIGN_TO_USER_ID` (`assign_to_user_id`),
  KEY `IDX_TEAM_ID` (`team_id`),
  KEY `IDX_REPLY_EMAIL_TEMPLATE_ID` (`reply_email_template_id`),
  KEY `IDX_GROUP_EMAIL_FOLDER_ID` (`group_email_folder_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbound_email`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `inbound_email` WRITE;
/*!40000 ALTER TABLE `inbound_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbound_email` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `inbound_email_team`
--

DROP TABLE IF EXISTS `inbound_email_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inbound_email_team` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `inbound_email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_INBOUND_EMAIL_ID_TEAM_ID` (`inbound_email_id`,`team_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`),
  KEY `IDX_TEAM_ID` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbound_email_team`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `inbound_email_team` WRITE;
/*!40000 ALTER TABLE `inbound_email_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbound_email_team` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `integration`
--

DROP TABLE IF EXISTS `integration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `integration` (
  `id` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integration`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `integration` WRITE;
/*!40000 ALTER TABLE `integration` DISABLE KEYS */;
/*!40000 ALTER TABLE `integration` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `job` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `execute_time` datetime DEFAULT NULL,
  `number` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `queue` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_group` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `executed_at` datetime DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `attempts` int(11) DEFAULT NULL,
  `target_id` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `scheduled_job_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_EXECUTE_TIME` (`status`,`execute_time`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_STATUS_SCHEDULED_JOB_ID` (`status`,`scheduled_job_id`),
  KEY `IDX_SCHEDULED_JOB_ID` (`scheduled_job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `kanban_order`
--

DROP TABLE IF EXISTS `kanban_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `kanban_order` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `order` smallint(6) DEFAULT NULL,
  `group` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_USER_ID` (`entity_type`,`entity_id`,`user_id`),
  KEY `IDX_ENTITY_TYPE` (`entity_type`),
  KEY `IDX_ENTITY_TYPE_USER_ID` (`entity_type`,`user_id`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`),
  KEY `IDX_USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kanban_order`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `kanban_order` WRITE;
/*!40000 ALTER TABLE `kanban_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `kanban_order` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `knowledge_base_article`
--

DROP TABLE IF EXISTS `knowledge_base_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_article` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Draft',
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Article',
  `publish_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body_plain` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  FULLTEXT KEY `IDX_SYSTEM_FULL_TEXT_SEARCH` (`name`,`body_plain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_article`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `knowledge_base_article` WRITE;
/*!40000 ALTER TABLE `knowledge_base_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_base_article` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `knowledge_base_article_knowledge_base_category`
--

DROP TABLE IF EXISTS `knowledge_base_article_knowledge_base_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_article_knowledge_base_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `knowledge_base_article_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `knowledge_base_category_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_KNOWLEDGE_BASE_ARTICLE_ID_KNOWLEDGE_BASE_CATEGORY_ID` (`knowledge_base_article_id`,`knowledge_base_category_id`),
  KEY `IDX_KNOWLEDGE_BASE_ARTICLE_ID` (`knowledge_base_article_id`),
  KEY `IDX_KNOWLEDGE_BASE_CATEGORY_ID` (`knowledge_base_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_article_knowledge_base_category`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `knowledge_base_article_knowledge_base_category` WRITE;
/*!40000 ALTER TABLE `knowledge_base_article_knowledge_base_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_base_article_knowledge_base_category` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `knowledge_base_article_portal`
--

DROP TABLE IF EXISTS `knowledge_base_article_portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_article_portal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `portal_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `knowledge_base_article_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_PORTAL_ID_KNOWLEDGE_BASE_ARTICLE_ID` (`portal_id`,`knowledge_base_article_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`),
  KEY `IDX_KNOWLEDGE_BASE_ARTICLE_ID` (`knowledge_base_article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_article_portal`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `knowledge_base_article_portal` WRITE;
/*!40000 ALTER TABLE `knowledge_base_article_portal` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_base_article_portal` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `knowledge_base_category`
--

DROP TABLE IF EXISTS `knowledge_base_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_category` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_category`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `knowledge_base_category` WRITE;
/*!40000 ALTER TABLE `knowledge_base_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_base_category` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `knowledge_base_category_path`
--

DROP TABLE IF EXISTS `knowledge_base_category_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_base_category_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ascendor_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descendor_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASCENDOR_ID` (`ascendor_id`),
  KEY `IDX_DESCENDOR_ID` (`descendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_base_category_path`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `knowledge_base_category_path` WRITE;
/*!40000 ALTER TABLE `knowledge_base_category_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_base_category_path` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `knowledge_items`
--

DROP TABLE IF EXISTS `knowledge_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_items` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` mediumtext NOT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tags`)),
  `visibility` enum('private','organization','public') NOT NULL DEFAULT 'organization',
  `status` enum('draft','published','archived') NOT NULL DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_knowledge_org` (`organization_id`),
  CONSTRAINT `fk_knowledge_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_items`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `knowledge_items` WRITE;
/*!40000 ALTER TABLE `knowledge_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_items` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `layout_record`
--

DROP TABLE IF EXISTS `layout_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `layout_record` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_set_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_NAME_LAYOUT_SET_ID` (`name`,`layout_set_id`),
  KEY `IDX_LAYOUT_SET_ID` (`layout_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout_record`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `layout_record` WRITE;
/*!40000 ALTER TABLE `layout_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `layout_record` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `layout_set`
--

DROP TABLE IF EXISTS `layout_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `layout_set` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `layout_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `layout_set`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `layout_set` WRITE;
/*!40000 ALTER TABLE `layout_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `layout_set` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `lead`
--

DROP TABLE IF EXISTS `lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `salutation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'New',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `industry` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opportunity_amount` double DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `do_not_call` tinyint(1) NOT NULL DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `converted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `account_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opportunity_amount_currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stream_updated_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_opportunity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_FIRST_NAME` (`first_name`,`deleted`),
  KEY `IDX_NAME` (`first_name`,`last_name`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_CREATED_AT_STATUS` (`created_at`,`status`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_CREATED_ACCOUNT_ID` (`created_account_id`),
  KEY `IDX_CREATED_CONTACT_ID` (`created_contact_id`),
  KEY `IDX_CREATED_OPPORTUNITY_ID` (`created_opportunity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `lead` WRITE;
/*!40000 ALTER TABLE `lead` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `lead_capture`
--

DROP TABLE IF EXISTS `lead_capture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_capture` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `subscribe_to_target_list` tinyint(1) NOT NULL DEFAULT 1,
  `subscribe_contact_to_target_list` tinyint(1) NOT NULL DEFAULT 1,
  `field_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `field_params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duplicate_check` tinyint(1) NOT NULL DEFAULT 1,
  `opt_in_confirmation` tinyint(1) NOT NULL DEFAULT 0,
  `opt_in_confirmation_lifetime` int(11) DEFAULT 48,
  `opt_in_confirmation_success_message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_lead_before_opt_in_confirmation` tinyint(1) NOT NULL DEFAULT 0,
  `skip_opt_in_confirmation_if_subscribed` tinyint(1) NOT NULL DEFAULT 0,
  `lead_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Web Site',
  `api_key` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `form_title` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_theme` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_success_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_success_redirect_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_language` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_frame_ancestors` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `form_captcha` tinyint(1) NOT NULL DEFAULT 0,
  `phone_number_country` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opt_in_confirmation_email_template_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pipeline_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_team_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`),
  KEY `IDX_OPT_IN_CONFIRMATION_EMAIL_TEMPLATE_ID` (`opt_in_confirmation_email_template_id`),
  KEY `IDX_PIPELINE_ID` (`pipeline_id`),
  KEY `IDX_TARGET_TEAM_ID` (`target_team_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_capture`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `lead_capture` WRITE;
/*!40000 ALTER TABLE `lead_capture` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_capture` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `lead_capture_log_record`
--

DROP TABLE IF EXISTS `lead_capture_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_capture_log_record` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `number` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_created` tinyint(1) NOT NULL DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `lead_capture_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_LEAD_CAPTURE_ID` (`lead_capture_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_capture_log_record`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `lead_capture_log_record` WRITE;
/*!40000 ALTER TABLE `lead_capture_log_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_capture_log_record` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `lead_meeting`
--

DROP TABLE IF EXISTS `lead_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_meeting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meeting_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_LEAD_ID_MEETING_ID` (`lead_id`,`meeting_id`),
  KEY `IDX_LEAD_ID` (`lead_id`),
  KEY `IDX_MEETING_ID` (`meeting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_meeting`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `lead_meeting` WRITE;
/*!40000 ALTER TABLE `lead_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_meeting` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `lead_target_list`
--

DROP TABLE IF EXISTS `lead_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_target_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_LEAD_ID_TARGET_LIST_ID` (`lead_id`,`target_list_id`),
  KEY `IDX_LEAD_ID` (`lead_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_target_list`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `lead_target_list` WRITE;
/*!40000 ALTER TABLE `lead_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_target_list` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `mass_action`
--

DROP TABLE IF EXISTS `mass_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mass_action` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `entity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `processed_count` int(11) DEFAULT NULL,
  `notify_on_finish` tinyint(1) NOT NULL DEFAULT 0,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mass_action`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `mass_action` WRITE;
/*!40000 ALTER TABLE `mass_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `mass_action` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `mass_email`
--

DROP TABLE IF EXISTS `mass_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mass_email` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `store_sent_emails` tinyint(1) NOT NULL DEFAULT 0,
  `opt_out_entirely` tinyint(1) NOT NULL DEFAULT 0,
  `from_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_to_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply_to_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `email_template_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inbound_email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EMAIL_TEMPLATE_ID` (`email_template_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_INBOUND_EMAIL_ID` (`inbound_email_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mass_email`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `mass_email` WRITE;
/*!40000 ALTER TABLE `mass_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `mass_email` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `mass_email_target_list`
--

DROP TABLE IF EXISTS `mass_email_target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mass_email_target_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mass_email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_MASS_EMAIL_ID_TARGET_LIST_ID` (`mass_email_id`,`target_list_id`),
  KEY `IDX_MASS_EMAIL_ID` (`mass_email_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mass_email_target_list`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `mass_email_target_list` WRITE;
/*!40000 ALTER TABLE `mass_email_target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `mass_email_target_list` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `mass_email_target_list_excluding`
--

DROP TABLE IF EXISTS `mass_email_target_list_excluding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mass_email_target_list_excluding` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mass_email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_MASS_EMAIL_ID_TARGET_LIST_ID` (`mass_email_id`,`target_list_id`),
  KEY `IDX_MASS_EMAIL_ID` (`mass_email_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mass_email_target_list_excluding`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `mass_email_target_list_excluding` WRITE;
/*!40000 ALTER TABLE `mass_email_target_list_excluding` DISABLE KEYS */;
/*!40000 ALTER TABLE `mass_email_target_list_excluding` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Planned',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `is_all_day` tinyint(1) NOT NULL DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `join_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_service` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `date_start_date` date DEFAULT NULL,
  `date_end_date` date DEFAULT NULL,
  `stream_updated_at` datetime DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DATE_START_STATUS` (`date_start`,`status`),
  KEY `IDX_DATE_START` (`date_start`,`deleted`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_UID` (`uid`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `meeting_user`
--

DROP TABLE IF EXISTS `meeting_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meeting_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'None',
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ID_MEETING_ID` (`user_id`,`meeting_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_MEETING_ID` (`meeting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `meeting_user` WRITE;
/*!40000 ALTER TABLE `meeting_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `next_number`
--

DROP TABLE IF EXISTS `next_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `next_number` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_TYPE_FIELD_NAME` (`entity_type`,`field_name`),
  KEY `IDX_ENTITY_TYPE` (`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `next_number`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `next_number` WRITE;
/*!40000 ALTER TABLE `next_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `next_number` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `note` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `post` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Post',
  `target_type` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `is_global` tinyint(1) NOT NULL DEFAULT 0,
  `is_internal` tinyint(1) NOT NULL DEFAULT 0,
  `is_pinned` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `super_parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `super_parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_CREATED_AT` (`created_at`),
  KEY `IDX_CREATED_BY_NUMBER` (`created_by_id`,`number`),
  KEY `IDX_TYPE` (`type`),
  KEY `IDX_TARGET_TYPE` (`target_type`),
  KEY `IDX_PARENT_ID` (`parent_id`),
  KEY `IDX_PARENT_TYPE` (`parent_type`),
  KEY `IDX_RELATED_ID` (`related_id`),
  KEY `IDX_RELATED_TYPE` (`related_type`),
  KEY `IDX_SUPER_PARENT_TYPE` (`super_parent_type`),
  KEY `IDX_SUPER_PARENT_ID` (`super_parent_id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_RELATED` (`related_id`,`related_type`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_SUPER_PARENT` (`super_parent_id`,`super_parent_type`),
  FULLTEXT KEY `IDX_SYSTEM_FULL_TEXT_SEARCH` (`post`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
INSERT INTO `note` VALUES
('6ae3de679729caa52',0,NULL,'{\"fields\":[\"data\"],\"attributes\":{\"was\":{\"data\":{}},\"became\":{\"data\":{\"Session\":{\"create\":\"no\",\"read\":\"all\",\"edit\":\"no\",\"delete\":\"no\",\"stream\":\"no\"}}}}}','Update',NULL,1,0,0,0,'2026-10-30 00:01:43','2026-10-30 00:01:43','6ae3db53ce46ceb39','Role',NULL,NULL,'6ae269f1404188a4c',NULL,NULL,NULL),
('6ae3df0f8840f94b1',0,NULL,'{\"fields\":[\"roles\"],\"attributes\":{\"was\":{\"rolesIds\":[],\"rolesNames\":{}},\"became\":{\"rolesIds\":[\"6ae3db53ce46ceb39\"],\"rolesNames\":{\"6ae3db53ce46ceb39\":\"API\"}}}}','Update',NULL,2,0,0,0,'2026-10-30 00:04:31','2026-10-30 00:04:31','6ae3d895b6044ff7b','User',NULL,NULL,'6ae269f1404188a4c',NULL,NULL,NULL),
('6ae3e142e4aa4c8cb',0,NULL,'{\"fields\":[\"data\"],\"attributes\":{\"was\":{\"data\":{\"Session\":{\"create\":\"no\",\"read\":\"all\",\"edit\":\"no\",\"delete\":\"no\",\"stream\":\"no\"}}},\"became\":{\"data\":{\"Session\":{\"create\":\"no\",\"read\":\"all\",\"edit\":\"no\",\"delete\":\"no\"}}}}}','Update',NULL,3,0,0,0,'2026-10-30 00:13:54','2026-10-30 00:13:54','6ae3db53ce46ceb39','Role',NULL,NULL,'6ae269f1404188a4c',NULL,NULL,NULL);
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `note_portal`
--

DROP TABLE IF EXISTS `note_portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `note_portal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `note_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portal_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NOTE_ID_PORTAL_ID` (`note_id`,`portal_id`),
  KEY `IDX_NOTE_ID` (`note_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_portal`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `note_portal` WRITE;
/*!40000 ALTER TABLE `note_portal` DISABLE KEYS */;
/*!40000 ALTER TABLE `note_portal` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `note_team`
--

DROP TABLE IF EXISTS `note_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `note_team` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `note_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NOTE_ID_TEAM_ID` (`note_id`,`team_id`),
  KEY `IDX_NOTE_ID` (`note_id`),
  KEY `IDX_TEAM_ID` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_team`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `note_team` WRITE;
/*!40000 ALTER TABLE `note_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `note_team` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `note_user`
--

DROP TABLE IF EXISTS `note_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `note_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `note_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NOTE_ID_USER_ID` (`note_id`,`user_id`),
  KEY `IDX_NOTE_ID` (`note_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `note_user` WRITE;
/*!40000 ALTER TABLE `note_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `note_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `number` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `email_is_processed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `message` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_CREATED_AT` (`created_at`),
  KEY `IDX_USER` (`user_id`,`number`),
  KEY `IDX_USER_ID_READ_RELATED_PARENT_TYPE` (`user_id`,`deleted`,`read`,`related_parent_type`),
  KEY `IDX_ACTION_ID` (`action_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_RELATED` (`related_id`,`related_type`),
  KEY `IDX_RELATED_PARENT` (`related_parent_id`,`related_parent_type`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `o_auth_account`
--

DROP TABLE IF EXISTS `o_auth_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `o_auth_account` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `access_token` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refresh_token` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `provider_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_PROVIDER_ID` (`provider_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `o_auth_account`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `o_auth_account` WRITE;
/*!40000 ALTER TABLE `o_auth_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `o_auth_account` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `o_auth_provider`
--

DROP TABLE IF EXISTS `o_auth_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `o_auth_provider` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `client_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authorization_endpoint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token_endpoint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authorization_prompt` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'none',
  `scopes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `authorization_params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scope_separator` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `o_auth_provider`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `o_auth_provider` WRITE;
/*!40000 ALTER TABLE `o_auth_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `o_auth_provider` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `offer`
--

DROP TABLE IF EXISTS `offer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `offer` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `price` double DEFAULT NULL,
  `duration_min` int(11) DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `offer` WRITE;
/*!40000 ALTER TABLE `offer` DISABLE KEYS */;
/*!40000 ALTER TABLE `offer` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `opportunity`
--

DROP TABLE IF EXISTS `opportunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `opportunity` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `amount` double DEFAULT NULL,
  `stage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Prospecting',
  `last_stage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `probability` int(11) DEFAULT NULL,
  `lead_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `close_date` date DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `amount_currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stream_updated_at` datetime DEFAULT NULL,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_CREATED_AT_ID` (`created_at`,`id`),
  KEY `IDX_STAGE` (`stage`,`deleted`),
  KEY `IDX_LAST_STAGE` (`last_stage`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_CREATED_AT_STAGE` (`created_at`,`stage`),
  KEY `IDX_ASSIGNED_USER_STAGE` (`assigned_user_id`,`stage`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_CAMPAIGN_ID` (`campaign_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opportunity`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `opportunity` WRITE;
/*!40000 ALTER TABLE `opportunity` DISABLE KEYS */;
/*!40000 ALTER TABLE `opportunity` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `order_id` char(36) NOT NULL,
  `catalog_item_id` char(36) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `quantity` decimal(12,3) NOT NULL DEFAULT 1.000,
  `unit_price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `unit_cost` decimal(12,2) NOT NULL DEFAULT 0.00,
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_order_items_order` (`order_id`),
  KEY `fk_order_items_catalog` (`catalog_item_id`),
  CONSTRAINT `fk_order_items_catalog` FOREIGN KEY (`catalog_item_id`) REFERENCES `catalog_items` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `order_resources`
--

DROP TABLE IF EXISTS `order_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_resources` (
  `order_id` char(36) NOT NULL,
  `resource_id` char(36) NOT NULL,
  `role` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`resource_id`),
  KEY `fk_order_resources_resource` (`resource_id`),
  CONSTRAINT `fk_order_resources_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_resources_resource` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_resources`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `order_resources` WRITE;
/*!40000 ALTER TABLE `order_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_resources` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `customer_id` char(36) DEFAULT NULL,
  `status` enum('draft','scheduled','in_progress','completed','cancelled') NOT NULL DEFAULT 'draft',
  `scheduled_at` datetime DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `cost` decimal(12,2) NOT NULL DEFAULT 0.00,
  `workflow_id` char(36) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_orders_org_status` (`organization_id`,`status`),
  KEY `idx_orders_org_scheduled` (`organization_id`,`scheduled_at`),
  KEY `fk_orders_customer` (`customer_id`),
  CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_orders_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `industry_pack` varchar(64) NOT NULL DEFAULT 'beauty',
  `owner_id` char(36) DEFAULT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`settings`)),
  `status` enum('active','suspended','archived') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
INSERT INTO `organizations` VALUES
('11111111-1111-1111-1111-111111111111','Atmosfera Beauty','beauty',NULL,NULL,'active','2026-10-31 07:56:20','2026-10-31 07:56:20');
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `parts`
--

DROP TABLE IF EXISTS `parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `parts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned NOT NULL,
  `sku` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `brand` varchar(128) DEFAULT NULL,
  `price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `stock_qty` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_parts_organization_sku` (`organization_id`,`sku`),
  KEY `idx_parts_organization_name` (`organization_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parts`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `parts` WRITE;
/*!40000 ALTER TABLE `parts` DISABLE KEYS */;
INSERT INTO `parts` VALUES
(2,1,'BRK-PAD-001','Тормозные колодки Brembo','Brembo',5200.00,8,1,'2026-10-31 10:19:47','2026-10-31 10:49:59');
/*!40000 ALTER TABLE `parts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `password_change_request`
--

DROP TABLE IF EXISTS `password_change_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_change_request` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `request_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_REQUEST_ID` (`request_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_change_request`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `password_change_request` WRITE;
/*!40000 ALTER TABLE `password_change_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_change_request` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `personal_project`
--

DROP TABLE IF EXISTS `personal_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_project` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'idea',
  `target_amount` double DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_amount_currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_project`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `personal_project` WRITE;
/*!40000 ALTER TABLE `personal_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_project` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `phone_number`
--

DROP TABLE IF EXISTS `phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone_number` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numeric` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invalid` tinyint(1) NOT NULL DEFAULT 0,
  `opt_out` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_NAME` (`name`),
  KEY `IDX_NUMERIC` (`numeric`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_number`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `phone_number` WRITE;
/*!40000 ALTER TABLE `phone_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_number` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `pipeline`
--

DROP TABLE IF EXISTS `pipeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pipeline` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `order` int(11) DEFAULT NULL,
  `status` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` int(11) DEFAULT NULL,
  `is_available_for_all` tinyint(1) NOT NULL DEFAULT 1,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ENTITY_TYPE_STATUS` (`entity_type`,`status`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pipeline`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `pipeline` WRITE;
/*!40000 ALTER TABLE `pipeline` DISABLE KEYS */;
/*!40000 ALTER TABLE `pipeline` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `pipeline_stage`
--

DROP TABLE IF EXISTS `pipeline_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pipeline_stage` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `order` int(11) DEFAULT NULL,
  `mapped_status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `pipeline_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_PIPELINE_ID` (`pipeline_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pipeline_stage`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `pipeline_stage` WRITE;
/*!40000 ALTER TABLE `pipeline_stage` DISABLE KEYS */;
/*!40000 ALTER TABLE `pipeline_stage` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `portal`
--

DROP TABLE IF EXISTS `portal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `custom_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `tab_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `quick_create_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `application_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_params` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_zone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `week_start` int(11) DEFAULT -1,
  `default_currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboard_layout` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashlets_options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_token_lifetime` double DEFAULT NULL,
  `auth_token_max_idle_time` double DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `logo_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_logo_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_set_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authentication_provider_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CUSTOM_ID` (`custom_id`),
  KEY `IDX_LAYOUT_SET_ID` (`layout_set_id`),
  KEY `IDX_AUTHENTICATION_PROVIDER_ID` (`authentication_provider_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `portal` WRITE;
/*!40000 ALTER TABLE `portal` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `portal_portal_role`
--

DROP TABLE IF EXISTS `portal_portal_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal_portal_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `portal_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portal_role_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_PORTAL_ID_PORTAL_ROLE_ID` (`portal_id`,`portal_role_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`),
  KEY `IDX_PORTAL_ROLE_ID` (`portal_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_portal_role`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `portal_portal_role` WRITE;
/*!40000 ALTER TABLE `portal_portal_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_portal_role` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `portal_role`
--

DROP TABLE IF EXISTS `portal_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal_role` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `export_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `mass_update_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_role`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `portal_role` WRITE;
/*!40000 ALTER TABLE `portal_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_role` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `portal_role_user`
--

DROP TABLE IF EXISTS `portal_role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal_role_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `portal_role_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_PORTAL_ROLE_ID_USER_ID` (`portal_role_id`,`user_id`),
  KEY `IDX_PORTAL_ROLE_ID` (`portal_role_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_role_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `portal_role_user` WRITE;
/*!40000 ALTER TABLE `portal_role_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_role_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `portal_user`
--

DROP TABLE IF EXISTS `portal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `portal_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `portal_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_PORTAL_ID_USER_ID` (`portal_id`,`user_id`),
  KEY `IDX_PORTAL_ID` (`portal_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `portal_user` WRITE;
/*!40000 ALTER TABLE `portal_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `preferences`
--

DROP TABLE IF EXISTS `preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `preferences` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preferences`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `preferences` WRITE;
/*!40000 ALTER TABLE `preferences` DISABLE KEYS */;
INSERT INTO `preferences` VALUES
('6ae269f1404188a4c','{\n    \"id\": \"6ae269f1404188a4c\",\n    \"timeZone\": null,\n    \"dateFormat\": null,\n    \"timeFormat\": null,\n    \"weekStart\": -1,\n    \"defaultCurrency\": null,\n    \"thousandSeparator\": \",\",\n    \"decimalMark\": \".\",\n    \"dashboardLayout\": [\n        {\n            \"name\": \"My Espo\",\n            \"layout\": [\n                {\n                    \"id\": \"default-stream\",\n                    \"name\": \"Stream\",\n                    \"x\": 0,\n                    \"y\": 0,\n                    \"width\": 2,\n                    \"height\": 4\n                },\n                {\n                    \"id\": \"default-activities\",\n                    \"name\": \"Activities\",\n                    \"x\": 2,\n                    \"y\": 2,\n                    \"width\": 2,\n                    \"height\": 4\n                }\n            ]\n        }\n    ],\n    \"dashletsOptions\": {},\n    \"dashboardLocked\": false,\n    \"language\": \"ru_RU\",\n    \"exportDelimiter\": \",\",\n    \"receiveAssignmentEmailNotifications\": true,\n    \"receiveMentionEmailNotifications\": true,\n    \"receiveStreamEmailNotifications\": true,\n    \"assignmentNotificationsIgnoreEntityTypeList\": [],\n    \"reactionNotifications\": true,\n    \"reactionNotificationsNotFollowed\": false,\n    \"notificationGrouping\": true,\n    \"notificationSound\": false,\n    \"signature\": null,\n    \"defaultReminders\": [],\n    \"defaultRemindersTask\": [],\n    \"theme\": \"Dark\",\n    \"themeParams\": {\n        \"navbar\": \"side\"\n    },\n    \"pageContentWidth\": null,\n    \"useCustomTabList\": false,\n    \"addCustomTabs\": false,\n    \"emailReplyToAllByDefault\": true,\n    \"emailReplyForceHtml\": true,\n    \"doNotFillAssignedUserIfNotRequired\": true,\n    \"followEntityOnStreamPost\": true,\n    \"followCreatedEntities\": false,\n    \"followCreatedEntityTypeList\": [],\n    \"followAsCollaborator\": true,\n    \"emailUseExternalClient\": false,\n    \"scopeColorsDisabled\": false,\n    \"tabColorsDisabled\": false,\n    \"textSearchStoringDisabled\": false,\n    \"calendarSlotDuration\": null,\n    \"calendarScrollHour\": null\n}');
/*!40000 ALTER TABLE `preferences` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `reminder`
--

DROP TABLE IF EXISTS `reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminder` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `remind_at` datetime DEFAULT NULL,
  `start_at` datetime DEFAULT NULL,
  `type` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Popup',
  `seconds` int(11) DEFAULT 0,
  `is_submitted` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_REMIND_AT` (`remind_at`),
  KEY `IDX_START_AT` (`start_at`),
  KEY `IDX_TYPE` (`type`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminder`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `reminder` WRITE;
/*!40000 ALTER TABLE `reminder` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminder` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `resources` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `type` enum('employee','room','equipment','vehicle','storage','location') NOT NULL DEFAULT 'employee',
  `name` varchar(255) NOT NULL,
  `capacity` int(11) NOT NULL DEFAULT 1,
  `calendar` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`calendar`)),
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_resources_org_type` (`organization_id`,`type`),
  CONSTRAINT `fk_resources_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` VALUES
('22222222-2222-2222-2222-222222222222','11111111-1111-1111-1111-111111111111','employee','Анна — мастер',1,NULL,'active','2026-10-31 07:56:20','2026-10-31 07:57:46'),
('33333333-3333-3333-3333-333333333333','11111111-1111-1111-1111-111111111111','employee','Мария — мастер',1,NULL,'active','2026-10-31 07:56:20','2026-10-31 07:57:46');
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `assignment_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `user_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `message_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `portal_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `group_email_account_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `export_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `mass_update_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `data_privacy_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `follower_management_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `audit_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `mention_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `user_calendar_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `lock_permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'not-set',
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES
('6ae3db53ce46ceb39','API',0,'not-set','not-set','not-set','not-set','not-set','not-set','not-set','not-set','not-set','not-set','not-set','not-set','not-set','{\"Session\":{\"create\":\"no\",\"read\":\"all\",\"edit\":\"no\",\"delete\":\"no\"}}','{\"Team\":{},\"User\":{},\"Email\":{},\"Meeting\":{},\"Document\":{},\"Task\":{},\"Call\":{},\"Campaign\":{},\"KnowledgeBaseCategory\":{},\"TargetListCategory\":{},\"Contact\":{},\"Account\":{},\"Lead\":{},\"Case\":{},\"DocumentFolder\":{},\"Opportunity\":{},\"TargetList\":{},\"KnowledgeBaseArticle\":{},\"Session\":{},\"CMaster\":{},\"CService\":{}}','2026-10-29 23:48:35','2026-10-30 00:13:54');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `role_team`
--

DROP TABLE IF EXISTS `role_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_team` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ROLE_ID_TEAM_ID` (`role_id`,`team_id`),
  KEY `IDX_ROLE_ID` (`role_id`),
  KEY `IDX_TEAM_ID` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_team`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `role_team` WRITE;
/*!40000 ALTER TABLE `role_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_team` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_ROLE_ID_USER_ID` (`role_id`,`user_id`),
  KEY `IDX_ROLE_ID` (`role_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
INSERT INTO `role_user` VALUES
(1,'6ae3db53ce46ceb39','6ae3d895b6044ff7b',0);
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `scheduled_job`
--

DROP TABLE IF EXISTS `scheduled_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_job` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `job` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `scheduling` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `is_internal` tinyint(1) NOT NULL DEFAULT 0,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_job`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `scheduled_job` WRITE;
/*!40000 ALTER TABLE `scheduled_job` DISABLE KEYS */;
INSERT INTO `scheduled_job` VALUES
('6ae269f129eef72a3','Submit Popup Reminders',0,'SubmitPopupReminders','Active','* * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',1,NULL,NULL),
('6ae269f12ab4cadaf','Process Job Group',0,'ProcessJobGroup','Active','* * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',1,NULL,NULL),
('6ae269f12b60e9da1','Process Job Queue q0',0,'ProcessJobQueueQ0','Active','* * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',1,NULL,NULL),
('6ae269f12c1be52bf','Process Job Queue q1',0,'ProcessJobQueueQ1','Active','*/1 * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',1,NULL,NULL),
('6ae269f12cef78eeb','Process Job Queue e0',0,'ProcessJobQueueE0','Active','* * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',1,NULL,NULL),
('6ae269f12d7b0b259','Dummy',0,'Dummy','Active','1 */12 * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',1,NULL,NULL),
('6ae269f12e03a0cf4','Check for New Version',0,'CheckNewVersion','Active','15 5 * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',1,NULL,NULL),
('6ae269f12e8cf1a27','Check for New Versions of Installed Extensions',0,'CheckNewExtensionVersion','Active','25 5 * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',1,NULL,NULL),
('6ae269f12f1ce2daf','Sync Currency Rates',0,'SyncCurrencyRates','Active','2 0 * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',1,NULL,NULL),
('6ae269f1ab179d69a','Clean-up',0,'Cleanup','Active','1 1 * * 0',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL),
('6ae269f1aeb0342b3','Auth Token Control',0,'AuthTokenControl','Active','*/6 * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL),
('6ae269f1af8004df8','Send Email Notifications',0,'SendEmailNotifications','Active','*/2 * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL),
('6ae269f1affa048c9','Process Webhook Queue',0,'ProcessWebhookQueue','Active','*/2 * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL),
('6ae269f1b070a9b37','Check Personal Email Accounts',0,'CheckEmailAccounts','Active','*/1 * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL),
('6ae269f1b0e679e17','Check Group Email Accounts',0,'CheckInboundEmails','Active','*/1 * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL),
('6ae269f1b1583ad8d','Send Scheduled Emails',0,'SendScheduledEmails','Active','*/10 * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL),
('6ae269f1b1c9091ac','Control Knowledge Base Article Status',0,'ControlKnowledgeBaseArticleStatus','Active','10 1 * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL),
('6ae269f1b23baf173','Send Email Reminders',0,'SendEmailReminders','Active','*/2 * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL),
('6ae269f1b2b4859b4','Send Mass Emails',0,'ProcessMassEmail','Active','10,30,50 * * * *',NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',0,'system',NULL);
/*!40000 ALTER TABLE `scheduled_job` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `scheduled_job_log_record`
--

DROP TABLE IF EXISTS `scheduled_job_log_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_job_log_record` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `execution_time` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `scheduled_job_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_SCHEDULED_JOB_ID_EXECUTION_TIME` (`scheduled_job_id`,`execution_time`),
  KEY `IDX_SCHEDULED_JOB_ID` (`scheduled_job_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_job_log_record`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `scheduled_job_log_record` WRITE;
/*!40000 ALTER TABLE `scheduled_job_log_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_job_log_record` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'new',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'telegram',
  `deposit_amount` double DEFAULT NULL,
  `deposit_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `canceled_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancel_reason` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reminder_sent_at` datetime DEFAULT NULL,
  `deposit_amount_currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specialist_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `offer_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_SPECIALIST_ID` (`specialist_id`),
  KEY `IDX_OFFER_ID` (`offer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Archived',
  `date_sent` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `from_phone_number_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `replied_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DATE_SENT` (`date_sent`,`deleted`),
  KEY `IDX_DATE_SENT_STATUS` (`date_sent`,`status`,`deleted`),
  KEY `IDX_FROM_PHONE_NUMBER_ID` (`from_phone_number_id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_REPLIED_ID` (`replied_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `sms_phone_number`
--

DROP TABLE IF EXISTS `sms_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_phone_number` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sms_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_SMS_ID_PHONE_NUMBER_ID_ADDRESS_TYPE` (`sms_id`,`phone_number_id`,`address_type`),
  KEY `IDX_SMS_ID` (`sms_id`),
  KEY `IDX_PHONE_NUMBER_ID` (`phone_number_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_phone_number`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `sms_phone_number` WRITE;
/*!40000 ALTER TABLE `sms_phone_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_phone_number` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `specialist`
--

DROP TABLE IF EXISTS `specialist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialist` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `specialty` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `notes` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialist`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `specialist` WRITE;
/*!40000 ALTER TABLE `specialist` DISABLE KEYS */;
/*!40000 ALTER TABLE `specialist` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `star_subscription`
--

DROP TABLE IF EXISTS `star_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `star_subscription` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ENTITY` (`user_id`,`entity_id`,`entity_type`),
  KEY `IDX_USER_ENTITY_TYPE` (`user_id`,`entity_type`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`),
  KEY `IDX_USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `star_subscription`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `star_subscription` WRITE;
/*!40000 ALTER TABLE `star_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `star_subscription` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `stream_subscription`
--

DROP TABLE IF EXISTS `stream_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `stream_subscription` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT 0,
  `entity_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_USER_ENTITY` (`user_id`,`entity_id`,`entity_type`),
  KEY `IDX_ENTITY` (`entity_id`,`entity_type`),
  KEY `IDX_USER` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stream_subscription`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `stream_subscription` WRITE;
/*!40000 ALTER TABLE `stream_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `stream_subscription` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `system_data`
--

DROP TABLE IF EXISTS `system_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_data` (
  `id` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `last_password_recovery_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_data`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `system_data` WRITE;
/*!40000 ALTER TABLE `system_data` DISABLE KEYS */;
INSERT INTO `system_data` VALUES
('1',0,NULL);
/*!40000 ALTER TABLE `system_data` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `target`
--

DROP TABLE IF EXISTS `target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `target` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `salutation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_postal_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `do_not_call` tinyint(1) NOT NULL DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `middle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FIRST_NAME` (`first_name`,`deleted`),
  KEY `IDX_NAME` (`first_name`,`last_name`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `target` WRITE;
/*!40000 ALTER TABLE `target` DISABLE KEYS */;
/*!40000 ALTER TABLE `target` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `target_list`
--

DROP TABLE IF EXISTS `target_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_list` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `category_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_AT` (`created_at`,`deleted`),
  KEY `IDX_CATEGORY_ID` (`category_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_list`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `target_list` WRITE;
/*!40000 ALTER TABLE `target_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `target_list` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `target_list_category`
--

DROP TABLE IF EXISTS `target_list_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_list_category` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `order` int(11) DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_PARENT_ID` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_list_category`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `target_list_category` WRITE;
/*!40000 ALTER TABLE `target_list_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `target_list_category` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `target_list_category_path`
--

DROP TABLE IF EXISTS `target_list_category_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_list_category_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ascendor_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descendor_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_ASCENDOR_ID` (`ascendor_id`),
  KEY `IDX_DESCENDOR_ID` (`descendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_list_category_path`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `target_list_category_path` WRITE;
/*!40000 ALTER TABLE `target_list_category_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `target_list_category_path` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `target_list_user`
--

DROP TABLE IF EXISTS `target_list_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_list_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_list_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opted_out` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ID_TARGET_LIST_ID` (`user_id`,`target_list_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_TARGET_LIST_ID` (`target_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_list_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `target_list_user` WRITE;
/*!40000 ALTER TABLE `target_list_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `target_list_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Not Started',
  `priority` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Normal',
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `date_start_date` date DEFAULT NULL,
  `date_end_date` date DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `stream_updated_at` datetime DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned_user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint(20) DEFAULT 0,
  `email_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DATE_START_STATUS` (`date_start`,`status`),
  KEY `IDX_DATE_END_STATUS` (`date_end`,`status`),
  KEY `IDX_DATE_START` (`date_start`,`deleted`),
  KEY `IDX_STATUS` (`status`,`deleted`),
  KEY `IDX_ASSIGNED_USER` (`assigned_user_id`,`deleted`),
  KEY `IDX_ASSIGNED_USER_STATUS` (`assigned_user_id`,`status`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`),
  KEY `IDX_ACCOUNT_ID` (`account_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`),
  KEY `IDX_ASSIGNED_USER_ID` (`assigned_user_id`),
  KEY `IDX_EMAIL_ID` (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `position_list` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `layout_set_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `working_time_calendar_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_LAYOUT_SET_ID` (`layout_set_id`),
  KEY `IDX_WORKING_TIME_CALENDAR_ID` (`working_time_calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `team_user`
--

DROP TABLE IF EXISTS `team_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `team_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_TEAM_ID_USER_ID` (`team_id`,`user_id`),
  KEY `IDX_TEAM_ID` (`team_id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `team_user` WRITE;
/*!40000 ALTER TABLE `team_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `template` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `body` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `header` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `left_margin` double DEFAULT 10,
  `right_margin` double DEFAULT 10,
  `top_margin` double DEFAULT 10,
  `bottom_margin` double DEFAULT 20,
  `print_footer` tinyint(1) NOT NULL DEFAULT 0,
  `print_header` tinyint(1) NOT NULL DEFAULT 0,
  `footer_position` double DEFAULT 10,
  `header_position` double DEFAULT 0,
  `style` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `page_orientation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Portrait',
  `page_format` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'A4',
  `page_width` double DEFAULT NULL,
  `page_height` double DEFAULT NULL,
  `font_face` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version_number` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `template` WRITE;
/*!40000 ALTER TABLE `template` DISABLE KEYS */;
/*!40000 ALTER TABLE `template` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `two_factor_code`
--

DROP TABLE IF EXISTS `two_factor_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `two_factor_code` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attempts_left` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_AT` (`created_at`),
  KEY `IDX_USER_ID_METHOD` (`user_id`,`method`),
  KEY `IDX_USER_ID_METHOD_IS_ACTIVE` (`user_id`,`method`,`is_active`),
  KEY `IDX_USER_ID_METHOD_CREATED_AT` (`user_id`,`method`,`created_at`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `two_factor_code`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `two_factor_code` WRITE;
/*!40000 ALTER TABLE `two_factor_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `two_factor_code` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `unique_id`
--

DROP TABLE IF EXISTS `unique_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `unique_id` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `terminate_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_NAME` (`name`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unique_id`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `unique_id` WRITE;
/*!40000 ALTER TABLE `unique_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `unique_id` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'regular',
  `password` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_version` int(11) NOT NULL DEFAULT 0,
  `auth_method` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salutation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_color` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `middle_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delete_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `default_team_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboard_template_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `working_time_calendar_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_set_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_NAME_DELETE_ID` (`user_name`,`delete_id`),
  KEY `IDX_USER_NAME` (`user_name`),
  KEY `IDX_TYPE` (`type`),
  KEY `IDX_DEFAULT_TEAM_ID` (`default_team_id`),
  KEY `IDX_CONTACT_ID` (`contact_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_DASHBOARD_TEMPLATE_ID` (`dashboard_template_id`),
  KEY `IDX_WORKING_TIME_CALENDAR_ID` (`working_time_calendar_id`),
  KEY `IDX_LAYOUT_SET_ID` (`layout_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
('6ae269f1404188a4c',0,'admin','admin','$2y$12$8wJWeaUDLintT84IyLJ06Opm4/wYJmY.Ji56L681iga6BxOCAFkXi',1,NULL,NULL,NULL,NULL,'Admin',1,NULL,NULL,NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',NULL,'0',NULL,NULL,NULL,'system',NULL,NULL,NULL),
('6ae3d895b6044ff7b',0,'api_user','api','$2y$12$AW0rrLbiwxvXlCSfdVC6iOBSmrFRrMYuOUrKN1WbBRwowUG3l54pm',1,'ApiKey','dcc884f4470a3e022099ce4852febaf6',NULL,NULL,'api_user',1,NULL,'#4a3d08',NULL,'2026-10-29 23:36:53','2026-10-30 00:04:31',NULL,'0',NULL,NULL,NULL,'6ae269f1404188a4c',NULL,NULL,NULL),
('system',0,'system','system',NULL,0,NULL,NULL,NULL,NULL,'System',1,NULL,NULL,NULL,'2026-10-28 21:32:33','2026-10-28 21:32:33',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_data`
--

DROP TABLE IF EXISTS `user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_data` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `auth2_f_a` tinyint(1) NOT NULL DEFAULT 0,
  `auth2_f_a_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth2_f_a_totp_secret` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth2_f_a_email_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_data`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_data` WRITE;
/*!40000 ALTER TABLE `user_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_data` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_reaction`
--

DROP TABLE IF EXISTS `user_reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_reaction` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_PARENT_USER_TYPE` (`parent_id`,`parent_type`,`user_id`,`type`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_PARENT` (`parent_id`,`parent_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_reaction`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_reaction` WRITE;
/*!40000 ALTER TABLE `user_reaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_reaction` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_working_time_range`
--

DROP TABLE IF EXISTS `user_working_time_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_working_time_range` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `working_time_range_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_USER_ID_WORKING_TIME_RANGE_ID` (`user_id`,`working_time_range_id`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_WORKING_TIME_RANGE_ID` (`working_time_range_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_working_time_range`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_working_time_range` WRITE;
/*!40000 ALTER TABLE `user_working_time_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_working_time_range` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('owner','admin','manager','operator','viewer') NOT NULL DEFAULT 'operator',
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `status` enum('active','invited','disabled') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_org_email` (`organization_id`,`email`),
  CONSTRAINT `fk_users_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
('c619660e-bec7-4ecf-8b52-017a553d5f62','11111111-1111-1111-1111-111111111111','admin@ucp.local','$2b$10$fJLtgLV5BwqObrImDCCHSOGXeiMu9oFu/mnog0ZxihrMcQ2f4RwCK','owner',NULL,'active','2026-10-31 08:25:02','2026-10-31 08:25:02');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `webhook`
--

DROP TABLE IF EXISTS `webhook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `event` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `entity_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `skip_own` tinyint(1) NOT NULL DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EVENT` (`event`),
  KEY `IDX_ENTITY_TYPE_TYPE` (`entity_type`,`type`),
  KEY `IDX_ENTITY_TYPE_FIELD` (`entity_type`,`field`),
  KEY `IDX_USER_ID` (`user_id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `webhook` WRITE;
/*!40000 ALTER TABLE `webhook` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `webhook_event_queue_item`
--

DROP TABLE IF EXISTS `webhook_event_queue_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook_event_queue_item` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `number` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `is_processed` tinyint(1) NOT NULL DEFAULT 0,
  `target_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_TARGET` (`target_id`,`target_type`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_event_queue_item`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `webhook_event_queue_item` WRITE;
/*!40000 ALTER TABLE `webhook_event_queue_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_event_queue_item` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `webhook_queue_item`
--

DROP TABLE IF EXISTS `webhook_queue_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook_queue_item` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `number` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `processed_at` datetime DEFAULT NULL,
  `attempts` int(11) DEFAULT 0,
  `process_at` datetime DEFAULT NULL,
  `webhook_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_NUMBER` (`number`),
  KEY `IDX_WEBHOOK_ID` (`webhook_id`),
  KEY `IDX_TARGET` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook_queue_item`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `webhook_queue_item` WRITE;
/*!40000 ALTER TABLE `webhook_queue_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhook_queue_item` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `workflows`
--

DROP TABLE IF EXISTS `workflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `workflows` (
  `id` char(36) NOT NULL,
  `organization_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `entity_type` varchar(64) NOT NULL,
  `definition` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`definition`)),
  `status` enum('active','draft','archived') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_workflows_org` (`organization_id`),
  CONSTRAINT `fk_workflows_organization` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflows`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `workflows` WRITE;
/*!40000 ALTER TABLE `workflows` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflows` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `working_time_calendar`
--

DROP TABLE IF EXISTS `working_time_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `working_time_calendar` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_zone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_ranges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '[["9:00","17:00"]]',
  `weekday0` tinyint(1) NOT NULL DEFAULT 0,
  `weekday1` tinyint(1) NOT NULL DEFAULT 1,
  `weekday2` tinyint(1) NOT NULL DEFAULT 1,
  `weekday3` tinyint(1) NOT NULL DEFAULT 1,
  `weekday4` tinyint(1) NOT NULL DEFAULT 1,
  `weekday5` tinyint(1) NOT NULL DEFAULT 1,
  `weekday6` tinyint(1) NOT NULL DEFAULT 0,
  `weekday0_time_ranges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weekday1_time_ranges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weekday2_time_ranges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weekday3_time_ranges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weekday4_time_ranges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weekday5_time_ranges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weekday6_time_ranges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `working_time_calendar`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `working_time_calendar` WRITE;
/*!40000 ALTER TABLE `working_time_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `working_time_calendar` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `working_time_calendar_working_time_range`
--

DROP TABLE IF EXISTS `working_time_calendar_working_time_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `working_time_calendar_working_time_range` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `working_time_calendar_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `working_time_range_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_WORKING_TIME_CALENDAR_ID_WORKING_TIME_RANGE_ID` (`working_time_calendar_id`,`working_time_range_id`),
  KEY `IDX_WORKING_TIME_CALENDAR_ID` (`working_time_calendar_id`),
  KEY `IDX_WORKING_TIME_RANGE_ID` (`working_time_range_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `working_time_calendar_working_time_range`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `working_time_calendar_working_time_range` WRITE;
/*!40000 ALTER TABLE `working_time_calendar_working_time_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `working_time_calendar_working_time_range` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `working_time_range`
--

DROP TABLE IF EXISTS `working_time_range`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `working_time_range` (
  `id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `time_ranges` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `type` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Non-working',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `modified_at` datetime DEFAULT NULL,
  `created_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by_id` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_TYPE_RANGE` (`type`,`date_start`,`date_end`),
  KEY `IDX_TYPE` (`type`),
  KEY `IDX_CREATED_BY_ID` (`created_by_id`),
  KEY `IDX_MODIFIED_BY_ID` (`modified_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `working_time_range`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `working_time_range` WRITE;
/*!40000 ALTER TABLE `working_time_range` DISABLE KEYS */;
/*!40000 ALTER TABLE `working_time_range` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping routines for database 'ucp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-10-31 20:06:05
