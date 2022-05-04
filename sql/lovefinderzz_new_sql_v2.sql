
-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Lovefinderzz
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Lovefinderzz
-- -----------------------------------------------------
-- CREATE SCHEMA IF NOT EXISTS `Lovefinderzz` DEFAULT CHARACTER SET utf8 ;
-- USE `Lovefinderzz` ;

-- -----------------------------------------------------
-- Table `Lovefinderzz`.`user`
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS user (
  `id` INTEGER NOT NULL CONSTRAINT 'user_pk' PRIMARY KEY AUTOINCREMENT ,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL);


-- -----------------------------------------------------
-- Table `Lovefinderzz`.`type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `type` (
  `id` INTEGER NOT NULL CONSTRAINT 'type_pk' PRIMARY KEY AUTOINCREMENT,
  `name` VARCHAR(45) NOT NULL);


-- -----------------------------------------------------
-- Table `Lovefinderzz`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tags` (
  `id` INTEGER NOT NULL CONSTRAINT 'tags_pk' PRIMARY KEY AUTOINCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `tagscol` VARCHAR(45) NULL);


-- -----------------------------------------------------
-- Table `Lovefinderzz`.`place`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `place` (
  `id` INTEGER NOT NULL CONSTRAINT 'place_pk' PRIMARY KEY AUTOINCREMENT,
  `type_id` INTEGER NOT NULL,
  'season_start' DATETIME DEFAULT NULL,
  'season_end' DATETIME DEFAULT NULL,
  `name` VARCHAR(45) NOT NULL,
  `width` DOUBLE NOT NULL,
  `height` DOUBLE NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `plz` VARCHAR(45) NOT NULL,
  `opening_time` TIME(0) NULL,
  `closing_time` TIME(0) NULL,
  `link` VARCHAR(45) NULL,
  `description` TEXT(100) NULL,
  'created_by' INTEGER NOT NULL DEFAULT 1, -- 1 soll der admin user sein oder wir legen dummy an
--   INDEX `fk_place_type_idx` (`type_id` ASC),
    CONSTRAINT `fk_place_type`
        FOREIGN KEY (`type_id`)
        REFERENCES `type` (`id`)
        ON DELETE NO ACTION -- default type??
        ON UPDATE CASCADE ,
    CONSTRAINT 'fk_place_user'
        FOREIGN KEY ('created_by')
        REFERENCES 'user' ('id')
        ON DELETE SET DEFAULT
        ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table `Lovefinderzz`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comments` (
  `id` INTEGER NOT NULL CONSTRAINT 'comments_pk' PRIMARY KEY AUTOINCREMENT,
  `user_id` INTEGER NOT NULL,
  `place_id` INTEGER NOT NULL,
  `comment` TEXT(100) NOT NULL,
--   INDEX `fk_comments_user1_idx` (`user_id` ASC),
--   INDEX `fk_comments_place1_idx` (`place_id` ASC),
  CONSTRAINT `fk_comments_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE ,
  CONSTRAINT `fk_comments_place`
    FOREIGN KEY (`place_id`)
    REFERENCES `place` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Lovefinderzz`.`place_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `place_has_tags` (
  `place_id` INTEGER NOT NULL,
  `tags_id` INTEGER NOT NULL,
  PRIMARY KEY (`place_id`, `tags_id`),
--   INDEX `fk_place_has_tags_tags1_idx` (`tags_id` ASC),
--   INDEX `fk_place_has_tags_place1_idx` (`place_id` ASC),
  CONSTRAINT `fk_place_has_tags_place`
    FOREIGN KEY (`place_id`)
    REFERENCES `place` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_place_has_tags_tags`
    FOREIGN KEY (`tags_id`)
    REFERENCES `tags` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
