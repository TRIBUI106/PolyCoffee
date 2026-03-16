-- ==========================================
-- POLYCOFFEE DATABASE INITIALIZATION
-- Premium Brews & Jakarta EE ProMax
-- ==========================================

-- Create Database
CREATE DATABASE IF NOT EXISTS jav202_assignment CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE jav202_assignment;

-- 1. Users Table (Core Personnel)
DROP TABLE IF EXISTS bill_details;
DROP TABLE IF EXISTS bills;
DROP TABLE IF EXISTS drinks;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    role TINYINT(1) DEFAULT 0 COMMENT '1: Manager, 0: Staff',
    active TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

-- 2. Categories Table (Menu Archetypes)
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    active TINYINT(1) DEFAULT 1
) ENGINE=InnoDB;

-- 3. Drinks Table (The Artisan Collection)
CREATE TABLE drinks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    price INT NOT NULL,
    active TINYINT(1) DEFAULT 1,
    CONSTRAINT fk_drink_category FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB;

-- 4. Bills Table (Transaction Ledger)
CREATE TABLE bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    code VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total INT DEFAULT 0,
    status ENUM('WAITING', 'FINISHED', 'CANCELLED') DEFAULT 'WAITING',
    CONSTRAINT fk_bill_user FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- 5. Bill Details Table (Line Items)
CREATE TABLE bill_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    drink_id INT NOT NULL,
    quantity INT NOT NULL,
    price INT NOT NULL,
    CONSTRAINT fk_detail_bill FOREIGN KEY (bill_id) REFERENCES bills(id) ON DELETE CASCADE,
    CONSTRAINT fk_detail_drink FOREIGN KEY (drink_id) REFERENCES drinks(id)
) ENGINE=InnoDB;

-- ==========================================
-- SEED DATA: AUTHENTICATION
-- ==========================================
INSERT INTO users (email, password, full_name, phone, role, active) VALUES
('chez1s.dev@gmail.com', 'cz', 'Bùi Đức Trí', '0901234567', 1, 1),
('haunvtv00054@fpt.edu.vn', '123', 'Nguyễn Vủ Hậu', '0907654321', 0, 1),
('demo@polycoffee.com', '123', 'Trợ Lý Khách Hàng', '0123456789', 0, 1);

-- ==========================================
-- SEED DATA: CATEGORIES
-- ==========================================
INSERT INTO categories (name, active) VALUES
('Cà Phê Truyền Thống', 1),
('Trà Trái Cây', 1),
('Bảng Đặc Biệt', 1),
('Bánh Ngọt', 1),
('Đá Xay', 1);

-- ==========================================
-- SEED DATA: THE DRINK COLLECTION
-- ==========================================

-- Cà Phê Truyền Thống
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(1, 'Cà Phê Sữa Đá', 'Cà phê sữa đá truyền thống, đậm vị và thơm ngọt.', 35000, 1, 'ca-phe-sua-da.jpg'),
(1, 'Cà Phê Đen Đá', 'Cà phê đen đá nguyên chất truyền thống cho một khởi đầu mạnh mẽ.', 30000, 1, 'ca-phe-den-da.jpg'),
(1, 'Bạc Xỉu', 'Thức uống nhiều sữa hòa quyện với chút cà phê, hoàn hảo cho những tín đồ ngọt ngào.', 35000, 1, 'bac-xiu.jpg');

-- Trà Trái Cây
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(2, 'Trà Đào Cam Sả', 'Trà đào đặc trưng hòa quyện cùng cam và sả.', 45000, 1, 'tra-dao.jpg'),
(2, 'Trà Lài Macchiato', 'Trà lài thơm ngát kết hợp cùng lớp kem macchiato mặn béo.', 49000, 1, 'tra-lai-macchiato.jpg'),
(2, 'Trà Vải', 'Trà vải thanh mát với quả vải tươi.', 45000, 1, 'tra-vai.jpg');

-- Bảng Đặc Biệt
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(3, 'Phindi Hạnh Nhân', 'Cà phê hiện đại hương hạnh nhân kết hợp vị kem độc đáo.', 55000, 1, 'phindi-hanh-nhan.jpg'),
(3, 'Trà Sen Vàng', 'Trà sen vàng ngọt thanh trọn vị cùng hạt sen giòn rụm.', 49000, 1, 'tra-sen-vang.jpg');

-- Bánh Ngọt
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(4, 'Bánh Mì Quế', 'Bánh mì que quế giòn rụm và ấm nóng.', 19000, 1, 'banh-mi-que.jpg'),
(4, 'Tiramisu', 'Bánh ngọt cổ điển Ý với điểm nhấn từ cà phê Việt Nam.', 39000, 1, 'tiramisu.jpg');

-- Đá Xay
INSERT INTO drinks (category_id, name, description, price, active, image) VALUES
(5, 'Matcha Đá Xay', 'Matcha xay nhuyễn cùng sữa sữa tươi và một lớp kem.', 55000, 1, 'matcha-da-xay.jpg'),
(5, 'Caramel Frappuccino', 'Cà phê caramel đậm đà xay nhuyễn, phủ thêm một lớp kem.', 59000, 1, 'caramel-frappuccino.jpg');

-- ==========================================
-- END OF INITIALIZATION
-- ==========================================
