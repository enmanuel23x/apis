-- MySQL Script generated by MySQL Workbench
-- Fri Jul  3 13:07:56 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dbGestionOcupacion
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dbGestionOcupacion` ;

-- -----------------------------------------------------
-- Schema dbGestionOcupacion
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbGestionOcupacion` DEFAULT CHARACTER SET utf8 ;
USE `dbGestionOcupacion` ;

-- -----------------------------------------------------
-- Table `dbGestionOcupacion`.`client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbGestionOcupacion`.`client` ;

CREATE TABLE IF NOT EXISTS `dbGestionOcupacion`.`client` (
  `cli_id` INT(11) NOT NULL AUTO_INCREMENT,
  `cli_name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  PRIMARY KEY (`cli_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbGestionOcupacion`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbGestionOcupacion`.`user` ;

CREATE TABLE IF NOT EXISTS `dbGestionOcupacion`.`user` (
  `usr_id` INT(11) NOT NULL AUTO_INCREMENT,
  `usr_name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `usr_email` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `usr_id_trello` INT(11) NULL DEFAULT NULL,
  `usr_id_clockify` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`usr_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbGestionOcupacion`.`request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbGestionOcupacion`.`request` ;

CREATE TABLE IF NOT EXISTS `dbGestionOcupacion`.`request` (
  `req_id` INT(11) NOT NULL AUTO_INCREMENT,
  `board_id` VARCHAR(50) NULL DEFAULT NULL,
  `project_id` VARCHAR(50) NULL DEFAULT NULL,
  `task_id` VARCHAR(50) NULL DEFAULT NULL,
  `req_ms_project` TEXT NULL DEFAULT NULL,
  `cli_id` INT(11) NULL,
  `coa_id` INT(11) NULL DEFAULT NULL,
  `req_title` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `req_description` VARCHAR(1024) NULL DEFAULT NULL,
  `req_responsable` VARCHAR(45) NULL DEFAULT NULL,
  `req_order_priority` INT(11) NULL DEFAULT NULL,
  `req_date` DATE NULL DEFAULT NULL,
  `req_init_date` DATE NULL DEFAULT '9999-12-31',
  `req_final_date` DATE NULL DEFAULT '9999-12-31',
  `req_real_final_date` DATE NULL DEFAULT NULL,
  `sta_id` VARCHAR(45) NULL DEFAULT NULL,
  `req_advance_ptge` FLOAT NULL DEFAULT NULL,
  `req_deviations_ptge` FLOAT NULL DEFAULT NULL,
  `req_client_completed_deliverables` VARCHAR(1024) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `req_client_pending_activities` VARCHAR(1024) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `req_client_comments` VARCHAR(1024) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `req_intelix_completed_deliverables` VARCHAR(1024) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `req_intelix_pending_activities` VARCHAR(1024) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `req_intelix_comments` VARCHAR(1024) NULL DEFAULT NULL,
  `req_last_update_date` DATE NULL DEFAULT NULL,
  `rty_id` INT(11) NULL DEFAULT NULL,
  `tea_id` INT(11) NULL DEFAULT NULL,
  `req_comitee` INT(11) NULL DEFAULT NULL,
  `req_comitee_points_discuss` VARCHAR(1024) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `req_day_desv` INT(11) NULL DEFAULT NULL,
  `req_cargar` VARCHAR(45) CHARACTER SET 'utf8' NULL DEFAULT 'true',
  PRIMARY KEY (`req_id`),
  INDEX `cli_id_idx` (`cli_id` ASC) ,
  INDEX `coa_id` (`coa_id` ASC) ,
  INDEX `rty_id` (`rty_id` ASC) ,
  INDEX `tea_id` (`tea_id` ASC) ,
  CONSTRAINT `client_id`
    FOREIGN KEY (`cli_id`)
    REFERENCES `dbGestionOcupacion`.`client` (`cli_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbGestionOcupacion`.`booking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbGestionOcupacion`.`booking` ;

CREATE TABLE IF NOT EXISTS `dbGestionOcupacion`.`booking` (
  `boo_id` INT(11) NOT NULL AUTO_INCREMENT,
  `cli_id` INT(11) NOT NULL,
  `req_id` INT(11) NOT NULL,
  `usr_id` INT(11) NOT NULL,
  `boo_duration` INT(20) NULL DEFAULT NULL,
  `boo_start_date` DATE NOT NULL,
  `boo_end_date` DATE NOT NULL,
  `boo_percentage` FLOAT NOT NULL,
  PRIMARY KEY (`boo_id`),
  INDEX `cli_id` (`cli_id` ASC) ,
  INDEX `usr_id` (`usr_id` ASC) ,
  INDEX `req_id` (`req_id` ASC) ,
  CONSTRAINT `cli_id`
    FOREIGN KEY (`cli_id`)
    REFERENCES `dbGestionOcupacion`.`client` (`cli_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usr_id`
    FOREIGN KEY (`usr_id`)
    REFERENCES `dbGestionOcupacion`.`user` (`usr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `req_id`
    FOREIGN KEY (`req_id`)
    REFERENCES `dbGestionOcupacion`.`request` (`req_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbGestionOcupacion`.`database_reg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbGestionOcupacion`.`database_reg` ;

CREATE TABLE IF NOT EXISTS `dbGestionOcupacion`.`database_reg` (
  `reg_id` INT(11) NOT NULL AUTO_INCREMENT,
  `reg_update_time` DATETIME NOT NULL,
  PRIMARY KEY (`reg_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbGestionOcupacion`.`clockify_task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbGestionOcupacion`.`clockify_task` ;

CREATE TABLE IF NOT EXISTS `dbGestionOcupacion`.`clockify_task` (
  `clo_id` INT NOT NULL AUTO_INCREMENT,
  `clo_task_name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `clo_description` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `clo_date` DATETIME NULL DEFAULT '9999-12-31 00:00:00',
  `clo_time` TIME NULL DEFAULT NULL,
  `clo_poject_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`clo_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbGestionOcupacion`.`activities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbGestionOcupacion`.`activities` ;

CREATE TABLE IF NOT EXISTS `dbGestionOcupacion`.`activities` (
  `act_id` INT(11) NOT NULL AUTO_INCREMENT,
  `req_id` INT(11) NULL DEFAULT NULL,
  `act_trello_name` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `act_description_trello` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `act_card_id` VARCHAR(50) NULL DEFAULT NULL,
  `act_init_date` DATETIME NULL DEFAULT '9999-12-31 00:00:00',
  `act_init_real_date` DATETIME NULL DEFAULT NULL,
  `act_end_date` DATETIME NULL DEFAULT '9999-12-31 00:00:00',
  `act_real_end_date` DATETIME NULL DEFAULT NULL,
  `act_estimated_hours` FLOAT NULL DEFAULT NULL,
  `act_desv_percentage` INT(11) NULL DEFAULT NULL,
  `act_day_desv` INT(11) NULL DEFAULT NULL,
  `act_id_parent` INT(11) NULL DEFAULT NULL,
  `act_id_parent2` INT(11) NULL DEFAULT NULL,
  `act_id_prelacion` INT(11) NULL DEFAULT NULL,
  `act_id_project_task` INT(11) NULL DEFAULT NULL,
  `act_id_user_trello` VARCHAR(50) NULL DEFAULT NULL,
  `act_time_loaded` FLOAT NULL DEFAULT NULL,
  `act_status` VARCHAR(10) NOT NULL DEFAULT 'Active',
  `act_porcent` INT(11) NOT NULL DEFAULT '0',
  `act_title` VARCHAR(50) NOT NULL,
  `act_mail` VARCHAR(50) NULL DEFAULT NULL,
  `act_trello_user` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`act_id`),
  INDEX `req_id_idx` (`req_id` ASC) ,
  CONSTRAINT `request_id`
    FOREIGN KEY (`req_id`)
    REFERENCES `dbGestionOcupacion`.`request` (`req_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
