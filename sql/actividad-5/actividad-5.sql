-- Creo base de datos
DROP DATABASE IF EXISTS user_file_system_db;
CREATE DATABASE user_file_system_db CHARACTER SET utf8 COLLATE utf8_bin;
USE user_file_system_db;

-- Tabla de usuarios (similar al de la actividad 3)
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Tabla de carpetas
CREATE TABLE folder (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    id_parent INT DEFAULT NULL,
    id_user INT NOT NULL,
    FOREIGN KEY (id_parent) REFERENCES folder(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES user(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Tabla de archivos
CREATE TABLE file (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL,
    created_at DATE NOT NULL,
    id_folder INT NOT NULL,
    id_user INT NOT NULL,
    FOREIGN KEY (id_folder) REFERENCES folder(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_user) REFERENCES user(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Insert usuarios ejemplo
INSERT INTO user (name, password) VALUES 
('alice', 'passalice'),
('bob', 'passbob');

-- Insert carpetas ejemplo
INSERT INTO folder (name, id_parent, id_user) VALUES
('Root', NULL, 1),
('Docs', 1, 1),
('Images', 1, 1),
('Root', NULL, 2),
('Work', 4, 2);

-- Insertar archivos ejemplo
INSERT INTO file (name, type, created_at, id_folder, id_user) VALUES
('file1.pdf', 'pdf', '2025-07-01', 2, 1),
('file2.jpg', 'jpg', '2025-07-02', 3, 1),
('file3.docx', 'docx', '2025-07-03', 5, 2);

-- ====================
-- Procedimientos ABM carpeta
-- ====================

DELIMITER //

CREATE PROCEDURE folder_create(
    IN fname VARCHAR(100),
    IN fparent INT,
    IN fuser INT
)
BEGIN
    INSERT INTO folder (name, id_parent, id_user) VALUES (fname, fparent, fuser);
END;
//

CREATE PROCEDURE folder_update(
    IN fid INT,
    IN fname VARCHAR(100),
    IN fparent INT,
    IN fuser INT
)
BEGIN
    UPDATE folder SET name = fname, id_parent = fparent, id_user = fuser WHERE id = fid;
END;
//

CREATE PROCEDURE folder_delete(IN fid INT)
BEGIN
    DELETE FROM folder WHERE id = fid;
END;
//

CREATE PROCEDURE folder_get_by_user(IN fuser INT)
BEGIN
    SELECT * FROM folder WHERE id_user = fuser;
END;
//

-- ====================
-- Procedimientos ABM archivo
-- ====================

CREATE PROCEDURE file_create(
    IN fname VARCHAR(100),
    IN ftype VARCHAR(20),
    IN fdate DATE,
    IN fid_folder INT,
    IN fuser INT
)
BEGIN
    INSERT INTO file (name, type, created_at, id_folder, id_user)
    VALUES (fname, ftype, fdate, fid_folder, fuser);
END;
//

CREATE PROCEDURE file_update(
    IN fid INT,
    IN fname VARCHAR(100),
    IN ftype VARCHAR(20),
    IN fdate DATE,
    IN fid_folder INT,
    IN fuser INT
)
BEGIN
    UPDATE file SET name = fname, type = ftype, created_at = fdate, id_folder = fid_folder, id_user = fuser
    WHERE id = fid;
END;
//

CREATE PROCEDURE file_delete(IN fid INT)
BEGIN
    DELETE FROM file WHERE id = fid;
END;
//

CREATE PROCEDURE file_get_by_user(IN fuser INT)
BEGIN
    SELECT * FROM file WHERE id_user = fuser;
END;
//

DELIMITER ;
