-- Borro y creo la base
DROP DATABASE IF EXISTS user_access_db;
CREATE DATABASE user_access_db CHARACTER SET utf8 COLLATE utf8_bin;
USE user_access_db;

-- Tabla de usuarios
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Tabla de grupos
CREATE TABLE group_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Tabla de permisos
CREATE TABLE permission (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Relación N:M entre usuario y grupo
CREATE TABLE user_group (
    id_user INT,
    id_group INT,
    PRIMARY KEY (id_user, id_group),
    FOREIGN KEY (id_user) REFERENCES user(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_group) REFERENCES group_data(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Relación N:M entre grupo y permiso
CREATE TABLE group_permission (
    id_group INT,
    id_permission INT,
    PRIMARY KEY (id_group, id_permission),
    FOREIGN KEY (id_group) REFERENCES group_data(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_permission) REFERENCES permission(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ========================
-- Insertar permisos base
-- ========================
INSERT INTO permission (action) VALUES 
('POST /api/uploadVideo'),
('POST /api/getUserVideos'),
('POST /api/likeVideo'),
('POST /api/commentOnVideo'),
('POST /api/deleteVideo'),
('POST /api/suspendUser');

-- Insertar grupos base
INSERT INTO group_data (name) VALUES 
('admin'),
('regular'),
('moderator');

-- Asociar permisos a grupos
-- admin → todos los permisos
INSERT INTO group_permission (id_group, id_permission)
SELECT 1, id FROM permission;

-- regular → like, comment, upload, getUserVideos
INSERT INTO group_permission (id_group, id_permission)
SELECT 2, id FROM permission WHERE action IN (
    'POST /api/uploadVideo',
    'POST /api/getUserVideos',
    'POST /api/likeVideo',
    'POST /api/commentOnVideo'
);

-- moderator → suspendUser
INSERT INTO group_permission (id_group, id_permission)
SELECT 3, id FROM permission WHERE action = 'POST /api/suspendUser';

-- ========================
-- Inserto datos de prueba
-- ========================
INSERT INTO user (name, password) VALUES 
('admin_user', 'adminpass'),
('mod_user', 'modpass'),
('regular_user', 'regpass');

-- Relacionar usuarios con grupos
-- admin_user → admin
INSERT INTO user_group VALUES (1, 1);

-- mod_user → moderator
INSERT INTO user_group VALUES (2, 3);

-- regular_user → regular
INSERT INTO user_group VALUES (3, 2);

-- ========================
-- CRUD: usuario
-- ========================

DELIMITER //

CREATE PROCEDURE user_create(IN uname VARCHAR(100), IN upass VARCHAR(100))
BEGIN
    INSERT INTO user (name, password) VALUES (uname, upass);
END;
//

CREATE PROCEDURE user_update(IN uid INT, IN uname VARCHAR(100), IN upass VARCHAR(100))
BEGIN
    UPDATE user SET name = uname, password = upass WHERE id = uid;
END;
//

CREATE PROCEDURE user_delete(IN uid INT)
BEGIN
    DELETE FROM user WHERE id = uid;
END;
//

CREATE PROCEDURE user_get(IN uname VARCHAR(100))
BEGIN
    SELECT * FROM user WHERE name = uname;
END;
//

-- CRUD: grupo
CREATE PROCEDURE group_create(IN gname VARCHAR(100))
BEGIN
    INSERT INTO group_data (name) VALUES (gname);
END;
//

-- CRUD: permiso
CREATE PROCEDURE permission_create(IN action_name VARCHAR(255))
BEGIN
    INSERT INTO permission (action) VALUES (action_name);
END;
//

-- ========================
-- Procedimientos extra
-- ========================

-- Ver todos los permisos que tiene un usuario por sus grupos
CREATE PROCEDURE user_permissions(IN uid INT)
BEGIN
    SELECT DISTINCT p.action
    FROM user_group ug
    JOIN group_permission gp ON ug.id_group = gp.id_group
    JOIN permission p ON gp.id_permission = p.id
    WHERE ug.id_user = uid;
END;
//

-- Ver usuarios de un grupo
CREATE PROCEDURE group_users(IN gid INT)
BEGIN
    SELECT u.name
    FROM user_group ug
    JOIN user u ON ug.id_user = u.id
    WHERE ug.id_group = gid;
END;
//

DELIMITER ;
