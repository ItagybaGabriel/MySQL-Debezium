-- Criando a base de dados (se ainda não existir)
CREATE DATABASE IF NOT EXISTS db1;
USE db1;

-- Tabela de usuários
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de perfis
CREATE TABLE profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Tabela de papéis
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- Tabela de permissões
CREATE TABLE permissions (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    permission_name VARCHAR(50) NOT NULL UNIQUE
);

-- Tabela de relação usuário-papel
CREATE TABLE user_roles (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Tabela de relação papel-permissão
CREATE TABLE role_permissions (
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id)
);

-- Tabela de sessões
CREATE TABLE sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    session_token VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    expires_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Inserindo dados de teste
INSERT INTO users (username, password_hash, email) VALUES
('jdoe', 'hashed_password_1', 'jdoe@example.com'),
('asmith', 'hashed_password_2', 'asmith@example.com');

INSERT INTO profiles (user_id, first_name, last_name, phone_number, address) VALUES
(1, 'John', 'Doe', '123456789', '123 Main St'),
(2, 'Alice', 'Smith', '987654321', '456 Elm St');

INSERT INTO roles (role_name) VALUES
('admin'),
('user');

INSERT INTO permissions (permission_name) VALUES
('read'),
('write'),
('delete');

INSERT INTO user_roles (user_id, role_id) VALUES
(1, 1),
(2, 2);

INSERT INTO role_permissions (role_id, permission_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1);

INSERT INTO sessions (user_id, session_token, expires_at) VALUES
(1, 'session_token_1', NOW() + INTERVAL 1 DAY),
(2, 'session_token_2', NOW() + INTERVAL 1 DAY);

GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'user1'@'%';
FLUSH PRIVILEGES;