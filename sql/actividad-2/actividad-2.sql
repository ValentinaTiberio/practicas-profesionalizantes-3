-- Borro y creo la base de datos
DROP DATABASE IF EXISTS country_db;
CREATE DATABASE country_db CHARACTER SET utf8 COLLATE utf8_bin;
USE country_db;

-- Creo tabla country
CREATE TABLE country (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capital VARCHAR(100) NOT NULL,
    language VARCHAR(100) NOT NULL,
    area FLOAT NOT NULL,
    population INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Creo tabla city relacionada con country (1:N)
CREATE TABLE city (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    population INT NOT NULL,
    area FLOAT NOT NULL,
    postal_code VARCHAR(20),
    is_coastal BOOLEAN NOT NULL,
    id_country INT NOT NULL,
    FOREIGN KEY (id_country) REFERENCES country(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Insertod atos de prueba
INSERT INTO country (name, capital, language, area, population) VALUES 
('Argentina', 'Buenos Aires', 'Spanish', 2780400, 47000000),
('Brazil', 'Brasília', 'Portuguese', 8516000, 214000000),
('France', 'Paris', 'French', 551695, 67000000);

INSERT INTO city (name, population, area, postal_code, is_coastal, id_country) VALUES 
('Buenos Aires', 3000000, 203, 'C1000', TRUE, 1),
('Córdoba', 1400000, 576, 'X5000', FALSE, 1),
('Rio de Janeiro', 6500000, 1182, '20000-000', TRUE, 2),
('São Paulo', 12300000, 1521, '01000-000', FALSE, 2),
('Marseille', 870000, 240, '13000', TRUE, 3);

-- =============================
-- Procedimientos de country
-- =============================

DELIMITER //

CREATE PROCEDURE country_get(IN country_name VARCHAR(100))
BEGIN
    SELECT * FROM country WHERE name = country_name;
END;
//

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

CREATE PROCEDURE country_delete(IN pid INT)
BEGIN
    DELETE FROM country WHERE id = pid;
END;
//

-- =============================
-- Procedimientos de city
-- =============================

CREATE PROCEDURE city_get(IN city_name VARCHAR(100))
BEGIN
    SELECT * FROM city WHERE name = city_name;
END;
//

CREATE PROCEDURE city_create(
    IN cname VARCHAR(100),
    IN cpopulation INT,
    IN carea FLOAT,
    IN cpostal_code VARCHAR(20),
    IN ccoastal BOOLEAN,
    IN cid_country INT
)
BEGIN
    INSERT INTO city (name, population, area, postal_code, is_coastal, id_country)
    VALUES (cname, cpopulation, carea, cpostal_code, ccoastal, cid_country);
END;
//

CREATE PROCEDURE city_update(
    IN cid INT,
    IN cname VARCHAR(100),
    IN cpopulation INT,
    IN carea FLOAT,
    IN cpostal_code VARCHAR(20),
    IN ccoastal BOOLEAN,
    IN cid_country INT
)
BEGIN
    UPDATE city
    SET name = cname,
        population = cpopulation,
        area = carea,
        postal_code = cpostal_code,
        is_coastal = ccoastal,
        id_country = cid_country
    WHERE id = cid;
END;
//

CREATE PROCEDURE city_delete(IN cid INT)
BEGIN
    DELETE FROM city WHERE id = cid;
END;
//

-- =============================
-- Procedimientos pedidos 
-- =============================

-- 1. País con la ciudad más poblada
CREATE PROCEDURE city_most_populated_country()
BEGIN
    SELECT country.name
    FROM city
    JOIN country ON city.id_country = country.id
    ORDER BY city.population DESC
    LIMIT 1;
END;
//

-- 2. Países con ciudades costeras de más de 1 millón de hab.
CREATE PROCEDURE coastal_cities_over_million()
BEGIN
    SELECT DISTINCT country.name
    FROM city
    JOIN country ON city.id_country = country.id
    WHERE city.is_coastal = TRUE AND city.population > 1000000;
END;
//

-- 3. País y ciudad con mayor densidad de población
CREATE PROCEDURE city_highest_density()
BEGIN
    SELECT country.name AS country, city.name AS city,
           (city.population / city.area) AS density
    FROM city
    JOIN country ON city.id_country = country.id
    ORDER BY density DESC
    LIMIT 1;
END;
//

DELIMITER ;
