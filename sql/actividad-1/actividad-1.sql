-- Crear la base de datos
DROP DATABASE IF EXISTS country_db;
CREATE DATABASE country_db CHARACTER SET utf8 COLLATE utf8_bin;
USE country_db;

-- Creación tabla principal
CREATE TABLE country (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capital VARCHAR(100) NOT NULL,
    language VARCHAR(100) NOT NULL,
    area FLOAT NOT NULL,
    population INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Inserto datos de prueba
INSERT INTO country (name, capital, language, area, population) VALUES 
('Argentina', 'Buenos Aires', 'Spanish', 2780400, 47000000),
('Brazil', 'Brasília', 'Portuguese', 8516000, 214000000),
('France', 'Paris', 'French', 551695, 67000000);

-- Procedimiento para obtener datos de un país por nombre
DELIMITER //
CREATE PROCEDURE country_get(IN country_name VARCHAR(100))
BEGIN
    SELECT * FROM country WHERE name = country_name;
END;
//

-- Procedimiento para crear un país
CREATE PROCEDURE country_create(
    IN pname VARCHAR(100),
    IN pcapital VARCHAR(100),
    IN planguage VARCHAR(100),
    IN parea FLOAT,
    IN ppopulation INT
)
BEGIN
    INSERT INTO country (name, capital, language, area, population)
    VALUES (pname, pcapital, planguage, parea, ppopulation);
END;
//

-- Procedimiento para editar un país por id
CREATE PROCEDURE country_update(
    IN pid INT,
    IN pname VARCHAR(100),
    IN pcapital VARCHAR(100),
    IN planguage VARCHAR(100),
    IN parea FLOAT,
    IN ppopulation INT
)
BEGIN
    UPDATE country
    SET name = pname,
        capital = pcapital,
        language = planguage,
        area = parea,
        population = ppopulation
    WHERE id = pid;
END;
//

-- Procedimiento para eliminar un país por id
CREATE PROCEDURE country_delete(IN pid INT)
BEGIN
    DELETE FROM country WHERE id = pid;
END;
//
DELIMITER ;
