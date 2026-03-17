CREATE DATABASE PolyCoffee;
USE PolyCoffee;

-- =========================
-- 1. categories
-- =========================
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

-- =========================
-- 2. drinks
-- =========================
CREATE TABLE drinks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- =========================
-- 3. users
-- =========================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100) NOT NULL,
    fullname VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

-- =========================
-- 4. bills
-- =========================
CREATE TABLE bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- =========================
-- 5. bill_details
-- =========================
CREATE TABLE bill_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    drink_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(id),
    FOREIGN KEY (drink_id) REFERENCES drinks(id)
);

-- =========================
-- Insert Sample Data
-- =========================

-- Categories
INSERT INTO categories(name, active) VALUES
('Coffee',1),
('Tea',1),
('Juice',1);

-- Drinks
INSERT INTO drinks(name, price, category_id, active) VALUES
('Black Coffee',2.5,1,1),
('Milk Coffee',3.0,1,1),
('Milk Tea',3.5,2,1),
('Orange Juice',4.0,3,1);

-- Users
INSERT INTO users(username,email,password,fullname,role,active) VALUES
('admin','admin@polycoffee.com','123','Administrator','ADMIN',1),
('staff','staff@polycoffee.com','123','Staff Member','STAFF',1);

-- Bills
INSERT INTO bills(user_id,status) VALUES
(1,'PAID'),
(2,'PAID');

-- Bill Details
INSERT INTO bill_details(bill_id,drink_id,quantity,price) VALUES
(1,1,2,2.5),
(1,3,1,3.5),
(2,2,1,3.0);


ALTER TABLE bills
    ADD COLUMN total DECIMAL(10,2) DEFAULT 0;

ALTER TABLE bills
    MODIFY status VARCHAR(30) DEFAULT 'PENDING';

CREATE INDEX idx_created_date ON bills(created_date);

INSERT INTO bill_details(bill_id,drink_id,quantity,price)
VALUES (1,1,2,30000),
       (1,2,1,20000);


SELECT b.id, b.user_id, b.total, b.status, b.created_date, u.username
FROM bills b
         LEFT JOIN users u ON b.user_id = u.id;