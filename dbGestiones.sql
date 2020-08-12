-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para dbgestionocupacion
DROP DATABASE IF EXISTS `dbgestionocupacion`;
CREATE DATABASE IF NOT EXISTS `dbgestionocupacion` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dbgestionocupacion`;

-- Volcando estructura para tabla dbgestionocupacion.activities
DROP TABLE IF EXISTS `activities`;
CREATE TABLE IF NOT EXISTS `activities` (
  `act_id` int(11) NOT NULL AUTO_INCREMENT,
  `req_id` int(11) DEFAULT NULL,
  `act_trello_name` varchar(200) DEFAULT NULL,
  `act_description_trello` varchar(200) DEFAULT NULL,
  `act_card_id` varchar(50) DEFAULT NULL,
  `act_init_date` datetime DEFAULT '9999-12-31 00:00:00',
  `act_init_real_date` datetime DEFAULT NULL,
  `act_end_date` datetime DEFAULT '9999-12-31 00:00:00',
  `act_real_end_date` datetime DEFAULT NULL,
  `act_estimated_hours` float DEFAULT NULL,
  `act_desv_percentage` int(11) DEFAULT NULL,
  `act_day_desv` int(11) DEFAULT NULL,
  `act_id_parent` int(11) DEFAULT NULL,
  `act_id_parent2` int(11) DEFAULT NULL,
  `act_id_prelacion` int(11) DEFAULT NULL,
  `act_id_project_task` int(11) DEFAULT NULL,
  `act_id_user_trello` varchar(50) DEFAULT NULL,
  `act_time_loaded` float DEFAULT NULL,
  `act_status` varchar(10) NOT NULL DEFAULT 'Active',
  `act_porcent` int(11) NOT NULL DEFAULT '0',
  `act_title` varchar(50) NOT NULL,
  `act_mail` varchar(50) DEFAULT NULL,
  `act_trello_user` varchar(50) NOT NULL,
  `act_card_end` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`act_id`),
  KEY `req_id_idx` (`req_id`),
  CONSTRAINT `request_id` FOREIGN KEY (`req_id`) REFERENCES `request` (`req_id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.activities: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.booking
DROP TABLE IF EXISTS `booking`;
CREATE TABLE IF NOT EXISTS `booking` (
  `boo_id` int(11) NOT NULL AUTO_INCREMENT,
  `cli_id` int(11) NOT NULL,
  `req_id` int(11) NOT NULL,
  `usr_id` int(11) NOT NULL,
  `boo_duration` int(20) DEFAULT NULL,
  `boo_start_date` date NOT NULL,
  `boo_end_date` date NOT NULL,
  `boo_percentage` float NOT NULL,
  PRIMARY KEY (`boo_id`),
  KEY `cli_id` (`cli_id`),
  KEY `usr_id` (`usr_id`),
  KEY `req_id` (`req_id`),
  CONSTRAINT `cli_id` FOREIGN KEY (`cli_id`) REFERENCES `client` (`cli_id`),
  CONSTRAINT `req_id` FOREIGN KEY (`req_id`) REFERENCES `request` (`req_id`),
  CONSTRAINT `usr_id` FOREIGN KEY (`usr_id`) REFERENCES `user` (`usr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.booking: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.branch
DROP TABLE IF EXISTS `branch`;
CREATE TABLE IF NOT EXISTS `branch` (
  `ram_id` int(11) NOT NULL AUTO_INCREMENT,
  `ram_name` varchar(45) DEFAULT NULL,
  `board_id` varchar(50) DEFAULT NULL,
  `list_id` varchar(50) DEFAULT NULL,
  `board_custom_create` char(1) DEFAULT '0',
  PRIMARY KEY (`ram_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.branch: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
REPLACE INTO `branch` (`ram_id`, `ram_name`, `board_id`, `list_id`, `board_custom_create`) VALUES
	(1, 'Principal', NULL, NULL, '0'),
	(2, 'Ramo Moda', NULL, NULL, '0'),
	(3, 'Beco', NULL, NULL, '0'),
	(4, 'Abstracta', NULL, NULL, '0'),
	(5, 'Amand', NULL, NULL, '0'),
	(6, 'Ramo Inmobiliario', NULL, NULL, '0'),
	(7, 'Ramo Logistico', NULL, NULL, '0'),
	(8, 'Beconsult', NULL, NULL, '0'),
	(9, 'EPA', NULL, NULL, '0'),
	(10, 'Ramo Automotriz', NULL, NULL, '0'),
	(11, 'Ramo Mayoreo', '5f314b5550c4671f9feea361', '5f314b720f493c0d2f174e39', '1'),
	(12, 'Intelix', NULL, NULL, '0');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.client
DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `cli_id` int(11) NOT NULL AUTO_INCREMENT,
  `cli_name` varchar(45) NOT NULL,
  PRIMARY KEY (`cli_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.client: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
REPLACE INTO `client` (`cli_id`, `cli_name`) VALUES
	(1, 'Mayoreo');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.clockify_task
DROP TABLE IF EXISTS `clockify_task`;
CREATE TABLE IF NOT EXISTS `clockify_task` (
  `clo_id` int(11) NOT NULL AUTO_INCREMENT,
  `clo_task_name` varchar(45) DEFAULT NULL,
  `clo_description` varchar(200) DEFAULT NULL,
  `clo_date` datetime DEFAULT '9999-12-31 00:00:00',
  `clo_time` time DEFAULT NULL,
  `clo_poject_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`clo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.clockify_task: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `clockify_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `clockify_task` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.database_reg
DROP TABLE IF EXISTS `database_reg`;
CREATE TABLE IF NOT EXISTS `database_reg` (
  `reg_id` int(11) NOT NULL AUTO_INCREMENT,
  `reg_update_time` datetime NOT NULL,
  PRIMARY KEY (`reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.database_reg: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `database_reg` DISABLE KEYS */;
/*!40000 ALTER TABLE `database_reg` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.label_trello
DROP TABLE IF EXISTS `label_trello`;
CREATE TABLE IF NOT EXISTS `label_trello` (
  `lab_id` int(11) NOT NULL AUTO_INCREMENT,
  `lab_0_or_2` varchar(45) DEFAULT NULL,
  `lab_2_or_5` varchar(45) DEFAULT NULL,
  `lab_5_or_more` varchar(45) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`lab_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `branch_id` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`ram_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.label_trello: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `label_trello` DISABLE KEYS */;
REPLACE INTO `label_trello` (`lab_id`, `lab_0_or_2`, `lab_2_or_5`, `lab_5_or_more`, `branch_id`) VALUES
	(8, '5f33e4a9109cce1887b6ef4e', '5f33e4a9e228913ae08889d9', '5f33e4a97ade2a8fa98f3831', 11),
	(9, '5f34235feaf27875ee347e3a', '5f34235f1571d3193d1bb366', '5f3423605af587432c580500', 1);
/*!40000 ALTER TABLE `label_trello` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.request
DROP TABLE IF EXISTS `request`;
CREATE TABLE IF NOT EXISTS `request` (
  `req_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_id` varchar(50) DEFAULT NULL,
  `project_id` varchar(50) DEFAULT NULL,
  `task_id` varchar(50) DEFAULT NULL,
  `req_ms_project` text,
  `cli_id` int(11) DEFAULT NULL,
  `coa_id` int(11) DEFAULT NULL,
  `req_title` varchar(200) DEFAULT NULL,
  `req_description` varchar(1024) DEFAULT NULL,
  `req_responsable` varchar(45) DEFAULT NULL,
  `req_order_priority` int(11) DEFAULT NULL,
  `req_date` date DEFAULT NULL,
  `req_init_date` date DEFAULT '9999-12-31',
  `req_final_date` date DEFAULT '9999-12-31',
  `req_real_final_date` date DEFAULT NULL,
  `sta_id` varchar(45) DEFAULT NULL,
  `req_advance_ptge` float DEFAULT NULL,
  `req_deviations_ptge` float DEFAULT NULL,
  `req_client_completed_deliverables` varchar(1024) DEFAULT NULL,
  `req_client_pending_activities` varchar(1024) DEFAULT NULL,
  `req_client_comments` varchar(1024) DEFAULT NULL,
  `req_intelix_completed_deliverables` varchar(1024) DEFAULT NULL,
  `req_intelix_pending_activities` varchar(1024) DEFAULT NULL,
  `req_intelix_comments` varchar(1024) DEFAULT NULL,
  `req_last_update_date` date DEFAULT NULL,
  `rty_id` int(11) DEFAULT NULL,
  `tea_id` int(11) DEFAULT NULL,
  `req_comitee` int(11) DEFAULT NULL,
  `req_comitee_points_discuss` varchar(1024) DEFAULT NULL,
  `req_day_desv` int(11) DEFAULT NULL,
  `req_cargar` varchar(45) DEFAULT 'true',
  PRIMARY KEY (`req_id`),
  KEY `cli_id_idx` (`cli_id`),
  KEY `coa_id` (`coa_id`),
  KEY `rty_id` (`rty_id`),
  KEY `tea_id` (`tea_id`),
  CONSTRAINT `client_id` FOREIGN KEY (`cli_id`) REFERENCES `client` (`cli_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.request: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
REPLACE INTO `request` (`req_id`, `board_id`, `project_id`, `task_id`, `req_ms_project`, `cli_id`, `coa_id`, `req_title`, `req_description`, `req_responsable`, `req_order_priority`, `req_date`, `req_init_date`, `req_final_date`, `req_real_final_date`, `sta_id`, `req_advance_ptge`, `req_deviations_ptge`, `req_client_completed_deliverables`, `req_client_pending_activities`, `req_client_comments`, `req_intelix_completed_deliverables`, `req_intelix_pending_activities`, `req_intelix_comments`, `req_last_update_date`, `rty_id`, `tea_id`, `req_comitee`, `req_comitee_points_discuss`, `req_day_desv`, `req_cargar`) VALUES
	(1, NULL, NULL, NULL, 'LOG-MA15-Modelo de Existencia y Disponibilidad.mpp', 1, NULL, 'Modelo Existencia y Disponibilidad', 'Modelo Existencia y Disponibilidad', NULL, NULL, '2020-01-01', '2020-01-01', '2020-07-01', '2020-07-03', 'open', NULL, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'true');
/*!40000 ALTER TABLE `request` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.tickets
DROP TABLE IF EXISTS `tickets`;
CREATE TABLE IF NOT EXISTS `tickets` (
  `tic_id` int(11) NOT NULL AUTO_INCREMENT,
  `tic_title` varchar(200) DEFAULT NULL,
  `tic_description` mediumtext,
  `tic_branch` varchar(45) DEFAULT NULL,
  `tic_subsidiary` varchar(45) DEFAULT NULL,
  `tic_deparment` varchar(45) DEFAULT NULL,
  `tic_usr_ci` varchar(20) DEFAULT NULL,
  `tic_category` varchar(255) DEFAULT NULL,
  `tic_priority` varchar(15) DEFAULT NULL,
  `tic_assigned_to` varchar(255) DEFAULT NULL,
  `tic_date` date DEFAULT NULL,
  `tic_last_update_date` date DEFAULT NULL,
  `tic_sol_date` date DEFAULT NULL,
  `tic_closing_date` date DEFAULT NULL,
  `tic_clockify_time` varchar(15) DEFAULT '0',
  `tic_sla` int(11) DEFAULT NULL,
  `tic_card_id` varchar(45) DEFAULT NULL,
  `tic_card_status` varchar(15) DEFAULT 'false',
  PRIMARY KEY (`tic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1911030008 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.tickets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `usr_id` int(11) NOT NULL AUTO_INCREMENT,
  `usr_name` varchar(45) DEFAULT NULL,
  `usr_email` varchar(45) DEFAULT NULL,
  `usr_ci` varchar(20) DEFAULT NULL,
  `usr_id_trello` int(11) DEFAULT NULL,
  `usr_id_clockify` int(11) DEFAULT NULL,
  PRIMARY KEY (`usr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.user: ~26 rows (aproximadamente)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
REPLACE INTO `user` (`usr_id`, `usr_name`, `usr_email`, `usr_ci`, `usr_id_trello`, `usr_id_clockify`) VALUES
	(1, 'Enmanuel Leon', 'eleon@intelix.biz', '18760371', NULL, NULL),
	(2, 'Alejandro Sanchez', 'asanchezb@intelix.biz', '14407921', NULL, NULL),
	(3, 'Alejandro Gonzalez', 'agonzalez@intelix.biz', NULL, NULL, NULL),
	(4, 'Angel Narvaez', 'anarvaez@intelix.biz', NULL, NULL, NULL),
	(5, 'Ramon Vielma', 'rvielma94@gmail.com', NULL, NULL, NULL),
	(6, 'Juan Rodriguez', 'juanchojjrc@gmail.com', NULL, NULL, NULL),
	(7, 'Enmanuel Leon', 'eleon@intelix.biz', NULL, NULL, NULL),
	(10, 'David De Freitas', 'ddefreitas@intelix.biz', '22416787', NULL, NULL),
	(11, 'David Hernandez', 'dhernandez@intelix.biz', '19698356', NULL, NULL),
	(12, 'Daniel Sierra', 'dsierra@intelix.biz', '9677258', NULL, NULL),
	(13, 'Francisco Ruiz', 'fruiz@intelix.biz', '7090002', NULL, NULL),
	(14, 'Franck Gutierrez', 'fgutierrez@intelix.biz', '13381535', NULL, NULL),
	(15, 'Freddy Rodríguez', 'frodriguez@intelix.biz', '20382020', NULL, NULL),
	(16, 'Gabriel Alvarez', 'galvarez@intelix.biz', '20513462', NULL, NULL),
	(17, 'Humberto Paez', 'hpaez@intelix.biz', '18748033', NULL, NULL),
	(18, 'Victor Tortolero', 'vtortolero@intelix.biz', '19856860', NULL, NULL),
	(19, 'Johan Gonzalez', 'jgonzalez@intelix.biz', '20108631', NULL, NULL),
	(20, 'Luis Arvelo', 'larvelo@intelix.biz', '18344592', NULL, NULL),
	(21, 'Luisangelica Velásquez', 'lvelasquez@intelix.biz', '20292880', NULL, NULL),
	(22, 'Mariely Fernandez', 'mfernandez@intelix.biz', '20181083', NULL, NULL),
	(23, 'Moisés Mendoza', 'mmendoza@intelix.biz', '23426105', NULL, NULL),
	(24, 'Oswaldo Lucena', 'olucena@intelix.biz', '20029825', NULL, NULL),
	(25, 'Williams León', 'wleon@intelix.biz', '12145275', NULL, NULL),
	(26, 'Willians Vasquez', 'wvasquez@intelix.biz', '18531264', NULL, NULL),
	(27, 'Yhovanny Quintero', 'yquintero@intelix.biz', '15107515', NULL, NULL),
	(28, 'Yaimaru Salas', 'yquintero@intelix.biz', '25107171', NULL, NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
