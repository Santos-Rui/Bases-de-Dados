USE `mydb` ;
delimiter $$


CREATE FUNCTION ConsegueCorrer (configX INT, jogoX Int) -- DIZ SE CORRE E SE AO MIN OU REC
RETURNS VARCHAR(25)
BEGIN 

		DECLARE res VARCHAR(20) ;
        set res = 'Nao corre';
        

		SELECT CASE 
        
			WHEN (Jogo.CpuRec <= Cpu.Rating || Jogo.RamRec <= Ram.Capacidade || Jogo.GpuRec <= Gpu.Rating)  THEN 'Corre Recomendado'
			WHEN (Jogo.CpuRec > Cpu.Rating || Jogo.RamRec > Ram.Capacidade || Jogo.GpuRec > Gpu.Rating)     THEN 'Corre apenas Minimo'
			ELSE 0
		END
            
        INTO res FROM Configuracao

		INNER JOIN CPU ON Configuracao.CPU_id = Cpu.Id
        INNER JOIN GPU ON Configuracao.GPU_id = Gpu.Id
        INNER JOIN RAM ON Configuracao.RAM_id = Ram.Id
        
		INNER JOIN CPU_Jogo ON Cpu.Id = Cpu_Jogo.CPU_Id
        INNER JOIN GPU_Jogo ON GPU.Id = Gpu_Jogo.GPU_Id
        INNER JOIN RAM_Jogo on RAM.Id = Ram_Jogo.Ram_Id
        
        INNER JOIN Jogo ON CPU_Jogo.Jogo_Id = Jogo.Id && Ram_Jogo.Jogo_Id = Jogo.Id && Gpu_Jogo.Jogo_Id = Jogo.Id
   
		WHERE (Configuracao.Id = ConfigX && Jogo.Id=jogoX);
        
        RETURN res;
	
END$$

CREATE FUNCTION OQueNaoCorre (configX INT, jogoX Int) -- DIZ O QUE NAO CORRE
RETURNS varchar(25)
BEGIN 

		DECLARE res VARCHAR(25) ;
        set res = 'Gpu Ram e Cpu todos insuficientes';
        
        
		SELECT CASE 
        
			WHEN (Jogo.CpuMin <= Cpu.Rating && Jogo.RamMin <= Ram.Capacidade && Jogo.GpuMin > Gpu.Rating)  THEN 'Gpu Insuficiente'
            WHEN (Jogo.CpuMin <= Cpu.Rating && Jogo.RamMin > Ram.Capacidade && Jogo.GpuMin > Gpu.Rating)  THEN 'Gpu e Ram Insuficiente'
			WHEN (Jogo.CpuMin > Cpu.Rating && Jogo.RamMin <= Ram.Capacidade && Jogo.GpuMin > Gpu.Rating)  THEN 'Gpu e Cpu Insuficiente'
            
			WHEN (Jogo.CpuMin > Cpu.Rating && Jogo.RamMin <= Ram.Capacidade && Jogo.GpuMin <= Gpu.Rating)  THEN 'Cpu Insuficiente'
            WHEN (Jogo.CpuMin > Cpu.Rating && Jogo.RamMin > Ram.Capacidade && Jogo.GpuMin <= Gpu.Rating)  THEN 'Cpu e Ram Insuficiente'
            
            WHEN (Jogo.CpuMin <= Cpu.Rating && Jogo.RamMin > Ram.Capacidade && Jogo.GpuMin <= Gpu.Rating)  THEN 'Ram Insuficiente'
            
            WHEN (Jogo.CpuMin <= Cpu.Rating && Jogo.RamMin <= Ram.Capacidade && Jogo.GpuMin <= Gpu.Rating)  THEN 'Tudo Corre'
            
		END
            
        INTO res FROM Configuracao

		INNER JOIN CPU ON Configuracao.CPU_id = Cpu.Id
        INNER JOIN GPU ON Configuracao.GPU_id = Gpu.Id
        INNER JOIN RAM ON Configuracao.RAM_id = Ram.Id
        
		INNER JOIN CPU_Jogo ON Cpu.Id = Cpu_Jogo.CPU_Id
        INNER JOIN GPU_Jogo ON GPU.Id = Gpu_Jogo.GPU_Id
        INNER JOIN RAM_Jogo on RAM.Id = Ram_Jogo.Ram_Id
        
        RIGHT JOIN Jogo ON CPU_Jogo.Jogo_Id = Jogo.Id -- || Ram_Jogo.Jogo_Id = Jogo.Id || Gpu_Jogo.Jogo_Id = Jogo.Id
   
		WHERE (Configuracao.Id = ConfigX && Jogo.Id=jogoX)
        Group by Configuracao.Nome;
        
        RETURN res;
END$$



CREATE PROCEDURE  QuaisCorre (IN configX INT) -- MOSTRA TODOS OS JOGOS QUE CORREM NUMA CONFIG
BEGIN 

SELECT Jogo.Nome FROM Configuracao


		INNER JOIN CPU ON Configuracao.CPU_id = Cpu.Id
        INNER JOIN GPU ON Configuracao.GPU_id = Gpu.Id
        INNER JOIN RAM ON Configuracao.RAM_id = Ram.Id
        
		INNER JOIN CPU_Jogo ON Cpu.Id = Cpu_Jogo.CPU_Id
        INNER JOIN GPU_Jogo ON GPU.Id = Gpu_Jogo.GPU_Id
        INNER JOIN RAM_Jogo on RAM.Id = Ram_Jogo.Ram_Id
        
        INNER JOIN Jogo ON CPU_Jogo.Jogo_Id = Jogo.Id && Ram_Jogo.Jogo_Id = Jogo.Id && Gpu_Jogo.Jogo_Id = Jogo.Id

		Where Configuracao.Id = ConfigX;

END$$



CREATE PROCEDURE  GpuQueCorre (IN JogoX INT) -- MOSTRA TODOS OS GPUS QUE CORREM UM JOGO
BEGIN 

		SELECT Gpu.Nome FROM Jogo
		INNER JOIN GPU_Jogo ON Gpu_Jogo.Jogo_Id = Jogo.Id
        INNER JOIN GPU ON Gpu_Jogo.GPU_id = Gpu.Id
		
        WHERE Jogo.Id = JogoX;

END$$


CREATE PROCEDURE  CpuQueCorre (IN JogoX INT) -- MOSTRA TODOS OS CPUS QUE CORREM UM JOGO
BEGIN 

		SELECT Cpu.Modelo FROM Jogo
		INNER JOIN CPU_Jogo ON Cpu_Jogo.Jogo_Id = Jogo.Id
        INNER JOIN CPU ON Cpu_Jogo.CPU_id = Cpu.Id
		
        WHERE Jogo.Id = JogoX;

END$$


CREATE PROCEDURE  RamQueCorre (IN JogoX INT) -- MOSTRA TODOS OS RAMs QUE CORREM UM JOGO
BEGIN 

		SELECT Ram.Nome FROM Jogo
		INNER JOIN Ram_Jogo ON Ram_Jogo.Jogo_Id = Jogo.Id
        INNER JOIN Ram ON Ram_Jogo.Ram_id = Ram.Id
		
        WHERE Jogo.Id = JogoX;

END$$


CREATE PROCEDURE  ConfigsQueCorre (IN JogoX INT) -- MOSTRA TODASS CONFIGS QUE CORREM UM JOGO 
BEGIN 

		SELECT  Configuracao.Nome  FROM Jogo
        
		INNER JOIN Ram_Jogo ON Jogo.Id = Ram_Jogo.Jogo_Id
        INNER JOIN Ram ON Ram.Id = Ram_Jogo.Ram_id 
        
		INNER JOIN CPU_Jogo ON  Jogo.Id = Cpu_Jogo.Jogo_Id 
        INNER JOIN CPU ON Cpu_Jogo.CPU_id = Cpu.Id        

		INNER JOIN GPU_Jogo ON  Jogo.Id = Gpu_Jogo.Jogo_Id
        INNER JOIN GPU ON Gpu_Jogo.GPU_id = Gpu.Id
		
        INNER JOIN Configuracao  ON Configuracao.Cpu_Id = Cpu.Id && Configuracao.Gpu_Id = Gpu.Id && Configuracao.Ram_Id = Ram.Id
        
        WHERE Jogo.Id = JogoX;

END$$



CREATE VIEW  QuaisCorreV AS --  MOSTRA TODOS OS JOGOS QUE CORREM NUMA CONFIG
SELECT Jogo.Nome, Configuracao.Id FROM Configuracao


		INNER JOIN CPU ON Configuracao.CPU_id = Cpu.Id
        INNER JOIN GPU ON Configuracao.GPU_id = Gpu.Id
        INNER JOIN RAM ON Configuracao.RAM_id = Ram.Id
        
		INNER JOIN CPU_Jogo ON Cpu.Id = Cpu_Jogo.CPU_Id
        INNER JOIN GPU_Jogo ON GPU.Id = Gpu_Jogo.GPU_Id
        INNER JOIN RAM_Jogo on RAM.Id = Ram_Jogo.Ram_Id
        
        INNER JOIN Jogo ON CPU_Jogo.Jogo_Id = Jogo.Id && Ram_Jogo.Jogo_Id = Jogo.Id && Gpu_Jogo.Jogo_Id = Jogo.Id $$


-- Select * From QuaisCorreV  Where Id = 1;


CREATE view  CpuQueCorreV AS -- MOSTRA TODOS OS CPUS QUE CORREM UM JOGO


		SELECT Cpu.Modelo, Jogo.Id FROM Jogo
		INNER JOIN CPU_Jogo ON Cpu_Jogo.Jogo_Id = Jogo.Id
        INNER JOIN CPU ON Cpu_Jogo.CPU_id = Cpu.Id
        $$
