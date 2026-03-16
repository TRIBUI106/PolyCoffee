-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               9.6.0 - MySQL Community Server - GPL
-- Server OS:                    Linux
-- HeidiSQL Version:             12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for jav202_assignment
DROP DATABASE IF EXISTS `jav202_assignment`;
CREATE DATABASE IF NOT EXISTS `jav202_assignment` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jav202_assignment`;

-- Dumping structure for table jav202_assignment.bill_details
DROP TABLE IF EXISTS `bill_details`;
CREATE TABLE IF NOT EXISTS `bill_details` (
                                              `id` int NOT NULL AUTO_INCREMENT,
                                              `bill_id` int NOT NULL,
                                              `drink_id` int NOT NULL,
                                              `quantity` int NOT NULL,
                                              `price` int NOT NULL,
                                              `note` varchar(255) DEFAULT NULL,
                                              PRIMARY KEY (`id`),
                                              KEY `fk_detail_bill` (`bill_id`),
                                              KEY `fk_detail_drink` (`drink_id`),
                                              CONSTRAINT `fk_detail_bill` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`id`) ON DELETE CASCADE,
                                              CONSTRAINT `fk_detail_drink` FOREIGN KEY (`drink_id`) REFERENCES `drinks` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table jav202_assignment.bill_details: ~10 rows (approximately)
INSERT INTO `bill_details` (`id`, `bill_id`, `drink_id`, `quantity`, `price`, `note`) VALUES
                                                                                          (1, 1, 6, 1, 45000, NULL),
                                                                                          (2, 1, 11, 1, 55000, NULL),
                                                                                          (3, 1, 10, 2, 39000, NULL),
                                                                                          (4, 2, 12, 1, 59000, NULL),
                                                                                          (5, 2, 4, 1, 45000, NULL),
                                                                                          (6, 3, 3, 1, 35000, NULL),
                                                                                          (7, 3, 10, 2, 39000, NULL),
                                                                                          (8, 3, 11, 1, 55000, NULL),
                                                                                          (9, 4, 5, 1, 49000, NULL),
                                                                                          (10, 4, 1, 1, 35000, NULL);

-- Dumping structure for table jav202_assignment.bills
DROP TABLE IF EXISTS `bills`;
CREATE TABLE IF NOT EXISTS `bills` (
                                       `id` int NOT NULL AUTO_INCREMENT,
                                       `user_id` int DEFAULT NULL,
                                       `code` varchar(255) NOT NULL,
                                       `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                       `total` int DEFAULT '0',
                                       `status` enum('WAITING','FINISHED','CANCELLED') DEFAULT 'WAITING',
                                       PRIMARY KEY (`id`),
                                       UNIQUE KEY `code` (`code`),
                                       KEY `fk_bill_user` (`user_id`),
                                       CONSTRAINT `fk_bill_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table jav202_assignment.bills: ~4 rows (approximately)
INSERT INTO `bills` (`id`, `user_id`, `code`, `created_at`, `total`, `status`) VALUES
                                                                                   (1, 1, 'BILL-1773648543465', '2026-03-16 15:09:03', 178000, 'FINISHED'),
                                                                                   (2, 1, 'BILL-1773648554873', '2026-03-16 15:09:15', 104000, 'FINISHED'),
                                                                                   (3, 1, 'BILL-1773651172614', '2026-03-16 15:52:53', 168000, 'FINISHED'),
                                                                                   (4, 1, 'BILL-1773654246523', '2026-03-16 16:44:07', 84000, 'WAITING');

-- Dumping structure for table jav202_assignment.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
                                            `id` int NOT NULL AUTO_INCREMENT,
                                            `name` varchar(255) NOT NULL,
                                            `active` tinyint(1) DEFAULT '1',
                                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table jav202_assignment.categories: ~5 rows (approximately)
INSERT INTO `categories` (`id`, `name`, `active`) VALUES
                                                      (1, 'Cà Phê Truyền Thống', 1),
                                                      (2, 'Trà Trái Cây', 1),
                                                      (3, 'Bảng Đặc Biệt', 1),
                                                      (4, 'Bánh Ngọt', 1),
                                                      (5, 'Đá Xay', 1);

-- Dumping structure for table jav202_assignment.drinks
DROP TABLE IF EXISTS `drinks`;
CREATE TABLE IF NOT EXISTS `drinks` (
                                        `id` int NOT NULL AUTO_INCREMENT,
                                        `category_id` int NOT NULL,
                                        `name` varchar(255) NOT NULL,
                                        `description` varchar(255) DEFAULT NULL,
                                        `image` varchar(255) DEFAULT NULL,
                                        `price` int NOT NULL,
                                        `active` tinyint(1) DEFAULT '1',
                                        PRIMARY KEY (`id`),
                                        KEY `fk_drink_category` (`category_id`),
                                        CONSTRAINT `fk_drink_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table jav202_assignment.drinks: ~12 rows (approximately)
INSERT INTO `drinks` (`id`, `category_id`, `name`, `description`, `image`, `price`, `active`) VALUES
                                                                                                  (1, 1, 'Cà Phê Sữa Đá', 'Cà phê sữa đá truyền thống, đậm vị và thơm ngọt.', 'http://127.0.0.1:9000/polycoffee/1773653717507.jpg', 35000, 1),
                                                                                                  (2, 1, 'Cà Phê Đen Đá', 'Cà phê đen đá nguyên chất truyền thống cho một khởi đầu mạnh mẽ.', '1773654465607_PHIN_DEN_DA.jpg', 30000, 1),
                                                                                                  (3, 1, 'Bạc Xỉu', 'Thức uống nhiều sữa hòa quyện với chút cà phê, hoàn hảo cho những tín đồ ngọt ngào.', '1773654565186_BAC_SIU_1.jpg', 35000, 1),
                                                                                                  (4, 2, 'Trà Thanh Đào', 'Trà đào đặc trưng hòa quyện cùng cam và sả.', '1773654560247_TRA_THANH_DAO.jpg', 45000, 1),
                                                                                                  (5, 2, 'Trà Lài Macchiato', 'Trà lài thơm ngát kết hợp cùng lớp kem macchiato mặn béo.', '1773654694116_images.jpg', 49000, 1),
                                                                                                  (6, 2, 'Trà Vải', 'Trà vải thanh mát với quả vải tươi.', '1773654619841_TRA_THACH_VAI_1.jpg', 45000, 1),
                                                                                                  (7, 3, 'Phindi Hạnh Nhân', 'Cà phê hiện đại hương hạnh nhân kết hợp vị kem độc đáo.', '1773654789469_PHINDI_HANH_NHAN.jpg', 55000, 1),
                                                                                                  (8, 3, 'Trà Sen Vàng', 'Trà sen vàng ngọt thanh trọn vị cùng hạt sen giòn rụm.', '1773654803528_TSV_CU_NANG.jpg', 49000, 1),
                                                                                                  (9, 4, 'Bánh Mì Quế', 'Bánh mì que quế giòn rụm và ấm nóng.', '1773654819250_311327516_8823635290983654_3117248633003811915_n.jpg', 19000, 1),
                                                                                                  (10, 4, 'Tiramisu', 'Bánh ngọt cổ điển Ý với điểm nhấn từ cà phê Việt Nam.', '1773654917978_BANH_TIRAMISU.jpg', 39000, 1),
                                                                                                  (11, 5, 'Matcha Đá Xay', 'Matcha xay nhuyễn cùng sữa sữa tươi và một lớp kem.', '1773654876798_Highlands_Profile_Picture.jpg', 55000, 1),
                                                                                                  (12, 5, 'Caramel Frappuccino', 'Cà phê caramel đậm đà xay nhuyễn, phủ thêm một lớp kem.', '1773654954960_frappuccino.webp', 59000, 1);

-- Dumping structure for table jav202_assignment.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
                                       `id` int NOT NULL AUTO_INCREMENT,
                                       `email` varchar(255) NOT NULL,
                                       `password` varchar(255) NOT NULL,
                                       `full_name` varchar(255) DEFAULT NULL,
                                       `phone` varchar(255) DEFAULT NULL,
                                       `role` tinyint(1) DEFAULT '0' COMMENT '1: Manager, 0: Staff',
                                       `active` tinyint(1) DEFAULT '1',
                                       PRIMARY KEY (`id`),
                                       UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table jav202_assignment.users: ~3 rows (approximately)
INSERT INTO `users` (`id`, `email`, `password`, `full_name`, `phone`, `role`, `active`) VALUES
                                                                                            (1, 'chez1s.dev@gmail.com', 'cz', 'Bùi Đức Trí', '0901234567', 1, 1),
                                                                                            (2, 'haunvtv00054@fpt.edu.vn', '123', 'Nguyễn Vủ Hậu', '0907654321', 0, 1),
                                                                                            (3, 'demo@polycoffee.com', '123', 'Trợ Lý Khách Hàng', '0123456789', 0, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
