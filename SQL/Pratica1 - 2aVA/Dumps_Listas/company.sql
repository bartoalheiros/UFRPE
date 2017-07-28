CREATE DATABASE  IF NOT EXISTS `company` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `company`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: 127.0.0.1    Database: company
-- ------------------------------------------------------
-- Server version	5.7.18-log

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
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `dname` varchar(25) NOT NULL,
  `dnumber` int(4) NOT NULL,
  `mgrssn` char(9) NOT NULL,
  `mgrstartdate` date DEFAULT NULL,
  PRIMARY KEY (`dnumber`),
  KEY `dname` (`dname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('Headquarters',1,'888665555','1971-06-19'),('Administration',4,'987654321','1985-01-01'),('Research',5,'333445555','1978-05-22'),('Software',6,'111111100','1999-05-15'),('Hardware',7,'444444400','1998-05-15'),('Sales',8,'555555500','1997-01-01');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependent`
--

DROP TABLE IF EXISTS `dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependent` (
  `essn` char(9) NOT NULL,
  `dependent_name` varchar(15) NOT NULL,
  `sex` char(1) DEFAULT NULL,
  `bdate` date DEFAULT NULL,
  `relationship` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`essn`,`dependent_name`),
  CONSTRAINT `FK_EMP_DEP` FOREIGN KEY (`essn`) REFERENCES `employee` (`ssn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES ('123456789','Alice','F','1978-12-31','Daughter'),('123456789','Elizabeth','F','0000-00-00','Spouse'),('123456789','Michael','M','1978-01-01','Son'),('333445555','Alice','F','1976-04-05','Daughter'),('333445555','Joy','F','1948-05-03','Spouse'),('333445555','Theodore','M','1973-10-25','Son'),('444444400','Johnny','M','1997-04-04','Son'),('444444400','Tommy','M','1999-06-07','Son'),('444444401','Chris','M','1969-04-19','Spouse'),('444444402','Sam','M','1964-02-14','Spouse'),('987654321','Abner','M','1932-02-29','Spouse');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_locations`
--

DROP TABLE IF EXISTS `dept_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_locations` (
  `dnumber` int(4) NOT NULL,
  `dlocation` varchar(15) NOT NULL,
  PRIMARY KEY (`dnumber`,`dlocation`),
  CONSTRAINT `dept_locations_ibfk_1` FOREIGN KEY (`dnumber`) REFERENCES `department` (`dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_locations`
--

LOCK TABLES `dept_locations` WRITE;
/*!40000 ALTER TABLE `dept_locations` DISABLE KEYS */;
INSERT INTO `dept_locations` VALUES (1,'Houston'),(4,'Stafford'),(5,'Bellaire'),(5,'Houston'),(5,'Sugarland'),(6,'Atlanta'),(6,'Sacramento'),(7,'Milwaukee'),(8,'Chicago'),(8,'Dallas'),(8,'Miami'),(8,'Philladephia'),(8,'Seattle');
/*!40000 ALTER TABLE `dept_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_sal`
--

DROP TABLE IF EXISTS `dept_sal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_sal` (
  `dnumber` int(4) NOT NULL,
  `totalsalary` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_sal`
--

LOCK TABLES `dept_sal` WRITE;
/*!40000 ALTER TABLE `dept_sal` DISABLE KEYS */;
INSERT INTO `dept_sal` VALUES (4,93000),(7,634500),(1,55000),(5,133000),(8,571500),(6,480000);
/*!40000 ALTER TABLE `dept_sal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `fname` varchar(15) NOT NULL,
  `minit` varchar(1) DEFAULT NULL,
  `lname` varchar(15) NOT NULL,
  `ssn` char(9) NOT NULL,
  `bdate` date DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `sex` enum('M','F') DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `superssn` char(9) DEFAULT NULL,
  `dno` int(4) DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `superssn` (`superssn`),
  KEY `FK_EMP_DEPTO` (`dno`),
  CONSTRAINT `FK_EMP_DEPTO` FOREIGN KEY (`dno`) REFERENCES `department` (`dnumber`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`superssn`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('Jared','D','James','111111100','1966-10-10','123 Peachtree, Atlanta, GA','M',85000.00,'null',6),('Jon','C','Jones','111111101','1967-11-14','111 Allgood, Atlanta, GA','M',45000.00,'111111100',6),('Justin','n','Mark','111111102','1966-01-12','2342 May, Atlanta, GA','M',40000.00,'111111100',6),('Brad','C','Knight','111111103','1968-02-13','176 Main St., Atlanta, GA','M',44000.00,'111111100',6),('John','B','Smith','123456789','1955-01-09','731 Fondren, Houston, TX','M',30000.00,'333445555',5),('Evan','E','Wallis','222222200','1958-01-16','134 Pelham, Milwaukee, WI','M',92000.00,'null',7),('Josh','U','Zell','222222201','1954-05-22','266 McGrady, Milwaukee, WI','M',56000.00,'222222200',7),('Andy','C','Vile','222222202','1944-06-21','1967 Jordan, Milwaukee, WI','M',53000.00,'222222200',7),('Tom','G','Brand','222222203','1966-12-16','112 Third St, Milwaukee, WI','M',62500.00,'222222200',7),('Jenny','F','Vos','222222204','1967-11-11','263 Mayberry, Milwaukee, WI','F',61000.00,'222222201',7),('Chris','A','Carter','222222205','1960-03-21','565 Jordan, Milwaukee, WI','F',43000.00,'222222201',7),('Kim','C','Grace','333333300','1970-10-23','6677 Mills Ave, Sacramento, CA','F',79000.00,'null',6),('Jeff','H','Chase','333333301','1970-01-07','145 Bradbury, Sacramento, CA','M',44000.00,'333333300',6),('Franklin','T','Wong','333445555','1945-12-08','638 Voss, Houston, TX','M',40000.00,'888665555',5),('Alex','D','Freed','444444400','1950-10-09','4333 Pillsbury, Milwaukee, WI','M',89000.00,'null',7),('Bonnie','S','Bays','444444401','1956-06-19','111 Hollow, Milwaukee, WI','F',70000.00,'444444400',7),('Alec','C','Best','444444402','1966-06-18','233 Solid, Milwaukee, WI','M',60000.00,'444444400',7),('Sam','S','Snedden','444444403','1977-07-31','987 Windy St, Milwaukee, WI','M',48000.00,'444444400',7),('Joyce','A','English','453453453','1962-07-31','5631 Rice, Houston, TX','F',25000.00,'333445555',5),('John','C','James','555555500','1975-06-30','7676 Bloomington, Sacramento, CA','M',81000.00,'null',6),('Nandita','K','Ball','555555501','1969-04-16','222 Howard, Sacramento, CA','M',62000.00,'555555500',6),('Bob','B','Bender','666666600','1968-04-17','8794 Garfield, Chicago, IL','M',96000.00,'null',8),('Jill','J','Jarvis','666666601','1966-01-14','6234 Lincoln, Chicago, IL','F',36000.00,'666666600',8),('Kate','W','King','666666602','1966-04-16','1976 Boone Trace, Chicago, IL','F',44000.00,'666666600',8),('Lyle','G','Leslie','666666603','1963-06-09','417 Hancock Ave, Chicago, IL','M',41000.00,'666666601',8),('Billie','J','King','666666604','1960-01-01','556 Washington, Chicago, IL','F',38000.00,'666666603',8),('Jon','A','Kramer','666666605','1964-08-22','1988 Windy Creek, Seattle, WA','M',41500.00,'666666603',8),('Ray','H','King','666666606','1949-08-16','213 Delk Road, Seattle, WA','M',44500.00,'666666604',8),('Gerald','D','Small','666666607','1962-05-15','122 Ball Street, Dallas, TX','M',29000.00,'666666602',8),('Arnold','A','Head','666666608','1967-05-19','233 Spring St, Dallas, TX','M',33000.00,'666666602',8),('Helga','C','Pataki','666666609','1969-03-11','101 Holyoke St, Dallas, TX','F',32000.00,'666666602',8),('Naveen','B','Drew','666666610','1970-05-23','198 Elm St, Philadelphia, PA','M',34000.00,'666666607',8),('Carl','E','Reedy','666666611','1977-06-21','213 Ball St, Philadelphia, PA','M',32000.00,'666666610',8),('Sammy','G','Hall','666666612','1970-01-11','433 Main Street, Miami, FL','M',37000.00,'666666611',8),('Red','A','Bacher','666666613','1980-05-21','196 Elm Street, Miami, FL','M',33500.00,'666666612',8),('Ramesh','K','Narayan','666884444','1952-09-15','971 Fire Oak, Humble, TX','M',38000.00,'333445555',5),('James','E','Borg','888665555','1927-11-10','450 Stone, Houston, TX','M',55000.00,'null',1),('Jennifer','S','Wallace','987654321','1931-06-20','291 Berry, Bellaire, TX','F',43000.00,'888665555',4),('Ahmad','V','Jabbar','987987987','1959-03-29','980 Dallas, Houston, TX','M',25000.00,'987654321',4),('Alicia','J','Zelaya','999887777','1958-07-19','3321 Castle, Spring, TX','F',25000.00,'987654321',4);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `pname` varchar(25) NOT NULL,
  `pnumber` int(4) NOT NULL,
  `plocation` varchar(15) DEFAULT NULL,
  `dnum` int(4) NOT NULL,
  PRIMARY KEY (`pnumber`),
  UNIQUE KEY `pname` (`pname`),
  KEY `dnum` (`dnum`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`dnum`) REFERENCES `department` (`dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('ProductX',1,'Bellaire',5),('ProductY',2,'Sugarland',5),('ProductZ',3,'Houston',5),('Computerization',10,'Stafford',4),('Reorganization',20,'Houston',1),('Newbenefits',30,'Stafford',4),('OperatingSystems',61,'Jacksonville',6),('DatabaseSystems',62,'Birmingham',6),('Middleware',63,'Jackson',6),('InkjetPrinters',91,'Phoenix',7),('LaserPrinters',92,'LasVegas',7);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `works_on` (
  `essn` char(9) NOT NULL,
  `pno` int(4) NOT NULL,
  `hours` decimal(4,1) DEFAULT NULL,
  PRIMARY KEY (`essn`,`pno`),
  KEY `pno` (`pno`),
  CONSTRAINT `works_on_ibfk_1` FOREIGN KEY (`essn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `works_on_ibfk_2` FOREIGN KEY (`pno`) REFERENCES `project` (`pnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
INSERT INTO `works_on` VALUES ('111111100',61,40.0),('111111101',61,40.0),('111111102',61,40.0),('111111103',61,40.0),('123456789',1,32.5),('123456789',2,7.5),('222222200',62,40.0),('222222201',62,48.0),('222222202',62,40.0),('222222203',62,40.0),('222222204',62,40.0),('222222205',62,40.0),('333333300',63,40.0),('333333301',63,46.0),('333445555',2,10.0),('333445555',3,10.0),('333445555',10,10.0),('333445555',20,10.0),('444444400',91,40.0),('444444401',91,40.0),('444444402',91,40.0),('444444403',91,40.0),('453453453',1,20.0),('453453453',2,20.0),('555555500',92,40.0),('555555501',92,44.0),('666666601',91,40.0),('666666603',91,40.0),('666666604',91,40.0),('666666605',92,40.0),('666666606',91,40.0),('666666607',61,40.0),('666666608',62,40.0),('666666609',63,40.0),('666666610',61,40.0),('666666611',61,40.0),('666666612',61,40.0),('666666613',61,30.0),('666666613',62,10.0),('666666613',63,10.0),('666884444',3,40.0),('888665555',20,0.0),('987654321',20,15.0),('987654321',30,20.0),('987987987',10,35.0),('987987987',30,5.0),('999887777',10,10.0),('999887777',30,30.0);
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-28 13:42:31
