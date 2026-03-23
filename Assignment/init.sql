/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `jav202_assignment` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jav202_assignment`;

CREATE TABLE IF NOT EXISTS `bills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total` int DEFAULT '0',
  `status` enum('WAITING','FINISHED','CANCELLED') DEFAULT 'WAITING',
  `guest_name` varchar(255) DEFAULT NULL,
  `guest_phone` varchar(255) DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `discount_amount` int DEFAULT NULL,
  `guest_id` int DEFAULT NULL,
  `guest_voucher_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `fk_bill_user` (`user_id`),
  KEY `fk_bill_table` (`table_id`),
  KEY `FK1dr34lyvirbn5ufmcss4gqsu3` (`guest_id`),
  KEY `FK3m8cewyw2n3mh24hbrwigmxd5` (`guest_voucher_id`),
  CONSTRAINT `FK1dr34lyvirbn5ufmcss4gqsu3` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`id`),
  CONSTRAINT `FK3m8cewyw2n3mh24hbrwigmxd5` FOREIGN KEY (`guest_voucher_id`) REFERENCES `guest_vouchers` (`id`),
  CONSTRAINT `fk_bill_table` FOREIGN KEY (`table_id`) REFERENCES `coffee_tables` (`id`),
  CONSTRAINT `fk_bill_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `bills`;
INSERT INTO `bills` (`id`, `user_id`, `code`, `created_at`, `total`, `status`, `guest_name`, `guest_phone`, `table_id`, `payment_method`, `discount_amount`, `guest_id`, `guest_voucher_id`) VALUES
	(1, 1, 'BILL-1773648543465', '2026-03-16 15:09:03', 178000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 1, 'BILL-1773648554873', '2026-03-16 15:09:15', 104000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 1, 'BILL-1773651172614', '2026-03-16 15:52:53', 168000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 1, 'BILL-1773654246523', '2026-03-16 16:44:07', 84000, 'WAITING', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 1, 'BILL-1773655184772', '2026-03-16 16:59:45', 119000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 1, 'BILL-1773655223766', '2026-03-16 17:00:24', 142000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(7, 1, 'BILL-1773807944379', '2026-03-18 11:25:44', 85000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 1, 'BILL-1773808019895', '2026-03-18 11:27:00', 500000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 1, 'BILL-1773809397101', '2026-03-18 11:49:57', 153000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 1, 'BILL-1773809403681', '2026-03-18 11:50:04', 114000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 1, 'BILL-1773810236538', '2026-03-18 12:03:57', 45000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(12, 1, 'BILL-1773810246090', '2026-03-18 12:04:06', 39000, 'WAITING', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(13, 1, 'BILL-1773810581981', '2026-03-18 12:09:42', 45000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(14, 1, 'BILL-1773811175672', '2026-03-18 12:19:36', 114000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(15, 1, 'BILL-1773811194619', '2026-03-18 12:19:55', 59000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(16, 1, 'BILL-1773819329387', '2026-03-18 14:35:29', 153000, 'WAITING', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(17, 1, 'BILL-1773820233730', '2026-03-18 14:50:34', 104000, 'WAITING', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(18, 1, 'BILL-1773822209010', '2026-03-18 15:23:29', 208000, 'WAITING', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(19, 1, 'BILL-1773995997971', '2026-03-20 15:39:58', 139000, 'WAITING', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(20, 1, 'BILL-1773996501934', '2026-03-20 15:48:22', 153000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(21, 1, 'BILL-1773996757200', '2026-03-20 15:52:37', 114000, 'WAITING', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(22, 1, 'BILL-1773996915031', '2026-03-20 15:55:15', 153000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(23, 1, 'BILL-1774191965872', '2026-03-22 22:06:06', 138000, 'FINISHED', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(24, NULL, 'GUEST-1774235179269', '2026-03-23 10:06:19', 113000, 'WAITING', '0911532866', 'Bui Duc Tri', NULL, 'CASH', 0, 1, NULL),
	(25, 1, 'BILL-1774235640079', '2026-03-23 10:14:00', 110000, 'WAITING', NULL, NULL, NULL, NULL, 0, NULL, NULL),
	(26, 1, 'BILL-1774271187301', '2026-03-23 20:06:27', 30000, 'WAITING', NULL, NULL, NULL, NULL, 0, NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `bill_details`;
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
	(10, 4, 1, 1, 35000, NULL),
	(11, 5, 11, 1, 55000, NULL),
	(12, 5, 4, 1, 45000, ''),
	(13, 5, 9, 1, 19000, NULL),
	(14, 6, 10, 1, 39000, NULL),
	(15, 6, 3, 1, 35000, NULL),
	(16, 6, 9, 1, 19000, NULL),
	(17, 6, 8, 1, 49000, NULL),
	(18, 7, 11, 1, 55000, NULL),
	(19, 7, 2, 1, 30000, NULL),
	(20, 8, 1, 1, 500000, NULL),
	(21, 9, 10, 1, 39000, NULL),
	(22, 9, 3, 1, 35000, NULL),
	(23, 9, 2, 1, 30000, NULL),
	(24, 9, 8, 1, 49000, NULL),
	(25, 10, 12, 1, 59000, NULL),
	(26, 10, 11, 1, 55000, NULL),
	(27, 11, 4, 1, 45000, NULL),
	(28, 12, 10, 1, 39000, NULL),
	(29, 13, 6, 1, 45000, NULL),
	(30, 14, 12, 1, 59000, NULL),
	(31, 14, 11, 1, 55000, NULL),
	(32, 15, 12, 1, 59000, ''),
	(33, 16, 2, 1, 30000, NULL),
	(34, 16, 8, 1, 49000, NULL),
	(35, 16, 7, 1, 55000, NULL),
	(36, 16, 9, 1, 19000, NULL),
	(37, 17, 4, 1, 45000, NULL),
	(38, 17, 12, 1, 59000, NULL),
	(39, 18, 12, 1, 59000, NULL),
	(40, 18, 11, 1, 55000, NULL),
	(41, 18, 5, 1, 49000, NULL),
	(42, 18, 6, 1, 45000, NULL),
	(43, 19, 4, 1, 45000, NULL),
	(44, 19, 10, 1, 39000, NULL),
	(45, 19, 11, 1, 55000, NULL),
	(46, 20, 10, 1, 39000, NULL),
	(47, 20, 11, 1, 55000, NULL),
	(48, 20, 12, 1, 59000, NULL),
	(49, 21, 12, 1, 59000, NULL),
	(50, 21, 11, 1, 55000, NULL),
	(51, 22, 2, 1, 30000, NULL),
	(52, 22, 8, 1, 49000, NULL),
	(53, 22, 7, 1, 55000, NULL),
	(54, 22, 9, 1, 19000, NULL),
	(55, 23, 9, 1, 19000, NULL),
	(56, 23, 5, 1, 49000, NULL),
	(57, 23, 17, 1, 35000, NULL),
	(58, 23, 16, 1, 35000, NULL),
	(59, 24, 4, 1, 45000, ''),
	(60, 24, 9, 1, 19000, ''),
	(61, 24, 8, 1, 49000, ''),
	(62, 25, 22, 1, 55000, NULL),
	(63, 25, 11, 1, 55000, NULL),
	(64, 26, 2, 1, 30000, NULL);

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `name`, `active`) VALUES
	(1, 'Cà Phê Truyền Thống', 1),
	(2, 'Trà Trái Cây', 1),
	(3, 'Bảng Đặc Biệt', 1),
	(4, 'Bánh Ngọt', 1),
	(5, 'Đá Xay', 1);

CREATE TABLE IF NOT EXISTS `coffee_tables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_number` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `coffee_tables`;
INSERT INTO `coffee_tables` (`id`, `table_number`, `code`, `active`) VALUES
	(1, 'Bàn số 1', 'T1', 1),
	(2, 'Bàn số 2', 'T2', 1),
	(3, 'Bàn số 3', 'T3', 1),
	(4, 'Bàn số 4', 'T4', 1),
	(5, 'Bàn số 5', 'T5', 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `drinks`;
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
	(12, 5, 'Caramel Frappuccino', 'Cà phê caramel đậm đà xay nhuyễn, phủ thêm một lớp kem.', '1773654954960_frappuccino.webp', 59000, 1),
	(13, 1, 'Cà Phê Trứng', 'Sự pha trộn hoàn hảo mềm mịn giữa lòng đỏ trứng gà và cà phê đậm vị.', '1774167652578_ca_phe_trung___2__60f1c157ef5f41849f0d8338dfb50e51.png', 45000, 1),
	(14, 1, 'Cà Phê Dừa', 'Hương vị chua chua ngậy ngậy với lớp kem dừa béo trên tách cà phê sữa.', '1774168766880_cach_pha_ca_phe_cot_dua_4.jpg', 49000, 1),
	(15, 1, 'Cà Phê Muối', 'Lớp kem muối mằn mặn hòa quyện hoàn hảo với cà phê đen Việt Nam.', '1774168784239_cach_lam_ca_phe_muoi_nguyen_lieu_cong_thuc_lam.jpg', 39000, 1),
	(16, 1, 'Espresso', 'Ly cà phê Ý nguyên bản, mạnh mẽ và đầy đam mê.', '1774168822484_780x520_2.jpg', 35000, 1),
	(17, 1, 'Americano Đá', 'Espresso pha loãng với nước đá trong trẻo, đánh thức mọi giác quan.', '1774168803431_AMERICANO_DA.jpg', 35000, 1),
	(18, 1, 'Latte', 'Espresso với phần lớn sữa nóng và chút bọt sữa mỏng nhẹ.', '1774168986526_ca_phe_latte_la_gi_latte_co_vi_gi_latte_khac_gi_capuchino_202408161122.jpg', 49000, 1),
	(19, 1, 'Cappuccino', 'Tách cà phê Ý truyền thống với lượng bọt sữa, espresso và sữa bằng nhau.', '1774168842825_cappuccino_cafe_cua_y.jpg', 49000, 1),
	(20, 1, 'Mocha Nóng', 'Sự kết hợp hoàn hảo giữa Chocolate ngọt ngào và Espresso mạnh mẽ.', '1774169416576_ca_phe_mocha_nong.webp', 55000, 1),
	(21, 1, 'Flat White', 'Phiên bản cà phê đậm vị sữa nhưng dịu nhẹ hơn Latte.', '1774169434163_d_m_how_to_slot_1_large_2.avif', 45000, 1),
	(22, 1, 'Caramel Macchiato Nóng', 'Cà phê vani thơm ngát kết hợp cùng caramel béo ngọt và espresso.', '1774169462636_cach_lam_caramel_macchiato_thumb_b2c933a8cb.webp', 55000, 1),
	(23, 2, 'Trà Đào Cam Sả', 'Trà đào được biến tấu cùng cam sả mang lại hương vị the mát.', '1774169507438_tra_dao_cam_sa_ngot_ngao.webp', 45000, 1),
	(24, 2, 'Trà Vàng Mật Ong', 'Trà đen hòa cùng mật ong rừng, thích hợp giải nhiệt mùa hè.', '1774169538467_c3_299a3b22ea284f61845786cef7ce46c8_grande.jpg', 39000, 1),
	(25, 2, 'Trà Lựu Đỏ', 'Vị trà thanh lịch kết hợp cùng nước ép lựu tươi đỏ mọng.', '1774169559361_cach_pha_tra_luu_do_7_103562cb04.jpg', 49000, 1),
	(26, 2, 'Trà Dâu Tây Lắc', 'Trà xanh lài nhài kết hợp cùng mứt dâu tây tươi mát lạnh.', '1774169581530_thanh_pham_1195.jpg', 49000, 1),
	(27, 2, 'Trà Táo Bạc Hà', 'Hương vị táo giòn rụm kết hợp bạc hà mát lạnh xua tan nắng nóng.', '1774170589357_Tr__T_o_B_c_H_.jpg', 45000, 1),
	(28, 2, 'Trà Xoài Chanh Dây', 'Vị xoài nhiệt đới hòa quyện cùng chanh dây chua chua ngọt ngọt.', '1774170599700_Tr__Xo_i_Chanh_D_y.png', 49000, 1),
	(29, 2, 'Trà Vải Hoa Hồng', 'Trà trái vải thanh tao được điểm xuyết bằng mùi hương hoa hồng tinh tế.', '1774170608510_Tr__V_i_Hoa_H_ng.png', 49000, 1),
	(30, 2, 'Trà Bưởi Hồng', 'Hương bưởi hồng the mát, mang lại vị thanh khiết thư giãn.', '1774170616106_Tr__B__i_H_ng.png', 55000, 1),
	(31, 2, 'Trà Nhãn Sen', 'Trà nhãn ngọt dịu cùng hạt sen thanh mát đậm chất Việt Nam.', '1774170631523_Tr__Nh_n_Sen.webp', 45000, 1),
	(32, 2, 'Trà Chanh Mật Ong', 'Trà chanh truyền thống làm dịu cổ họng với mật ong vàng.', '1774170981097_Tr__Chanh_M_t_Ong.jpg', 35000, 1),
	(33, 3, 'Cold Brew Truyền Thống', 'Cà phê ủ lạnh hơn 16 tiếng, giữ được vị mượt mà không đắng gắt.', '1774170969692_Cold_Brew_Truy_n_Th_ng.webp', 45000, 1),
	(34, 3, 'Cold Brew Cam Sả', 'Sự pha trộn kỳ lạ giữa Cold brew thơm dịu và cam sả sảng khoái.', '1774170990285_Cold_Brew_Cam_S_.jpg', 49000, 1),
	(35, 3, 'Cold Brew Sữa Macchiato', 'Cold brew phủ lên một lớp kem phô mai béo ngậy thượng hạng.', '1774171741593_Cold_Brew_S_a_Macchiato.jpg', 55000, 1),
	(36, 3, 'Cà Phê Ủ Lạnh Vani', 'Cà phê ủ tươi nguyên chất kết hợp cùng chiết xuất vani cao cấp.', '1774171752408_C__Ph____L_nh_Vani.png', 49000, 1),
	(37, 3, 'Cà Phê Sữa Dừa Tuyết', 'Sữa dừa tuyết đông lạnh hòa quyện cùng cốt cà phê espresso.', '1774171759627_C__Ph__S_a_D_a_Tuy_t.jpg', 55000, 1),
	(38, 3, 'Trà Sữa Oolong Nướng', 'Vị trà Oolong sấy than nướng đặc trưng, kết hợp cùng sữa tươi.', '1774171793939_images.jpg', 45000, 1),
	(39, 3, 'Trà Sữa Thái Xanh', 'Hương trà Thái rực rỡ mang vị thanh mát truyền thống Thái Lan.', '1774171803027_cach_lam_tra_sua_thai_xanh.jpg', 39000, 1),
	(40, 3, 'Trà Sữa Trân Châu Koko', 'Trà sữa đen nguyên bản cùng 2 porsion trân châu mật đen giòn.', '1774171819905_Tr__S_a_Tr_n_Ch_u_Koko.jpeg', 45000, 1),
	(41, 3, 'Cà Phê Kem Phô Mai', 'Sự pha trộn trứ danh của Cà phê và lớp Cheese béo ngậy thần thánh.', '1774171828058_C__Ph__Kem_Ph__Mai.jpg', 59000, 1),
	(42, 3, 'Trà Sâm Dứa Sữa', 'Hương dứa truyền thống béo thơm từ sữa, ngọt ngào tuổi thơ.', '1774171834584_Tr__S_m_D_a_S_a.webp', 35000, 1),
	(43, 4, 'Bánh Croissant Bơ Pháp', 'Bánh sừng bò ngàn lớp thơm lừng bơ Pháp cao cấp.', '1774171864033_B_nh_Croissant_B__Ph_p.jpg', 25000, 1),
	(44, 4, 'Bánh Sừng Trâu Phô Mai', 'Phiên bản cải tiến nhân phô mai chảy béo ngậy bên trong hạt hạnh nhân.', '1774271545572_65535_53942003026_11d8356907_z_400_400_nofilter.jpg', 35000, 1),
	(45, 4, 'Bánh Mousse Trà Xanh', 'Bánh Mousse mềm mịn với lớp trà xanh chát nhẹ, tan trong miệng.', '1774271584744_banh_mousse_ea00bf53f9ff483ea10fa0d8f17f1c18.jpg', 45000, 1),
	(46, 4, 'Bánh Mousse Dâu Tây', 'Mousse dâu tươi được phủ sốt dâu đỏ au hấp dẫn.', '1774271633937_Banh_mousse_dautay_kisinfood_KISIN_0350.jpg', 45000, 1),
	(47, 4, 'Bánh Phô Mai Nướng', 'Basque Cheesecake đặc biệt với vỏ bánh hơi xém, lõi mềm nhão béo ngậy.', '1774271683360_unnamed.jpg', 49000, 1),
	(48, 4, 'Bánh Socola Lava', 'Socola đen nướng chảy nóng hổi từ trong lõi ra.', '1774271700235_MON_PHU_MB_Choco_Lava.jpg', 55000, 1),
	(49, 4, 'Bánh Mì Bơ Tỏi (Korea)', 'Bánh mì nướng bơ tỏi kẹp bơ tỏi phô mai sốt kem Hàn Quốc.', '1774271715541_banh_mi_bo_toi_han_quoc_da_nang13.jpg', 39000, 1),
	(50, 4, 'Bánh Donut Vani', 'Donut socola hoặc vani rắc đường màu bắt mắt.', '1774271753876_upload_2ba1557aa9b24a3f8d2953c8199106f4_grande.jpg', 25000, 1),
	(51, 4, 'Bánh Tart Trứng', 'Vỏ lớp tart ngàn lớp cùng nhân trứng béo vàng ươm.', '1774271771070_2024_2_29_638447616936343098_bia.webp', 19000, 1);

CREATE TABLE IF NOT EXISTS `guests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `point` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `guests`;
INSERT INTO `guests` (`id`, `fullname`, `phone_number`, `point`) VALUES
	(1, '0911532866', 'Bui Duc Tri', 226);

CREATE TABLE IF NOT EXISTS `guest_vouchers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `guest_id` int NOT NULL,
  `voucher_id` int NOT NULL,
  `is_used` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `guest_id` (`guest_id`),
  KEY `voucher_id` (`voucher_id`),
  CONSTRAINT `guest_vouchers_ibfk_1` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`id`),
  CONSTRAINT `guest_vouchers_ibfk_2` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `guest_vouchers`;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `users`;
INSERT INTO `users` (`id`, `email`, `password`, `full_name`, `phone`, `role`, `active`) VALUES
	(1, 'chez1s.dev@gmail.com', 'cz', 'Bùi Đức Trí', '0901234567', 1, 1),
	(2, 'haunvtv00054@fpt.edu.vn', '123', 'Nguyễn Vủ Hậu', '0907654321', 0, 1),
	(3, 'demo@polycoffee.com', '123', 'Trợ Lý Khách Hàng', '0123456789', 0, 1),
	(4, 'balam@polycoffee.com', '123', 'Bá Lãm', '0123456789', 0, 1),
	(5, 'giabao@polycoffee.com', '123', 'Gia Bảo', '0123456789', 0, 1),
	(6, 'leminh@polycoffee.com', '123', 'Lê Minh', '0123456789', 0, 1);

CREATE TABLE IF NOT EXISTS `vouchers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `required_points` int NOT NULL,
  `discount_amount` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `vouchers`;
INSERT INTO `vouchers` (`id`, `name`, `required_points`, `discount_amount`) VALUES
	(1, 'Giảm 10.000đ', 10, 10000),
	(2, 'Giảm 25.000đ', 25, 25000),
	(3, 'Giảm 50.000đ', 45, 50000);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
