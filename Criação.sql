-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `Id` INT UNSIGNED NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CPU`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CPU` (
  `Id` INT UNSIGNED NOT NULL,
  `Modelo` VARCHAR(45) NULL,
  `Marca` VARCHAR(45) NULL,
  `Ano` INT UNSIGNED NULL,
  `Rating` INT UNSIGNED NOT NULL,
  `Velocidade` DECIMAL(4,2) UNSIGNED NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RAM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RAM` (
  `Id` INT UNSIGNED NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Marca` VARCHAR(45) NULL,
  `Ano` INT UNSIGNED NULL,
  `Capacidade` INT UNSIGNED NOT NULL,
  `Velocidade` DECIMAL(4,2) UNSIGNED NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`GPU`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GPU` (
  `Id` INT UNSIGNED NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Marca` VARCHAR(45) NULL,
  `Ano` INT UNSIGNED NULL,
  `Rating` INT UNSIGNED NOT NULL,
  `Velocidade` DECIMAL(4,2) UNSIGNED NULL,
  `VRAM` INT UNSIGNED NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Configuracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Configuracao` (
  `id` INT UNSIGNED NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Data` DATE NOT NULL,
  `CPU_Id` INT UNSIGNED NOT NULL,
  `RAM_Id` INT UNSIGNED NOT NULL,
  `GPU_Id` INT UNSIGNED NOT NULL,
  `User_Id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Configuracao_CPU1_idx` (`CPU_Id` ASC) VISIBLE,
  INDEX `fk_Configuracao_RAM1_idx` (`RAM_Id` ASC) VISIBLE,
  INDEX `fk_Configuracao_GPU1_idx` (`GPU_Id` ASC) VISIBLE,
  INDEX `fk_Configuracao_User1_idx` (`User_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Configuracao_CPU1`
    FOREIGN KEY (`CPU_Id`)
    REFERENCES `mydb`.`CPU` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Configuracao_RAM1`
    FOREIGN KEY (`RAM_Id`)
    REFERENCES `mydb`.`RAM` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Configuracao_GPU1`
    FOREIGN KEY (`GPU_Id`)
    REFERENCES `mydb`.`GPU` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Configuracao_User1`
    FOREIGN KEY (`User_Id`)
    REFERENCES `mydb`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jogo` (
  `Id` INT UNSIGNED NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Ano` INT UNSIGNED NULL,
  `Desenvolvedora` VARCHAR(45) NULL,
  `CpuMin` INT UNSIGNED NOT NULL,
  `CpuRec` INT UNSIGNED NOT NULL,
  `GpuMin` INT UNSIGNED NOT NULL,
  `GpuRec` INT UNSIGNED NOT NULL,
  `RamMin` INT UNSIGNED NOT NULL,
  `RamRec` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CPU_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CPU_Jogo` (
  `CPU_Id` INT UNSIGNED NOT NULL,
  `Jogo_Id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`CPU_Id`, `Jogo_Id`),
  INDEX `fk_CPU_has_Jogo_Jogo1_idx` (`Jogo_Id` ASC) VISIBLE,
  INDEX `fk_CPU_has_Jogo_CPU1_idx` (`CPU_Id` ASC) VISIBLE,
  CONSTRAINT `fk_CPU_has_Jogo_CPU1`
    FOREIGN KEY (`CPU_Id`)
    REFERENCES `mydb`.`CPU` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CPU_has_Jogo_Jogo1`
    FOREIGN KEY (`Jogo_Id`)
    REFERENCES `mydb`.`Jogo` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RAM_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RAM_Jogo` (
  `RAM_Id` INT UNSIGNED NOT NULL,
  `Jogo_Id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`RAM_Id`, `Jogo_Id`),
  INDEX `fk_RAM_has_Jogo_Jogo1_idx` (`Jogo_Id` ASC) VISIBLE,
  INDEX `fk_RAM_has_Jogo_RAM1_idx` (`RAM_Id` ASC) VISIBLE,
  CONSTRAINT `fk_RAM_has_Jogo_RAM1`
    FOREIGN KEY (`RAM_Id`)
    REFERENCES `mydb`.`RAM` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RAM_has_Jogo_Jogo1`
    FOREIGN KEY (`Jogo_Id`)
    REFERENCES `mydb`.`Jogo` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`GPU_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GPU_Jogo` (
  `GPU_Id` INT UNSIGNED NOT NULL,
  `Jogo_Id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`GPU_Id`, `Jogo_Id`),
  INDEX `fk_GPU_has_Jogo_Jogo1_idx` (`Jogo_Id` ASC) VISIBLE,
  INDEX `fk_GPU_has_Jogo_GPU1_idx` (`GPU_Id` ASC) VISIBLE,
  CONSTRAINT `fk_GPU_has_Jogo_GPU1`
    FOREIGN KEY (`GPU_Id`)
    REFERENCES `mydb`.`GPU` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GPU_has_Jogo_Jogo1`
    FOREIGN KEY (`Jogo_Id`)
    REFERENCES `mydb`.`Jogo` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
