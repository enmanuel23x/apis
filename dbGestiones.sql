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
CREATE DATABASE IF NOT EXISTS `dbgestionocupacion` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dbgestionocupacion`;

-- Volcando estructura para tabla dbgestionocupacion.activities
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

-- Volcando datos para la tabla dbgestionocupacion.activities: ~24 rows (aproximadamente)
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
REPLACE INTO `activities` (`act_id`, `req_id`, `act_trello_name`, `act_description_trello`, `act_card_id`, `act_init_date`, `act_init_real_date`, `act_end_date`, `act_real_end_date`, `act_estimated_hours`, `act_desv_percentage`, `act_day_desv`, `act_id_parent`, `act_id_parent2`, `act_id_prelacion`, `act_id_project_task`, `act_id_user_trello`, `act_time_loaded`, `act_status`, `act_porcent`, `act_title`, `act_mail`, `act_trello_user`, `act_card_end`) VALUES
	(217, 1, 'LOG-MA15-Modelo de Existencia y Disponibilidad', NULL, NULL, '2020-06-01 08:00:00', NULL, '2020-06-26 12:00:00', NULL, 240, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'true', '', '', 0),
	(218, 1, 'Inicio solicitud', NULL, '5f33deeb8af7887c41a9d068', '2020-06-01 08:00:00', NULL, '2020-06-05 17:00:00', NULL, 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(219, 1, 'Existencia Propia y Proveedor', NULL, NULL, '2020-06-08 08:00:00', NULL, '2020-06-12 12:00:00', NULL, 68, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'true', '', '', 0),
	(220, 1, 'Implementación de Ajustes de entrada y salida proveedor', NULL, '5f33deecb0f606691172cf5f', '2020-06-08 08:00:00', NULL, '2020-06-10 17:00:00', NULL, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'true', '', '', 0),
	(221, 1, 'Creación de nuevos tipos de ajuste', NULL, '5f33deec9f3b8e42d051c5ce', '2020-06-08 08:00:00', NULL, '2020-06-08 17:00:00', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(222, 1, 'Validación y completación para los nuevos tipos de ajuste', NULL, '5f33deea12b7f30f92ce5d7f', '2020-06-09 08:00:00', NULL, '2020-06-10 17:00:00', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(223, 1, 'Modificación en réplica de Ajuste para llevar data a LEGACY', NULL, '5f33deeb4713348772a2b67e', '2020-06-08 08:00:00', '2020-08-01 16:00:00', '2020-06-09 12:00:00', '2020-08-09 16:00:00', 12, 38, 62, NULL, NULL, NULL, NULL, NULL, 16.6, 'Active', 67, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(224, 1, 'Implementación de ventas propias y proveedor', NULL, NULL, '2020-06-09 13:00:00', NULL, '2020-06-10 17:00:00', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'true', '', '', 0),
	(225, 1, 'Ventas propias', NULL, '5f33deeca6b9ba8cb21b2a42', '2020-06-09 13:00:00', NULL, '2020-06-10 10:00:00', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(226, 1, 'Ventas proveedor', NULL, '5f33deec72b3fa1e3306e17f', '2020-06-10 10:00:00', NULL, '2020-06-10 17:00:00', NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(227, 1, 'Implementación de Ajustes de entrada y salida proveedor', NULL, '5f33deecb0f606691172cf5f', '2020-06-11 08:00:00', NULL, '2020-06-11 17:00:00', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(228, 1, 'Implementación de réplica que calcule y almacene las unidades necesarias para la Existencia propia y proveedor en la nueva tabla', NULL, '5f33deedeea9ab8fa2426b81', '2020-06-11 08:00:00', NULL, '2020-06-12 12:00:00', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', '', 'angel_narvaez', 0),
	(229, 1, 'Disponibilidad Propia', NULL, NULL, '2020-06-12 08:00:00', NULL, '2020-06-18 12:00:00', NULL, 64, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'true', '', '', 0),
	(230, 1, 'Implementación de Fórmula de Existencia propia', NULL, '5f33deeb61c92078dbc22906', '2020-06-12 08:00:00', '2020-08-01 16:00:00', '2020-06-15 17:00:00', '2020-08-15 16:00:00', 16, 9, 61, NULL, NULL, NULL, NULL, NULL, 17.5167, 'Active', 50, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(231, 1, 'Implementación de Fórmula de Mercancia en cuarentena propia', NULL, '5f33deed576dcb3b283f2f08', '2020-06-12 13:00:00', NULL, '2020-06-16 12:00:00', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(232, 1, 'Implementación de Fórmula de Mercancia en cuarentena propia', NULL, '5f33deed576dcb3b283f2f08', '2020-06-16 08:00:00', NULL, '2020-06-17 17:00:00', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(233, 1, 'Implementación de Función de Disponibilidad Propia', NULL, '5f33deeba5e80833774bc821', '2020-06-16 13:00:00', NULL, '2020-06-18 12:00:00', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(234, 1, 'Disponibilidad Proveedor', NULL, NULL, '2020-06-18 08:00:00', NULL, '2020-06-25 12:00:00', NULL, 60, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'true', '', '', 0),
	(235, 1, 'Implementación de Fórmula de Existencia proveedor2', NULL, '5f33deea1072683c6d0f3752', '2020-06-18 08:00:00', NULL, '2020-06-19 12:00:00', NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(236, 1, 'Implementación de Fórmula de Mercancia en cuarentena proveedor', NULL, '5f33deece5c82a69886218d9', '2020-06-18 13:00:00', NULL, '2020-06-22 12:00:00', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(237, 1, 'Implementación de Fórmula de Ventas proveedor en tránsito', NULL, '5f33deebc90084482f24fcaa', '2020-06-19 13:00:00', NULL, '2020-06-23 12:00:00', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(238, 1, 'Implementación de Función de Disponibilidad Proveedor', NULL, '5f33deebbd74592219935098', '2020-06-22 13:00:00', NULL, '2020-06-25 12:00:00', NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0),
	(239, 1, 'Disponibilidad Total', NULL, NULL, '2020-06-25 13:00:00', NULL, '2020-06-26 12:00:00', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'true', '', '', 0),
	(240, 1, 'Implementación de Función de Disponibilidad Total', NULL, '5f33deec156c2e54cbf06228', '2020-06-25 13:00:00', NULL, '2020-06-26 12:00:00', NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'Active', 0, 'false', 'anarvaez@intelix.biz', 'angel_narvaez', 0);
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.booking
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
CREATE TABLE IF NOT EXISTS `database_reg` (
  `reg_id` int(11) NOT NULL AUTO_INCREMENT,
  `reg_update_time` datetime NOT NULL,
  PRIMARY KEY (`reg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla dbgestionocupacion.database_reg: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `database_reg` DISABLE KEYS */;
/*!40000 ALTER TABLE `database_reg` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.label_trello
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

-- Volcando datos para la tabla dbgestionocupacion.label_trello: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `label_trello` DISABLE KEYS */;
REPLACE INTO `label_trello` (`lab_id`, `lab_0_or_2`, `lab_2_or_5`, `lab_5_or_more`, `branch_id`) VALUES
	(8, '5f33e4a9109cce1887b6ef4e', '5f33e4a9e228913ae08889d9', '5f33e4a97ade2a8fa98f3831', 11);
/*!40000 ALTER TABLE `label_trello` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.request
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
	(1, '5f33ddbc4e9bd90ed2e02bf1', NULL, NULL, 'LOG-MA15-Modelo de Existencia y Disponibilidad.mpp', 1, NULL, 'Modelo Existencia y Disponibilidad', 'Modelo Existencia y Disponibilidad', NULL, NULL, '2020-01-01', '2020-01-01', '2020-07-01', '2020-07-03', 'open', NULL, 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'true');
/*!40000 ALTER TABLE `request` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.tickets
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

-- Volcando datos para la tabla dbgestionocupacion.tickets: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
REPLACE INTO `tickets` (`tic_id`, `tic_title`, `tic_description`, `tic_branch`, `tic_subsidiary`, `tic_deparment`, `tic_usr_ci`, `tic_category`, `tic_priority`, `tic_assigned_to`, `tic_date`, `tic_last_update_date`, `tic_sol_date`, `tic_closing_date`, `tic_clockify_time`, `tic_sla`, `tic_card_id`, `tic_card_status`) VALUES
	(1911030006, 'Venezuela  Dif.Vtas02/10/2019-02/11/2019 - 509298', '&lt;pre&gt; FERRETERIA EPA, C.A.                 Venezuela                                               Pagina..:         1 RIF:                                                                                         Fecha...:   3/11/19 CONTROL/SVINV127                           Diferencias de Archivos de Ventas del 02/10/2019 al 02/11/2019                                                Tienda menos Central------------------------------------------------------------------------------------------------    Fecha      Tda           Ventas Netas                  Impuesto                Archivos Comparados------------------------------------------------------------------------------------------------------------------JU 24/10/2019  004                  17.025,00-                  2.724,01- TRANSA-DETALLE VS. TRCMOV-TRDMOVMA 22/10/2019  004                  29.875,00-                  4.780,00- TRANSA-DETALLE VS. TRCMOV-TRDMOVLU 21/10/2019  004                  46.900,00                   7.504,01  TRANSA-DETALLE VS. TRCMOV-TRDMOV------------------------------------------------------------------------------------------------------------------              ************************ FIN DEL REPORTE ************************&lt;/pre&gt;', 'EPA', 'EPAVE', 'OF/01', '9823764', 'Aplicaciones > Facturacion', 'High', 'Llovera Padron, Gerson Luis ( INT-VE-277 )', '2019-11-03', '2019-11-11', '2019-11-06', '2019-11-11', '00:00:00', NULL, NULL, 'false'),
	(1911030007, 'Usuarios', '&lt;div dir="ltr"&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;Buenos días&lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt; &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;La presente es para informar que Gustavo Torres de tienda Capuy trabajo hasta el dia viernes 01 de noviembre, por lo que solicitamos cancelen su cuenta de correo. &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt; &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;A su vez solicito creación de usuario en &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;Abstracta La Trinidad &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;Mariana Castillo- Gerente de ventas &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt; &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;Abstracta LM&lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;Claudia Otero - Subgerente &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt; &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;BoConcept LM&lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;Rossana Campo - gerente de tienda&lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt; &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;BoConcept Casa Mall&lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;Liliana López - gerente de tienda&lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt; &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt; &lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt;Saludos,&lt;/div&gt;&lt;div class="gmail_default" style="font-family: verdana,sans-serif; font-size: small;"&gt; &lt;/div&gt;&lt;div&gt;&lt;div class="gmail_signature" dir="ltr" data-smartmail="gmail_signature"&gt;&lt;div dir="ltr"&gt;&lt;div&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div dir="ltr"&gt;&lt;div style="font-family: tahoma,sans-serif;"&gt;&lt;span style="color: #444444; font-size: small; font-family: arial, helvetica, sans-serif;"&gt;&lt;strong&gt;Ana Sanz&lt;/strong&gt;&lt;/span&gt;&lt;/div&gt;&lt;div&gt;&lt;span style="font-size: small; color: #666666; font-family: arial, helvetica, sans-serif;"&gt;Jefe de Ventas&lt;/span&gt;&lt;/div&gt;&lt;div&gt;&lt;span style="font-size: small; color: #666666; font-family: arial, helvetica, sans-serif;"&gt;Abstracta - BoConcept - Capuy&lt;/span&gt;&lt;/div&gt;&lt;div style="font-size: 12.8px;"&gt;&lt;div style="font-size: 12.8px;"&gt;&lt;div style="font-size: 12.8px;"&gt;&lt;span style="font-size: 12.8px;"&gt;&lt;span style="color: #666666; font-family: arial, helvetica, sans-serif;"&gt;+58 212-526.67.72&lt;/span&gt;&lt;/span&gt;&lt;/div&gt;&lt;div style="font-size: 12.8px;"&gt;&lt;span style="font-size: 12.8px;"&gt;&lt;span style="color: #666666; font-family: arial, helvetica, sans-serif;"&gt;+58 414-293.88.95&lt;/span&gt;&lt;/span&gt;&lt;/div&gt;&lt;div style="font-size: 12.8px;"&gt;&lt;span style="color: #999999; font-family: arial, helvetica, sans-serif;"&gt;&lt;strong&gt;&lt;a style="color: #1155cc;" href="http://www.beco.com.ve/" target="_blank" rel="noopener"&gt;www.becocompania.com.ve&lt;/a&gt; &lt;/strong&gt;&lt;/span&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;div dir="ltr"&gt;&lt;p style="font-size: 12.8px;"&gt;&lt;img src="https://drive.google.com/a/capuy.com/uc?id=19OsxnkgmLYV3i6-2x7HzlEflTGe8hMqG&amp;export=download" alt="image" /&gt;&lt;br /&gt;&lt;br /&gt;&lt;/p&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;&lt;/div&gt;', 'Ramo Mayoreo', 'Ramo Moda', 'Abstracta', '18760371', 'Aplicaciones > Usuarios', 'Medium', 'Torres Galarraga, Pedro Elías ( INT-VE-53 )', '2020-09-10', '2019-11-11', '2019-11-06', '2019-11-11', '50:00:59', NULL, '5f33e4a9d042154c160659da', 'false');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;

-- Volcando estructura para tabla dbgestionocupacion.user
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
