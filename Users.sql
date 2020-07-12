CREATE USER 'BdAdmin'@'localhost'; 
CREATE USER 'BdUser'@'localhost';



GRANT ALL PRIVILEGES ON mydb TO 'BdAdmin'@'localhost';

GRANT INSERT, UPDATE ON Configuracao to 'BdUser'@'localhost';
GRANT INSERT, UPDATE ON user to 'BdUser'@'localhost';