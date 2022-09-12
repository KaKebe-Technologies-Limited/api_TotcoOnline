-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema rgxszumy_totco
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rgxszumy_totco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rgxszumy_totco` DEFAULT CHARACTER SET utf8 ;
USE `rgxszumy_totco` ;

-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `firstname` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(225) NULL,
  `sex` VARCHAR(10) NULL,
  `date_of_birth` DATE NULL,
  `phone_number` VARCHAR(15) NULL,
  `email` VARCHAR(35) NULL,
  `profile_photo` VARCHAR(100) NULL,
  `description_Bio` TEXT NULL,
  `location` VARCHAR(45) NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `isAgent` TINYINT NULL DEFAULT 0,
  `isStaff` TINYINT NULL DEFAULT 0,
  `isAdmin` TINYINT NULL DEFAULT 0,
  `isSystemAdmin` TINYINT NULL DEFAULT 0,
  `isBranchManager` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_sales_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_sales_order` (
  `sales_order_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `createdBy` INT NOT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `isApproved` TINYINT NULL DEFAULT 0,
  `approvedBy` INT NULL,
  PRIMARY KEY (`sales_order_id`),
  INDEX `fk_tbl_sales_order_tbl_user_idx` (`createdBy` ASC),
  INDEX `fk_tbl_sales_order_tbl_user1_idx` (`approvedBy` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `pdt_name` VARCHAR(45) NULL,
  `isAvailable` TINYINT NULL DEFAULT 0,
  `available_quantity` INT NULL,
  `pdt_units` VARCHAR(45) NULL,
  `unit_price` INT NULL,
  `added_by` VARCHAR(45) NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `createdBy` INT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_tbl_product_tbl_user1_idx` (`createdBy` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_order_vs_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_order_vs_product` (
  `order_vs_pdt_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `sales_order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NULL,
  `selling_price` INT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_vs_pdt_id`, `sales_order_id`, `product_id`),
  INDEX `fk_tbl_sales_order_has_tbl_product_tbl_product1_idx` (`product_id` ASC),
  INDEX `fk_tbl_sales_order_has_tbl_product_tbl_sales_order1_idx` (`sales_order_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_cash_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_cash_request` (
  `cash_request_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `sales_order_id` INT NOT NULL,
  `amount_requested` INT NULL,
  `payment_deadline_requested` DATE NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cash_request_id`),
  INDEX `fk_tbl_cash_request_tbl_sales_order1_idx` (`sales_order_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_farm_input_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_farm_input_request` (
  `input_request_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `request_made_by` INT NOT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `isApproved` TINYINT NULL DEFAULT 0,
  `approvedBy` INT NULL,
  `total_cost` INT NULL,
  `amount_paid` INT NULL,
  PRIMARY KEY (`input_request_id`),
  INDEX `fk_tbl_farm_input_request_tbl_user1_idx` (`request_made_by` ASC),
  INDEX `fk_tbl_farm_input_request_tbl_user2_idx` (`approvedBy` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_farm_inputs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_farm_inputs` (
  `farm_input_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `farm_input_name` VARCHAR(45) NULL,
  `addedBy` INT NULL,
  `isAvailable` TINYINT NULL DEFAULT 0,
  `quantity-available` INT NULL,
  `units` VARCHAR(45) NULL,
  `unit_price` INT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`farm_input_id`),
  INDEX `fk_tbl_farm_inputs_tbl_user1_idx` (`addedBy` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_farm_input_vs_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_farm_input_vs_request` (
  `input_vs_request_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `farm_input_id` INT NOT NULL,
  `input_request_id` INT NOT NULL,
  `quantity` INT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`input_vs_request_id`, `farm_input_id`, `input_request_id`),
  INDEX `fk_tbl_farm_inputs_has_tbl_farm_input_request_tbl_farm_inpu_idx` (`input_request_id` ASC),
  INDEX `fk_tbl_farm_inputs_has_tbl_farm_input_request_tbl_farm_inpu_idx1` (`farm_input_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_branch` (
  `branch_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `branch_name` VARCHAR(45) NULL,
  `location` VARCHAR(100) NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`branch_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_branch_vs_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_branch_vs_user` (
  `branch_vs_user_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `branch_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`branch_vs_user_id`, `branch_id`, `user_id`),
  INDEX `fk_tbl_branch_has_tbl_user_tbl_user1_idx` (`user_id` ASC),
  INDEX `fk_tbl_branch_has_tbl_user_tbl_branch1_idx` (`branch_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_delivery_note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_delivery_note` (
  `delivery_note_id` INT NOT NULL,
  `uuid` VARCHAR(45) NULL,
  `sales_order_id` INT NOT NULL,
  `vehicle_details` TEXT NULL,
  `driver_name` VARCHAR(100) NULL,
  `driver_extra_details` TEXT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `branch_id` INT NULL,
  PRIMARY KEY (`delivery_note_id`),
  INDEX `fk_tbl_delivery_note_tbl_branch1_idx` (`branch_id` ASC),
  INDEX `fk_tbl_delivery_note_tbl_sales_order1_idx` (`sales_order_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_received_note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_received_note` (
  `received_note_id` INT NOT NULL AUTO_INCREMENT,
  `delivery_note_id` INT NOT NULL,
  `uuid` VARCHAR(45) NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`received_note_id`),
  INDEX `fk_tbl_received_note_tbl_delivery_note1_idx` (`delivery_note_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_txt_message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_txt_message` (
  `msg_id` INT NOT NULL,
  `sender_id` INT NOT NULL,
  `message` TEXT NULL,
  `isReply` TINYINT NULL DEFAULT 0,
  `replyTo` VARCHAR(45) NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `isSent` TINYINT NULL DEFAULT 0,
  `isReceived` TINYINT NULL DEFAULT 0,
  `sendToOne` TINYINT NULL DEFAULT 0,
  `sendToGroup` TINYINT NULL DEFAULT 0,
  `isForwarded` TINYINT NULL,
  PRIMARY KEY (`msg_id`),
  INDEX `fk_tbl_txt_message_tbl_user1_idx` (`sender_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_message_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_message_type` (
  `msgType_id` INT NOT NULL AUTO_INCREMENT,
  `message_type` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`msgType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_msg_vs_msgType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_msg_vs_msgType` (
  `tbl_id` INT NOT NULL AUTO_INCREMENT,
  `msg_id` INT NOT NULL,
  `msgType_id` INT NOT NULL,
  PRIMARY KEY (`tbl_id`, `msg_id`, `msgType_id`),
  INDEX `fk_tbl_txt_message_has_tbl_message_type_tbl_message_type1_idx` (`msgType_id` ASC),
  INDEX `fk_tbl_txt_message_has_tbl_message_type_tbl_txt_message1_idx` (`msg_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_chat_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_chat_group` (
  `group_id` INT NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(45) NULL,
  `group_name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `group_admin` VARCHAR(45) NULL,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_sendTo_receiver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_sendTo_receiver` (
  `sendTo_id` INT NOT NULL AUTO_INCREMENT,
  `msg_id` INT NULL,
  `receiver_id` INT NULL,
  `group_id` INT NULL,
  `sales_order_id` INT NULL,
  `time_received` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `isReceived` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`sendTo_id`),
  INDEX `fk_tbl_sendTo_receiver_tbl_user1_idx` (`receiver_id` ASC),
  INDEX `fk_tbl_sendTo_receiver_tbl_txt_message1_idx` (`msg_id` ASC),
  INDEX `fk_tbl_sendTo_receiver_tbl_chat_group1_idx` (`group_id` ASC),
  INDEX `fk_tbl_sendTo_receiver_tbl_sales_order1_idx` (`sales_order_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rgxszumy_totco`.`tbl_group_members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rgxszumy_totco`.`tbl_group_members` (
  `group_members_id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NULL,
  `user_id` INT NULL,
  `isAdmin` TINYINT NULL DEFAULT 0,
  `createdAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_members_id`),
  INDEX `fk_tbl_group_members_tbl_chat_group1_idx` (`group_id` ASC),
  INDEX `fk_tbl_group_members_tbl_user1_idx` (`user_id` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
