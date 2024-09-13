-- Criando a base de dados
CREATE DATABASE IF NOT EXISTS db3;
USE db3;

-- Tabela de clientes
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de pedidos
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Tabela de itens de pedido
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    -- Observação: o campo product_id refere-se à tabela products na instância 2
);

-- Tabela de pagamentos
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Tabela de envios
CREATE TABLE shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    shipment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    carrier VARCHAR(50),
    tracking_number VARCHAR(100),
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Tabela de devoluções
CREATE TABLE returns (
    return_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    return_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    reason TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    -- Observação: o campo product_id refere-se à tabela products na instância 2
);

-- Tabela de avaliações
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    -- Observação: o campo product_id refere-se à tabela products na instância 2
);

-- Inserindo dados de teste
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES
('Emily', 'Clark', 'emily.clark@example.com', '555-1234', '789 Pine St'),
('Michael', 'Brown', 'michael.brown@example.com', '555-5678', '101 Maple St');

INSERT INTO orders (customer_id, status, total_amount) VALUES
(1, 'Processing', 229.98),
(2, 'Shipped', 29.99);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 199.99),
(1, 2, 1, 29.99),
(2, 2, 1, 29.99);

INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(1, 229.98, 'Credit Card', 'Completed'),
(2, 29.99, 'PayPal', 'Completed');

INSERT INTO shipments (order_id, carrier, tracking_number, status) VALUES
(2, 'UPS', '1Z999AA10123456784', 'In Transit');

INSERT INTO reviews (customer_id, product_id, rating, comment) VALUES
(1, 1, 5, 'Great product! Highly recommended.'),
(2, 2, 4, 'Good value for the price.');

-- Grant necessary permissions to 'user3'
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'user3'@'%';
FLUSH PRIVILEGES;
