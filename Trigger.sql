USE `mydb` ;
delimiter $$

-- INSERT NAS TABELAS AUX QUANDO INSERIDO HARDWARE

CREATE TRIGGER  CpuAfterInsert AFTER INSERT ON CPU
for each row 
BEGIN
DECLARE i,n INT;
SELECT COUNT(*) FROM JOGO INTO n;
SET i=0;
WHILE i<n DO 

	IF ((Select CpuMin From JOGO LIMIT i,1) <= New.Rating )
      THEN INSERT INTO Cpu_Jogo SELECT NEW.Id, Jogo.Id FROM Jogo LIMIT i,1;
    END IF;
    
  SET i = i + 1;
END WHILE;
end;$$


CREATE TRIGGER  GpuAfterInsert AFTER INSERT ON GPU
for each row 
BEGIN
DECLARE i,n INT;
SELECT COUNT(*) FROM JOGO INTO n;
SET i=0;
WHILE i<n DO 

	IF ((Select GpuMin From JOGO LIMIT i,1) <= New.Rating )
      THEN INSERT INTO Gpu_Jogo SELECT NEW.Id, Jogo.Id FROM Jogo LIMIT i,1;
    END IF;
    
    SET i = i + 1;
END WHILE;
end;$$


CREATE TRIGGER  RamAfterInsert AFTER INSERT ON RAM
for each row 
BEGIN
DECLARE i,n INT;
SELECT COUNT(*) FROM JOGO INTO n;
SET i=0;
WHILE i<n DO 
	IF ((Select RamMin From JOGO LIMIT i,1) <= New.Capacidade )
      THEN INSERT INTO Ram_Jogo SELECT NEW.Id, Jogo.Id FROM Jogo LIMIT i,1;
    END IF;
  
  SET i = i + 1;
END WHILE;
end;$$





-- INSERT NAS TABELAS AUX QUANDO INSERIDO JOGO

delimiter $$

CREATE TRIGGER JogoAfterInsert1 AFTER INSERT ON Jogo
for each row 
BEGIN
DECLARE i,n INT;
SELECT COUNT(*) FROM CPU INTO n;
SET i=0;
WHILE i<n DO 
	IF ((Select Rating From CPU LIMIT i,1) >= New.CpuMin)
		THEN INSERT INTO Cpu_Jogo SELECT Cpu.Id, NEW.Id  FROM CPU LIMIT i,1;
	END IF;
  SET i = i + 1;
END WHILE;
end;$$



CREATE TRIGGER JogoAfterInsert2 AFTER INSERT ON Jogo
for each row 
BEGIN
DECLARE i,n INT;
SELECT COUNT(*) FROM GPU INTO n;
SET i=0;
WHILE i<n DO 
  IF ((Select Rating From GPU LIMIT i,1) >= New.GpuMin)
		THEN INSERT INTO Gpu_Jogo SELECT Gpu.Id, NEW.Id  FROM GPU LIMIT i,1;
	END IF;
  SET i = i + 1;
END WHILE;
end;$$



CREATE TRIGGER JogoAfterInsert3 AFTER INSERT ON Jogo
for each row 
BEGIN
DECLARE i,n INT;
SELECT COUNT(*) FROM RAM INTO n;
SET i=0;
WHILE i<n DO 
	IF ((Select Capacidade From RAM LIMIT i,1) >= New.RamMin)
		THEN INSERT INTO Ram_Jogo SELECT Ram.Id, NEW.Id  FROM Ram LIMIT i,1;
	END IF;
  SET i = i + 1;
END WHILE;
end;$$



-- DELETE NAS TABELAS AUX E CONFIG QUANDO APAGADO HARDWARE

CREATE TRIGGER CpuBeforeDelete  BEFORE DELETE ON CPU
  FOR EACH ROW     
BEGIN
  DELETE FROM Cpu_Jogo where Cpu_Jogo.Cpu_Id = OLD.Id;
  DELETE FROM Configuracao where Configuracao.Cpu_Id = OLD.Id ;
END$$



CREATE TRIGGER GpuBeforeDelete  BEFORE DELETE ON GPU
  FOR EACH ROW     
BEGIN
  DELETE FROM Gpu_Jogo where Gpu_Jogo.Gpu_Id = OLD.Id;
  DELETE FROM Configuracao where Configuracao.Gpu_Id = OLD.Id ;
END$$


CREATE TRIGGER RamBeforeDelete  BEFORE DELETE ON RAM
  FOR EACH ROW     
BEGIN
  DELETE FROM Ram_Jogo where Ram_Jogo.Ram_Id = OLD.Id;
  DELETE FROM Configuracao where Configuracao.Ram_Id = OLD.Id ;
END$$

-- DELETE NAS TABELAS AUX E CONFIG QUANDO APAGADO JOGO

CREATE TRIGGER JogoBeforeDelete  BEFORE DELETE ON Jogo
  FOR EACH ROW     
BEGIN
  DELETE FROM Ram_Jogo where Ram_Jogo.Jogo_Id = OLD.Id;
  DELETE FROM Cpu_Jogo where Cpu_Jogo.Jogo_Id = OLD.Id;
  DELETE FROM Gpu_Jogo where Gpu_Jogo.Jogo_Id = OLD.Id;
END$$
