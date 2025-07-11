-- Creo base de datos
DROP DATABASE IF EXISTS file_system_db;
CREATE DATABASE file_system_db CHARACTER SET utf8 COLLATE utf8_bin;
USE file_system_db;

-- Creo tabla de carpetas
CREATE TABLE folder (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    id_parent INT DEFAULT NULL,
    FOREIGN KEY (id_parent) REFERENCES folder(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Creo tabla de archivos
CREATE TABLE file (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL,
    created_at DATE NOT NULL,
    id_folder INT NOT NULL,
    FOREIGN KEY (id_folder) REFERENCES folder(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Inserto carpetas de ejemplo
INSERT INTO folder (name, id_parent) VALUES 
('Root', NULL),
('Docs', 1),
('Images', 1),
('Projects', 1),
('SubProject', 4);

-- Inserto archivos de ejemplo
INSERT INTO file (name, type, created_at, id_folder) VALUES
('manual.pdf', 'pdf', '2024-12-01', 2),
('photo.jpg', 'jpg', '2025-01-10', 3),
('presentation.ppt', 'ppt', '2025-03-05', 2),
('project.zip', 'zip', '2025-07-01', 4),
('report.docx', 'docx', '2025-07-11', 5);

-- ====================
