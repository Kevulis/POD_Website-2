-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema POD
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `POD` ;

-- -----------------------------------------------------
-- Schema POD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `POD` DEFAULT CHARACTER SET utf8 ;
USE `POD` ;

-- -----------------------------------------------------
-- Table `POD`.`owner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `POD`.`owner` ;

CREATE TABLE IF NOT EXISTS `POD`.`owner` (
  `email` VARCHAR(50) NOT NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NOT NULL,
  `security_question` TINYINT NOT NULL COMMENT '1 - \"What primary school did you attend?\"\n2 - \"What is the middle name of your mother?\"\n3 - \"What is the name of your pet?\"',
  `security_answer` VARCHAR(45) NOT NULL,
  `city_id` VARCHAR(45) NOT NULL,
  `region` VARCHAR(45) NULL,
  `is_active` TINYINT NOT NULL DEFAULT 1 COMMENT '0 - False\n1 - True\n',
  `create_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `POD`.`breed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `POD`.`breed` ;

CREATE TABLE IF NOT EXISTS `POD`.`breed` (
  `breed_id` INT UNSIGNED NOT NULL,
  `breed_name` VARCHAR(50) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`breed_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `POD`.`behaviour`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `POD`.`behaviour` ;

CREATE TABLE IF NOT EXISTS `POD`.`behaviour` (
  `behaviour_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `behaviour` VARCHAR(50) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`behaviour_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `POD`.`dog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `POD`.`dog` ;

CREATE TABLE IF NOT EXISTS `POD`.`dog` (
  `owner_email` VARCHAR(50) NOT NULL,
  `dog_id` INT UNSIGNED NOT NULL,
  `dog_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL COMMENT 'F - Female\nM - Male',
  `breed_id` INT UNSIGNED NOT NULL,
  `size` ENUM('S', 'M', 'L', 'XL') NOT NULL COMMENT 'S - Small\nM - Medium\nL - Large\nXL - Extra Large',
  `age_months` TINYINT NULL,
  `age_years` TINYINT NULL,
  `height` DECIMAL NULL,
  `weight` DECIMAL NULL,
  `energy_level` TINYINT NULL COMMENT '1 to 5',
  `behaviour_id` INT UNSIGNED NULL,
  `is_breeding_cycle` TINYINT NULL DEFAULT 0 COMMENT '0 - No\n1 - Yes',
  `is_avaliable_meeting` TINYINT NULL DEFAULT 0 COMMENT '0 - No\n1 - Yes',
  `description` VARCHAR(255) NULL,
  `create_time` DATETIME NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`owner_email`, `dog_id`),
  CONSTRAINT `fk_dog_breed1`
    FOREIGN KEY (`breed_id`)
    REFERENCES `POD`.`breed` (`breed_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dog_behaviour1`
    FOREIGN KEY (`behaviour_id`)
    REFERENCES `POD`.`behaviour` (`behaviour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dog_owner1`
    FOREIGN KEY (`owner_email`)
    REFERENCES `POD`.`owner` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_dog_breed_idx` ON `POD`.`dog` (`breed_id` ASC);

CREATE INDEX `fk_breed_gender_age_size` ON `POD`.`dog` (`breed_id` ASC, `gender` ASC, `age_years` ASC, `size` ASC);

CREATE INDEX `fk_dog_behaviour1_idx` ON `POD`.`dog` (`behaviour_id` ASC);

CREATE INDEX `fk_dog_owner1_idx` ON `POD`.`dog` (`owner_email` ASC);


-- -----------------------------------------------------
-- Table `POD`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `POD`.`image` ;

CREATE TABLE IF NOT EXISTS `POD`.`image` (
  `owner_email` VARCHAR(50) NOT NULL,
  `dog_id` INT UNSIGNED NOT NULL,
  `image_id` INT UNSIGNED NOT NULL,
  `file_name` VARCHAR(100) NOT NULL,
  `file_path` VARCHAR(200) NOT NULL,
  `file_type` VARCHAR(100) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`, `owner_email`, `dog_id`),
  CONSTRAINT `fk_image_dog1`
    FOREIGN KEY (`owner_email` , `dog_id`)
    REFERENCES `POD`.`dog` (`owner_email` , `dog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_image_dog1_idx` ON `POD`.`image` (`owner_email` ASC, `dog_id` ASC);


-- -----------------------------------------------------
-- Table `POD`.`interaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `POD`.`interaction` ;

CREATE TABLE IF NOT EXISTS `POD`.`interaction` (
  `interaction_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `owner_email` VARCHAR(50) NOT NULL,
  `dog_owner_email` VARCHAR(50) NOT NULL,
  `dog_dog_id` INT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`interaction_id`),
  CONSTRAINT `fk_interaction_owner1`
    FOREIGN KEY (`owner_email`)
    REFERENCES `POD`.`owner` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_interaction_dog1`
    FOREIGN KEY (`dog_owner_email` , `dog_dog_id`)
    REFERENCES `POD`.`dog` (`owner_email` , `dog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_interaction_owner1_idx` ON `POD`.`interaction` (`owner_email` ASC);

CREATE INDEX `fk_interaction_dog1_idx` ON `POD`.`interaction` (`dog_owner_email` ASC, `dog_dog_id` ASC);


-- -----------------------------------------------------
-- Table `POD`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `POD`.`message` ;

CREATE TABLE IF NOT EXISTS `POD`.`message` (
  `message_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `sender_email` VARCHAR(50) NOT NULL,
  `sender_dog_id` INT UNSIGNED NOT NULL,
  `receiver_email` VARCHAR(50) NOT NULL,
  `receiver_dog_id` INT UNSIGNED NOT NULL,
  `message` VARCHAR(255) NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  CONSTRAINT `fk_message_dog1`
    FOREIGN KEY (`sender_email` , `sender_dog_id`)
    REFERENCES `POD`.`dog` (`owner_email` , `dog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_dog2`
    FOREIGN KEY (`receiver_email` , `receiver_dog_id`)
    REFERENCES `POD`.`dog` (`owner_email` , `dog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_message_dog1_idx` ON `POD`.`message` (`sender_email` ASC, `sender_dog_id` ASC);

CREATE INDEX `fk_message_dog2_idx` ON `POD`.`message` (`receiver_email` ASC, `receiver_dog_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `POD`.`breed`
-- -----------------------------------------------------
START TRANSACTION;
USE `POD`;
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (1, 'Afador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (2, 'Affenhuahua', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (3, 'Affenpinscher', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (4, 'Afghan hound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (5, 'Airedale terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (6, 'Akbash', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (7, 'Akita', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (8, 'Akita pit', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (9, 'Alaskan kleen kai', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (10, 'Alaskan malamute', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (11, 'American bulldog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (12, 'American english coonhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (13, 'American eskimo dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (14, 'American foxhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (15, 'American leopard hound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (16, 'American piy bull terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (17, 'American pugabull', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (18, 'American staffordshire terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (19, 'American water spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (20, 'Anatolian shepherd dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (21, 'Appenzeller sennenhundle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (22, 'Auggie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (23, 'Aussiedoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (24, 'Aussiepom', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (25, 'Australian cattle dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (26, 'Australian kelpie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (27, 'Australian retrivier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (28, 'Australian shepherd', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (29, 'Australian shepherd husky', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (30, 'Australian shepherd lab mix', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (31, 'Australian shepherd pit bull mix', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (32, 'Australian terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (33, 'Azawakh', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (34, 'Barbet', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (35, 'Basenji', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (36, 'Bassador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (37, 'Basset fauve de bretagne', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (38, 'Basset hound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (39, 'Basset retriever', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (40, 'Bavarian mountain scent hound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (41, 'Beabull', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (42, 'Beagle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (43, 'Beaglier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (44, 'Bearded collie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (45, 'Bendlington terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (46, 'Belgian malinois', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (47, 'Belgian sheepdog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (48, 'Belgian tervuren', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (49, 'Berget picard', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (50, 'Bernedoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (51, 'Bernese mountain dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (52, 'Bichon frise', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (53, 'Biewer terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (54, 'Black and tan coohound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (55, 'Black mouth cur', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (56, 'Black russian terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (57, 'Bloodhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (58, 'Blue lacy', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (59, 'Bluetick coohound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (60, 'Bocker', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (61, 'Boerboel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (62, 'Boglen terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (63, 'Bolognese', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (64, 'Borador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (65, 'Border collie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (66, 'Border sheepdog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (67, 'Border terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (68, 'Borddoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (69, 'Borzoi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (70, 'Boshih', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (71, 'Bossie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (72, 'Boston boxer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (73, 'Boston terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (74, 'Bouvier des flandres', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (75, 'Boxador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (76, 'Boxer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (77, 'Boxerdoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (78, 'Boxmatian', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (79, 'Boxweiler', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (80, 'Boykin spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (81, 'Bracco iatliano', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (82, 'Braque du bourbonnais', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (83, 'Briard', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (84, 'Brittany', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (85, 'Broholmer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (86, 'Brussels griffon', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (87, 'Bugg', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (88, 'Bull-pie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (89, 'Bull terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (90, 'Bullador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (91, 'Bullboxer pit', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (92, 'Bulldog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (93, 'Bullmastiff', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (94, 'Bullamatian', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (95, 'Cairn terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (96, 'Cannan dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (97, 'Cane corso', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (98, 'Cardigan welsh corgi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (99, 'Catahoula bulldog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (100, 'Catahoula leopard dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (101, 'Caucasian shepherd dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (102, 'Cav-a jack', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (103, 'Cavachon', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (104, 'Cavador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (105, 'Cavalier king charles spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (106, 'Cavapoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (107, 'Cesky terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (108, 'Chabrador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (109, 'Cheagle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (110, 'Chesapeake bay retriver', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (111, 'Chi chi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (112, 'Chi-poo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (113, 'Chigi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (114, 'Chihuahua', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (115, 'Chilier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (116, 'Chinese crested', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (117, 'Chinese shar-pei', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (118, 'Chinook', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (119, 'Chion', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (120, 'Chipin', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (121, 'Chiweenie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (122, 'Chorkie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (123, 'Chow chow', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (124, 'Chow shepherd', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (125, 'Chug', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (126, 'Chusky', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (127, 'Cirneco dell-etna', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (128, 'Clumber spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (129, 'Cockalier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (130, 'Cockapoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (131, 'Cocker spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (132, 'Collie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (133, 'Corgi inu', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (134, 'Corgidor', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (135, 'Corman shepherd', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (136, 'Coton tulear', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (137, 'Curly-coated retriever', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (138, 'Dachasador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (139, 'Dachshund', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (140, 'Dalmatian', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (141, 'Dandie dinmont terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (142, 'Daniff', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (143, 'Deustscher wachtelhund', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (144, 'Doberdor', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (145, 'Doberman pisnscher', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (146, 'Docker', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (147, 'Dogo argentino', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (148, 'Dogue de bordeaux', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (149, 'Dorgi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (150, 'Dorkie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (151, 'Doxiepoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (152, 'Doxle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (153, 'Drentsche patrijshond', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (154, 'Drever', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (155, 'Dutch shepherd', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (156, 'English cocker spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (157, 'English foxhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (158, 'English setter', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (159, 'English springer spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (160, 'English toy spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (161, 'Entlebucher mountain dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (162, 'Estrela mountain dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (163, 'Eurasier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (164, 'Field spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (165, 'Finish lapphund', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (166, 'Finnish spitz', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (167, 'Flat-coated retriever', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (168, 'Fox terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (169, 'French bulldog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (170, 'French spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (171, 'Frenchton', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (172, 'Frengle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (173, 'German pinscher', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (174, 'Germans shepherd dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (175, 'German shepherd pit bull', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (176, 'German shorthaired pointer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (177, 'German spitz', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (178, 'German wirehaired pointer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (179, 'Giant schnauzer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (180, 'Glen of imaal terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (181, 'Goberian', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (182, 'Goldador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (183, 'Golden cocker retriever', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (184, 'Golden mountain dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (185, 'Golden retriever', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (186, 'Golden retriever corgi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (187, 'Golden shepherd', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (188, 'Goldendoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (189, 'Gollie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (190, 'Gordon setter', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (191, 'Great dane', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (192, 'Great pyreness', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (193, 'Greater swiss mountain dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (194, 'Greyador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (195, 'Greyhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (196, 'Hamiltonstovare', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (197, 'Hanoverian scenthound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (198, 'Harrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (199, 'Havanese', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (200, 'Hokkaido', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (201, 'Horgi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (202, 'Huskita', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (203, 'Huskydoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (204, 'Ibizan hound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (205, 'Icelandic sheepdog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (206, 'Irish red and white setter', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (207, 'Irish setter', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (208, 'Irish terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (209, 'Irish water spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (210, 'Irish wolfhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (211, 'Italian greyhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (212, 'Jack-a-poo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (213, 'Jack chi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (214, 'Jack russel terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (215, 'Japanese chin', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (216, 'Japanese spitz', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (217, 'Korean jindo dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (218, 'Karelian bear dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (219, 'Keeshond', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (220, 'Kerry blue terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (221, 'Komodor', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (222, 'Kooikerkondje', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (223, 'Kuvask', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (224, 'Kyi-leo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (225, 'Lab pointer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (226, 'Labernese', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (227, 'Labmaraner', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (228, 'Labrabull', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (229, 'Labradane', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (230, 'Labradoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (231, 'Labrador retriever', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (232, 'Labrastaff', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (233, 'Labsky', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (234, 'Lagotto romagnolo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (235, 'Lakeland terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (236, 'Lancashire heeler', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (237, 'Leonberger', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (238, 'Lhasa apso', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (239, 'Lhasapoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (240, 'Lowchen', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (241, 'Maltese', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (242, 'Maltese shhih tzu', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (243, 'Maltipoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (244, 'Manchester terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (245, 'Mastador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (246, 'Mastiff', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (247, 'Miniature pinscher', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (248, 'Miniature schnauzer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (249, 'Morkie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (250, 'Mudi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (251, 'Mutt', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (252, 'Neopolitan mastiff', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (253, 'Newfoundland', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (254, 'Norfolk terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (255, 'Norwegian buhund', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (256, 'Norwegian elkhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (257, 'Norwegian lundehund', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (258, 'Norwich terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (259, 'Nova scotia duck tolling retriever', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (260, 'Old english sheepdog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (261, 'Otterhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (262, 'Papillon', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (263, 'Papipoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (264, 'Peekapoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (265, 'Pekingese', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (266, 'Pembroke', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (267, 'Petit basset', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (268, 'Pharaoh hound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (269, 'Pitsky', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (270, 'Plott', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (271, 'Pocke beagle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (272, 'Pointer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (273, 'Polish lawland sheepdog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (274, 'Pomapoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (275, 'Pomchi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (276, 'Pameagle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (277, 'Pomeranian', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (278, 'Pomsky', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (279, 'Poochon', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (280, 'Poodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (281, 'Portuguese podengo pequeno', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (282, 'Portuguese water dog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (283, 'Pug', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (284, 'Pugalier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (285, 'Puggle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (286, 'Puginese', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (287, 'Puli', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (288, 'Pyrenean', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (289, 'Rat terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (290, 'Redbone coonhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (291, 'Rhodesian ridgeback', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (292, 'Rottador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (293, 'Rottle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (294, 'Rottwelier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (295, 'Saint berdoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (296, 'Saint bernard', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (297, 'Saluki', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (298, 'Samoyed', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (299, 'Samusky', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (300, 'Schipperke', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (301, 'Schnoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (302, 'Scottish deerhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (303, 'Scottish terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (304, 'Sealyham terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (305, 'Sheepadoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (306, 'Shepsky', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (307, 'Shetland sheepdog', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (308, 'Shiba inu', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (309, 'Shicon', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (310, 'Shih-poo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (311, 'Shih tzu', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (312, 'Shiranian', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (313, 'Shollie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (314, 'Shorkie', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (315, 'Siberian husky', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (316, 'Silken windhound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (317, 'Silky terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (318, 'Skye terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (319, 'Sloughi', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (320, 'Small musterlander pointer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (321, 'Soft coated wheaten terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (322, 'Spanish mastiff', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (323, 'Spinone italiano', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (324, 'Springador', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (325, 'Stabyhoun', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (326, 'Staffordshire bull terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (327, 'Standard schnauzer', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (328, 'Sussex spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (329, 'Swedish vallhund', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (330, 'Teripoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (331, 'Texas heeler', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (332, 'Tibetan mastiff', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (333, 'Tibetan spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (334, 'Tibetan terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (335, 'Toy fox terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (336, 'Treening tennessee', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (337, 'Treening walker coohound', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (338, 'Valley vizsla', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (339, 'Weimaraner', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (340, 'Welsh springer spaniel', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (341, 'Welsh terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (342, 'West highland white terrier', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (343, 'Westiepoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (344, 'Whippet', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (345, 'Whoodle', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (346, 'Wireharied pointing griffon', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (347, 'Xoloitzcuintli', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (348, 'Yorkipoo', DEFAULT);
INSERT INTO `POD`.`breed` (`breed_id`, `breed_name`, `last_update`) VALUES (349, 'Yorshire terrier', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `POD`.`behaviour`
-- -----------------------------------------------------
START TRANSACTION;
USE `POD`;
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'friendly', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'digging', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'chasing', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'excessive barking', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'chewing', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'jumping up', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'bitting', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'begging', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'running away', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'food stealing', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'leash pulling', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'eliminating inside', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'leash aggression', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'aggressive', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'happy', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'grumpy', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'alert', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'submissive', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'bad breath', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'circling', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'poop eater', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'lazy', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'loyal', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'pacient', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'inteligent', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'adventurous', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'silly', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'docile', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'cheered up', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'independent', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'fearless', DEFAULT);
INSERT INTO `POD`.`behaviour` (`behaviour_id`, `behaviour`, `last_update`) VALUES (DEFAULT, 'full of energy', DEFAULT);

COMMIT;

