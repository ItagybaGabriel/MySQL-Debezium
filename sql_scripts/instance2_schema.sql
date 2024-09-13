-- Criando a base de dados
CREATE DATABASE IF NOT EXISTS db2;
USE db2;

-- Tabela de fornecedores
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100)
);

-- Tabela de produtos
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    supplier_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Tabela de categorias
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- Tabela de relação produto-categoria
CREATE TABLE product_categories (
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Tabela de preços
CREATE TABLE prices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    start_date DATETIME,
    end_date DATETIME,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Tabela de descontos
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    discount_percentage DECIMAL(5,2) NOT NULL,
    start_date DATETIME,
    end_date DATETIME,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Tabela de inventário
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Tabela de imagens de produtos
CREATE TABLE product_images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Inserindo dados de teste
INSERT INTO suppliers (supplier_name, contact_email) VALUES
('Supplier A', 'contact@supplierA.com'),
('Supplier B', 'contact@supplierB.com');

INSERT INTO products (product_name, description, supplier_id) VALUES
('Product 1', 'Description of Product 1', 1),
('Product 2', 'Description of Product 2', 2);

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Books');

INSERT INTO product_categories (product_id, category_id) VALUES
(1, 1),
(2, 2);

INSERT INTO prices (product_id, amount, currency, start_date) VALUES
(1, 199.99, 'USD', NOW()),
(2, 29.99, 'USD', NOW());

INSERT INTO discounts (product_id, discount_percentage, start_date, end_date) VALUES
(1, 10.00, NOW(), NOW() + INTERVAL 7 DAY);

INSERT INTO inventory (product_id, quantity) VALUES
(1, 50),
(2, 100);

INSERT INTO product_images (product_id, image_url) VALUES
(1, 'http://example.com/images/product1.jpg'),
(2, 'http://example.com/images/product2.jpg');

-- Grant necessary permissions to 'user2'
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'user2'@'%';
FLUSH PRIVILEGES;
