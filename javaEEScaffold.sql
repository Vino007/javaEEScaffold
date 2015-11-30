CREATE DATABASE  IF NOT EXISTS `javaeescaffold` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `javaeescaffold`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: javaeescaffold
-- ------------------------------------------------------
-- Server version	5.6.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_resource`
--

DROP TABLE IF EXISTS `t_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_resource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` time DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `available` bit(1) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `permission` varchar(100) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `creator_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_resource`
--

LOCK TABLES `t_resource` WRITE;
/*!40000 ALTER TABLE `t_resource` DISABLE KEYS */;
INSERT INTO `t_resource` VALUES (1,NULL,NULL,'','用户管理',0,'user:menu',1,'menu','user/all',NULL),(2,NULL,NULL,'','创建用户',1,'user:create',1,'button','',NULL),(3,NULL,NULL,'','删除用户',1,'user:delete',1,'button',NULL,NULL),(4,NULL,NULL,'','编辑用户',1,'user:update',1,'button',NULL,NULL),(5,NULL,NULL,'','查询用户',1,'user:view',1,'button',NULL,NULL),(6,NULL,NULL,'','角色管理',0,'role:menu',2,'menu','role/all',NULL),(7,NULL,NULL,'\0','创建角色',6,'role:create',1,'button','',NULL),(8,NULL,NULL,'','删除角色',6,'role:delete',1,'button','2',NULL),(9,NULL,NULL,'','编辑角色',6,'role:update',1,'button','',NULL),(10,NULL,NULL,'','查询角色',6,'role:view',1,'button','',NULL),(11,'14:15:19',NULL,'','资源管理',0,'resource:menu',3,'menu','resource/all','admin'),(12,'15:22:35',NULL,'','创建资源',11,'resource:create',1,'button','','admin'),(13,'15:22:52',NULL,'','删除资源',11,'resource:delete',1,'button','','admin'),(14,'15:23:23',NULL,'','查询资源',11,'resource:view',1,'button','','admin'),(15,'15:23:47',NULL,'','编辑资源',11,'resource:update',1,'button','','admin'),(18,'19:27:09',NULL,'','绑定角色',1,'user:bind',1,'button','','admin'),(19,'19:34:06',NULL,'','绑定资源',6,'role:bind',1,'button','','admin'),(30,'14:12:57',NULL,'','上传用户',1,'user:upload',1,'button','','admin'),(31,'14:13:13',NULL,'','下载用户',1,'user:download',1,'button','','admin'),(38,'23:32:16',NULL,'','监控系统',0,'monitor:view',4,'menu','druid','admin');
/*!40000 ALTER TABLE `t_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role`
--

DROP TABLE IF EXISTS `t_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `available` bit(1) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `mark` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `creator_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_role`
--

LOCK TABLES `t_role` WRITE;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
INSERT INTO `t_role` VALUES (1,'2015-10-19 22:18:02',NULL,'','超管',NULL,'admin','guest'),(21,'2015-10-18 13:36:34',NULL,'','fg',NULL,'admin2','admin'),(25,'2015-10-28 14:36:22',NULL,'','来宾',NULL,'guest','admin');
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role_resource`
--

DROP TABLE IF EXISTS `t_role_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_role_resource` (
  `role_id` bigint(20) NOT NULL,
  `resource_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`resource_id`),
  KEY `FK_hvd3v1xf4men57mo38osb4ih1` (`resource_id`),
  CONSTRAINT `FK_hvd3v1xf4men57mo38osb4ih1` FOREIGN KEY (`resource_id`) REFERENCES `t_resource` (`id`),
  CONSTRAINT `FK_qie95ky0tnqn6cl36rd606yxo` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_role_resource`
--

LOCK TABLES `t_role_resource` WRITE;
/*!40000 ALTER TABLE `t_role_resource` DISABLE KEYS */;
INSERT INTO `t_role_resource` VALUES (1,1),(21,1),(25,1),(1,2),(21,2),(1,3),(21,3),(1,4),(21,4),(1,5),(21,5),(25,5),(1,6),(21,6),(25,6),(1,7),(21,7),(1,8),(21,8),(1,9),(21,9),(1,10),(21,10),(25,10),(1,11),(21,11),(25,11),(1,12),(21,12),(1,13),(21,13),(1,14),(21,14),(25,14),(1,15),(21,15),(1,18),(21,18),(1,19),(21,19),(1,30),(1,31),(1,38);
/*!40000 ALTER TABLE `t_role_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `locked` bit(1) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `salt` varchar(50) DEFAULT NULL,
  `user_alias` varchar(50) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `creator_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (98,'2015-10-18 13:37:12',NULL,'2015-11-17 19:40:08','\0','2015-11-19 16:27:56','bf97b99d87c941ec977cd4dc6ec945f0','9aff3745b94a4d705464bdd0e8dfb4ca','访客','guest','admin'),(100,'2015-10-19 22:27:00',NULL,'2015-11-30 21:16:41','\0','2015-11-30 21:21:55','e5e5730c57233c3a56c2b6fe9c77f3ec','d71e5418430e88094ec30d71c9a6ad04','超级管理员','admin','guest'),(101,'2015-11-29 20:21:13',NULL,NULL,'\0',NULL,'a8525bbddb233340143f298f1a739dde','5030e98c0e24ac273151410aa1e48627','zczxc','xzc','admin');
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user_role`
--

DROP TABLE IF EXISTS `t_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FK_4uvv76e86ms8ru0kk9s01d3s2` (`role_id`),
  CONSTRAINT `FK_4uvv76e86ms8ru0kk9s01d3s2` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`),
  CONSTRAINT `FK_kefwen29p9h9ilvry31mgyc94` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user_role`
--

LOCK TABLES `t_user_role` WRITE;
/*!40000 ALTER TABLE `t_user_role` DISABLE KEYS */;
INSERT INTO `t_user_role` VALUES (100,1),(98,25);
/*!40000 ALTER TABLE `t_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-30 21:47:47
