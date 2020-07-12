use `mydb`;

SET GLOBAL log_bin_trust_function_creators = 1;





INSERT INTO Cpu (iD, Modelo, Marca, Ano, Rating, Velocidade)    -- https://www.cpubenchmark.net/high_end_cpus.html
	VALUES
		(1, 'Core i5-7600K', 'Intel', 2017, 9129, 3.8),
        (2, 'Core i7-7700K', 'Intel', 2017, 12040, 4.2),
        (3, 'Core i5-6600', 'Intel', 2016, 7760, 3.3),
        (4, 'Ryzen Threadripper 1950X','AMD',2017, 22078, 4),
        (5, 'Ryzen 5 2600X', 'AMD', 2018, 14358, 3.6),
        (6, 'Intel Core i5-3570K @ 3.40GHz', 'Intel', 2012, 7170, 3.4)
        
		;
        
        
INSERT INTO Gpu (iD, Nome, Marca, Ano, Rating, Velocidade, VRAM)  -- https://www.videocardbenchmark.net/high_end_gpus.html
	VALUES 
		(1, 'GeForce RTX 2080 Ti', 'Nvidea', 2018, 17058, 1.35, 11), 		
        (2, 'GeForce GTX 1060', 'Nvidea', 2016, 9022, 1.70, 6),
        (3, 'GeForce GTX 1070', 'Nvidea', 2016, 11224, 1.56, 8),
        (4, 'Radeon Pro Vega 64', 'AMD', 2018, 10426, 1.35 , 16),
        (5, 'GeForce GTX 980M', 'Nvidea', 2014, 5904, 1.03, 4)
        ;
        
INSERT INTO Ram (Id, Nome, Marca, Ano, Capacidade, Velocidade)
	VALUES
		(1, 'GSkill F4-3600C19-8GSXF', 'G Skill ', 2018, 16, 2.5),
        (2, 'Corsair CMD16GX4M2B3600C18', 'Corsair', 2015, 8, 2.3),
        (3, 'Kingston 9932301-P01.A00G', 'Kingston ', 2018, 4, 1.9 )
        ;
        
INSERT INTO User (Id, Nome)
	VALUES
		(1, 'João Manuel'),
        (2, 'Alvaro Miranda'),
        (3, 'Feranando Pessoa'),
        (4, 'Bill Portões'),
        (5, 'Steve Trabalhos')
        ;

INSERT INTO Jogo (Id, Nome, Ano, Desenvolvedora, CpuMin, CpuRec, GpuMin, GpuRec, RamMin, Ramrec)
VALUES
		(1,'Fortnite', 2017, 'Epic Games', 6000 ,8000 ,4000 ,6000, 4, 6),
        (2,'COD Battle Royale', 2018, 'Activision', 7000, 8500, 6000, 7000, 6, 8),
        (3,'CSGO', 2014, 'Valve', 4000, 5000, 2500, 3500, 4, 6),
        (4,'PUBg', 2016, 'Bluehole', 8600, 9000, 6500, 8000, 6, 8)
        ;
        

INSERT INTO Configuracao (Id, Nome, Data, Gpu_Id, Cpu_Id, Ram_id, User_Id)
VALUES
		(1, 'Pc da Sala', '2017-12-12', 1, 2, 2, 2),
        (2, 'Portatil', '2016-05-02', 5, 6, 3, 2)
        ;
        
        
        
        
