/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : department_store_retail

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 10/02/2025 17:38:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `product_id` int(11) NOT NULL COMMENT '商品ID',
  `quantity` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (6, 8, 101, 8, '2025-02-08 14:05:45');
INSERT INTO `cart` VALUES (7, 14, 100, 2, '2025-02-09 16:40:51');
INSERT INTO `cart` VALUES (8, 14, 100, 2, '2025-02-09 16:49:13');
INSERT INTO `cart` VALUES (9, 14, 100, 2, '2025-02-09 16:49:15');
INSERT INTO `cart` VALUES (10, 14, 100, 2, '2025-02-09 16:49:16');
INSERT INTO `cart` VALUES (11, 14, 100, 2, '2025-02-09 16:49:17');
INSERT INTO `cart` VALUES (12, 14, 100, 2, '2025-02-09 16:49:19');
INSERT INTO `cart` VALUES (13, 14, 100, 2, '2025-02-09 16:49:20');
INSERT INTO `cart` VALUES (14, 14, 100, 2, '2025-02-09 16:49:21');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品分类ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '商品分类名',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '饮料', 2);
INSERT INTO `categories` VALUES (3, '文具', 2);
INSERT INTO `categories` VALUES (4, '食品', 2);
INSERT INTO `categories` VALUES (5, '生活', 2);
INSERT INTO `categories` VALUES (6, '电子', 2);
INSERT INTO `categories` VALUES (7, '衣物', 2);
INSERT INTO `categories` VALUES (23, '未命名', 10);
INSERT INTO `categories` VALUES (24, '未命名', 1000);

-- ----------------------------
-- Table structure for limited_products
-- ----------------------------
DROP TABLE IF EXISTS `limited_products`;
CREATE TABLE `limited_products`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '限购商品ID',
  `product_id` int(11) NOT NULL COMMENT '商品ID，关联 products 表',
  `limit_quantity` int(11) NOT NULL COMMENT '每个用户的限购数量',
  `limit_timeframe` enum('daily','weekly','monthly','once') CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'once' COMMENT '限购周期',
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品限购规则创建日期',
  `end_date` datetime NOT NULL COMMENT '限购结束日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_product`(`product_id`) USING BTREE,
  CONSTRAINT `fk_limited_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of limited_products
-- ----------------------------
INSERT INTO `limited_products` VALUES (2, 123, 10, 'monthly', '2025-02-10 16:41:53', '2025-03-10 16:41:53');

-- ----------------------------
-- Table structure for limited_purchases
-- ----------------------------
DROP TABLE IF EXISTS `limited_purchases`;
CREATE TABLE `limited_purchases`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '购买记录ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID，关联 users 表',
  `product_id` int(11) NOT NULL COMMENT '商品ID，关联 products 表',
  `purchased_quantity` int(11) NOT NULL DEFAULT 0 COMMENT '用户已购买数量',
  `purchase_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '购买时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of limited_purchases
-- ----------------------------
INSERT INTO `limited_purchases` VALUES (1, 14, 123, 2, '2025-02-10 15:04:01');
INSERT INTO `limited_purchases` VALUES (2, 14, 123, 2, '2025-02-10 08:22:16');
INSERT INTO `limited_purchases` VALUES (3, 15, 123, 4, '2025-02-10 08:22:33');
INSERT INTO `limited_purchases` VALUES (4, 16, 123, 4, '2025-02-10 08:42:00');

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单详情ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '商品ID',
  `quantity` int(11) NOT NULL COMMENT '商品数量',
  `price` decimal(10, 2) NOT NULL COMMENT '商品单价',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES (1, 5, 101, 2, 99.99, '2025-02-08 19:23:59');
INSERT INTO `order_details` VALUES (2, 6, 101, 2, 99.99, '2025-02-08 19:26:06');
INSERT INTO `order_details` VALUES (3, 7, 101, 2, 99.99, '2025-02-08 19:26:49');
INSERT INTO `order_details` VALUES (5, 9, 101, 2, 99.99, '2025-02-08 19:29:06');
INSERT INTO `order_details` VALUES (13, 16, 100, 2, 99.99, '2025-02-09 16:57:52');
INSERT INTO `order_details` VALUES (14, 17, 100, 2, 99.99, '2025-02-09 16:57:57');
INSERT INTO `order_details` VALUES (15, 18, 100, 2, 99.99, '2025-02-09 16:57:58');
INSERT INTO `order_details` VALUES (16, 19, 100, 2, 99.99, '2025-02-09 16:57:59');
INSERT INTO `order_details` VALUES (17, 20, 100, 2, 99.99, '2025-02-09 16:58:00');
INSERT INTO `order_details` VALUES (18, 21, 100, 2, 99.99, '2025-02-09 16:58:01');
INSERT INTO `order_details` VALUES (19, 22, 100, 2, 99.99, '2025-02-09 16:58:02');
INSERT INTO `order_details` VALUES (20, 23, 100, 2, 99.99, '2025-02-09 16:58:03');
INSERT INTO `order_details` VALUES (21, 24, 100, 2, 99.99, '2025-02-09 16:58:04');
INSERT INTO `order_details` VALUES (22, 25, 100, 2, 99.99, '2025-02-09 16:58:05');
INSERT INTO `order_details` VALUES (23, 26, 100, 2, 99.99, '2025-02-09 16:58:07');
INSERT INTO `order_details` VALUES (24, 27, 100, 2, 99.99, '2025-02-09 16:58:08');
INSERT INTO `order_details` VALUES (25, 28, 100, 2, 99.99, '2025-02-09 16:58:09');
INSERT INTO `order_details` VALUES (26, 29, 100, 2, 99.99, '2025-02-09 16:58:10');
INSERT INTO `order_details` VALUES (27, 30, 100, 2, 99.99, '2025-02-09 16:58:11');
INSERT INTO `order_details` VALUES (28, 31, 100, 2, 99.99, '2025-02-09 16:58:13');
INSERT INTO `order_details` VALUES (29, 32, 100, 2, 99.99, '2025-02-09 16:58:14');
INSERT INTO `order_details` VALUES (30, 33, 100, 2, 99.99, '2025-02-09 17:35:08');
INSERT INTO `order_details` VALUES (31, 33, 100, 2, 99.99, '2025-02-09 17:35:08');
INSERT INTO `order_details` VALUES (32, 33, 100, 2, 99.99, '2025-02-09 17:35:08');
INSERT INTO `order_details` VALUES (33, 33, 100, 2, 99.99, '2025-02-09 17:35:08');
INSERT INTO `order_details` VALUES (34, 34, 100, 2, 99.99, '2025-02-09 17:35:13');
INSERT INTO `order_details` VALUES (35, 34, 100, 2, 99.99, '2025-02-09 17:35:13');
INSERT INTO `order_details` VALUES (36, 34, 100, 2, 99.99, '2025-02-09 17:35:13');
INSERT INTO `order_details` VALUES (37, 34, 100, 2, 99.99, '2025-02-09 17:35:13');
INSERT INTO `order_details` VALUES (38, 35, 100, 2, 99.99, '2025-02-09 17:35:15');
INSERT INTO `order_details` VALUES (39, 35, 100, 2, 99.99, '2025-02-09 17:35:15');
INSERT INTO `order_details` VALUES (40, 35, 100, 2, 99.99, '2025-02-09 17:35:15');
INSERT INTO `order_details` VALUES (41, 35, 100, 2, 99.99, '2025-02-09 17:35:15');
INSERT INTO `order_details` VALUES (42, 36, 100, 2, 99.99, '2025-02-09 17:35:16');
INSERT INTO `order_details` VALUES (43, 36, 100, 2, 99.99, '2025-02-09 17:35:16');
INSERT INTO `order_details` VALUES (44, 36, 100, 2, 99.99, '2025-02-09 17:35:16');
INSERT INTO `order_details` VALUES (45, 36, 100, 2, 99.99, '2025-02-09 17:35:16');
INSERT INTO `order_details` VALUES (46, 37, 100, 2, 99.99, '2025-02-09 17:35:17');
INSERT INTO `order_details` VALUES (47, 37, 100, 2, 99.99, '2025-02-09 17:35:17');
INSERT INTO `order_details` VALUES (48, 37, 100, 2, 99.99, '2025-02-09 17:35:17');
INSERT INTO `order_details` VALUES (49, 37, 100, 2, 99.99, '2025-02-09 17:35:17');
INSERT INTO `order_details` VALUES (50, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (51, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (52, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (53, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (54, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (55, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (56, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (57, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (58, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (59, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (60, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (61, 38, 100, 2, 99.99, '2025-02-09 17:35:26');
INSERT INTO `order_details` VALUES (63, 39, 100, 2, 100.00, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (64, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (65, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (66, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (67, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (68, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (69, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (70, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (71, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (72, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (73, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (74, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (75, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (76, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (77, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (78, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (79, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (80, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (81, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (82, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (83, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (84, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (85, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (86, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (87, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (88, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (89, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (90, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (91, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (92, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (93, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (94, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (95, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (96, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (97, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (98, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (99, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (100, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (101, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (102, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (103, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (104, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (105, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (106, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (107, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (108, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (109, 39, 100, 2, 99.99, '2025-02-09 17:35:41');
INSERT INTO `order_details` VALUES (110, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (111, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (112, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (113, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (114, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (115, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (116, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (117, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (118, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (119, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (120, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (121, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (122, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (123, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (124, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (125, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (126, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (127, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (128, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (129, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (130, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (131, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (132, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (133, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (134, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (135, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (136, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (137, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (138, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (139, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (140, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (141, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (142, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (143, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (144, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (145, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (146, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (147, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (148, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (149, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (150, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (151, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (152, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (153, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (154, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (155, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (156, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (157, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (158, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (159, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (160, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (161, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (162, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (163, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (164, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (165, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (166, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (167, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (168, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (169, 40, 100, 2, 99.99, '2025-02-09 17:35:45');
INSERT INTO `order_details` VALUES (170, 41, 100, 2, 99.99, '2025-02-09 17:35:52');
INSERT INTO `order_details` VALUES (171, 39, 103, 2, 1000.00, '2025-02-09 17:41:35');
INSERT INTO `order_details` VALUES (172, 42, 100, 2, 99.99, '2025-02-10 12:55:46');
INSERT INTO `order_details` VALUES (173, 43, 100, 2, 99.99, '2025-02-10 12:59:32');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `status` int(11) NULL DEFAULT 0 COMMENT '订单状态 0待付款、1已付款、2已发货、3已送达、4已取件、5已取消、6已退款',
  `total_price` decimal(10, 2) NOT NULL COMMENT '订单金额',
  `product_id` int(11) NULL DEFAULT NULL COMMENT '商品ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (5, 8, 1, 199.99, NULL, '2025-02-08 12:00:00');
INSERT INTO `orders` VALUES (6, 8, 1, 199.99, NULL, '2025-02-08 19:26:06');
INSERT INTO `orders` VALUES (7, 8, 1, 199.99, 101, '2025-02-08 19:26:49');
INSERT INTO `orders` VALUES (9, 8, 1, 199.99, 101, '2025-02-08 19:29:06');
INSERT INTO `orders` VALUES (16, 14, 1, 199.98, 800, '2025-02-09 16:57:52');
INSERT INTO `orders` VALUES (17, 14, 1, 199.98, 800, '2025-02-09 16:57:57');
INSERT INTO `orders` VALUES (18, 14, 1, 199.98, 800, '2025-02-09 16:57:59');
INSERT INTO `orders` VALUES (19, 14, 1, 199.98, 800, '2025-02-09 16:58:00');
INSERT INTO `orders` VALUES (20, 14, 1, 199.98, 800, '2025-02-09 16:58:01');
INSERT INTO `orders` VALUES (21, 14, 1, 199.98, 800, '2025-02-09 16:58:02');
INSERT INTO `orders` VALUES (22, 14, 1, 199.98, 800, '2025-02-09 16:58:03');
INSERT INTO `orders` VALUES (23, 14, 1, 199.98, 800, '2025-02-09 16:58:04');
INSERT INTO `orders` VALUES (24, 14, 1, 199.98, 800, '2025-02-09 16:58:05');
INSERT INTO `orders` VALUES (25, 14, 1, 199.98, 800, '2025-02-09 16:58:06');
INSERT INTO `orders` VALUES (26, 14, 1, 199.98, 800, '2025-02-09 16:58:07');
INSERT INTO `orders` VALUES (27, 14, 1, 199.98, 800, '2025-02-09 16:58:09');
INSERT INTO `orders` VALUES (28, 14, 1, 199.98, 800, '2025-02-09 16:58:10');
INSERT INTO `orders` VALUES (29, 14, 1, 199.98, 800, '2025-02-09 16:58:11');
INSERT INTO `orders` VALUES (30, 14, 1, 199.98, 800, '2025-02-09 16:58:12');
INSERT INTO `orders` VALUES (31, 14, 1, 199.98, 800, '2025-02-09 16:58:14');
INSERT INTO `orders` VALUES (32, 14, 1, 199.98, 800, '2025-02-09 16:58:15');
INSERT INTO `orders` VALUES (33, 14, 1, 799.92, 800, '2025-02-09 17:35:08');
INSERT INTO `orders` VALUES (34, 14, 1, 799.92, 800, '2025-02-09 17:35:14');
INSERT INTO `orders` VALUES (35, 14, 1, 799.92, 800, '2025-02-09 17:35:15');
INSERT INTO `orders` VALUES (36, 14, 1, 799.92, 800, '2025-02-09 17:35:16');
INSERT INTO `orders` VALUES (37, 14, 1, 799.92, 800, '2025-02-09 17:35:18');
INSERT INTO `orders` VALUES (38, 14, 1, 2399.76, 800, '2025-02-09 17:35:26');
INSERT INTO `orders` VALUES (39, 14, 1, 9599.04, 800, '2025-02-09 17:35:41');
INSERT INTO `orders` VALUES (40, 14, 1, 11998.80, 800, '2025-02-09 17:35:46');
INSERT INTO `orders` VALUES (41, 14, 1, 199.98, 800, '2025-02-09 17:35:52');
INSERT INTO `orders` VALUES (42, 14, 1, 199.98, 101, '2025-02-10 12:55:46');
INSERT INTO `orders` VALUES (43, 14, 1, 179.98, 101, '2025-02-10 12:59:33');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '商品名',
  `model` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '商品型号',
  `info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品信息',
  `price` decimal(10, 2) NOT NULL COMMENT '商品价钱',
  `category` int(11) NOT NULL COMMENT '分类ID',
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '商品图片',
  `inventory` int(11) NULL DEFAULT 0 COMMENT '库存量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '商品修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 310 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (5, '柠檬水', '', '这是一款真正的好柠檬水，用柠檬制成的柠檬就像穆尔西亚的果园一样真实。正宗的柠檬味蘸酱！ 它含有恰到好处的水、糖和柠檬的组合，具有完美的甜味和清爽的味道。此外，此食谱中的柠檬来自穆尔西亚，我们是那里为我们的饮料获取最佳原材料的专家。', 2.00, 101, '1738921879999_VN-limonada-750ml.webp', 3000, '2025-02-07 17:51:20', '2025-02-07 17:51:20');
INSERT INTO `products` VALUES (6, '热带羽衣甘蓝', '好喝型', '水果、羽衣甘蓝和朝鲜蓟的营养健康组合，有助于促进消化，具有非常自然的味道。羽衣甘蓝的多种特性和好处使这种蔬菜越来越受到追捧。', 2.00, 101, '1738921993985_VN_mockup_Kale_750ml_2025.webp', 3000, '2025-02-07 17:53:13', '2025-02-08 19:12:38');
INSERT INTO `products` VALUES (7, '燕麦片-香蕉-椰子在旅途中', '', '对于燕麦片爱好者来说非常方便的形式，因为他们可以随时食用。具有非常特殊风味的食谱，消费者总是重复。', 2.00, 101, '1738922035405_VN_mockup_Avena-Coco_250ml_2025.webp', 3000, '2025-02-07 17:53:55', '2025-02-07 17:53:55');
INSERT INTO `products` VALUES (8, '燕麦片-草莓-香蕉饮料', '', '我们最新的伟大创新！草莓、香蕉和燕麦片在冰镇饮料中：奶油味和正宗风味的独特结合。市场上任何时间的特殊和不同的食谱。100% 天然燕麦和水果！', 2.00, 101, '1738922053172_VN_mockup_Avena_fresa_750ml_2025.webp', 3000, '2025-02-07 17:54:13', '2025-02-07 17:54:13');
INSERT INTO `products` VALUES (9, '燕麦片-香蕉-椰子', '123123', '燕麦片系列最理想的组合。水果和谷物的惊人组合，营养丰富，营养丰富，非常适合早餐和小吃。', 2.00, 101, '1738922071635_VN_mockup_Avena_coco_750ml_2025.webp', 3000, '2025-02-07 17:54:31', '2025-02-07 17:54:31');
INSERT INTO `products` VALUES (10, '火龙果在旅途中', '', '享受我们最新的伟大创新！多种口味的组合，让您的夏天更加明亮。具有最多汁的热带风味和最精致的地中海风味。', 2.00, 101, '1738922089469_VN_mockup_DragonFruit_250ml_2025.webp', 3000, '2025-02-07 17:54:49', '2025-02-07 17:54:49');
INSERT INTO `products` VALUES (11, '芒果百香果', '', '补充能量和维生素，非常方便，便于携带和每天食用。', 2.00, 101, '1738922107086_VN_mockup_Mango_250ml_2025.webp', 3000, '2025-02-07 17:55:07', '2025-02-07 17:55:07');
INSERT INTO `products` VALUES (12, '热带羽衣甘蓝', '', '水果、羽衣甘蓝和朝鲜蓟的营养健康组合，有助于促进消化，具有非常自然的味道。羽衣甘蓝的多种特性和好处使这种蔬菜越来越受到追捧。', 2.00, 101, '1738922124361_VN_mockup_Kale_750ml_2025.webp', 3000, '2025-02-07 17:55:24', '2025-02-07 17:55:24');
INSERT INTO `products` VALUES (13, '红果', '', '用草莓、覆盆子和 Mollar de Elche 石榴制成的果汁，是唯一一种获得受保护原产地名称的果汁。这种石榴生长在地中海，那里的气候条件最适合种植，从而在酸度和甜度之间实现了更大的平衡。', 2.00, 101, '1738922138300_VN_mockup_Granada_750ml_2025.webp', 3000, '2025-02-07 17:55:38', '2025-02-07 17:55:38');
INSERT INTO `products` VALUES (14, '芒果-百香果', '', '富含天然人参和瓜拉纳提取物的热带水果的最佳组合。维生素的来源，提供所需的活力和额外能量，从而减轻疲劳和乏力感。我们最畅销的食谱之一。', 2.00, 101, '1738922151906_VN_mockup_Mango_750ml_2025.webp', 3000, '2025-02-07 17:55:51', '2025-02-07 17:55:51');
INSERT INTO `products` VALUES (15, '热带羽衣甘蓝', '', '营养丰富且完整的果汁，可促进消化系统健康，其优点是可以随身携带。', 2.00, 101, '1738922169600_VN_mockup_Kale_250ml_2025.webp', 3000, '2025-02-07 17:56:09', '2025-02-07 17:56:09');
INSERT INTO `products` VALUES (16, '螺旋藻', '', '水果和螺旋藻的清爽组合，非常适合最热的时期和您正在寻找清凉饮料的任何时候。螺旋藻的 100% 天然蓝色使其成为货架上独一无二的产品。', 2.00, 101, '1738922182435_VN_mockup_Espirulina_750ml_2025.webp', 3000, '2025-02-07 17:56:22', '2025-02-07 17:56:22');
INSERT INTO `products` VALUES (17, '橙', '', '这种果汁只含有榨橙子，没有添加剂或添加糖。100% 天然配方，维生素 C 含量高，有助于免疫系统的正常运作。', 2.00, 101, '1738922216384_VN_mockup_Naranja_750ml_2025.webp', 3000, '2025-02-07 17:56:56', '2025-02-07 17:56:56');
INSERT INTO `products` VALUES (18, '康普茶瓶装红果', '', '康普茶瓶装红果', 2.00, 101, '1738922513285_botella-fresa-300x300.jpg.webp', 3000, '2025-02-07 18:01:53', '2025-02-07 18:01:53');
INSERT INTO `products` VALUES (19, '康普茶橙和肉桂瓶', '', '康普茶橙和肉桂瓶', 2.00, 101, '1738922521501_botella-naranja-1-300x300.jpg.webp', 3000, '2025-02-07 18:02:01', '2025-02-07 18:02:01');
INSERT INTO `products` VALUES (20, '康普茶柠檬和螺旋藻瓶', '', '康普茶柠檬和螺旋藻瓶', 2.00, 101, '1738922529244_botella-limon-300x300.jpg.webp', 3000, '2025-02-07 18:02:09', '2025-02-07 18:02:09');
INSERT INTO `products` VALUES (21, '普茶姜&姜黄瓶', '', '普茶姜&姜黄瓶', 2.00, 101, '1738922548049_botella-curcuma-300x300.jpg.webp', 3000, '2025-02-07 18:02:28', '2025-02-07 18:02:28');
INSERT INTO `products` VALUES (22, '康普茶菠萝薄荷', '', '康普茶菠萝薄荷', 2.00, 101, '1738922559411_botella-pina-300x300.jpg.webp', 3000, '2025-02-07 18:02:39', '2025-02-07 18:02:39');
INSERT INTO `products` VALUES (23, '康普茶芒果', '', '康普茶芒果', 2.00, 101, '1738922567931_botella-mango-300x300.jpg.webp', 3000, '2025-02-07 18:02:47', '2025-02-07 18:02:47');
INSERT INTO `products` VALUES (24, '康普茶芒果', '', '康普茶芒果', 2.00, 101, '1738922638247_botellas_0005_Ready_0006_Botella.png', 3000, '2025-02-07 18:03:58', '2025-02-07 18:03:58');
INSERT INTO `products` VALUES (25, '饮料', '', '饮料', 2.00, 101, '1738922664126_MADREMONTE-CAFE.png', 3000, '2025-02-07 18:04:24', '2025-02-07 18:04:24');
INSERT INTO `products` VALUES (26, '饮料', '', '饮料', 2.00, 101, '1738922675203_botellas_0002_La-Original-Licuado-de-Avena-prisma-330-Tropical-v4.png', 3000, '2025-02-07 18:04:35', '2025-02-07 18:04:35');
INSERT INTO `products` VALUES (27, '饮料', '', '饮料', 2.00, 101, '1738922690629_botellas_0006_PURA-FRUTA_Pina-kiwi_PET_750ml_bala.png', 3000, '2025-02-07 18:04:50', '2025-02-07 18:04:50');
INSERT INTO `products` VALUES (28, '饮料', '', '饮料', 2.00, 101, '1738922700583_botellas_0009_734816-1L.-ZU-FRUTOS-ROJOS-20053933-000-02.png', 3000, '2025-02-07 18:05:00', '2025-02-07 18:05:00');
INSERT INTO `products` VALUES (29, '饮料', '', '饮料', 2.00, 101, '1738922713596_botellas_0000_733731-AUTENTICO-Limonada-Frambuesa-750-ml.png', 3000, '2025-02-07 18:05:13', '2025-02-07 18:05:13');
INSERT INTO `products` VALUES (30, '补水饮料 12 件装', '', '疯狂清爽的电解质饮料', 2.00, 101, '1738922952966_Rehydrating-Drink_Front_1200x.webp', 3000, '2025-02-07 18:09:12', '2025-02-07 18:09:12');
INSERT INTO `products` VALUES (31, '可可蜂蜜芝麻酱', '', '', 2.00, 102, '1738923363682_taxini_kakoa_meli-800x880.png', 3000, '2025-02-07 18:16:03', '2025-02-07 18:16:03');
INSERT INTO `products` VALUES (32, '芝麻酱', '', '说到野生芝麻酱，只有一个合适的描述：SUPERFOOD！', 2.00, 102, '1738923482679_taxini_sisami-800x880.png', 3000, '2025-02-07 18:18:02', '2025-02-07 18:18:02');
INSERT INTO `products` VALUES (33, '全麦芝麻酱', '', '双倍的芝麻酱风味搭配双倍的纤维等于强大的 SUPERFOOD x2！', 2.00, 102, '1738923519008_taxini_olikis.png', 3000, '2025-02-07 18:18:39', '2025-02-07 18:18:39');
INSERT INTO `products` VALUES (34, '高蛋白芝麻酱', '', '豌豆和芝麻是植物蛋白世界中充满活力的二重奏，联手创造了一种营养丰富的混合物。它们一起构成了 Wild！超级食物 x2，你我都受益！', 2.00, 102, '1738923594756_taxini_protein.png', 3000, '2025-02-07 18:19:54', '2025-02-07 18:19:54');
INSERT INTO `products` VALUES (35, 'Tahini 杏仁酱 Peanut Butter', '', '那是给你的 Wild Soul 和你不断的困境。冷静下来，因为我们已经有了答案！只需一勺芝麻酱配杏仁酱和花生酱，就充满了所有的美味和营养。', 2.00, 102, '1738923611941_taxini_amigdalo-fistiko.png', 3000, '2025-02-07 18:20:11', '2025-02-07 18:20:11');
INSERT INTO `products` VALUES (36, '芝麻酱配角豆糖浆', '', '角豆树（富含钙的甜美素食美食）和芝麻酱（终极超级食品）的相遇点燃了植物性蛋白质和无尽能量的狂野爆发！', 2.00, 102, '1738923624857_taxini_xaroypomelo.png', 3000, '2025-02-07 18:20:24', '2025-02-07 18:20:24');
INSERT INTO `products` VALUES (37, '椰子芝麻酱', '', '有谁不爱椰子的异国情调回味呢？谁能抗拒这种 SUPERFOOD 乐趣的神奇组合呢？', 2.00, 102, '1738923637507_taxini_karyda.png', 3000, '2025-02-07 18:20:37', '2025-02-07 18:20:37');
INSERT INTO `products` VALUES (38, '芝麻酱配亚麻籽', '', '植物性 Omega-3 脂肪酸的终极来源与植物性蛋白质和无限能量的终极来源相得益彰。', 2.00, 102, '1738923646803_taxini_linarosporo.png', 3000, '2025-02-07 18:20:46', '2025-02-07 18:20:46');
INSERT INTO `products` VALUES (39, '芝麻酱配奇亚籽', '', '亲爱的 Wild Soul，我们在您最喜欢的芝麻酱中添加了奇亚籽。为什么？获得超松脆的质地和额外的 SUPERFOOD 品质', 2.00, 102, '1738923659351_taxini_chia.png', 3000, '2025-02-07 18:20:59', '2025-02-07 18:20:59');
INSERT INTO `products` VALUES (40, '野生榛子果仁糖', '', '45% 磨碎的烤榛子、磨碎的烤腰果、有机椰子糖、脱脂可可。  称它为 Holy Butter 是有充分理由的！我们将您所有的童年回忆都装在一个罐子里，我们只是挑战您尝试一下！  是的，这是事实，野生榛子果仁糖刚刚从天堂降落在您的盘子里！你能承受这种乐趣吗？', 2.00, 102, '1738923700720_Pralina-Sticker.png', 3000, '2025-02-07 18:21:40', '2025-02-07 18:21:40');
INSERT INTO `products` VALUES (41, '花生酱', '', '100% 磨碎的烤花生  这是给你的特别款待，我的 Wild 朋友，迎合你超级活跃的生活方式和对健康美食的品味！别忘了，花生酱是让您绝对疯狂的首选小吃！', 2.00, 102, '1738923718155_fistikovoutiro-1.png', 3000, '2025-02-07 18:21:58', '2025-02-07 18:21:58');
INSERT INTO `products` VALUES (42, '花生酱配肉桂和枣', '', '磨碎的烤花生、枣 15%、肉桂 1%、MESSOLONGHI 盐', 2.00, 102, '1738923725751_2_with_shadow_.png', 3000, '2025-02-07 18:22:05', '2025-02-07 18:22:05');
INSERT INTO `products` VALUES (43, '花生酱脆', '', '100% 磨碎的烤花生  您心爱的野生花生酱，为您的日常冒险提供动力，现在以松脆的变化形式出现，以进一步提升您对它的热爱！', 2.00, 102, '1738923736547_fistikovoutiro_tragano.png', 3000, '2025-02-07 18:22:16', '2025-02-07 18:22:16');
INSERT INTO `products` VALUES (44, '杏仁酱', '', '准备好被超级营养、美味可口的杏仁酱所吸引，它不仅可以增强您的野生能量，还可以让您感觉更饱满，看起来更容光焕发！', 2.00, 102, '1738923746675_amigdalovoutiro.png', 3000, '2025-02-07 18:22:26', '2025-02-07 18:22:26');
INSERT INTO `products` VALUES (45, '杏仁黄油脆', '', '尽情享受一勺奶油松脆的杏仁酱，充满活力和美味——这是避开不必要的零食的理想方式，最重要的是，以前所未有的方式释放您的狂野一面！  共享', 2.00, 102, '1738923756237_amigdalovoutiro_tragano-1.png', 3000, '2025-02-07 18:22:36', '2025-02-07 18:22:36');
INSERT INTO `products` VALUES (46, '格兰诺拉麦片酱', '', '磨碎的烤杏仁、枣、初榨芝麻油、燕麦、芝麻、亚麻籽、肉桂、生姜', 2.00, 102, '1738923768395_Βούτυρο-Γκρανόλα.png', 3000, '2025-02-07 18:22:48', '2025-02-07 18:22:48');
INSERT INTO `products` VALUES (47, '杏仁黄油脆片配可可和枣', '', '准备好被我们罪恶、松脆、奶油和营养丰富的超级 Wild 零食所诱惑——它是如此美味甜美，以至于只吃一勺是不可能的。', 2.00, 102, '1738923780973_amigdalovoutiro_tragoano-xourmades_.png', 3000, '2025-02-07 18:23:00', '2025-02-07 18:23:00');
INSERT INTO `products` VALUES (48, '榛子酱', '', '榛子酱，这种美味的营养宝石，由于无数的原因，它作为我们的终极 Wild 最爱占有特殊的地位。', 2.00, 102, '1738923793311_fountoukovoutiro.png', 3000, '2025-02-07 18:23:13', '2025-02-07 18:23:13');
INSERT INTO `products` VALUES (49, '榛子酱松脆', '', '出于多种原因，榛子酱脆片是我们最喜爱的 Wild 美食——一种美味的营养美味。', 2.00, 102, '1738923803572_fountoukovoutiro_tragano.png', 3000, '2025-02-07 18:23:23', '2025-02-07 18:23:23');
INSERT INTO `products` VALUES (50, '芝麻油', '', '芝麻油是从果仁中提取的，而不是从芝麻壳中提取的。它是通过冷榨方法生产的，包括压碎种子并通过压力挤出油。通过这种方式，我们心爱的野生芝麻酱也被制作出来。它由 85% 的单不饱和脂肪酸和多不饱和脂肪酸组成，天然不含胆固醇或反式不饱和脂肪。它富含健康脂肪酸、维生素 K，具有很高的抗氧化功能。', 2.00, 102, '1738923828234_sesame_oil_big_.png', 3000, '2025-02-07 18:23:48', '2025-02-07 18:23:48');
INSERT INTO `products` VALUES (51, '来自 Mani 的野生香草蜂蜜', '', '如果我们能想象到绝对的野外景色，我们肯定会把它放在玛尼半岛。正是贫瘠和干燥的景观营造出一种电影般的充满希望的氛围。 这种 Mani 的狂野性就是我们获得这种美味蜂蜜的原因。', 2.00, 102, '1738923845403_wild_herb_honey_mani.png', 3000, '2025-02-07 18:24:05', '2025-02-07 18:24:05');
INSERT INTO `products` VALUES (52, '来自奥林匹斯山的野花蜂蜜', '', '奥林巴斯。希腊最高的山峰不是没有原因的。这是一个独特的遗产，伴随着充满冒险、爱情、秘密和激情的故事。（是的，这很容易成为一部长达 20 年的肥皂剧的舞台）。', 2.00, 102, '1738923855468_wild_flower_honey_olympus.png', 3000, '2025-02-07 18:24:15', '2025-02-07 18:24:15');
INSERT INTO `products` VALUES (53, '来自克里特岛的野生百里香蜂蜜', '', '克里特。它是希腊最南端的地区，对一些人来说，它是世界上最美丽的岛屿之一。如果您还没有从一端到另一端进行公路旅行，我们强烈建议您开始计划它。在克里特岛美食中，蜂蜜是甜味和咸味创作中的明星和关键成分。', 2.00, 102, '1738923867744_wild_honey_crete.png', 3000, '2025-02-07 18:24:27', '2025-02-07 18:24:27');
INSERT INTO `products` VALUES (54, '苹果肉桂果酱配葡萄汁圣诞版', '', '苹果浓缩葡萄汁、柠檬汁、肉桂 （0.1）。每 100 克果酱用 70 克水果准备。每 66 克果酱的糖总含量为 100 克', 2.00, 102, '1738923894326_apple_cinnamon_jam_1.png', 3000, '2025-02-07 18:24:54', '2025-02-07 18:24:54');
INSERT INTO `products` VALUES (55, 'Forest Fruits 葡萄汁果酱', '', '草莓、覆盆子、蓝莓、浓缩葡萄汁和柠檬汁的混合物，每批每 100 克含有 70 克水果。每 62 克总糖含量为 100 克。', 2.00, 102, '1738923904168_forest_fruit.png', 3000, '2025-02-07 18:25:04', '2025-02-07 18:25:04');
INSERT INTO `products` VALUES (56, '杏酱配葡萄汁', '', '杏子、浓缩葡萄汁和柠檬汁的美味混合物，每 100 克含有 70 克水果。每 62 克含有 100 克总糖含量。', 2.00, 102, '1738923913610_apricot-jam-1.png', 3000, '2025-02-07 18:25:13', '2025-02-07 18:25:13');
INSERT INTO `products` VALUES (57, '芒果酱配葡萄汁', '', '芒果、浓缩葡萄汁和柠檬汁的令人愉悦的混合物，每 100 克含有 70 克水果。每 62 克含有 100 克总糖含量。', 2.00, 102, '1738923924867_mango.png', 3000, '2025-02-07 18:25:24', '2025-02-07 18:25:24');
INSERT INTO `products` VALUES (58, '葡萄汁草莓酱', '', '草莓、浓缩葡萄汁和柠檬汁的令人愉悦的混合物，每 100 克含有 70 克水果。每 62 克含有 100 克总糖含量。', 2.00, 102, '1738923935564_strawberry.png', 3000, '2025-02-07 18:25:35', '2025-02-07 18:25:35');
INSERT INTO `products` VALUES (59, '葡萄汁无花果酱', '', '无花果、浓缩葡萄汁、柠檬汁。每 100 克含 70 克水果。总糖含量 62 克每 100 克。', 2.00, 102, '1738923943527_grape_juice.png', 3000, '2025-02-07 18:25:43', '2025-02-07 18:25:43');
INSERT INTO `products` VALUES (60, '葡萄汁橙果酱', '', '橙子、浓缩葡萄汁、柠檬汁。每 100 克含 55 克水果。糖的总含量为每 63 克 100 克。', 2.00, 102, '1738923954299_jam_orang.png', 3000, '2025-02-07 18:25:54', '2025-02-07 18:25:54');
INSERT INTO `products` VALUES (61, '蜂蜜和杏仁酥糖', '', 'TAHINI（芝麻粉） 蜂蜜 43% 杏仁 7% 皂角提取物', 2.00, 103, '1738924041252_2a.png', 3000, '2025-02-07 18:27:21', '2025-02-07 18:27:21');
INSERT INTO `products` VALUES (62, '可可和蜂蜜酥料', '', 'AHINI（芝麻粉） 蜂蜜 41% DEFFATED 可可 5% 皂角提取物', 2.00, 103, '1738924055886_5_a.png', 3000, '2025-02-07 18:27:35', '2025-02-07 18:27:35');
INSERT INTO `products` VALUES (63, '酥糖配腰果和蜂蜜', '', 'TAHINI（芝麻粉） 蜂蜜 43% 腰果 7% 皂角提取物', 2.00, 103, '1738924063184_3_a-1.png', 3000, '2025-02-07 18:27:43', '2025-02-07 18:27:43');
INSERT INTO `products` VALUES (64, '花生酱蜂蜜酥糖', '', '花生酱 蜂蜜 35% 川尼 EXTRAC', 2.00, 103, '1738924071446_7.png', 3000, '2025-02-07 18:27:51', '2025-02-07 18:27:51');
INSERT INTO `products` VALUES (65, '榛子酱蜂蜜酥糖', '', '榛子酱 蜂蜜 47% 皂角提取物', 2.00, 103, '1738924079137_6.png', 3000, '2025-02-07 18:27:59', '2025-02-07 18:27:59');
INSERT INTO `products` VALUES (66, '酥糖配核桃、肉桂和蜂蜜', '', 'TAHINI（圆芝麻） 蜂蜜 43% 核桃 7% 肉桂 CHUENI 提取物', 2.00, 103, '1738924093017_9_a.png', 3000, '2025-02-07 18:28:13', '2025-02-07 18:28:13');
INSERT INTO `products` VALUES (67, '蜂蜜酥糖', '', 'TAHINI（芝麻粉） 蜂蜜 49% 皂角提取物', 2.00, 103, '1738924107651_1.png', 3000, '2025-02-07 18:28:27', '2025-02-07 18:28:27');
INSERT INTO `products` VALUES (68, '开心果和蜂蜜酥料', '', 'TAHINI（芝麻粉） 蜂蜜 43% PISTACHIOS 7% 皂角提取物', 2.00, 103, '1738924116203_4a.png', 3000, '2025-02-07 18:28:36', '2025-02-07 18:28:36');
INSERT INTO `products` VALUES (69, '烤芝麻', '', '健康的骨骼和牙齿（钙 + 镁/锰 + 健康脂肪 + 蛋白质） 降低总胆固醇水平和低密度脂蛋白（木脂素：sesamines，sesamol） 良好的神经系统功能 饥饿控制（维生素 B1 或硫胺素、维生素 B3 或烟酸） 提高碳水化合物/脂肪酸的代谢率。', 2.00, 103, '1738924158023_1_0015_17-Sesame-Seeds.png', 3000, '2025-02-07 18:29:18', '2025-02-07 18:29:18');
INSERT INTO `products` VALUES (70, '烤全芝麻', '', '蛋白质 增强免疫系统 正常的神经功能 蛋白质/碳水化合物/脂肪酸的代谢率提高（维生素 B6） 纤维的完美来源（对肠道健康至关重要） 降低胆固醇 矿物质的高效性', 2.00, 103, '1738924169251_1_0013_18-Whole-Sesame.png', 3000, '2025-02-07 18:29:29', '2025-02-07 18:29:29');
INSERT INTO `products` VALUES (71, '烤花生', '', '蛋白质冠军 （25%）！ 健康的血管和心脏（白藜芦醇、钾、镁、单不饱和脂肪酸 ）。 抗氧化和抗衰老特性（维生素E，白藜芦醇）。 良好的神经/消化系统功能。 提高碳水化合物/脂肪酸的代谢率。', 2.00, 103, '1738924177721_1_0003_02-Roasted-Peanuts.png', 3000, '2025-02-07 18:29:37', '2025-02-07 18:29:37');
INSERT INTO `products` VALUES (72, '生杏仁', '', '生杏仁：大自然完美的维生素 E 来源！享受其整体优势：  通过钾、镁、单不饱和脂肪和纤维支持健康的血管和心脏功能。 用钙、磷、锰、镁、脂肪和蛋白质的混合物强化骨骼和牙齿。 提高和生育能力，同时利用维生素 E、锌和铜的优效抗氧化特性。 使用维生素 E、维生素 B2（核黄素）和磷增强视力。 用富含镁和纤维的新盟友滋养您的胃，促进消化和谐。', 2.00, 103, '1738924188915_1_0006_08-Almond.png', 3000, '2025-02-07 18:29:48', '2025-02-07 18:29:48');
INSERT INTO `products` VALUES (73, '烤杏仁', '', '烤杏仁，您的终极维生素 E 能量源！用每一口提升您的健康：  用钾、镁、单不饱和脂肪和纤维滋养您的血管和心脏。 通过钙、磷、锰、镁、脂肪和蛋白质的完美混合物来强化您的骨骼和牙齿。 提高和生育能力，同时受益于其含有维生素 E、锌和铜的强大抗氧化作用。 用维生素 E、维生素 B2（核黄素）和磷增强视力。 用镁和纤维呵护您的胃，促进消化健康。', 2.00, 103, '1738924197186_1_0007_09-Roasted-Almond.png', 3000, '2025-02-07 18:29:57', '2025-02-07 18:29:57');
INSERT INTO `products` VALUES (74, '生去皮杏仁', '', '维生素 E 的完美来源 健康的血管和心脏（钾、镁、单不饱和脂肪和纤维） 强健骨骼和牙齿（钙/磷 + 锰/镁 + 脂肪 + 蛋白质） 和生育能力，强大的抗氧化作用（维生素Ε，锌，铜） 对视力有益（维生素 Ε、维生素 B2 或核黄素、磷） 你的胃刚刚找到了它最好的朋友（镁、纤维）', 2.00, 103, '1738924204753_1_0005_06-Almond-Pearl.png', 3000, '2025-02-07 18:30:04', '2025-02-07 18:30:04');
INSERT INTO `products` VALUES (75, '烤焯水杏仁', '', '维生素 E 的完美来源 健康的血管和心脏（钾、镁、单不饱和脂肪和纤维） 强健骨骼和牙齿（钙/磷 + 锰/镁 + 脂肪 + 蛋白质） 和生育能力，强大的抗氧化作用（维生素Ε，锌，铜） 对视力有益（维生素 Ε、维生素 B2 或核黄素、磷） 你的胃刚刚找到了它最好的朋友（镁、纤维）', 2.00, 103, '1738924214147_1_0004_07-Roasted-Almond-Pearl.png', 3000, '2025-02-07 18:30:14', '2025-02-07 18:30:14');
INSERT INTO `products` VALUES (76, '烤榛子', '', '完美的“酮症坚果”！（14% 蛋白质、8% 碳水化合物、60% 脂肪） 健康的血管和心脏（钾、镁、单不饱和脂肪和纤维） 和生育能力（叶酸或维生素B9，维生素E，锌，铜） 抗氧化和抗衰老特性（维生素E，白藜芦醇）。 运动/心理表现 美丽的皮肤、健康的头发和强壮的指甲。', 2.00, 103, '1738924228443_1_0008_10-Roasted-Hazelnut.png', 3000, '2025-02-07 18:30:28', '2025-02-07 18:30:28');
INSERT INTO `products` VALUES (77, '生腰果', '', '生腰果：大自然的营养源  丰富的铜来源，对各种生理过程和整体健康至关重要。 富含促进健康的抗氧化剂，增强人体的天然防御系统。 支持铁的吸收并增强免疫系统，有助于整体健康。 增强皮肤弹性，促进头发健康，打造充满活力的外观。 锌和铜等抗氧化剂具有抗衰老特性，促进年轻活力。 作为一种集中的能量来源，使它们成为碳水化合物含量为 30% 以保持表现的运动员的绝佳选择。 通过高水平的镁、锰和铜支持强壮的骨骼。 由于其植物甾醇含量，有助于降低胆固醇，促进心血管健康。', 2.00, 103, '1738924235636_1_0009_11-Cashew.png', 3000, '2025-02-07 18:30:35', '2025-02-07 18:30:35');
INSERT INTO `products` VALUES (78, '烤腰果', '', '烤腰果：大自然的宝库  富含铜，对各种身体机能和整体健康至关重要。 富含促进健康的抗氧化剂，可增强身体对氧化应激的防御能力。 促进铁的吸收并支持免疫系统功能，促进整体健康。 增强皮肤弹性，促进头发健康，有助于容光焕发。 腰果富含锌和铜等抗氧化剂，具有抗衰老特性，可促进年轻活力。 作为一种集中的能量来源，使它们成为运动员的理想选择，30% 的碳水化合物提供持续的能量。 通过高水平的镁、锰和铜来支持骨骼健康。 由于其植物甾醇含量，有助于降低胆固醇，促进心血管健康。', 2.00, 103, '1738924246240_1_0010_12-Roasted-Cashew.png', 3000, '2025-02-07 18:30:46', '2025-02-07 18:30:46');
INSERT INTO `products` VALUES (79, '巴西坚果', '', '只需一种巴西坚果即可满足我们 175% 的硒日常需求，有助于心脏健康、抵抗癌症、提高生育能力、学习能力和拥有健康的甲状腺 抗氧化作用 健康的血管和心脏（铜、镁、锌和纤维）', 2.00, 103, '1738924254644_1_0013_16-Brazil-Nut.png', 3000, '2025-02-07 18:30:54', '2025-02-07 18:30:54');
INSERT INTO `products` VALUES (80, '核桃', '', '富含 omega-3 和 omega-6 脂肪酸，支持心脏和大脑健康。 碳水化合物含量低，其中很大一部分是纤维，有助于消化和促进饱腹感。 它们由 65% 的健康脂肪和大约 15% 的蛋白质组成，提供持续的能量。 核桃含有植物甾醇、γ-生育酚、omega-3 脂肪酸和抗氧化多酚，有助于降低患心血管疾病的风险并有助于预防癌症。 富含单不饱和脂肪、多酚和维生素 E，可增强认知功能，支持最佳的大脑健康和表现。', 2.00, 103, '1738924265961_karydi.png', 3000, '2025-02-07 18:31:05', '2025-02-07 18:31:05');
INSERT INTO `products` VALUES (81, '草莓', '', ' 用我们地区的新鲜草莓制成的冰棒。', 2.00, 103, '1738924451888_file-1651678936242.png', 3000, '2025-02-07 18:34:11', '2025-02-07 18:34:11');
INSERT INTO `products` VALUES (82, '用我们地区的新鲜草莓制成的冰棒。', '', '草莓 ', 2.00, 104, '1738924491168_file-1651678936242.png', 3000, '2025-02-07 18:34:51', '2025-02-07 18:34:51');
INSERT INTO `products` VALUES (83, '柠檬', '', '用鲜榨柠檬汁制成的冰棒。', 2.00, 104, '1738924508180_download.png', 3000, '2025-02-07 18:35:08', '2025-02-07 18:35:08');
INSERT INTO `products` VALUES (84, '西番莲果', '', '新鲜百香果冰淇淋', 2.00, 104, '1738924526905_download.png', 3000, '2025-02-07 18:35:26', '2025-02-07 18:35:26');
INSERT INTO `products` VALUES (85, '芒果', '', '新鲜芒果冰淇淋', 2.00, 104, '1738924541165_download.png', 3000, '2025-02-07 18:35:41', '2025-02-07 18:35:41');
INSERT INTO `products` VALUES (86, 'KING BLACK', '', '由榛子制成的冰棒，带有榛子、巧克力和威化漩涡，专为意大利的 Lucciano\'s 开发。', 2.00, 104, '1738924557965_download.png', 3000, '2025-02-07 18:35:57', '2025-02-07 18:35:57');
INSERT INTO `products` VALUES (87, '饼干和奶油', '', '用生奶油制成的冰棒，配上巧克力甘纳许和巧克力饼干漩涡，装饰着 stracciatella 涂层饼干。', 2.00, 104, '1738924569492_download.png', 3000, '2025-02-07 18:36:09', '2025-02-07 18:36:09');
INSERT INTO `products` VALUES (88, '马斯卡彭 & 浆果', '', '由意大利马斯卡彭奶酪制成的冰棒，带有巴塔哥尼亚浆果漩涡。', 2.00, 104, '1738924581469_download.png', 3000, '2025-02-07 18:36:21', '2025-02-07 18:36:21');
INSERT INTO `products` VALUES (89, '无加糖花生', '', '不加糖的花生冰棒。', 2.00, 104, '1738924593126_download.png', 3000, '2025-02-07 18:36:33', '2025-02-07 18:36:33');
INSERT INTO `products` VALUES (90, '草莓和鲜奶油', '', '草莓鲜奶油冰棒，质地和风味的完美结合。', 2.00, 104, '1738924607610_download.png', 3000, '2025-02-07 18:36:47', '2025-02-07 18:36:47');
INSERT INTO `products` VALUES (91, '生奶油', '', '生奶油冰棒，涂有半甜比利时巧克力和小块焦糖花生。', 2.00, 104, '1738924620154_download.png', 3000, '2025-02-07 18:37:00', '2025-02-07 18:37:00');
INSERT INTO `products` VALUES (92, 'CRISPY DULCE DE LECHE', '', '牛奶焦糖冰棒，涂有比利时白巧克力和小块焦糖花生。', 2.00, 104, '1738924633059_download.png', 3000, '2025-02-07 18:37:13', '2025-02-07 18:37:13');
INSERT INTO `products` VALUES (93, '脆皮巧克力', '', 'Lucciano 的巧克力冰棒，涂有半甜比利时巧克力和小块焦糖花生。', 2.00, 104, '1738924644836_download.png', 3000, '2025-02-07 18:37:24', '2025-02-07 18:37:24');
INSERT INTO `products` VALUES (94, 'FIORE 草莓', '', '草莓鲜奶油冰棒，涂有粉红色的比利时白巧克力。它装饰着五颜六色的洒水和白巧克力眼睛。', 2.00, 104, '1738924657574_download.png', 3000, '2025-02-07 18:37:37', '2025-02-07 18:37:37');
INSERT INTO `products` VALUES (95, '百香果芝士蛋糕', '', '芝士蛋糕冰棒，百香果漩涡，涂有白巧克力。', 2.00, 104, '1738924677675_download.png', 3000, '2025-02-07 18:37:57', '2025-02-07 18:37:57');
INSERT INTO `products` VALUES (96, '开心果', '', 'Pistacchio 冰棒，来自勃朗特和西西里岛的最好的 pistacchios 的组合，涂有比利时 pistacchio 风味的白巧克力。', 2.00, 104, '1738924710395_download.png', 3000, '2025-02-07 18:38:30', '2025-02-07 18:38:30');
INSERT INTO `products` VALUES (97, '红浆果冰糕', '', '红色浆果冰糕。来自巴塔哥尼亚的蓝莓、草莓、覆盆子和黑莓的混合物。涂有白巧克力，饰有紫色线条。', 2.00, 104, '1738924718036_file-1605880662082.png', 3000, '2025-02-07 18:38:38', '2025-02-07 18:38:38');
INSERT INTO `products` VALUES (98, '开心果', '', 'Pistacchio 冰棒，来自勃朗特和西西里岛的最好的 pistacchios 的组合，涂有比利时 pistacchio 风味的白巧克力。', 2.00, 104, '1738924718372_download.png', 3000, '2025-02-07 18:38:38', '2025-02-07 18:38:38');
INSERT INTO `products` VALUES (99, 'ENZO DULCE DE LECHE & GIANDUIA', '', '牛奶焦糖冰棒配 gianduia 巧克力馅，外层涂有比利时白巧克力。', 2.00, 104, '1738924757996_download.png', 3000, '2025-02-07 18:39:17', '2025-02-07 18:39:17');
INSERT INTO `products` VALUES (100, 'TONIO 饼干和奶油', '', '意大利为 Lucciano 制作的生奶油冰棒和饼干，巧克力甘纳许漩涡，涂有白巧克力。所有装饰细节均手工制作。', 2.00, 104, '1738924773024_download.png', 3000, '2025-02-07 18:39:33', '2025-02-07 18:39:33');
INSERT INTO `products` VALUES (101, '小黄人', '', '涂有比利时原产的意大利白巧克力，带有经典的蓝色和黄色。采用手工制作的眼睛，增添完美的触感喔', 2.00, 104, '1738924796446_download.png', 3000, '2025-02-07 18:39:56', '2025-02-07 18:39:56');
INSERT INTO `products` VALUES (102, '双重黑巧克力', '', '巧克力冰淇淋，比利时白巧克力和牛奶巧克力双层涂层，金色粉末密封，比利时白巧克力和牛奶巧克力双层涂层，金色粉末密封。', 2.00, 104, '1738924811402_download.png', 3000, '2025-02-07 18:40:11', '2025-02-07 18:40:11');
INSERT INTO `products` VALUES (103, '白双巧克力', '', '白巧克力配牛奶巧克力漩涡，双层涂有比利时白巧克力和牛奶巧克力。', 2.00, 104, '1738924826439_download.png', 3000, '2025-02-07 18:40:26', '2025-02-07 18:40:26');
INSERT INTO `products` VALUES (104, 'Icepop 0% 添加糖', '', '牛奶巧克力冰淇淋，上面覆盖着牛奶巧克力，不加糖。', 2.00, 104, '1738924836176_download.png', 3000, '2025-02-07 18:40:36', '2025-02-07 18:40:36');
INSERT INTO `products` VALUES (105, '焦糖金', '', '焦糖冰棒涂有金色巧克力。', 2.00, 104, '1738924846531_download.png', 3000, '2025-02-07 18:40:46', '2025-02-07 18:40:46');
INSERT INTO `products` VALUES (106, 'Sorbet 至尊 80%', '', '纯素 80% 巧克力冰糕涂有相同的巧克力。', 2.00, 104, '1738924857234_download.png', 3000, '2025-02-07 18:40:57', '2025-02-07 18:40:57');
INSERT INTO `products` VALUES (107, '芒果', '', '新鲜芒果冰淇淋。', 2.00, 104, '1738924878809_file-1610718793008.png', 3000, '2025-02-07 18:41:18', '2025-02-07 18:41:18');
INSERT INTO `products` VALUES (108, '西番莲果', '', '新鲜的百香果冰淇淋。', 2.00, 104, '1738924891129_file-1610721043266.png', 3000, '2025-02-07 18:41:31', '2025-02-07 18:41:31');
INSERT INTO `products` VALUES (109, '石灰', '', '用新鲜的酸橙汁制成的冰淇淋。', 2.00, 104, '1738924900031_file-1610718218332.png', 3000, '2025-02-07 18:41:40', '2025-02-07 18:41:40');
INSERT INTO `products` VALUES (110, '可可岩', '', '马来西亚椰子冰淇淋配白巧克力、酥脆威化饼和椰丝漩涡。', 2.00, 104, '1738924908436_file-1605796153632.png', 3000, '2025-02-07 18:41:48', '2025-02-07 18:41:48');
INSERT INTO `products` VALUES (111, '百香果芝士蛋糕', '', '芝士蛋糕冰淇淋配百香果大理石花纹。', 2.00, 104, '1738924917758_file-1610718319660.png', 3000, '2025-02-07 18:41:57', '2025-02-07 18:41:57');
INSERT INTO `products` VALUES (112, '柠檬派', '', '我们将著名的食谱变成了令人难以置信的冰淇淋，以纪念它。', 2.00, 104, '1738924926705_file-1605796132277.png', 3000, '2025-02-07 18:42:06', '2025-02-07 18:42:06');
INSERT INTO `products` VALUES (113, '马斯卡彭 & 浆果', '', '独家配方，意大利为 Lucciano\'s 制造，马斯卡彭奶酪与阿根廷巴塔哥尼亚的浆果漩涡相结合。', 2.00, 104, '1738924943512_file-1605796102869.png', 3000, '2025-02-07 18:42:23', '2025-02-07 18:42:23');
INSERT INTO `products` VALUES (114, '樱桃香草', '', 'Vainilla 樱桃大理石花纹奶油冰淇淋。', 2.00, 104, '1738924958105_file-1610721193651.png', 3000, '2025-02-07 18:42:38', '2025-02-07 18:42:38');
INSERT INTO `products` VALUES (115, '开心果', '', '用西西里美食中最珍贵的食材之一制成的招牌风味。勃朗特和西西里岛最好的手弦琴的组合。', 2.00, 104, '1738924965359_file-1608320787259.png', 3000, '2025-02-07 18:42:45', '2025-02-07 18:42:45');
INSERT INTO `products` VALUES (116, '白巧克力 Pistacchio Crock', '', '白巧克力奶油冰淇淋配松脆的意大利 pistacchio 大理石花纹。', 2.00, 104, '1738924978475_file-1610721356116.png', 3000, '2025-02-07 18:42:58', '2025-02-07 18:42:58');
INSERT INTO `products` VALUES (117, 'SUPREME 榛子', '', '冰淇淋由顶级意大利纯榛子制成。', 2.00, 104, '1738924986464_file-1649365068727.png', 3000, '2025-02-07 18:43:06', '2025-02-07 18:43:06');
INSERT INTO `products` VALUES (118, '特大号床 Good', '', '榛子冰淇淋配榛子、巧克力和威化饼漩涡，专为意大利 Lucciano\'s 开发。', 2.00, 104, '1738924998473_file-1651840560634.png', 3000, '2025-02-07 18:43:18', '2025-02-07 18:43:18');
INSERT INTO `products` VALUES (119, '花生焦糖', '', '花生酱冰淇淋，配 stracciatella 巧克力和牛奶焦糖漩涡以及咸花生片。', 2.00, 104, '1738925007124_file-1605795818831.png', 3000, '2025-02-07 18:43:27', '2025-02-07 18:43:27');
INSERT INTO `products` VALUES (120, 'LUCCIANO 巧克力榛子', '', 'Lucciano\'s 巧克力，巧克力和榛子馅，由 Lucciano\'s 在意大利独家开发。', 2.00, 104, '1738925020818_file-1605793992679.png', 3000, '2025-02-07 18:43:40', '2025-02-07 18:43:40');
INSERT INTO `products` VALUES (121, '牛奶焦糖巧克力片', '', '牛奶焦糖冰淇淋配半甜意大利 Stracciatella。', 2.00, 104, '1738925028523_file-1610722888238.png', 3000, '2025-02-07 18:43:48', '2025-02-07 18:43:48');
INSERT INTO `products` VALUES (122, 'WAFERINO 缸', '', '用香草威化饼和夜香威化饼的漩涡制成的冰淇淋。', 2.00, 104, '1738925037484_file-1649364848105.png', 3000, '2025-02-07 18:43:57', '2025-02-07 18:43:57');
INSERT INTO `products` VALUES (123, '果仁糖', '', 'Gianduia 冰淇淋配 gianduia 奶油漩涡、威化饼和夜蛾。', 2.00, 104, '1738925047076_file-1651678340356.png', 2986, '2025-02-07 18:44:07', '2025-02-07 18:44:07');
INSERT INTO `products` VALUES (124, '尚蒂伊奶油色带有比利时 stracciatella 的漩涡。', '', 'Gianduia 冰淇淋配 gianduia 奶油漩涡、威化饼和夜蛾。', 2.00, 104, '1738925065500_file-1651840707525.png', 3000, '2025-02-07 18:44:25', '2025-02-07 18:44:25');
INSERT INTO `products` VALUES (125, 'Sorbet 至尊 80%', '', '纯素 80% 巧克力冰糕', 2.00, 104, '1738925081828_file-1651675957640.png', 3000, '2025-02-07 18:44:41', '2025-02-07 18:44:41');
INSERT INTO `products` VALUES (126, '香蕉', '', '用新鲜香蕉制成，配以比利时巧克力和牛奶焦糖漩涡。', 2.00, 104, '1738925093788_file-1605796064430.png', 3000, '2025-02-07 18:44:53', '2025-02-07 18:44:53');
INSERT INTO `products` VALUES (127, 'Dulce de leche & dulce de leche', '', '阿根廷 dulce de leche 优质冰淇淋，带有 dulce de leche 漩涡，由意大利 Lucciano\'s 独家开发。', 2.00, 104, '1738925104890_file-1610723358749.png', 3000, '2025-02-07 18:45:04', '2025-02-07 18:45:04');
INSERT INTO `products` VALUES (128, 'PISTACHIO 芝士蛋糕', '', '奶油芝士蛋糕冰淇淋配上松脆的 pistacchios 漩涡', 2.00, 104, '1738925115031_file-1723475807124.png', 3000, '2025-02-07 18:45:15', '2025-02-07 18:45:15');
INSERT INTO `products` VALUES (129, '白榛子和咸焦糖', '', '白色榛子冰淇淋配上咸焦糖漩涡和可可碎。', 2.00, 104, '1738925137707_file-1723475734129.png', 3000, '2025-02-07 18:45:37', '2025-02-07 18:45:37');
INSERT INTO `products` VALUES (130, '红桑', '', '新鲜的红桑葚冰淇淋，带有红桑葚漩涡。', 2.00, 104, '1738925147668_file-1723475886218.png', 3000, '2025-02-07 18:45:47', '2025-02-07 18:45:47');
INSERT INTO `products` VALUES (131, '努赫', '', '营养酵母或 Nooch 是出了名的用途广泛！富含维生素 B-12 和蛋白质，将其用作您的秘密武器调味料。有 3 种创意口味;奶酪、培根和小鸡，撒在你能拿到的任何东西上。  将其拌在意大利面、披萨、爆米花或米饭上。将其扔在土豆、汤和沙拉上，或用它来制作美味的无乳制品通心粉奶酪。世界是您的纯素龙虾。', 2.00, 104, '1738925203931_Cheese-2023-Render.webp', 3000, '2025-02-07 18:46:43', '2025-02-07 18:46:43');
INSERT INTO `products` VALUES (132, '努赫', '', '营养酵母或 Nooch 是出了名的用途广泛！富含维生素 B-12 和蛋白质，将其用作您的秘密武器调味料。有 3 种创意口味;奶酪、培根和小鸡，撒在你能拿到的任何东西上。  将其拌在意大利面、披萨、爆米花或米饭上。将其扔在土豆、汤和沙拉上，或用它来制作美味的无乳制品通心粉奶酪。世界是您的纯素龙虾。', 2.00, 104, '1738925219179_bacon-nooch-packet-B12.webp', 3000, '2025-02-07 18:46:59', '2025-02-07 18:46:59');
INSERT INTO `products` VALUES (133, '努赫', '', '营养酵母或 Nooch 是出了名的用途广泛！富含维生素 B-12 和蛋白质，将其用作您的秘密武器调味料。有 3 种创意口味;奶酪、培根和小鸡，撒在你能拿到的任何东西上。  将其拌在意大利面、披萨、爆米花或米饭上。将其扔在土豆、汤和沙拉上，或用它来制作美味的无乳制品通心粉奶酪。世界是您的纯素龙虾。', 2.00, 104, '1738925231136_chicken-front-transparent-80.webp', 3000, '2025-02-07 18:47:11', '2025-02-07 18:47:11');
INSERT INTO `products` VALUES (134, 'Simply® Flexi Flora 蛋白棒', '', '覆盆子、杏仁糖和优质黑巧克力', 2.00, 105, '1738925319397_KvadratProvepakkeversion1.webp', 3000, '2025-02-07 18:48:39', '2025-02-07 18:48:39');
INSERT INTO `products` VALUES (135, 'Simply® Flying Felix 蛋白棒', '', '豆蔻、杏仁糖和优质牛奶巧克力', 2.00, 105, '1738925329356_FlyingFelix_sq_bar_wBite_1000.webp', 3000, '2025-02-07 18:48:49', '2025-02-07 18:48:49');
INSERT INTO `products` VALUES (136, 'Simply® Rich Arnold 蛋白棒', '', '焦糖、花生和优质黑巧克力', 2.00, 105, '1738925338100_RichArnold_sq_bar_wBite_1000.webp', 3000, '2025-02-07 18:48:58', '2025-02-07 18:48:58');
INSERT INTO `products` VALUES (137, 'Simply® Speedy Tom 蛋白棒', '', '巴西莓、可可、百香果和优质黑巧克力', 2.00, 105, '1738925354756_SpeedyTom_sq_bar_wBite_1000.webp', 3000, '2025-02-07 18:49:14', '2025-02-07 18:49:14');
INSERT INTO `products` VALUES (138, 'Simply® Sixpack Sally 蛋白棒', '', '焦糖、柚子、芝麻和优质牛奶巧克力', 2.00, 105, '1738925363429_SixpackSally_sq_bar_wBite_1000.webp', 3000, '2025-02-07 18:49:23', '2025-02-07 18:49:23');
INSERT INTO `products` VALUES (139, 'Flying Felix 和 Flexi Flora', '', '蛋白质混合物 30 包', 2.00, 105, '1738925378914_MixProtein_FlyingFlexi_collibox_1000.webp', 3000, '2025-02-07 18:49:38', '2025-02-07 18:49:38');
INSERT INTO `products` VALUES (140, '蛋白质混合 30 包', '', 'Rich Arnold、Speedy Tom 和 Sixpack Sally', 2.00, 105, '1738925400340_MixProteinx2_sq_collibox_30_angle_1000.webp', 3000, '2025-02-07 18:50:00', '2025-02-07 18:50:00');
INSERT INTO `products` VALUES (141, '蛋白质混合 15 包', '', '混合盒装 3 种不同的蛋白棒', 2.00, 105, '1738925414127_MixProtein_sq_collibox_15_angle_1000.webp', 3000, '2025-02-07 18:50:14', '2025-02-07 18:50:14');
INSERT INTO `products` VALUES (142, 'F.C. 哥本哈根蛋白棒', '', '杏仁、百香果和黑巧克力', 2.00, 105, '1738925428162_Bar_FCKproteinbar_wBite_592b7729-0f14-484b-846c-c1a813e2d953.webp', 3000, '2025-02-07 18:50:28', '2025-02-07 18:50:28');
INSERT INTO `products` VALUES (143, '水瓶', '', '我们信赖大自然', 2.00, 105, '1738925438785_Gift_Drikkedunk_3cab6fb6-c470-4c67-b485-3ec2c90b3c11.webp', 3000, '2025-02-07 18:50:38', '2025-02-07 18:50:38');
INSERT INTO `products` VALUES (144, '树 莓', '', '这种细腻的味道立即成为经典。此外，覆盆子在对身体有益方面享有盛誉，这使它们更具吸引力。', 2.00, 106, '1738925541463_can-framboise-new.png', 3000, '2025-02-07 18:52:21', '2025-02-07 18:52:21');
INSERT INTO `products` VALUES (145, '枫树姜', '', '枫树的意思是春天、更新、重生。再加上生姜的睿智和异国情调的味道，您将拥有世界上最好的！', 2.00, 106, '1738925618564_download.png', 3000, '2025-02-07 18:53:38', '2025-02-07 18:53:38');
INSERT INTO `products` VALUES (146, '樱桃 + 青柠', '', '在任何二元性中，无论风雨无阻，面对新的挑战或在舒适的日常生活中，都由您来选择每一刻的积极因素。', 2.00, 106, '1738925688804_download.png', 3000, '2025-02-07 18:54:48', '2025-02-07 18:54:48');
INSERT INTO `products` VALUES (147, '草莓', '', '在一天中的某个时候，您需要停下来想想自己。就像日出一样，草莓海带会唤起当下的珍贵美味和令人振奋的提醒。', 2.00, 106, '1738925736107_download.png', 3000, '2025-02-07 18:55:36', '2025-02-07 18:55:36');
INSERT INTO `products` VALUES (148, '·奶酪和火腿馅的 Panike®', '', '·奶酪和火腿馅的 Panike®', 2.00, 107, '1738926081335_download.webp', 3000, '2025-02-07 19:01:21', '2025-02-07 19:01:21');
INSERT INTO `products` VALUES (149, 'Panike® 馅料为碎牛肉、奶酪和火腿', '', 'Panike® 馅料为碎牛肉、奶酪和火腿', 2.00, 107, '1738926096721_download.webp', 3000, '2025-02-07 19:01:36', '2025-02-07 19:01:36');
INSERT INTO `products` VALUES (150, '奶酪馅的 Panike®', '', '奶酪馅的 Panike®', 2.00, 107, '1738926115161_download.webp', 3000, '2025-02-07 19:01:55', '2025-02-07 19:01:55');
INSERT INTO `products` VALUES (151, '火腿馅的 Panike®', '', '火腿馅的 Panike®', 2.00, 107, '1738926132919_download.webp', 3000, '2025-02-07 19:02:12', '2025-02-07 19:02:12');
INSERT INTO `products` VALUES (152, '·牛肉末馅的 Panike®', '', '·牛肉末馅的 Panike®', 2.00, 107, '1738926146887_download.webp', 3000, '2025-02-07 19:02:26', '2025-02-07 19:02:26');
INSERT INTO `products` VALUES (153, '·鸡肉馅的 Panike®', '', '·鸡肉馅的 Panike®', 2.00, 107, '1738926161707_download.webp', 3000, '2025-02-07 19:02:41', '2025-02-07 19:02:41');
INSERT INTO `products` VALUES (154, '香肠糕点热狗', '', '香肠糕点热狗', 2.00, 107, '1738926195103_download.png', 3000, '2025-02-07 19:03:15', '2025-02-07 19:03:15');
INSERT INTO `products` VALUES (155, '香肠和奶酪糕点', '', '香肠和奶酪糕点', 2.00, 107, '1738926210216_download.webp', 3000, '2025-02-07 19:03:30', '2025-02-07 19:03:30');
INSERT INTO `products` VALUES (156, '奶酪火腿糕点', '', '奶酪火腿糕点', 2.00, 107, '1738926224917_download.webp', 3000, '2025-02-07 19:03:44', '2025-02-07 19:03:44');
INSERT INTO `products` VALUES (157, '牛肉碎糕点（葡式）', '', '牛肉碎糕点（葡式）', 2.00, 107, '1738926236541_download.webp', 3000, '2025-02-07 19:03:56', '2025-02-07 19:03:56');
INSERT INTO `products` VALUES (158, '牛肉碎糕点', '', '牛肉碎糕点', 2.00, 107, '1738926267743_download.webp', 3000, '2025-02-07 19:04:27', '2025-02-07 19:04:27');
INSERT INTO `products` VALUES (159, 'Mushroom with Nuts 惠灵顿', '', 'Mushroom with Nuts 惠灵顿', 2.00, 107, '1738926347679_download.png', 3000, '2025-02-07 19:05:47', '2025-02-07 19:05:47');
INSERT INTO `products` VALUES (160, '鸡肉糕点 SN', '', '鸡肉糕点 SN', 2.00, 107, '1738926362710_download.png', 3000, '2025-02-07 19:06:02', '2025-02-07 19:06:02');
INSERT INTO `products` VALUES (161, '披萨酱糕点', '', '披萨酱糕点', 2.00, 107, '1738926418077_download.png', 3000, '2025-02-07 19:06:58', '2025-02-07 19:06:58');
INSERT INTO `products` VALUES (162, '菠菜糕点配乳清干酪', '', '菠菜糕点配乳清干酪', 2.00, 107, '1738926432704_download.png', 3000, '2025-02-07 19:07:12', '2025-02-07 19:07:12');
INSERT INTO `products` VALUES (163, '金枪鱼糕点', '', '金枪鱼糕点', 2.00, 107, '1738926448404_download.webp', 3000, '2025-02-07 19:07:28', '2025-02-07 19:07:28');
INSERT INTO `products` VALUES (164, '葡萄牙奶油蛋卷配火腿和香肠', '', '葡萄牙奶油蛋卷配火腿和香肠', 2.00, 107, '1738926466602_download.webp', 3000, '2025-02-07 19:07:46', '2025-02-07 19:07:46');
INSERT INTO `products` VALUES (165, '葡萄牙奶油蛋卷配火腿和奶酪', '', '葡萄牙奶油蛋卷配火腿和奶酪', 2.00, 107, '1738926480574_download.webp', 3000, '2025-02-07 19:08:00', '2025-02-07 19:08:00');
INSERT INTO `products` VALUES (166, '葡萄牙奶油蛋卷配火腿、奶酪和香肠', '', '葡萄牙奶油蛋卷配火腿、奶酪和香肠', 2.00, 107, '1738926497860_download.webp', 3000, '2025-02-07 19:08:17', '2025-02-07 19:08:17');
INSERT INTO `products` VALUES (167, '奶油蛋卷配香肠', '', '奶油蛋卷配香肠', 2.00, 107, '1738926512291_download.webp', 3000, '2025-02-07 19:08:32', '2025-02-07 19:08:32');
INSERT INTO `products` VALUES (168, 'Panike® 羊角面包', '', 'Panike® 羊角面包', 2.00, 107, '1738926533217_download.png', 3000, '2025-02-07 19:08:53', '2025-02-07 19:08:53');
INSERT INTO `products` VALUES (169, '迷你肉桂卷', '', '迷你肉桂卷', 2.00, 107, '1738926593388_download.png', 3000, '2025-02-07 19:09:53', '2025-02-07 19:09:53');
INSERT INTO `products` VALUES (170, '135 克 Pain au Chocolat 巧克力', '', '135 克 Pain au Chocolat 巧克力', 2.00, 107, '1738926604907_download.webp', 3000, '2025-02-07 19:10:04', '2025-02-07 19:10:04');
INSERT INTO `products` VALUES (171, '120 克 Pain au Chocolat 巧克力', '', '120 克 Pain au Chocolat 巧克力', 2.00, 107, '1738926618661_download.webp', 3000, '2025-02-07 19:10:18', '2025-02-07 19:10:18');
INSERT INTO `products` VALUES (172, 'Pain au Chocolat', '', '120 克 Pain au Chocolat 巧克力', 2.00, 107, '1738926635444_download.webp', 3000, '2025-02-07 19:10:35', '2025-02-07 19:10:35');
INSERT INTO `products` VALUES (173, 'Pain au Chocolat', '', 'Pain au Chocolat', 2.00, 107, '1738926637039_download.webp', 3000, '2025-02-07 19:10:37', '2025-02-07 19:10:37');
INSERT INTO `products` VALUES (174, '140 克 Pain au Créme Patissiére', '', '140 克 Pain au Créme Patissiére', 2.00, 107, '1738926651621_download.webp', 3000, '2025-02-07 19:10:51', '2025-02-07 19:10:51');
INSERT INTO `products` VALUES (175, '120 克 Pain au Créme Patissiére', '', '120 克 Pain au Créme Patissiére', 2.00, 107, '1738926666196_download.webp', 3000, '2025-02-07 19:11:06', '2025-02-07 19:11:06');
INSERT INTO `products` VALUES (176, 'Panike® Butter Croissant', '', 'Panike® Butter Croissant', 2.00, 107, '1738926681479_download.webp', 3000, '2025-02-07 19:11:21', '2025-02-07 19:11:21');
INSERT INTO `products` VALUES (177, 'Multi Cereal Croissant', '', 'Multi Cereal Croissant', 2.00, 107, '1738926705314_download.png', 3000, '2025-02-07 19:11:45', '2025-02-07 19:11:45');
INSERT INTO `products` VALUES (178, 'Chocolate Croissant', '', 'Chocolate Croissant', 2.00, 107, '1738926727790_download.webp', 3000, '2025-02-07 19:12:07', '2025-02-07 19:12:07');
INSERT INTO `products` VALUES (179, 'Créme Patissiére Croissant', '', 'Créme Patissiére Croissant', 2.00, 107, '1738926744368_download.webp', 3000, '2025-02-07 19:12:24', '2025-02-07 19:12:24');
INSERT INTO `products` VALUES (180, '杏仁羊角面包', '', '杏仁羊角面包', 2.00, 107, '1738926766389_download.webp', 3000, '2025-02-07 19:12:46', '2025-02-07 19:12:46');
INSERT INTO `products` VALUES (181, '巧克力 Scoubidou', '', '巧克力 Scoubidou', 2.00, 107, '1738926780224_download.webp', 3000, '2025-02-07 19:13:00', '2025-02-07 19:13:00');
INSERT INTO `products` VALUES (182, '巧克力 Scoubidou', '', '巧克力 Scoubidou', 2.00, 107, '1738926810179_download.webp', 3000, '2025-02-07 19:13:30', '2025-02-07 19:13:30');
INSERT INTO `products` VALUES (183, '苹果派', '', '苹果派', 2.00, 107, '1738926831423_download.webp', 3000, '2025-02-07 19:13:51', '2025-02-07 19:13:51');
INSERT INTO `products` VALUES (184, '枫树山核桃', '', '枫树山核桃', 2.00, 107, '1738926848341_download.webp', 3000, '2025-02-07 19:14:08', '2025-02-07 19:14:08');
INSERT INTO `products` VALUES (185, '室内喷雾 Rock', '', '清爽的室内喷雾，立即产生花香和诱人的香味。  带有玫瑰、羊绒和皮革的香调。', 2.00, 107, '1738927045427_room-spray-rock-roses.jpg', 3000, '2025-02-07 19:17:25', '2025-02-07 19:17:25');
INSERT INTO `products` VALUES (186, '室内喷雾 Rock', '', '清爽的室内喷雾，立即产生花香和诱人的香味。  带有玫瑰、羊绒和皮革的香调。', 2.00, 108, '1738927073149_room-spray-rock-roses.jpg', 3000, '2025-02-07 19:17:53', '2025-02-07 19:17:53');
INSERT INTO `products` VALUES (187, '黑莓和麝香 - 淡香水', '', '这款香调探索了甜美的红色浆果的新鲜度，并带有令人上瘾的白麝香。  Mûre et Musc 是 L\'Artisan Parfumuur 第一个系列的标志性设计，以其创新和最终的古典主义而著称。在阳光明媚的日子里，泡腾的新鲜浆果、长长的绿草和白色的小围裙都准备好采摘黑莓了。温暖的白麝香与浓郁的黑莓形成鲜明对比，不仅使这款香水与众不同，而且使这家小众香水公司与众不同，成为香水界的真正先驱。', 2.00, 108, '1738927083746_mure-musc--eau-de-toilette.jpg', 3000, '2025-02-07 19:18:03', '2025-02-07 19:18:03');
INSERT INTO `products` VALUES (188, '香棒 Rock Roses', '', '这些诱人的香薰棒旨在丰富任何室内空间。  这款香水棒散发出花香、诱人的香味，带有玫瑰、羊绒和皮革的香调。  不停。长达 3-4 个月。', 2.00, 108, '1738927095672_fragrance-sticks-rock-roses.jpg', 3000, '2025-02-07 19:18:15', '2025-02-07 19:18:15');
INSERT INTO `products` VALUES (189, 'Day Cycle', '', '超保湿 6 合 1 面部精华液 这款超保湿**、保护和舒缓的液体可全天增强皮肤的柔软度、紧致度和自然光泽。 这是每天早上和剃须后理想的“多合一”日常姿态。 它包含 Urban Shield®，这是一种独家专利复合物，可提供最大程度的日常保护。', 2.00, 108, '1738927110773_cycle-jour--fluide.jpg', 3000, '2025-02-07 19:18:30', '2025-02-07 19:18:30');
INSERT INTO `products` VALUES (190, '夜循环', '', '这款超滋养抗衰老抗衰老面霜**通过在夜间强效细胞再生阶段使皮肤恢复活力，持久保持皮肤的年轻。 它包含 Urban Shield®，这是一种独家专利复合物，可提供最大程度的日常保护。', 2.00, 108, '1738927129160_cycle-nuit.jpg', 3000, '2025-02-07 19:18:49', '2025-02-07 19:18:49');
INSERT INTO `products` VALUES (191, '保湿补水面膜', '', 'Anti-Thirst Hydrating Mask 可恢复皮肤的舒适度，将水分含量提高 111%，抚平细纹并抚平皮肤的微浮雕。  它有助于恢复皮肤的舒适感，将水分含量提高 111%（1 小时见效），抚平细纹并抚平皮肤的微浮雕。青金石 （Lapis Lazuli） 带来美丽的蓝色，您已经感到沐浴在清新中了！  涂抹在干净、干燥的皮肤上 10 分钟（不要再这样，面膜不应干燥）。用湿布或可清洗的化妆棉去除多余的部分，然后涂抹您常用的护肤品。', 2.00, 108, '1738927152581_le-masque-anti-soif-hydratant.jpg', 3000, '2025-02-07 19:19:12', '2025-02-07 19:19:12');
INSERT INTO `products` VALUES (192, 'Mémoire d\'une Palmeraie 11 - 淡香精', '', '这种独特的香水让人想起一棵生长在海边的棕榈树，它的棕榈树上涂有盐晶体。这款作品微妙而独特，时而浓郁而精致，闪耀着花香、盐水和胡椒的光芒，而棕榈树香调则因其多个切面而闪闪发光。一个签名，一个存在，一条难忘的小径。  香调： 塞川胡椒、柠檬 、铃兰花蕾、麝香棕榈 、干琥珀香调  ', 2.00, 108, '1738927165801_memoire-d-une-palmeraie-11--eau-de-parfum.jpg', 3000, '2025-02-07 19:19:25', '2025-02-07 19:19:25');
INSERT INTO `products` VALUES (193, '皮肤健康系统 - Prisma Protect spf 30', '', 'Dermalogica 的全新保湿霜是真正的多任务超级皮肤护理。  这款保湿霜与每天激活的皮肤保护模式主动协同作用，保护您的皮肤免受紫外线和空气污染等有害入侵者的侵害。得益于智能无人机技术，Prisma Protect SPF30 将日光转化为皮肤可用的能量。这款超级多任务护理采用创新的光激活技术，保护、滋润和完善肌肤。', 2.00, 108, '1738927177023_skin-health-system--prisma-protect-spf-30.jpg', 3000, '2025-02-07 19:19:37', '2025-02-07 19:19:37');
INSERT INTO `products` VALUES (194, 'Age Smart - 复合维生素能量修复®面膜', '', '这款面膜高度浓缩抗氧化维生素，有助于皮肤再生，同时加强其天然保护。  不含香料或人工色素。', 2.00, 108, '1738927189140_age-smart--multivitamin-power-recovery-masque.jpg', 3000, '2025-02-07 19:19:49', '2025-02-07 19:19:49');
INSERT INTO `products` VALUES (195, 'Active Clearing - 皮脂清洁面膜', '', '这款清爽哑光面膜*可细化皮肤纹理，并深层净化，这要归功于高岭土和膨润土的存在。  不含香料或人工色素。  *如果您正在接受皮肤科医生开出的治疗，例如 Accutane 或 Adapalene，则禁止使用 Medibac 系列。如果你不确定，我们建议你去找皮肤科医生，或联络我们的 Dermalogica 专科医生。', 2.00, 108, '1738927245088_active-clearing--sebum-clearing-masque.jpg', 3000, '2025-02-07 19:20:45', '2025-02-07 19:20:45');
INSERT INTO `products` VALUES (196, 'Mixed Emotions - 淡香精', '', 'Mixed Emotions 是一款史诗般的*香水，旨在反映我们这个时代的动荡本质——高潮 和低谷的提炼，反映了不稳定的现实和不断变化的世界。Mixed Emotions 探索二分法和不和谐，将熟悉和意想不到的事物结合起来，创造出一款在对比中具有凝聚力的香水。  Mixed Emotions 展示了我们当前集体心理状态的嗅觉素描。马黛茶的舒适味和黑醋栗 的尖锐甜味位于木制框架内;紫 叶合成物扰乱了红茶的令人安心的香味。这是一个令人耳目一新的提醒，不好也没关系——从令人不安的经历中， 一个新的现实可能会出现。', 2.00, 108, '1738927259100_mixed-emotions--eau-de-parfum.jpg', 3000, '2025-02-07 19:20:59', '2025-02-07 19:20:59');
INSERT INTO `products` VALUES (197, 'Intensive Rejuvenating Body Balm', '', '一款富含保湿檀香和澳洲坚果油的丰富滋养润肤膏，特别适合干性皮肤。  早晚，从颈部到脚部按摩新鲜清洁的皮肤，专注于肘部、膝盖和脚部等干燥区域。', 2.00, 108, '1738927273379_baume-intensif-rajeunissant-pour-le-corps.jpg', 3000, '2025-02-07 19:21:13', '2025-02-07 19:21:13');
INSERT INTO `products` VALUES (198, 'Concentrated Citrus 身体乳', '', '以柑橘为基础的配方，含有舒缓清爽的橙子和柠檬皮油，以及软化和保湿的核桃油提取物。  从头到脚按摩，避开面部，涂抹在干净的皮肤上，尤其是在阳光照射后。夏季存放在冰箱中，以获得令人愉悦的清新感。', 2.00, 108, '1738927287558_baume-concentre-aux-agrumes-pour-le-corps.jpg', 3000, '2025-02-07 19:21:27', '2025-02-07 19:21:27');
INSERT INTO `products` VALUES (199, '天竺葵叶身体膏', '', '天竺葵叶身体膏', 2.00, 108, '1738927298533_baume-a-la-feuille-de-geranium-pour-le-corps.jpg', 3000, '2025-02-07 19:21:38', '2025-02-07 19:21:38');
INSERT INTO `products` VALUES (200, '天竺葵叶身体膏', '', '滋养坚果油、软化成分以及柑橘和天竺葵叶提取物的保湿混合物，可为肌肤提供深层滋养。  早晚，从颈部到脚部按摩新鲜清洁的皮肤，专注于肘部、膝盖和脚部等干燥区域。', 2.00, 108, '1738927306492_baume-a-la-feuille-de-geranium-pour-le-corps.jpg', 3000, '2025-02-07 19:21:46', '2025-02-07 19:21:46');
INSERT INTO `products` VALUES (201, 'Resolute 保湿身体乳', '', '一款浓郁的润肤膏，带有特有的辛辣香味。  基于乳木果油和小麦胚芽以及甜杏仁油，可滋润和滋养肌肤。  早晚，从颈部到脚部按摩新鲜清洁的皮肤，专注于肘部、膝盖和脚部等干燥区域。', 2.00, 108, '1738927326519_baume-hydratant-resolu-pour-le-corps.jpg', 3000, '2025-02-07 19:22:06', '2025-02-07 19:22:06');
INSERT INTO `products` VALUES (202, 'Ernesto 扩散器', '', 'Objects for the Home 的产品线正在扩大：Diffuser 加入了 L\'OEuf、Vaporisateur 和 Promeneuse 的行列，为家居增添香气。  Diffuser 的容量为 350 毫升，采用有色的凹槽玻璃制成，并饰有金色 Trudon 徽章。Diffuser 与蜡烛在同一个玻璃车间制造，顶部有一个 100% 可回收的铝环，里面有 8 根黑色的天然藤条。  Diffuser 允许 3 到 4 个月的被动扩散。', 2.00, 108, '1738927343487_diffuseur-ernesto.jpg', 3000, '2025-02-07 19:22:23', '2025-02-07 19:22:23');
INSERT INTO `products` VALUES (203, '牧师 EGF ', '', '含有植物 EGF 的再生和紧致身体精华液，具有无与伦比的保湿、柔软和紧致肌肤。仅含 8 种纯净、有益健康的成分。  这款奢华的抗衰老身体精华液含有高浓度的植物性 EGF，可提供持久的保湿效果，使肌肤明显更光滑、更丰满、更紧致、更健康。配方中仅含有 8 种纯成分，可快速渗透，修复干燥区域并改善整体肤质。', 2.00, 108, '1738927358634_serum-egf-corps.jpg', 3000, '2025-02-07 19:22:38', '2025-02-07 19:22:38');
INSERT INTO `products` VALUES (204, 'Skin Health System - 智能反应精华液', '', 'SmartResponse 技术有助于在皮肤损伤开始之前阻止它。四种智能活化剂可在皮肤需要的地方滋润、提亮、软化和减少细纹和皱纹。  最常见的皮肤状况，如发红、细纹、色素沉着和脱水，都是您的皮肤受损的迹象。Dermalogica 的新 Smart Response Serum 采用革命性的 Smart Response 技术，能够响应您的皮肤发出的信号，以防止皮肤损伤，甚至在您注意到皮肤上的明显迹象之前。', 2.00, 108, '1738927370238_skin-health-system--smart-response-serum.jpg', 3000, '2025-02-07 19:22:50', '2025-02-07 19:22:50');
INSERT INTO `products` VALUES (205, 'Legends of the Cedar - 淡香精', '', '这位调香师想创造一种近乎神秘的情感，他亲切地称之为“木花蜜”，围绕着奶油雪松，带有藏红花和肉豆蔻的燃烧和美食气息。迷人的岩蔷薇和劳丹脂树脂的存在让人想起东方温暖的大地。雪松和火热香料的创新结合为这款香水增添了神秘的光环，使旅程变得神秘。  “这款香水是围绕着带有藏红花点缀的奶油雪松构建的木花蜜，”Christophe Raynaud。', 2.00, 108, '1738927393552_legendes-du-cedre--eau-de-parfum.jpg', 3000, '2025-02-07 19:23:13', '2025-02-07 19:23:13');
INSERT INTO `products` VALUES (206, '黎凡特的故事 - Eau de Parfum', '', '在简单明了的写作中，调香师想捕捉到大马士革玫瑰的绿色和辛辣香味，这种香味经过庄严的处理，只是注入了浓郁的熏香和广藿香。他成功地将这种土耳其玫瑰的清新和胡椒和柠檬三重奏令人上瘾的温暖置于紧张状态。这款香水完全围绕东方人最喜欢的花朵构建，在皮肤上散发着神秘的光环。  “这款香水以三种充满活力的辣椒为特色 - 白色、粉红色和黑色 - 在神秘迷人的广藿香基调上增强了标志性的黎凡玫瑰，每个方面都雄伟壮观。”克里斯托夫·雷诺  ', 2.00, 108, '1738927408252_contes-du-levant--eau-de-parfum.jpg', 3000, '2025-02-07 19:23:28', '2025-02-07 19:23:28');
INSERT INTO `products` VALUES (207, 'Oud & Spice - 香水', '', '两种嗅觉的艺术结合：沉香木的华丽香味与充满活力和明亮的柑橘香调相得益彰。  沉香木的强劲、包裹感经过蒸馏，并与肉桂和丁香的温暖、辛辣色调相结合，创造出难忘的发现。  有关产品使用、供应商详细信息、警告或安全信息的任何查询，请直接联系 Acqua di Parma 专门的客户服务团队', 2.00, 108, '1738927422565_oud-spice--eau-de-parfum.jpg', 3000, '2025-02-07 19:23:42', '2025-02-07 19:23:42');
INSERT INTO `products` VALUES (208, 'The Emulsion - 保湿注入', '', '违背水合作用定律。这款轻盈的乳液含有细胞更新神奇肉汤™，为肌肤提供全天愈合保湿，为肌肤补充、强化和稳定肌肤。其流畅、快速吸收的质地毫不费力地涂抹，只留下您最容光焕发、最健康的皮肤。  涂抹精华液后，用指尖将按压 2 泵的量均匀涂抹于面部和颈部。随后使用 La Mer 保湿霜。', 2.00, 108, '1738927434382_l-emulsion--infusion-hydratante.jpg', 3000, '2025-02-07 19:23:54', '2025-02-07 19:23:54');
INSERT INTO `products` VALUES (209, 'White Magnolia - 淡香精', '', 'Etro 用 White Magnolia 创作了一首赞美大自然的美丽和奇迹的赞美诗。白玉兰的光芒与奶油麝香和 Boisées 香调的包裹温暖相结合，创造出一款庆祝春天的香水。在充分尊重环境和人类的情况下获得的天然原材料与来自最现代科学研究的精制分子在成分上完美平衡。', 2.00, 108, '1738927450147_white-magnolia--eau-de-parfum.jpg', 3000, '2025-02-07 19:24:10', '2025-02-07 19:24:10');
INSERT INTO `products` VALUES (210, 'Powerbright- 淡斑精华液', '', '您的日常生活和环境与色素沉着斑点的发展有什么关系？嗯，一切都，真的！暴露于紫外线被认为是黑色素分泌的最重要触发因素，是皮肤色素沉着不规则的主要原因。  一款尖端的精华液，可治疗不规则色素沉着，让皮肤继续均匀和提亮。PowerBright 淡斑精华液采用最新的突破性成分配制而成，可提供快速、明显的效果，能够减少黑斑并均匀肤色。', 2.00, 108, '1738927460119_powerbright-dark-spot-serum.jpg', 3000, '2025-02-07 19:24:20', '2025-02-07 19:24:20');
INSERT INTO `products` VALUES (211, 'Clear Start - 冷却 Aqua Jelly', '', '一款适合油性皮肤的保湿霜，赋予所有水润的光泽，没有油光。这款清爽的果冻保湿霜的水润质地让皮肤感觉清新，略带水润。轻盈的配方含有类似视黄醇的生物类黄酮复合物，有助于减少多余油脂并改善皮肤。透明质酸锁住水分，深层滋润肌肤。蓝艾菊花油和提亮蓝莓提取物有助于镇静和舒缓皮肤，同时提供抗氧化功效。', 2.00, 108, '1738927471175_clear-start--cooling-aqua-jelly.jpg', 3000, '2025-02-07 19:24:31', '2025-02-07 19:24:31');
INSERT INTO `products` VALUES (212, 'The Butterfly Hunt - 淡香水', '', 'La Chasse aux Papillons 是一段童年的回忆，灵感来自追逐蝴蝶和在夏日天空下玩耍。这是一个无忧无虑的时代。漫长而阳光明媚的日子和开满鲜花的草地。想象一下，躺在柑橘树的树荫下，仰望天空。飘逸的白云和蝴蝶漂浮在上方。蝴蝶翅膀和细网的纱布与这款香水的精致本质相呼应。结果是柔软、明亮和透明。', 2.00, 108, '1738927482498_la-chasse-aux-papillons--eau-de-toilette.jpg', 3000, '2025-02-07 19:24:42', '2025-02-07 19:24:42');
INSERT INTO `products` VALUES (213, 'Mémoire d\'une Palmeraie 02 - 淡香精', '', '这款诞生于千年绿洲中心的香水，最接近棕榈树开花时捕捉到的香味。精致的马赛克由精致的精华和郁郁葱葱的树叶组成，微风轻抚，它构成了绿色、木质和麝香的和谐，大自然在皮肤上温暖。', 2.00, 108, '1738927524008_memoire-d-une-palmeraie-02--eau-de-parfum.jpg', 3000, '2025-02-07 19:25:24', '2025-02-07 19:25:24');
INSERT INTO `products` VALUES (214, 'Radiance Cycle', '', ' Tanned Complexion Face Serum 这款保湿**、保护和哑光精华液非常适合压力和疲劳时期。它的赤藓糖基底赋予皮肤晒黑、有光泽、超自然的肤色，每次使用都会增强。 它包含 Urban Shield®，这是一种独家专利复合物，可提供最大程度的日常保护。', 2.00, 108, '1738927535676_cycle-eclat.jpg', 3000, '2025-02-07 19:25:35', '2025-02-07 19:25:35');
INSERT INTO `products` VALUES (215, '极限循环 - 香膏', '', '一款独特的超保湿*、保护和舒缓的必备香膏，富含低分子量植物透明质酸，可密集全面地呵护您的面部。在身体、心理和气候压力很大的时期是理想的。  总成分的 99.7% 是天然来源的。  65.8% 的总成分来自有机农业。  76.6% 的活性成分（比标准产品多 4 到 5 倍）。  *表皮的上层。', 2.00, 108, '1738927549781_cycle-extreme--baume.jpg', 3000, '2025-02-07 19:25:49', '2025-02-07 19:25:49');
INSERT INTO `products` VALUES (216, 'Cycle Extrême - 精华液', '', '这款抗衰老精华液含有异常浓度的植物来源的低分子量透明质酸。早晚使用，深层活化肌肤，提供有效对抗皱纹的最佳反应。不含酒精。  主要作用： 1. 抗皱 2.振兴 3.平滑 4.公司 5.丰满', 2.00, 108, '1738927563751_cycle-extreme--serum.jpg', 3000, '2025-02-07 19:26:03', '2025-02-07 19:26:03');
INSERT INTO `products` VALUES (217, '精确循环', '', '3 合 1 眼部轮廓液 这种液体具有三重预防和治疗作用：抗皱、抗黑眼圈和抗浮肿。它可以每天使用，也可以偶尔用作面膜，以获得强烈的放松和舒缓感觉。 它包含 Urban Shield®，这是一种独家专利复合物，可提供最大程度的日常保护。', 2.00, 108, '1738927579077_cycle-precision.jpg', 3000, '2025-02-07 19:26:19', '2025-02-07 19:26:19');
INSERT INTO `products` VALUES (218, '5 合 1 胡须油', '', '8 种有机植物油（芝麻、荷荷巴油、蓖麻油、甜杏仁油、鳄梨油、南瓜籽油、巴巴苏油和果仁油）的独家组合，可滋润、滋养和保护胡须和皮肤。结果：胡须更柔软、更光滑，易于梳理且无任何油污。', 2.00, 108, '1738927594686_huile-a-barbe-5-en-1.jpg', 3000, '2025-02-07 19:26:34', '2025-02-07 19:26:34');
INSERT INTO `products` VALUES (219, 'Inflorescence - 淡香精', '', '2013 年春季。为了庆祝这个焕然一新的季节的开始，该品牌的创始人 Ben Gorham 构思了一种花香，可以捕捉盛开的野花花园的力量和美丽。其结果是名为 Inflorescence 的香水，这是一场田园诗般的漫步，穿过不屈不挠盛开的玫瑰，点缀着粉红色小苍兰令人陶醉的蜂蜜香调，处于它们美丽的巅峰。春天的第一朵花是这幅作品的核心：奶油色和奶油色的木兰花蕾，展开的花瓣，准备落在颤抖的铃兰床上。最后，更令人惊讶的是，Ben Gorham 使用茉莉花作为基调，在支持整个嗅觉结构的同时带来新鲜感。...', 2.00, 108, '1738927610173_inflorescence--eau-de-parfum.jpg', 3000, '2025-02-07 19:26:50', '2025-02-07 19:26:50');
INSERT INTO `products` VALUES (220, 'Saddler - Extrait de Parfum', '', '马鞍对骑手来说是必不可少的，他对体内的动物充满热情。在三款专为皮肤设计的 Night Veils 中，这一款无疑是最紧张的。活泼、黑暗、烟熏味，这种皮革浓缩物没有任何抑制。嗅觉惊喜从第一秒开始就爆发了。红茶叶的香调与羊绒混合在一起，羊绒是一种琥珀色的木质分子，吸引了人们的好奇心。然后，Sellier 传送到一个老式吸烟室，在那里你会发现珍贵的烟叶、旧书和随着时间的推移而软化的皮革制成的俱乐部椅子。在这里，皮革与琴头的木材、背景中的橡木苔藓和桦木融为一体，如此特别，如此烟熏，绝对让人联想到动物皮毛。一种嗅觉特技飞行练习，可用于 ...', 2.00, 108, '1738927630085_night-veils--sellier--extrait-de-parfum.jpg', 3000, '2025-02-07 19:27:10', '2025-02-07 19:27:10');
INSERT INTO `products` VALUES (221, 'Casablanca Lily - Extrait de Parfum', '', '当最后一缕阳光消失时，最浓郁的香味侵入了大气层。茉莉花、百合花和玫瑰：如此多的花朵，在夜幕降临时以强大的尾流揭示它们的神秘面纱。BYREDO 的 Night Veils 系列受到这些充满花卉颗粒的时光的启发，提供了一种新的香水仪式。这三种新提取物中的一种一滴就足以在皮肤上散布每朵花的性感。Three Night Veils 香水以罕见的优雅点缀廓形。每首作品的主题，夜之花（茉莉花、百合和玫瑰），都转化为真正的感官范围。Night Veils 香水远非沦为单一的成分', 2.00, 108, '1738927646753_night-veils--casablanca-lily--extrait-de-parfum.jpg', 3000, '2025-02-07 19:27:26', '2025-02-07 19:27:26');
INSERT INTO `products` VALUES (222, 'Skin Health System - 特殊洁面啫喱', '', '这款无皂泡沫凝胶洁面乳可去除杂质而不会使皮肤干燥。 这款无皂泡沫洁面啫喱可深层清洁，而不会干扰皮肤的水分平衡。  不含香料或人工色素。', 2.00, 108, '1738927667297_skin-health-system--special-cleansing-gel.jpg', 3000, '2025-02-07 19:27:47', '2025-02-07 19:27:47');
INSERT INTO `products` VALUES (223, '沉香木 - Eau de Parfum', '', 'Francis Kurkdjian 的 OUD Eau de Parfum 以最珍贵的成分——来自老挝的沉香木为基础，在大理石和凿刻的黄金宫殿的郊区令人梦寐以求，淹没在点缀着星星的午夜蓝天空中。  阿特拉斯雪松和印度尼西亚广藿香在皮肤上与他进行了一场感性的对话。  藏红花和榄香素带来光芒的火花，金色的存在在金银丝中闪烁。  OUD 香水既东方又西，阳刚又阴柔，是一种纯粹的神秘，一种辛辣的东方香水，迷人、麻醉、壮丽。  警告： 进入 MAISON FRANCIS KURKDJIAN 产品成分的成分会定期更新。在使用 MAISON FRANCIS KURKDJIAN 产品之前，请阅读其包装上的成分表，以确保成分适合您个人使用。', 2.00, 108, '1738927682680_oud--eau-de-parfum.jpg', 3000, '2025-02-07 19:28:02', '2025-02-07 19:28:02');
INSERT INTO `products` VALUES (224, 'Age Smart - 抗氧化保湿剂', '', '这款清爽喷雾可紧致、滋润并保护皮肤免受自由基的侵害。 一个真正的抗氧化盾牌，可以对抗自由基。  其紧致特性可立即改善皮肤质地。 它丰满且水分充足。  不含香料或人工色素。', 2.00, 108, '1738927694380_age-smart--antioxidant-hydramist.jpg', 3000, '2025-02-07 19:28:14', '2025-02-07 19:28:14');
INSERT INTO `products` VALUES (225, 'Mora Bella - 淡香水', '', '贪婪多汁的水果与热带花卉的美味组合，以舒适的檀香木和麝香为基调。  前调：石榴、佛手柑、柠檬。 中调：覆盆子、黑莓、茉莉、Belle de Nuit。 基调： 檀香木， 麝香。', 2.00, 108, '1738927714743_mora-bella--eau-de-toilette.jpg', 3000, '2025-02-07 19:28:34', '2025-02-07 19:28:34');
INSERT INTO `products` VALUES (226, 'Clear Start - Breakout Clearing 泡沫洗面奶', '', '深层清洁和净化皮肤。  这款净化粉刺洁面泡沫可去除堵塞毛孔并导致粉刺的死皮细胞、杂质和多余油脂。  用于面部、背部、颈部......以及任何需要深层清洁毛孔的粉刺区域。', 2.00, 108, '1738927755877_clear-start--breakout-clearing-foaming-wash.jpg', 3000, '2025-02-07 19:29:15', '2025-02-07 19:29:15');
INSERT INTO `products` VALUES (227, 'PowerBright 保湿霜 SPF50', '', '这款润肤且强大的广谱日间保湿霜使用油脂复合物技术来保护皮肤免受导致色素沉着过度（黑斑、变色、肤色不均）的环境侵害。  强大的肽有助于调节黑色素的产生，而红藻和棕藻的混合物与植物提取物相结合，有助于均匀肤色。  交联透明质酸可强化皮肤的天然保湿屏障，减少因脱水引起的细纹的出现。  不含香料、人工色素和对羟基苯甲酸酯。', 2.00, 108, '1738927765406_powerbright-moisturizer-spf50.jpg', 3000, '2025-02-07 19:29:25', '2025-02-07 19:29:25');
INSERT INTO `products` VALUES (228, 'Age Smart - 复合维生素 Thermafoliant', '', '这种双重磨砂膏可去除死细胞，抚平和唤醒皮肤。  它既是机械的又是化学的，可以改善皮肤纹理并提高之后应用的抗衰老治疗的有效性。  不含香水或人工色素。', 2.00, 108, '1738927776203_age-smart--multivitamin-thermafoliant.jpg', 3000, '2025-02-07 19:29:36', '2025-02-07 19:29:36');
INSERT INTO `products` VALUES (229, 'Skin Health System - 预清洁', '', '这款轻盈的卸妆油由橄榄油和杏仁制成，富含苦果、琉璃苣籽和米糠油，可去除皮肤表面的油脂和油性杂质。  它的水溶性配方使其非常容易冲洗（没有任何油腻残留物）。  随后使用适当的 dermalogica 洁面乳，在 Precleanse 的作用下促进其渗透，让您获得更强烈和专业的清洁效果。  不含香料或人工色素。', 2.00, 108, '1738927788479_skin-health-system--precleanse.jpg', 3000, '2025-02-07 19:29:48', '2025-02-07 19:29:48');
INSERT INTO `products` VALUES (230, 'Age Smart - 动态皮肤修复 - SPF50', '', '这款保湿液的 SPF 50 可紧致并保护皮肤免受紫外线伤害。 它可以恢复柔软度和弹性，同时防止和保护皮肤免受导致皮肤老化的因素的影响。  不含香料或人工色素。', 2.00, 108, '1738927801457_age-smart--dynamic-skin-recovery--spf50.jpg', 3000, '2025-02-07 19:30:01', '2025-02-07 19:30:01');
INSERT INTO `products` VALUES (231, 'Age Smart - Super Rich 修复', '', '这款丰富且高度浓缩的面霜可对抗皮肤严重干燥和皮肤老化的最初迹象，同时促进和保护皮肤。  它是 Dermalogica 最丰富的保湿霜。  它甚至可以缓解、滋润和调理最干燥和最脱水的皮肤。它也是抵御寒冷和干燥风的盾牌。  不含香料或人工色素。', 2.00, 108, '1738927812202_age-smart--super-rich-repair.jpg', 3000, '2025-02-07 19:30:12', '2025-02-07 19:30:12');
INSERT INTO `products` VALUES (232, 'Clear Start - 皮肤舒缓保湿化妆水', '', '这款无油、轻盈的保湿霜可减少杂质，对抗发红并提供最佳保湿效果！适合日常使用。', 2.00, 108, '1738927834217_clear-start--skin-soothing-hydrating-lotion.jpg', 3000, '2025-02-07 19:30:34', '2025-02-07 19:30:34');
INSERT INTO `products` VALUES (233, '皮肤套件 - 干性', '', '大胆尝试，获得完美健康的皮肤，多亏了这款针对干性皮肤的套件。你已经是 Dermalogica 产品的粉丝了吗？无论你走到哪里，都带着这个套装，每天都能从Dermalogica的专业知识中受益。使用 Essential 清洁液清洁，去除杂质而不会使皮肤干燥。Spray Multi Active 爽肤水。芦荟和薄荷醇可舒缓皮肤。密集的水分平衡可恢复皮肤的水分含量并减少过早衰老的迹象。Gentle Cream Exfoliant 富含乳酸、水杨酸和水果酶，可松弛死皮细胞并促进细胞更新。因此，皮肤更柔软，更容光焕发。密集的眼部修复可促进细纹的减少和细纹的恢复。', 2.00, 108, '1738927850513_skin-kit--dry.jpg', 3000, '2025-02-07 19:30:50', '2025-02-07 19:30:50');
INSERT INTO `products` VALUES (234, '剪贴簿胶带，4包双面胶带滚筒用于工艺品，粘性胶水流道剪贴簿用品日记学校办公用品，适合儿童和成人，0.3英寸x 26英尺', '', '剪贴簿胶带，4包双面胶带滚筒用于工艺品，粘性胶水流道剪贴簿用品日记学校办公用品，适合儿童和成人，0.3英寸x 26英尺', 2.00, 108, '1738927937347_713JVvgUsOL._SX522_.jpg', 3000, '2025-02-07 19:32:17', '2025-02-07 19:32:17');
INSERT INTO `products` VALUES (235, 'BIC Xtra-Smooth 粉彩机械铅笔带橡皮擦，中号点（0.7 毫米），40 支装，用于学校或办公用品的散装机械铅笔', '', 'BIC Xtra-Smooth 粉彩机械铅笔带橡皮擦，中号点（0.7 毫米），40 支装，用于学校或办公用品的散装机械铅笔', 2.00, 108, '1738927947692_81ZIPszdZ0L._AC_SX466_.jpg', 3000, '2025-02-07 19:32:27', '2025-02-07 19:32:27');
INSERT INTO `products` VALUES (236, 'EXPO低气味干擦记号笔，凿尖，各种时尚颜色，适用于教室、办公室和家庭使用36支', '', 'EXPO低气味干擦记号笔，凿尖，各种时尚颜色，适用于教室、办公室和家庭使用36支', 2.00, 109, '1738927994781_814ZlkBCeiL._AC_SL1500_.jpg', 3000, '2025-02-07 19:33:14', '2025-02-07 19:33:14');
INSERT INTO `products` VALUES (237, '五星螺旋笔记本 + 学习应用程序，5 个主题，大学直纹纸，抗墨水渗出，防水封面，8-1/2“ x 11”，200 张，黑色 （72081）', '', '五星螺旋笔记本 + 学习应用程序，5 个主题，大学直纹纸，抗墨水渗出，防水封面，8-1/2“ x 11”，200 张，黑色 （72081）', 2.00, 109, '1738928029590_71gpdT3i-TL._AC_SL1500_.jpg', 3000, '2025-02-07 19:33:49', '2025-02-07 19:33:49');
INSERT INTO `products` VALUES (238, 'Crayola蜡笔批量（24包，学前班和幼儿园的返校用品，儿童批量蜡笔，课堂用品', '', 'Crayola蜡笔批量（24包，学前班和幼儿园的返校用品，儿童批量蜡笔，课堂用品', 2.00, 109, '1738928044307_81RPzbd96YL._AC_SL1500_.jpg', 3000, '2025-02-07 19:34:04', '2025-02-07 19:34:04');
INSERT INTO `products` VALUES (239, '亚马逊基础版窄尺 5 x 8 英寸有线书写便签簿，6 个装（50 张），多色', '', '亚马逊基础版窄尺 5 x 8 英寸有线书写便签簿，6 个装（50 张），多色', 2.00, 109, '1738928057441_71euci0sK5L._AC_SL1500_.jpg', 3000, '2025-02-07 19:34:17', '2025-02-07 19:34:17');
INSERT INTO `products` VALUES (240, '亚马逊基础版窄尺 5 x 8 英寸有线书写便签簿，6 个装（50 张），多色', '', '6 包 50 页记事本;每种柔和的颜色（粉红色、兰花色和蓝色）各 2 个，用于可选的颜色编码;非常适合家庭、学校或办公室 9/32 英寸窄直纹行距，适用于较小的手写内容或在单个页面上编写更多笔记 坚固的刨花板背衬，提供额外的书写板支撑 多孔顶部，便于从焊盘上取下板材 用于组织笔记的左侧边距和标题空间 产品尺寸：5 x 8 英寸（宽 x 长，包括装订）', 2.00, 109, '1738928065350_71euci0sK5L._AC_SL1500_.jpg', 3000, '2025-02-07 19:34:25', '2025-02-07 19:34:25');
INSERT INTO `products` VALUES (241, 'Soucolor 72色彩色铅笔，适用于成人涂色书，返校用品，软芯，艺术家绘画素描铅笔套装，艺术用品套装，适合儿童青少年初学者混合阴影的礼物', '', '你将得到 -- 72支彩色铅笔 + 1个Soucolor铅笔盒。便于存储并保持颜色全部可见，无需任何麻烦即可找到您正在寻找的颜色。 高级铅笔-- 72色艺术彩色铅笔具有柔软的铅芯，易于削尖，不会断裂、开裂或碎裂。 多种颜色 -- 72种独立颜色，丰富的颜色提供平滑的着色，易于混合和阴影，彩色插图 完美的绘画，素描，成人着色书。回到学习用品，学习用品。 安全使用 -- 无味材料。具有 EN71 安全证书。注意：窒息危险：小部件，不适合 3 岁以下。 报告此商品或卖家的问题', 2.00, 109, '1738928083435_81mbDWmT1NL._AC_SL1500_.jpg', 3000, '2025-02-07 19:34:43', '2025-02-07 19:34:43');
INSERT INTO `products` VALUES (242, 'Mr. Pen- 美学荧光笔，8 件，凿尖，柔和的粉彩，无出血圣经荧光笔粉彩，荧光笔各种颜色，粉彩荧光笔套装，美学学校用品', '', '包装包括 8 支荧光笔，包括非霓虹色、柔和色和温和的各种颜色。 耐用、快干的墨水可防止污迹和污迹，让您的作品保持干净清晰。 我们的美学高光笔舒适易握，不会手痛，使用时不会滚动。多功能凿尖可有效产生宽线和窄线。 Mr. Pen 美学荧光笔非常适合以明亮鲜艳的色彩突出您的经文、笔记、日记或任何您想阅读的书籍。 这些可爱的荧光笔适用于学校、大学、家庭、办公室，甚至旅行日记、日程、工作、学习、笔记等。它们也是送给家人和朋友的绝佳礼物。', 2.00, 109, '1738928092933_712QWjsqr4L._AC_SL1500_.jpg', 3000, '2025-02-07 19:34:52', '2025-02-07 19:34:52');
INSERT INTO `products` VALUES (243, 'ddaowanx 中性笔，6 支 0.5mm 快干黑色墨水笔细尖光滑书写笔，可爱的办公学校用品女士礼物', '', '中性笔：您将收到 6 支快干墨水笔，采用现代简约设计，满足您的需求日常使用和更换需求 快干墨水：这些可伸缩的滚珠中性笔具有可靠的墨水，不会轻易褪色或弄脏;滚珠墨水干得很快，帮助您保持工作整洁有序 实用简单的设计：方便的夹子设计可以将中性墨水圆珠笔牢固地夹在书本、笔记本或包上，携带方便，不用担心丢失;可伸缩设计，轻轻按压笔帽，笔端自动缩回 使用范围：6pc中性笔适用于儿童和成人用于书写、日记、素描、绘画、剪贴簿、制作礼品卡等，满足您日常学习和工作中的各种需求 实用礼品：您可以将这些彩色中性笔作为实用礼物送给您的家人、朋友、学生、同学和同事，以便在生日、感恩节、圣诞袜填充物、毕业典礼、课堂活动、派对等各种场合表达您的感情。爱与祝福', 2.00, 109, '1738928110019_61mcgT64xQL._AC_SL1500_.jpg', 3000, '2025-02-07 19:35:10', '2025-02-07 19:35:10');
INSERT INTO `products` VALUES (244, 'X-ACTO 1670 School Pro 教室电动削笔器，黑/灰', '', '每个售 1 个。 取出垃圾桶时，SafeStart 电机停止剃须。 尺寸：5.5 英寸长 x 9 英寸宽 x 8.5 英寸高;重量：3.67 磅。 六种尺寸的表盘几乎适合每支铅笔。 重型黑色金属磨刀器。', 2.00, 109, '1738928126316_71jFts0kAXL._SL1500_.jpg', 3000, '2025-02-07 19:35:26', '2025-02-07 19:35:26');
INSERT INTO `products` VALUES (245, 'Phomemo标签制作机，D30便携式手持式蓝牙迷你标签制作打印机，适用于智能手机热敏小型标签制作机的多个模板，可充电，易于使用，适用于家庭办公室，学校', '', '升级版 - Phomemo D30 蓝牙标签机支持连续标签带和固定长度的标签。它的重量和尺寸是传统标签机的一半，配备德国热敏打印头，打印质量提高了 25%，提供卓越的打印清晰度，从而实现轻松打印、流畅的打印效果和快速处理 省钱 - 直热技术 - D30 蓝牙标签机是无墨打印，不需要墨水、碳粉或色带。由于您可以选择许多热敏彩色标签胶带，与大多数标签制造商打印机相比，成本是有形的并且要低得多。（此标签制作工具是 Monochrome Printing Output，它只打印黑色文本。我们可以创建彩色标签艺术品，需要使用彩色图案标签胶带打印） 多种创意功能和便捷的标签模板 - 从包括1000+符号、110+框架和各种字体在内的各种预先设计的模板中选择，方便且节省时间。使用图标、文本、表格、符号、徽标、条形码、二维码、图像、时间、插入 Excel、Scan、OCR 和语音 RECG 从 App 轻松创建各种设计标签贴纸，既有趣又轻松 无线&便携 - 迷你尺寸的无线蓝牙连接Phomemo标签打印机，方便&快速打印，从智能移动设备轻松创建标签。内置耐用且可充电的电池，可长时间工作，可滑入口袋，便于随身携带 Phomemo D30 贴纸打印机机广泛用于各种设置。它通过存储标签、食品日期标记、化妆品分类和罐子贴纸帮助整理家中的用品。它非常适合在教育和办公环境中创建学校名称标签、学习笔记、文件分类、电缆标识和个人物品标签。它擅长为小型企业制作价格标签、珠宝标签等。', 2.00, 109, '1738928142405_71plOJQwFEL._AC_SL1500_.jpg', 3000, '2025-02-07 19:35:42', '2025-02-07 19:35:42');
INSERT INTO `products` VALUES (246, '300 件回形针、活页夹和橡皮筋、办公用品套装、回形针和回形针、学校用品、办公用品、办公桌必需品的教师用品（各种尺寸）', '', '高性价比：50 个 （50mm） 和 120 个 （28mm） 彩色回形针。80 根彩色橡皮筋。8 个 （25mm）、12 个 （19mm） 和 30 个 （15mm） 彩色活页夹。它们以不同的网格存储在可重复使用的塑料容器中，以便于查找或存放。 高质量：学校用品办公用品的回形针和活页夹均采用优质金属回针制成，由乙烯基涂层制成，耐腐蚀且表面光滑，防止纸张刮伤。橡皮筋由天然橡胶制成，光滑、可拉伸、可重复使用。可爱的办公用品教师用品装点您忙碌疲惫的生活。 高效的文件排列：各种尺寸、不同的活页夹、回形针和橡皮筋，多色系，适合不同粗细、类型、场景的信息标注和文件排列，让您在工作过程中更加轻松和有趣。 申请方法：妥善保管您的文件、试卷、传单、续期、信封、海报、门票等。也用于食品夹、服装设计、家具、照片挂饰和作为节日礼物;学校用品教师用品非常适合办公室、学校和家庭日常使用。 您将获得：170 个回形针、50 个活页夹和 80 个橡皮筋，我们友好的 7*24 客户服务以确保安全。', 2.00, 109, '1738928158926_71IsmIm4ZPL._AC_SL1500_.jpg', 3000, '2025-02-07 19:35:58', '2025-02-07 19:35:58');
INSERT INTO `products` VALUES (247, 'BIC（R） Wite-Out（R） 修正带，471 3/5 英寸，10 包，BICWOTAP10', '', '一包 10 支装的 BIC Wite-Out Brand EZ Correct Correction Tape，这是一种抗撕裂、基于薄膜的修正带，带有胶带分配器，可提供最大的舒适度和控制力 立即使用这款白色的修正带写下或打出您的修正，它不需要干燥时间，也不会渗出或滴落。 透明修正带分配器可让您准确查看剩余多少胶带，自动卷绕轮可让您在胶带松动时倒带 每个胶带分配器包含 39.3 英尺的白色修正胶带，为学校或办公用品提供持久的选择 BIC Wite-Out 品牌胶带适合右撇子和左撇子，为学生和员工提供了广泛的文档和作业用途', 2.00, 109, '1738928173300_81Rd8Ya4HJL._AC_SL1500_.jpg', 3000, '2025-02-07 19:36:13', '2025-02-07 19:36:13');
INSERT INTO `products` VALUES (248, '牛津螺旋笔记本，1个主题，大学直纹纸，8 x 10-1/2英寸，粉色，橙色，黄色，绿色，蓝色和紫色，70张（63756），6件套', '', '我们的螺旋笔记本采用独家的柑橘色粉彩新调色板，可美化您的上学日或工作日;实用可爱的笔记本套装;打了3个洞，大学规则;70 张;6 件装 欢迎使用凝胶笔和高光笔;每个笔记本包含70张光滑的双面纸，抵抗墨水涂抹和渗透，以获得精准的A加笔记;无钩挂线圈将其全部固定在一起 正确的裁决;这些 8 英寸 x 10-1/2 英寸的大学直纹笔记本比宽直尺笔记本每页适合更多的写作;为您提供 70 张双面片材（7-1/2“ x 10-1/2” 分离）3 个打孔以适合您的活页夹 表现恰到好处;Oxford 微孔板的设计使您想要的音符保留下来，而您没有干净地分离的音符;没有像便宜的笔记本品牌那样松动的床单或事故 质量，合适的价格;批量 6 包是课堂、家庭学校或工作的经济选择;以淡粉色、橙色、黄色、绿色、蓝色和紫色为主题或儿童进行颜色编码', 2.00, 109, '1738928191818_81Rd8Ya4HJL._AC_SL1500_.jpg', 3000, '2025-02-07 19:36:31', '2025-02-07 19:36:31');
INSERT INTO `products` VALUES (249, '五星螺旋笔记本 + 学习应用程序，6 包，1 个主题，大学直纹纸，8-1/2“ x 11”，100 张，抗墨水渗出，防水封面，黑色，红色，蓝色，绿色，白色，紫色 （38052）', '', '持续一整年。保证！ 使用 Five Star 应用程序扫描、学习和整理您的笔记。创建即时抽认卡并将您的笔记同步到 Google Drive，以便从任何设备随时随地访问它们。 1 个主题笔记本有 100 张双面大学直纹纸，可防止墨水渗出，并有穿孔以便于撕下。撕下的床单尺寸为 8-1/2 英寸 x 11 英寸。 坚固的口袋有助于防止撕裂，并可容纳 8-1/2 英寸 x 11 英寸的松散床单和讲义。保护套防水，可保护您的笔记，我们的 Spiral Lock 线有助于防止挂在衣服和背包上。 采用 SFI 认证纸张制成。笔记本是可回收的 - 只需撕下口袋上的加固胶带，其余部分即可回收利用！6 件装，颜色有黑色、火红色、太平洋蓝、森林绿、白色和紫水晶紫。', 2.00, 109, '1738928201558_71h5ZIymgeL._AC_SL1500_.jpg', 3000, '2025-02-07 19:36:41', '2025-02-07 19:36:41');
INSERT INTO `products` VALUES (250, '返校用品盒 K-5 年级 - 学校用品套装返校必需品 - 32 件（1 盒）', '', '用装满小学生所需的一切的 School Supply Box 来消除返校购物的麻烦。此供应套件包含 （1） 塑料铅笔盒、（1） 10 包绘儿乐记号笔、（1） 24 包绘儿乐蜡笔、（1） 12 包彩色铅笔和 （3） 埃尔默胶棒。 此外，盒子里还包含 （10） 支 #2 铅笔，（5） 铅笔顶橡皮擦，（1） 橡皮擦，（1） 卷笔刀，（1） 对钝头剪刀，（2） 铅笔握把，（1） 标准 12 英寸尺子，（1） 宽尺螺旋笔记本，（1） 宽尺作文簿，以及 （2） 带金属尖的 2 口袋文件夹。 这个学校用品盒中的艺术用品非常适合您的年轻艺术家用于艺术项目、地图项目、着色页、着色书、作业或制作节日装饰。 这个庞大的学习用品套件包含了您的孩子在幼儿园、一年级、二年级、三年级、四年级或五年级开学第一天可能需要的一切。 学校用品盒不必只为学龄儿童准备。这些用品包也是送给老师、代课老师、校长、副校长、导师、辅导员或在家上学的孩子的绝佳礼物。', 2.00, 109, '1738928213992_81gappgdZnL._SL1500_.jpg', 3000, '2025-02-07 19:36:53', '2025-02-07 19:36:53');
INSERT INTO `products` VALUES (251, 'Crayola儿童批量彩色铅笔（24支装），教师返校用品，教师课堂必备品，12种颜色[亚马逊独家]', '', '批量绘儿乐彩色铅笔：包括 24 包绘儿乐彩色铅笔，每包有 12 种绘儿乐颜色。 儿童彩色铅笔： 这些彩色铅笔非常适合在艺术项目中鼓励学生的创造力，允许广泛的艺术表现形式和技巧。 预磨尖且耐用：软芯不易断裂，预磨尖的尖端开箱即用。 返校用品：绘儿乐彩色铅笔是每个学校用品清单上的必备品。对于囤积小学课堂用品的教师来说，它们是一个很好的选择。 12种CRAYOLA颜色：Crayola颜色包括红色、红橙色、橙色、黄色、绿色、黄绿色、天蓝色、蓝色、紫色、黑色、棕色和白色。 儿童礼物：用绘儿乐彩色铅笔的礼物激励年轻艺术家创造性地表达自己。 安全无毒：适合6岁及以上的孩子。', 2.00, 109, '1738928227753_81TlNqOb+pL._AC_SL1500_.jpg', 3000, '2025-02-07 19:37:07', '2025-02-07 19:37:07');
INSERT INTO `products` VALUES (252, 'Sharpie S-Gel， 中性笔， 绘图笔， 用于日记的中性墨水笔， 书写笔， 着色笔， 中号笔尖 （0.7Mm）， 黑色笔杆， 黑色中性墨水， 12支', '', '采用无污迹、无出血技术的中性笔 强烈大胆的凝胶墨水颜色提供始终生动的书写 波状橡胶握把，带来舒适的书写体验 中点 （0.7mm） 包括 12 支黑色中性墨水笔', 2.00, 109, '1738928246218_81Z0eKG8vaL._AC_SL1500_.jpg', 3000, '2025-02-07 19:37:26', '2025-02-07 19:37:26');
INSERT INTO `products` VALUES (253, '四个糖果可爱的机械铅笔套装，6支粉彩机械铅笔0.5和0.7毫米，配有360支HB铅笔芯，3支橡皮擦和9支橡皮擦补充装，适合女孩写作的美学机械铅笔', '', '精美套装：您将获得一套可爱的自动铅笔，包括 3 支 0.5 毫米自动铅笔、3 支 0.7 毫米自动铅笔、3 管 0.5 毫米铅笔芯、3 管 0.7 毫米铅笔芯、3 件橡皮擦和 9 件橡皮笔芯 三角握把：自动铅笔的三角形握把设计，可以引导舒适的握持姿势，避免滑倒;光滑的笔杆和轻巧的重量提供轻松高效的书写体验 360 件升级树脂芯：铅笔芯由树脂和石墨制成，更坚固、有弹性、更光滑;6 管铅笔芯，共 360 件，让您长时间使用 两种类型的笔尖：该套装包含两种类型的笔尖，0.5 毫米和 0.7 毫米，可让您根据需要进行切换;可爱的自动铅笔适合书写、绘画、绘图、素描、素描 可爱的糖果色：这款粉红色的机械铅笔套装专为女孩设计，是送给朋友、同学、家人等的理想礼物选择;如有任何问题，我们友好的客户服务随时为您提供帮助 多合一套装：非常适合作为礼物;包括一个方便的保护套，便于存放和携带，非常适合学校作业和专业项目', 2.00, 109, '1738928260872_71yim77YZpL._AC_SL1500_.jpg', 3000, '2025-02-07 19:37:40', '2025-02-07 19:37:40');
INSERT INTO `products` VALUES (254, 'Nicpro 78件装美容学校用品，配有可爱笔盒，12支粉彩荧光笔，12支彩色和黑色墨水凝胶笔，10支机械铅笔0.5， 0.7， 0.9， 2.0毫米，6支学生文具用圆珠笔', '', '终极组合文具套装：配有 12 支柔和色彩荧光笔、10 支彩色墨水中性笔和 2 支粉红色中性笔黑色墨水和 12 件中性笔芯、6 支粉彩自动铅笔 0.5、0.7、0.9 毫米和 6 支可爱的自动铅笔 2.0 毫米和 582 件铅笔芯、6 支 4 合 1 多色笔、一个迷人的粉红色铅笔袋和 3 件橡皮擦， 2 个卷笔刀和 18 个橡皮擦笔芯。这是办公和学习用品文具必需品的终极组合 大容量粉红色铅笔袋：由耐用的涤纶织物制成，拉链光滑，前窗设计，您可以清楚地看到并拿走文具或任何您需要的东西，最多可容纳 100+ 支钢笔和铅笔。它不仅可以用作铅笔盒，还可以用于其他用途，例如旅行箱或化妆包 12 件混合颜色荧光笔：扁平桶形，带有凿尖，舒适且易于握持。水性墨水，快干，荧光笔颜色柔和柔和，非常适合宽大的高光或细下划线，非常适合旅行日记、日程、工作、学习、笔记。注意：我们的产品仅适用于 3 岁以上的儿童 10 支自动铅笔：此套装包括 6 支 0.5 毫米、0.7 毫米、0.9 毫米的活动铅笔和 4 支 2.0 毫米的活动铅笔。符合人体工程学的三角形握把，握持舒适，引线超强、光滑，产生清晰的黑线。4 种线径为不同的书写或绘图任务提供多功能性 6 支多色圆珠笔：4 合 1 多色笔在一支笔中具有 4 种墨水颜色，红色、黑色、蓝色、绿色，适合日常使用。可伸缩多墨水笔采用侧键设计，轻松切换四种颜色，让您的书写更高效、更方便', 2.00, 109, '1738928276321_81tcwf4-IhL._AC_SL1500_.jpg', 3000, '2025-02-07 19:37:56', '2025-02-07 19:37:56');
INSERT INTO `products` VALUES (255, '剪刀，iBayam 8英寸全能剪刀批量3包，超锐利的2.5毫米厚刀片剪刀舒适握把办公桌配件缝纫布料家庭工艺教师学校用品，右手/左手', '', '绝对是家用剪刀。非常适合切割粗麻布、纸张、纸板、轻线、布料、胶带、照片。非常适合缝纫、裁缝、绗缝、裁缝、剪裁图案、改动、手工制作。 3 对优质直柄剪刀。让您可以进行精确的切割，因为刀片具有完美的摩擦力，使用起来非常舒适。3 对直柄剪刀，用于平滑切割。 优质不锈钢刀片可实现高密度钢，使其比普通不锈钢坚硬 3 倍，并且切割更顺畅。舒适握把孔让您保持舒适，左手或右手均可使用。 8 英寸 Comfort-Grip 剪刀，3 把特殊剪刀适用于大多数需要剪掉的物品。它也可以用作家用剪刀，用于剪开准备烹饪的冷冻食品袋。', 2.00, 109, '1738928295806_61KzBzZaUfL._AC_SL1500_.jpg', 3000, '2025-02-07 19:38:15', '2025-02-07 19:38:15');
INSERT INTO `products` VALUES (256, 'BIC Xtra-Smooth 粉彩机械铅笔带橡皮擦，中号点（0.7 毫米），24 支装，用于学校或办公用品的散装机械铅笔', '', '一包 24 支装的 BIC Xtra-Smooth No. 2 自动铅笔，带橡皮擦和粉彩桶 多功能 0.7 毫米中号笔尖非常适合各种日常写作活动，也是学习用品的绝佳补充 BIC 铅笔采用优质铅芯，不会弄脏和干净擦除，让您的作品看起来整洁专业 这些铅笔随时可用，永远不需要削尖;要推进潜在客户，只需单击内置的橡皮擦 很棒的学校自动铅笔，带有与大多数标准化测试兼容的 2 号铅笔芯', 2.00, 109, '1738928312120_81kndBt1okL._AC_SL1500_.jpg', 3000, '2025-02-07 19:38:32', '2025-02-07 19:38:32');
INSERT INTO `products` VALUES (257, '便利贴超粘性画架垫，25英寸x 30英寸，白色，30张/垫，4个垫/包，非常适合虚拟教师和学生（559 VAD 4PK）', '', '粘得牢固，保持时间延长 2 倍 - 画架纸可以重新定位而不会损坏表面。与标准活动挂图纸不同，不需要胶带或大头针。将议程和想法放在每个人都可以看到的地方 防油墨渗漏纸 - 大型白色优质自粘活动挂图纸，可防止标记渗漏，将绝妙的想法保留在页面上，而不是页面下方的内容上 集思广益和管理项目的理想选择 - 非常适合培训或教学会议、头脑风暴会议、规划会议、项目管理和敏捷流程、会议和演示 下载免费的 Post-It 应用程序 - 无论您是在远程工作还是学习，Post-it 应用程序都是捕捉和分享想法、跟踪作业或与朋友创建彩色日历的完美方式。跨多个平台（包括 Dropbox、Trello、PowerPoint）共享，或在您的设备之间同步 大号白色优质纸 - 25 英寸x 30 英寸，30 张/垫，4 张/包 设计适合许多画架 - 坚固的背卡有一个手柄，使画架垫便于携带，插槽适合大多数画架。非常适合学生活动和培训课程 与便利贴超级便利贴一起使用 - 使用便利贴超级便签记录想法的大号可粘性纸张。为创意提供成长之地', 2.00, 109, '1738928438510_71Dg8D+wcAL._AC_SL1500_.jpg', 3000, '2025-02-07 19:40:38', '2025-02-07 19:40:38');
INSERT INTO `products` VALUES (258, 'Vitoler 8.5“ 剪刀，3 把多用途剪刀 重型剪刀 布艺剪刀 厨房剪刀，办公 学校用品 桌面配件', '', '握感舒适： vitoler 剪刀重量轻，带有橡胶手柄，易于抓握，减少长时间使用时的手部疲劳，确保每个人都可以轻松处理和使用这些剪刀，使其成为必备的办公用品 坚固耐用： 工艺剪刀由高密度钢制成，比普通不锈钢硬 3 倍，使用寿命比以前的配方长 6 倍，并且可以在超过 100,000 次切割中保持锋利 超级锋利： 我们的剪刀具有锋利的边缘，可以一直剪到刀片的尖端，并且具有很强的耐腐蚀性和耐粘合剂性，例如用于纸张、纸板、塑料包装、织物、胶带等的胶水和胶带，几乎适用于任何类型的切割 规格尺寸：办公剪刀的尺寸约为 8.5 x 3 x 0.4 英寸，有黑色和红色、黑色和绿色以及黑色和蓝色可供选择，刀片长度为 3.5 英寸，手柄长度为 4.1 英寸，设计简单大方，非常适合您的使用 使用场合：我们的全能重型剪刀适用于手工艺车间、浴室、缝纫室、洗衣房、手工艺室、办公室以及大多数日常琐事', 2.00, 109, '1738928455600_61dU5qpUicL._AC_SL1200_.jpg', 3000, '2025-02-07 19:40:55', '2025-02-07 19:40:55');
INSERT INTO `products` VALUES (259, '金属订书机重型50张容量，带有1750个订书钉和订书钉移除器，全条式书桌订书机，无卡纸，防滑办公室订书机，适用于办公室和教室，黑色', '', '【耐用的金属订书机】：我们的金属结构重型订书机可确保高质量、无卡纸装订和长期使用。它可以轻松装订多达 50 张，是书桌、办公室和教室必备的订书钉。 【超值包装】：包装包括一个金属订书机、一个订书钉去除器、一盒 1,250 个标准 1/4 英寸订书钉和一盒 500 个 5/16 英寸订书钉。 【桌面订书机】：我们的订书机可以容纳一整条 210 个标准订书钉。防滑橡胶底座在使用时可将订书机牢固地固定在位。低订料指标可帮助您了解补料的时间。 【固定和固定】：您可以反转铁砧进行临时固定，并打开订书机以将纸张固定到公告板上。 【满意和退款保证】： 客户满意度是我们的首要任务。请放心购买。如有任何产品问题，请通过 Amazon Message Center 联系我们。', 2.00, 109, '1738928471143_71pJrGjCY4L._AC_SL1500_.jpg', 3000, '2025-02-07 19:41:11', '2025-02-07 19:41:11');
INSERT INTO `products` VALUES (260, '亚马逊基础订书机，带1000个订书钉，办公订书机，25张纸容量，防滑，黑色', '', '桌面办公订书机，最多可容纳 210 个订书钉。 包装中包含 1000 个订书钉;订书钉具有标准的 1/4 英寸腿长 可以 180° 打开，以便将信息贴在公告板上;可旋转砧 提供两种装订模型：临时装订和永久装订 全橡胶底座在使用过程中将订书机牢固地固定在位;无打滑或打滑 非常适合学校、办公室和家庭日常装订', 2.00, 109, '1738928480682_71ORqgJajrL._AC_SL1500_.jpg', 3000, '2025-02-07 19:41:20', '2025-02-07 19:41:20');
INSERT INTO `products` VALUES (261, 'IRIS USA 6夸脱塑料储物箱带盖容器，4包，感官储物箱，手工艺品储物箱，手工艺品组织者和存储，家庭、办公和学校用品的组织容器，可堆叠，透明', '', '美国制造，采用全球材料 – IRIS USA 的扁平存储容器是一个完美的存储组织者，可以使用美国制造的防断裂、耐用的聚丙烯材料安全地容纳您的所有物品。 多功能储物箱 - 这款平面储物容器盒是您在家中、办公室或学校存储各种物品的完美存储解决方案工具。这个存储容器方便地容纳了标准 （8.5 X 11） 纸张、文件、文件、笔记本、工艺品和学习用品。 系好安全带 - 储物扣锁在耐用的塑料盖上，将内部和外部分开。任何贵重物品在安全扣上后都不会防尘和防液体。 透明 - 无需再寻找您的珍贵物品。这款扁平储物箱的清晰设计让您可以从任何角度立即找到任何存储的物品。 尺寸 - 14.00 英寸长 x 11.00 英寸宽 x 3.25 英寸高', 2.00, 109, '1738928493349_71bHriJMVcL._AC_SL1500_.jpg', 3000, '2025-02-07 19:41:33', '2025-02-07 19:41:33');
INSERT INTO `products` VALUES (262, '青少年情人节礼物，美学中性笔，0.5mm细尖黑色可爱笔办公桌配件，日本文具家庭工作必需品护士学校用品，少女生日礼物', '', '【流畅的书写体验】 0.5 毫米柔和型可爱笔尖细腻，墨水快干，确保每次都能获得无缝、精确、流畅的书写体验，让您毫不费力地在页面上滑动，是商务人士的完美办公必需品、办公桌配件、大学生和高中生的学习用品。中性笔采用可伸缩设计，易于使用和存放，非常适合移动写作需求。 【快干黑色墨水】这款中性笔确保您在需要时随时手头有一支笔，是学生、学院生、实用学生和任何想要可靠和时尚书写工具的人的完美套装。黑色墨水笔大胆而充满活力，为您的所有文件和项目提供清晰易读的书写，专用的快干墨水可防止污迹和涂抹，确保每次都能获得干净、整洁和专业的书写体验。 【细点精度】他们的 0.5 毫米细点笔组提供清晰干净的线条，并允许精确和准确的书写，使这些滚球凝胶日记笔成为详细工作、手写、记笔记和绘图的理想选择。您可以将它们用于所有写作，它们不会穿过纸张，当然，也不会涂抹或流血。 【用途广泛】无论您是在学校、办公室还是在家中，我们的中性笔都非常适合您的所有写作需求，从记笔记和填写表格，到涂鸦、计划和日记，使它们用途广泛，适用于各种任务和项目，您只需将其轻松固定在笔记本、活页夹或口袋上。柔软的硅胶抓握带来超柔软的触感，使每支中性笔握持起来都轻松舒适。非常适合家庭学校办公用品护理用品。 【完美的礼物选择】凭借其时尚的夹式设计，唯美的钢笔不仅实用，而且是教室、学校和办公室中男士、女士、儿童、男孩和少女的完美学校必需品配件。这是个好主意，可以作为学生的课堂奖品和圣经学习用品、艺术派对礼物、生日礼物、圣诞袜填充物和圣诞礼物。青少年情人节礼物。', 2.00, 109, '1738928505739_61MJ5yTyVnL._AC_SL1500_.jpg', 3000, '2025-02-07 19:41:45', '2025-02-07 19:41:45');
INSERT INTO `products` VALUES (263, '四个糖果0.5毫米机械铅笔套装 - 6支可爱的铅笔，附带360支HB和2B铅笔芯，3件套粉彩橡皮擦和9件套橡皮擦笔芯，用于写作绘画绘图的美学学校用品', '', '多合一套装：包含 6 支可爱的自动铅笔、6 管 360 根铅芯的散装供应、3 根柔和的橡皮擦和 9 个橡皮擦笔芯，全部包装在一个方便的手提箱中 每个细节都很重要：具有防滑橡胶手柄，舒适，内置带笔芯的橡皮擦，坚固的笔夹和可伸缩的笔尖，确保口袋安全 具有双重硬度的树脂笔芯：增强强度和弹性以减少破损，这些笔芯提供流畅、无疲劳的书写，线条质量一致，减少碎屑;HB 可用于日常任务，2B 可用于更柔和、更深色的线条，适合艺术素描 用于干净擦除的 4B Soft Pastel 橡皮擦：这些橡皮擦提供轻松擦除和最少的残留物，形成干净的条带，便于清理;它们非常适合所有用户，擦除时不会有污迹、撕裂或重影，并且不含乳胶 用于精密任务的 0.5 mm 导程：提供清晰、精确的线条，非常适合详细的图表、笔记和绘图;提供流畅的书写，清晰、深色的线条，易于擦除，无需锐化，非常适合学校作业 甜美的粉彩触感：享受糖果般的粉红色、紫色和蓝色的铅笔，每支铅笔都带有淡淡的甜味;搭配配饰，打造凝聚力外观;由高强度 ABS 制成，具有韧性和可靠性', 2.00, 109, '1738928523428_71jRMERtxqL._AC_SL1500_.jpg', 3000, '2025-02-07 19:42:03', '2025-02-07 19:42:03');
INSERT INTO `products` VALUES (264, 'Soucolor 学校用品 9“ x 12” 高中教师生素描本，1 包 100 张螺旋装订艺术素描本，无酸（68 磅/100 克/平方米）儿童艺术家空白书，返校物品', '', '【优质纸张】专业素描本绘图板。适合所有级别艺术家的完美尺寸。每个画板 100 张，总共 100 张优质画板纸，价格实惠。适合绘画、素描的质地。对于喜欢素描、绘画、插图、绘画、写作和创作艺术的人来说，这是一份优秀的艺术纸质书礼物。非常适合与石墨铅笔、彩色铅笔、木炭、钢笔、软油画棒、素描棒等搭配使用的素描本。 【高品质素描绘图本垫】这款素描本纸不含酸且 PH 值中性，标准重量为 68 磅/100 克，比其他品牌的同类素描本更厚、更好。它可以防止渗色、污迹和羽化，使艺术品干净。让您的作品在未来几年内保持美观！ 【适用于所有类型的干媒】我们的这些优质、耐用、无酸、天然白色素描纸适用于所有类型的干媒，如铅笔、钢笔、蜡笔、木炭、蜡笔和素描棒。不适用于酒精记号笔和水彩笔。 【顶部坚固的螺旋装订和微孔纸】顶部螺旋装订对左撇子和右撇子都很好，对左撇子和右撇子都很友好，打开时可以让垫子平放，便于翻页。凭借思考卡纸封面和重型背板提供额外的保护，它将始终保持纸张的良好状态，提供更好的绘图和写作体验。每页都有微孔，让您可以轻松删除单个页面。 【适合所有艺术家的高级素描本】这款非常大的素描本非常适合儿童、艺术学生和专业艺术家创作艺术品和练习技能。返校用品、圣诞艺术用品、工艺绘画绘画用品的绝佳礼物。保证：如果素描绘图板的性能不符合您的期望，只需告诉我们，我们将免费为您更换或退款您！', 2.00, 109, '1738928589116_71Zj-yxJo+L._AC_SL1500_.jpg', 3000, '2025-02-07 19:43:09', '2025-02-07 19:43:09');
INSERT INTO `products` VALUES (265, 'Scotch Magic Tape， 隐形，家庭办公用品和大学和教室用品，12卷', '', '隐形胶带：12 卷 Scotch Magic Tape 可以安全、永久、无形地修复撕裂和撕裂 牢固粘合：透明胶带使用值得信赖的 3M 胶粘剂技术为您提供强大、安全和永久的密封 浸渍：哑光饰面且不可见，这款胶带与纸张融为一体，是您返校用品的绝佳补充 适用于：使用这款办公胶带进行永久、安全的纸张修补，包括安装、快速修复、项目添加以及修复原始文档和照片 补充胶带：胶带可以顺畅地从易于使用的透明胶带分配器（单独出售）上滑落，并易于切割 额外的好处：这种照片安全胶带易于应用;此外，您可以用钢笔、铅笔或记号笔在上面书写，以便轻松标记 包装内容：一个包装，内含 12 卷 0.75 英寸的胶带卷。x 1000 英寸，带有 1 英寸。核心 SCOTCH 品牌：最好的项目从销量第一的家庭和办公室胶带开始', 2.00, 109, '1738928604156_71luDmY5csL._SL1500_.jpg', 3000, '2025-02-07 19:43:24', '2025-02-07 19:43:24');
INSERT INTO `products` VALUES (266, '四颗糖果4件金属机械铅笔套装，带盒，0.5毫米和0.7毫米艺术家铅笔，带8管（480件）HB铅笔芯，3块橡皮擦，9块橡皮笔芯，用于写作绘图，绘画，黑色和银色', '', '四颗糖果4件金属机械铅笔套装，带盒，0.5毫米和0.7毫米艺术家铅笔，带8管（480件）HB铅笔芯，3块橡皮擦，9块橡皮笔芯，用于写作绘图，绘画，黑色和银色', 2.00, 109, '1738928626621_81YLFYNg5UL._AC_SL1500_.jpg', 3000, '2025-02-07 19:43:46', '2025-02-07 19:43:46');
INSERT INTO `products` VALUES (267, '便利贴16个便签3x3英寸，自粘便签便签本多色，学校用品办公用品，假日商店的写作便签，教师感恩圣诞礼物和日常生活组织', '', '丰饶便签：16 个垫/包，50 张/垫，800 个/包，3 英寸 x 3 英寸。 适用场景：多色记事本适合写购物清单、提醒、日记、备忘录、笔记、清单;他们是送给工人、员工、老师、学生、朋友、家人的理想礼物。 强力粘合：我们的超级便利贴提供粘附力，确保它们保持原位并且不会脱落，将其便利贴贴在任何地方。 高质量纸张：80gsm 坚固的贴纸不会撕裂、卷曲或溢出墨水。我们的便签 800 件由优质纸张制成，友好环保，通过 FSC。 满意保证：如果有任何问题，请联系我们，我们将为您提供满意的解决方案。', 2.00, 109, '1738928638138_51rZuG3kKvL._AC_SL1500_.jpg', 3000, '2025-02-07 19:43:58', '2025-02-07 19:43:58');
INSERT INTO `products` VALUES (268, 'Kaco 凝胶笔，0.5 毫米细尖，黑色墨水 10 支装，快干流畅书写，美观办公用品可再填充可收回', '', '鲜艳而丰富的色彩：用KACO笔让无聊的任务变得有趣 写入流畅：无跳墨或堵塞 握持舒适： 由 ABS 制成。KACO 钢笔具有可爱柔软的质地、良好的尺寸和轻便的重量 无渗色无污迹：快速干写 用于记笔记和日记的笔：您记笔记和日记的选择 报告此商品或卖家的问题', 2.00, 109, '1738928652952_61PSwIbCetL._AC_SL1500_.jpg', 3000, '2025-02-07 19:44:12', '2025-02-07 19:44:12');
INSERT INTO `products` VALUES (269, '2025年计划书 - 每周和每月计划书，2025年1月至2025年12月，螺旋装订的2025年日历计划书，内袋，非常适合办公室家庭学习用品 - A5（6.3“ x 8.5”），鼠尾草绿色', '', '全面覆盖：我们的 2025 年规划师涵盖从 1 月到 12 月的全年，确保您为未来每个月和每周做好准备。包括 53 周，您将有足够的空间来计划、设定目标和跟踪您的成功进度。 为成功而构建： 通过每月和每周日历页面体验顺畅的规划之旅，这些页面为日程安排、确定优先级和反思提供了专门的空间。每个月都以一位知名人物的鼓舞人心的名言开始，激励您保持专注和动力。 周到的细节：ZOTIA 的 2025 年规划器配备了周到的细节，可增强您的规划体验。松紧带使其安全关闭，而每月标签允许快速导航。透明的双面口袋为笔记或提醒提供额外的存储空间。 适合所有人的多功能：这款 2025 年规划师非常适合学生、教师、专业人士和家庭主妇，可满足任何忙碌人士的多样化需求。使用它来管理学校作业、工作项目、家庭活动和个人目标 - 所有这些都在一个方便的地方。 组织和启发：体验 ZOTIA 的 2025 年规划师的结构和鼓励。凭借其功能性设计、鼓舞人心的元素和实用的功能，它是任何重视组织和效率的人的完美选择。用 2025 年规划器强势结束这一年，支持您的每一步。', 2.00, 109, '1738928668264_71m5zx22JlL._AC_SL1500_.jpg', 3000, '2025-02-07 19:44:28', '2025-02-07 19:44:28');
INSERT INTO `products` VALUES (270, '2 PCS 可折叠剪贴板，360°封面文件夹剪贴板，塑料剪贴板带双低调夹，A4大小的文件夹存储A3 A4纸剪贴板，办公学习用品剪贴板-深绿色', '', '【尺寸和数量】2 x 深绿色折叠剪贴板扩展尺寸：12.4“x19.17”，折叠尺寸：9.4“x12.4”。A4 尺寸可满足日常办公文档存储需求。圆角设计，坚固轻便的夹板文件夹可以使书写和记事变得轻松，方便我们在不同场合携带它 【PP弹性塑料】这个文件剪贴板存储是由3层泡沫PP材料制成的，因为它具有良好的抗拉强度和稳定性。可 360 度翻转使用，易于编写和检查，您可以将文件剪辑在剪贴板内部或外部，管理更加规范，满足您的随身携带和记录需求 【双夹设计】折叠板顶部和左侧有金属弹簧夹，夹紧力强，不易折断，可轻松容纳多达 100 页 A3、A4、A5、A6 尺寸的纸张并书写。橡胶夹角，抓握更牢固，不会留下纸张痕迹 【突出优点】 SFLHHDM 塑料剪贴板的这个盖面是哑光光泽质地，因此具有抗摩擦、防尘、防水的特点，并且易于用湿布擦拭干净。手感舒适、耐刮擦、耐磨，即使在户外工作也能很好地保护文件免受恶劣天气的影响 【使用范围广】这款塑料剪贴板是多功能的，文件封面有利于保护我们的隐私。坚固轻便的夹板文件夹可以轻松书写和记笔记，无论是学校的户外学习项目、商务会议、办公室或实验室的日常工作，都是一份很好的礼物', 2.00, 109, '1738928683467_71b7mtXEKVL._AC_SL1500_.jpg', 3000, '2025-02-07 19:44:43', '2025-02-07 19:44:43');
INSERT INTO `products` VALUES (271, '2 PCS 可折叠剪贴板，360°封面文件夹剪贴板，塑料剪贴板带双低调夹，A4大小的文件夹存储A3 A4纸剪贴板，办公学习用品剪贴板-深绿色', '', '【尺寸和数量】2 x 深绿色折叠剪贴板扩展尺寸：12.4“x19.17”，折叠尺寸：9.4“x12.4”。A4 尺寸可满足日常办公文档存储需求。圆角设计，坚固轻便的夹板文件夹可以使书写和记事变得轻松，方便我们在不同场合携带它 【PP弹性塑料】这个文件剪贴板存储是由3层泡沫PP材料制成的，因为它具有良好的抗拉强度和稳定性。可 360 度翻转使用，易于编写和检查，您可以将文件剪辑在剪贴板内部或外部，管理更加规范，满足您的随身携带和记录需求 【双夹设计】折叠板顶部和左侧有金属弹簧夹，夹紧力强，不易折断，可轻松容纳多达 100 页 A3、A4、A5、A6 尺寸的纸张并书写。橡胶夹角，抓握更牢固，不会留下纸张痕迹 【突出优点】 SFLHHDM 塑料剪贴板的这个盖面是哑光光泽质地，因此具有抗摩擦、防尘、防水的特点，并且易于用湿布擦拭干净。手感舒适、耐刮擦、耐磨，即使在户外工作也能很好地保护文件免受恶劣天气的影响 【使用范围广】这款塑料剪贴板是多功能的，文件封面有利于保护我们的隐私。坚固轻便的夹板文件夹可以轻松书写和记笔记，无论是学校的户外学习项目、商务会议、办公室或实验室的日常工作，都是一份很好的礼物', 2.00, 109, '1738928689489_71VanDayMcL._AC_SL1500_.jpg', 3000, '2025-02-07 19:44:49', '2025-02-07 19:44:49');
INSERT INTO `products` VALUES (272, 'ZICOTO 美学螺旋笔记本 3 件装女士 - 可爱的大学规则 8x6 日记本/笔记本，带大口袋和线条页面 - 在工作或学校保持整洁的完美用品', '', '轻松完成所有事情：多么聪明且漂亮的方式来组织笔记、提醒、待办事项并将您的想法转化为行动！可爱的螺旋笔记本套装是办公室和家庭使用的绝佳工具，可以整齐而有格地写下您想到的任何事情 充足的空间 - 3件套：每个笔记本的大小完美，为8.2x6.2“，还有一个额外的双面存储口袋，用于存放松散的笔记、文件、购物清单等 - 有了ZICOTOs的大学规则笔记本日记套装，你可以把所有东西整齐地放在一个地方。 美丽的简约设计：可爱的外观，让写作变得有趣！设计可爱的螺旋日记本具有内页线条，可实现整洁、均匀和清晰的书写，或者换句话说：无拘无束的空间来释放您的创造力 实用螺旋装订：纸质笔记本是赢家！每个可爱的笔记本都旨在对您在家中或工作的日常生活产生积极影响。巧妙的螺旋装订可确保顺利翻页并保持页面可靠连接，同时在打开时仍保持平整 适合日常使用的优质产品：无论是用于记笔记和任务、头脑风暴、日记还是涂鸦，由于其坚固的封面和带有穿孔边缘的优质纸张，易于撕下，这款现代笔记本是您长时间的耐用伴侣', 2.00, 109, '1738928702036_71HQQuouEkL._AC_SL1500_.jpg', 3000, '2025-02-07 19:45:02', '2025-02-07 19:45:02');
INSERT INTO `products` VALUES (273, 'DORESshop LED夜灯，插墙夜灯[2包]，带有黄昏到黎明传感器，可调光夜灯，可调节浴室、走廊、卧室、儿童房、楼梯、柔和白色的亮度', '', '自动开/关：带有特殊智能光感应芯片的装饰夜灯会检测周围环境的亮度，使夜灯在夜间自动开启，在白天关闭。无需手动打开 Night Lite。 亮度可调：这款可调光插电夜灯的亮度可通过滑动开关在0lm至60lm范围内调节。您可以选择您想要的亮度以满足您的不同使用场景。 能源效率：最大功耗的夜灯仅为 1W，有助于节省电费和保护环境。非常适合浴室、厨房、婴儿房、走廊、卧室、儿童房、婴儿房、楼梯、卫生间等。简单的设计可以使您的家更加舒适和温暖。 插入式 LED 夜灯：夜灯插入式设计在黑暗中提供更宽的亮度，并在夜间上厕所或在厨房取水时提供足够的光线来指引您的方向。 耐用且可靠：夜灯采用高质量塑料制成，这款农舍夜灯使用寿命长。精心设计的 mini outlook 节省空间，不会堵塞其他设备的底部出口。', 2.00, 110, '1738928917533_71Y0SEq9m4L._AC_SL1500_.jpg', 3000, '2025-02-07 19:48:37', '2025-02-07 19:48:37');
INSERT INTO `products` VALUES (274, '浪涌保护器电源板，带多个插座的延长线，5英尺超薄扁平插头8个插座4个USB端口（2USB C），1080J多插头插座扩展器，适用于家庭办公室、大学宿舍、房间必需品', '', '自动开/关：带有特殊智能【12 合 1 电源板】带有 8AC 宽插座和 4 个 USB 充电端口（总共 5V/3.1A）的电源板可同时为多达 12 台设备供电。2.2 英寸的 CES 广泛分布在出口之间，适合大型适配器而不会相互阻塞。 【超薄扁平插头电源板】仅配备 0.35 英寸超薄插头和 45° 直角设计，可轻松靠近墙壁，并隐藏在家具、床或冰箱的背面。 【2 x USB C 充电站】为您的设备增加了额外的 2 个 USB C 端口，带有 USB C 端口的电源板最多可充电 5V/3A。USB-A 端口最多可充电 5V/2.4A。 【1080J浪涌保护】带有多个插座的延长线带有浪涌保护铁和过载保护，可以保护您的电器免受照明、浪涌或尖刺的影响。 【多重安全保护】RoHS、ETL 证书。这种扁平的墙壁插头具有过载保护、短路保护等功能。防火 PC 外壳在 1382°F 下具有阻燃性，使其更耐用。光感应芯片的装饰夜灯会检测周围环境的亮度，使夜灯在夜间自动开启，在白天关闭。无需手动打开 Night Lite。 亮度可调：这款可调光插电夜灯的亮度可通过滑动开关在0lm至60lm范围内调节。您可以选择您想要的亮度以满足您的不同使用场景。 能源效率：最大功耗的夜灯仅为 1W，有助于节省电费和保护环境。非常适合浴室、厨房、婴儿房、走廊、卧室、儿童房、婴儿房、楼梯、卫生间等。简单的设计可以使您的家更加舒适和温暖。 插入式 LED 夜灯：夜灯插入式设计在黑暗中提供更宽的亮度，并在夜间上厕所或在厨房取水时提供足够的光线来指引您的方向。 耐用且可靠：夜灯采用高质量塑料制成，这款农舍夜灯使用寿命长。精心设计的 mini outlook 节省空间，不会堵塞其他设备的底部出口。', 2.00, 110, '1738928930543_516kyL3WcGL._AC_SL1500_.jpg', 3000, '2025-02-07 19:48:50', '2025-02-07 19:48:50');
INSERT INTO `products` VALUES (275, 'LEVOIT 卧室家用空气净化器，3 合 1 过滤清洁器带香味海绵，改善睡眠，过滤烟雾、过敏、宠物皮屑、异味、灰尘、办公室、桌面、便携式、Core Mini-P、白色', '', '去除无处不在的污染物：我们的预过滤器和主过滤器可捕获棉绒、毛发、宠物皮屑、细小的空气污染物和烟雾颗粒，帮助您实现更清洁的环境 帮助使气味无味：活性炭过滤器有助于中和烟雾、异味和烟雾。您会喜欢在家中深呼吸的感觉 随时随地使用：使用 Levoit Core Mini-P 家用空气净化器，专注于您在卧室、厨房或办公室的活动。它提供自动关闭显示屏，以实现不间断的睡眠和镇静的芳香疗法 #1 空气净化器品牌：Levoit 已在全球售出超过 650 万件产品，在 35 个国家和地区销售，并且 6 年来一直是空气净化技术的先驱 原装 LEVOIT 过滤器：仅使用原装 Levoit 更换零件以保持最佳性能（搜索 Core Mini-RF）。杂牌过滤器不一致、不可靠，并且可能会损坏空气净化器 注意：我们的产品在越南和中国都有制造，因此您可能会收到越南或中国制造的机器', 2.00, 110, '1738928944540_71tpOZEW0eL._AC_SL1500_.jpg', 3000, '2025-02-07 19:49:04', '2025-02-07 19:49:04');
INSERT INTO `products` VALUES (276, '纸巾架 - 自粘或钻孔，哑光黑色，升级铝制厨房卷筒分配器位于橱柜下，比不锈钢更轻但更坚固！', '', '高质量材料：这款纸巾架由高质量的铝合金材料制成，比不锈钢更轻但更硬、更坚固！它防水、防锈、耐腐蚀，可以持续很长时间。哑光黑色涂层使其更加时尚美观！ 节省空间：纸巾架非常适合您的厨房、浴室、车库、房车等，垂直或水平安装可以帮助您节省最多的空间。 易于安装：有两种方法可以安装此纸巾架，自粘或钻孔，您可以根据您的墙壁或橱柜情况自由选择合适的安装方法。 尺寸： 这款纸巾架导轨的长度为 12.2 英寸，足以悬挂大多数尺寸的纸巾卷。 广泛使用：不仅仅是纸巾架喔！本产品还可用作毛巾架、铝箔架、卫生纸架、帽架、餐具架等。买一个，随心所欲地使用吧！', 2.00, 110, '1738928960249_71SdoAGoQFL._AC_SL1500_.jpg', 3000, '2025-02-07 19:49:20', '2025-02-07 19:49:20');
INSERT INTO `products` VALUES (277, '4包丙烯酸棉签分配器，适用于棉签，球，垫子，牙线签-小型透明塑料罐药剂师罐套装，浴室必需品配件装饰，梳妆台化妆品存储组织器', '', '物品包括 12 件 - 4 包透明丙烯酸 qtip 持有人分配器带盖（2 个 12 盎司和 2 个 10 盎司）+ 4 个带有黑色预印文字的透明标签（棉球、棉签、棉垫、牙线签）+ 4 个白色标签 理想尺寸的存储容器 - 这些罐子是小物件的完美组织者，非常易于存放和取出，例如棉签、棉球、棉签、棉圆、牙线镐、卫生棉条、浴盐、发带、化妆刷、美容蛋、面刷、蜡笔、糖果、钢笔、夹子和更多小东西 每个空间的功能与美感 - 这些药剂师罐子是很好的装饰元素，是大多数家居装饰清关的配件套装，如洗手间用品、浴室必需品配件、梳妆台整理、浴室架子、卧室、厨房或办公室。 厚实透明光滑亚克力 - 4 个可爱的罐子和盖子由厚塑料制成，边缘光滑，安全且不易破裂。盖子 100% 适合罐子，以防止灰尘进入，易于打开和关闭 实用标签 - 我们精心准备的透明标签是大多数人常用的。您可以选择直接使用它们或将项目名称写在白色标签上。', 2.00, 110, '1738928978983_715jUKUnAXL._AC_SL1500_.jpg', 3000, '2025-02-07 19:49:38', '2025-02-07 19:49:38');
INSERT INTO `products` VALUES (278, 'HOMEXCEL 超细纤维清洁布，12 包清洁布，4 种颜色混合清洁毛巾，11.5“X11.5”（绿/蓝/黄/粉）', '', '超细纤维 有效清洁：将这些清洁布以完美尺寸（11.5“ x 11.5”）清洁您的工作台、厨房、窗户，甚至您的汽车和其他精致表面;仅使用水或清洁剂，即可获得无条纹和整洁的效果 无尘无划痕：由87%的聚酯纤维和13%的聚酰胺制成;这些清洁抹布摸起来柔软且不起毛;它们不会划伤或损坏任何饰面;放心清洁 超吸水性：这些超细纤维清洁布旨在快速吸收液体，非常适合用于干燥餐具、擦拭溢出物或抛光表面;超细纤维材料确保以最小的工作量进行高效清洁 可重复使用：这些清洁毛巾可以重复使用数百次;它们采用加固边缘，经久耐用，不易断裂;通过减少纸巾的使用对环境产生积极影响 多功能且易于清洗：不仅适合一般清洁任务，也非常适合清洁汽车外部或内部、电子产品、眼镜、屏幕等;使用后，只需冲洗或扔进洗衣机即可', 2.00, 110, '1738928992019_813-YxuWrrL._AC_SL1500_.jpg', 3000, '2025-02-07 19:49:52', '2025-02-07 19:49:52');
INSERT INTO `products` VALUES (279, '电源板浪涌保护器 - 6 个广泛插座，带 3 个 USB 端口 （1 个 USB C），3 侧插座延长板，5 英尺延长线扁平插头，壁挂式小型电源板，适用于旅行家庭办公室大学宿舍', '', '【带 USB C 快速充电的 9 合 1 桌面电源板】— 配备 6 个交流电源插座、2 个 USB 端口和 1 个 USB C 电源板，可同时为 9 台设备供电。USB C 充电端口最大 3A，USB A 充电端口最大 2.4A，借助智能充电技术，它可以自动检测您连接的设备并达到更快的充电效率，无需各种转换器即可为您的设备充电。 【3 侧节省空间的设计和宽广的出口】— 3 侧设计，每个交流电源插座之间有 1.6 英寸的空间，比标准的 1.5 英寸插座大，适合大型适配器而不会相互阻塞。紧凑的尺寸 （5.0*1.9*1.8 英寸） 在您的桌面或行李箱上占用的空间更小，对于旅行、家庭、办公室和大学宿舍来说是必不可少的。 【带扁平插头的壁挂式延长线】— 低矮的扁平插头可轻松安装在狭小空间内;直角平塞设计，防止底部塞堵塞;5 英尺升级后的电源线非常粗，具有更好的载流能力 （13A）;背面的两个安装孔使该电源板可以安全地安装在各种应用中。 【过载浪涌保护器 】 — 具有 900 焦耳浪涌保护器插座。带有集成断路器的点亮开/关开关，用于所有插座的过载保护，当电压浪涌压倒性时，它会自动切断电源以保护连接的设备。（“浪涌保护”指示灯亮起表示您的设备受到保护）。 【多重安全保护】— 这款旅行电源板经过 ROH、FC、ETCL 认证，可防止过压、过流、过充、短路、过热。防火 PC 外壳具有 1382°F 的阻燃性，使其更耐用，使用寿命更长。', 2.00, 110, '1738929002615_61eWr5cZGPL._AC_SL1500_.jpg', 3000, '2025-02-07 19:50:02', '2025-02-07 19:50:02');
INSERT INTO `products` VALUES (280, 'Bounty 快速尺寸纸巾，白色，12 家庭卷 = 30 普通卷', '', '包装包含 12 卷 Bounty 白色快速尺寸纸巾 每张卷中更多的工作表，更多的任务* *vs. Bounty Double Plus 吸水性更强，与领先的普通品牌相比，您可以更少用量 与领先的普通品牌相比，更快地收拾烂摊子 使用 Quick Size 卷，您可以根据混乱的大小选择板材尺寸。 6 包 2 份家庭卷 = 30 份普通卷 过去 6 年在线媒体奖项中获奖最多的纸巾', 2.00, 110, '1738929016753_81H0SGO8pEL._AC_SL1500_.jpg', 3000, '2025-02-07 19:50:16', '2025-02-07 19:50:16');
INSERT INTO `products` VALUES (281, 'Kitsch 头发喷雾瓶 - 带有超细喷雾的连续水喷雾，适用于发型设计、理发店、沙龙、清洁、植物、多功能喷雾瓶 - 由再生塑料制成 - 陶土，5盎司', '', '时尚的多功能设计：使用我们时尚、可再填充的喷雾瓶提升您的美容程序，非常适合使用头发水瓶喷雾喷雾轻松定型头发，为您的美容方案增添一丝优雅 环保选择：我们的喷雾瓶由回收材料制成，拥抱可持续性，支持环保生活，同时通过持续喷雾瓶改善您的日常生活 节省空间的便利性：使用我们的紧凑型喷雾瓶享受轻松的处理和存放，其设计可无缝融入任何美容或家庭日常活动 特定功能： 我们的喷雾瓶专为在各种应用中精确、有针对性的使用而设计，确保可靠性和效率 轻松优雅：体验我们的喷雾瓶带来的功能性和风格的融合，这是任何现代生活方式的必备品，也是一个贴心的礼物想法', 2.00, 110, '1738929028455_51u3yqZIjWL._AC_SL1250_.jpg', 3000, '2025-02-07 19:50:28', '2025-02-07 19:50:28');
INSERT INTO `products` VALUES (282, '200ML 陶瓷扩散器，香薰扩散器，带 7 种颜色灯的精油扩散器，家庭办公室自动关闭，木纹底座（1/3/6/ON 小时工作时间）', '', '陶瓷 超声波扩散器：家用香薰扩散器通过高频超声波振动，可以将精油和水制成超细纳米水雾，在空气中，产生香味还可以加湿干燥的空气，仿佛融入大自然的怀抱，放松您的身体和情绪。 手工陶瓷扩散器：通过经验丰富的工匠手工研磨，香薰机的陶瓷表面有磨砂颗粒。 氛围灯效：7 个 LED 灯会自动改变，您也可以选择喜欢的灯光颜色，带有香味和水雾。 无水自动关机功能：香薰机可连续使用6-8h，无水时自动关机。 定时功能：可设定工作时间1H/3H/6H/ON。 超低调设计：超声波香薰扩散器具有低音工作（≤19dB）的特点，可在夜间使用，缓解情绪，缓解压力，促进睡眠。', 2.00, 110, '1738929043295_71fsxb94LlL._AC_SL1500_.jpg', 3000, '2025-02-07 19:50:43', '2025-02-07 19:50:43');
INSERT INTO `products` VALUES (283, 'Phomemo D30 标签制作机，便携式蓝牙迷你标签打印机，智能手机手持式热敏贴纸小型贴标机多种模板字体图标无墨家庭办公室', '', '升级版 - Phomemo D30 蓝牙标签机支持连续和固定长度的标签胶带。它的重量和尺寸是传统标签机的一半，并配备了德国热敏打印头。打印质量提高了 25%，提供卓越的清晰度、轻松的作、流畅的打印和快速的加工 使用热敏技术节省资金 - D30 蓝牙标签机使用无墨打印，不需要墨水、碳粉或色带。有许多彩色热敏标签胶带可供选择，与大多数标签制造商相比，总体成本要低得多。（此标签制作机仅生成黑色文本。要创建彩色标签设计，请使用彩色图案标签胶带） 多种创意功能和标签模板 - 从1000+符号、60+框架和各种字体中选择。享受便利并节省时间。使用该应用程序轻松创建各种标签设计，包括图标、文本、表格、符号、徽标、条形码、二维码、图像、时间戳、Excel 导入、扫描、OCR 和语音识别。这既有趣又轻松！ 无线和便携式 - 这款迷你尺寸的蓝牙连接Phomemo标签打印机提供了方便快捷的移动设备打印。它有一个内置的、耐用的可充电电池，可长时间使用。紧凑的设计使其可以轻松滑入您的口袋，便于携带 应用广泛 - Phomemo D30 贴纸打印机非常适合家庭整理、学习用品（存储、食品日期标记、化妆品分类、罐子贴纸）、学校用品（姓名标签、学习笔记、办公文件）、电缆和个人物品识别以及小企业使用（价格标签、珠宝标签等）', 2.00, 110, '1738929057281_51TqaqMXyxL._AC_SL1080_.jpg', 3000, '2025-02-07 19:50:57', '2025-02-07 19:50:57');
INSERT INTO `products` VALUES (284, 'Cruise Essentials， Addtam 6 英尺超扁平延长线，带 6 个插座延长器，扁平插头电源板，无浪涌保护器，适用于游轮、旅行、宿舍、家庭办公室、ETL 认证', '', '【直角超扁平插头】 - 仅 0.35 英寸超薄插头和 45 度直角设计，比传统插头纤薄得多，可以轻松靠近墙壁，隐藏在家具、床或冰箱的背面，不会浪费您家的每一英寸空间 【6 合 1 电源板延长线】- 带有 3 个交流电源插座的 6 面电源板可以接受标准的 N American 2 或 3 芯扁平插针插头而不会阻塞（1875W/125V/15A），大学宿舍、家庭、办公室、卧室、厨房等的必备配件 【邮轮配件必备品】- 小型邮轮电源板带有无电涌保护，绝对是家庭和邮轮配件的必备品;小巧轻便，携带方便，最适合旅行 【易于安装在墙壁和桌面上】-无需测量和猜测您必须连接螺钉的位置，两端 Addtam 独特的螺钉固定设计使这个白色电源板可以安全地安装在墙壁上或桌子下（包括 4 个螺钉）。让您的桌面井井有条 【多重安全保护】- ETL 证书。这款带有多个插座的延长线具有 ON/OFF 开关过载保护、短路保护、过流保护、过压保护和过热保护。当电压浪涌压倒性时，它将自动切断电源以保护连接的设备。', 2.00, 110, '1738929073432_51GKqaOz1GL._AC_SL1500_.jpg', 3000, '2025-02-07 19:51:13', '2025-02-07 19:51:13');
INSERT INTO `products` VALUES (285, 'LANE LINEN 16 件套浴巾套装 - 100% 纯棉浴室毛巾套装、高吸水性浴室毛巾、豪华浴巾套装、柔软毛巾、4 条浴巾、4 条手巾、8 条毛巾 - 铂金', '', '优质浴巾套装：使用我们的 600 GSM 100% 优质棉 16 件套固体高吸水毛巾套装，将酒店水疗氛围带回家。这些健身毛巾采用毛圈结构，不仅触感柔软，而且吸水性强，干燥方便舒适。 每套 16 件套铂金毛巾包括：4 条超大浴巾 - 28 英寸 x 54 英寸，4 条手巾 - 16 英寸 x 28 英寸和 8 条毛巾 - 13 英寸 x 13 英寸。每条浴巾、手巾和洗脸巾均采用优质棉花制成，保证在您的皮肤上柔软，让您在淋浴后保持温暖干燥。 护理说明：由于使用了低扭曲环，我们的浴室毛巾提供了极好的柔软度。由于毛巾含有 100% 棉绒，您可能会在前几次使用时看到一些棉绒，但每次洗涤后应该会减少。为获得最佳使用效果，首次使用时请单独清洗。始终单独清洗毛巾，以减少棉绒。 Oeko-Tex 认证：我们的浴室毛巾套装由 OEKO-TEX 认证工厂制成。这些浴巾浴室套装非常适合任何浴室配件。这些豪华浴巾采用美丽的纯色设计，可与任何浴室装饰相配。 满意保证：具有优质酒店水疗品质的最佳浴巾。我们相信我们产品的耐用性和柔软性。但是，以防万一，如果您对购买不满意，我们提供 30 天退款保证。这是男士和女士、妈妈和爸爸的完美礼物，情人节 - 母亲 - 父亲节和圣诞节。', 2.00, 110, '1738929097866_A1OcYGF8bdL._AC_SL1500_.jpg', 3000, '2025-02-07 19:51:37', '2025-02-07 19:51:37');
INSERT INTO `products` VALUES (286, 'LANE LINEN 16 件套浴巾套装 - 100% 纯棉浴室毛巾套装、高吸水性浴室毛巾、豪华浴巾套装、柔软毛巾、4 条浴巾、4 条手巾、8 条毛巾 - 铂金', '', '优质浴巾套装：使用我们的 600 GSM 100% 优质棉 16 件套固体高吸水毛巾套装，将酒店水疗氛围带回家。这些健身毛巾采用毛圈结构，不仅触感柔软，而且吸水性强，干燥方便舒适。 每套 16 件套铂金毛巾包括：4 条超大浴巾 - 28 英寸 x 54 英寸，4 条手巾 - 16 英寸 x 28 英寸和 8 条毛巾 - 13 英寸 x 13 英寸。每条浴巾、手巾和洗脸巾均采用优质棉花制成，保证在您的皮肤上柔软，让您在淋浴后保持温暖干燥。 护理说明：由于使用了低扭曲环，我们的浴室毛巾提供了极好的柔软度。由于毛巾含有 100% 棉绒，您可能会在前几次使用时看到一些棉绒，但每次洗涤后应该会减少。为获得最佳使用效果，首次使用时请单独清洗。始终单独清洗毛巾，以减少棉绒。 Oeko-Tex 认证：我们的浴室毛巾套装由 OEKO-TEX 认证工厂制成。这些浴巾浴室套装非常适合任何浴室配件。这些豪华浴巾采用美丽的纯色设计，可与任何浴室装饰相配。 满意保证：具有优质酒店水疗品质的最佳浴巾。我们相信我们产品的耐用性和柔软性。但是，以防万一，如果您对购买不满意，我们提供 30 天退款保证。这是男士和女士、妈妈和爸爸的完美礼物，情人节 - 母亲 - 父亲节和圣诞节。', 2.00, 110, '1738929573791_A1OcYGF8bdL._AC_SL1500_.jpg', 3000, '2025-02-07 19:59:33', '2025-02-07 19:59:33');
INSERT INTO `products` VALUES (287, 'LANE LINEN 16 件套浴巾套装 - 100% 纯棉浴室毛巾套装、高吸水性浴室毛巾、豪华浴巾套装、柔软毛巾、4 条浴巾、4 条手巾、8 条毛巾 - 铂金', '', '优质浴巾套装：使用我们的 600 GSM 100% 优质棉 16 件套固体高吸水毛巾套装，将酒店水疗氛围带回家。这些健身毛巾采用毛圈结构，不仅触感柔软，而且吸水性强，干燥方便舒适。 每套 16 件套铂金毛巾包括：4 条超大浴巾 - 28 英寸 x 54 英寸，4 条手巾 - 16 英寸 x 28 英寸和 8 条毛巾 - 13 英寸 x 13 英寸。每条浴巾、手巾和洗脸巾均采用优质棉花制成，保证在您的皮肤上柔软，让您在淋浴后保持温暖干燥。 护理说明：由于使用了低扭曲环，我们的浴室毛巾提供了极好的柔软度。由于毛巾含有 100% 棉绒，您可能会在前几次使用时看到一些棉绒，但每次洗涤后应该会减少。为获得最佳使用效果，首次使用时请单独清洗。始终单独清洗毛巾，以减少棉绒。 Oeko-Tex 认证：我们的浴室毛巾套装由 OEKO-TEX 认证工厂制成。这些浴巾浴室套装非常适合任何浴室配件。这些豪华浴巾采用美丽的纯色设计，可与任何浴室装饰相配。 满意保证：具有优质酒店水疗品质的最佳浴巾。我们相信我们产品的耐用性和柔软性。但是，以防万一，如果您对购买不满意，我们提供 30 天退款保证。这是男士和女士、妈妈和爸爸的完美礼物，情人节 - 母亲 - 父亲节和圣诞节。', 2.00, 110, '1738929596301_81lqVnewYlL._AC_SL1500_.jpg', 3000, '2025-02-07 19:59:56', '2025-02-07 19:59:56');
INSERT INTO `products` VALUES (288, 'LANE LINEN 16 件套浴巾套装 - 100% 纯棉浴室毛巾套装、高吸水性浴室毛巾、豪华浴巾套装、柔软毛巾、4 条浴巾、4 条手巾、8 条毛巾 - 铂金', '', '优质浴巾套装：使用我们的 600 GSM 100% 优质棉 16 件套固体高吸水毛巾套装，将酒店水疗氛围带回家。这些健身毛巾采用毛圈结构，不仅触感柔软，而且吸水性强，干燥方便舒适。 每套 16 件套铂金毛巾包括：4 条超大浴巾 - 28 英寸 x 54 英寸，4 条手巾 - 16 英寸 x 28 英寸和 8 条毛巾 - 13 英寸 x 13 英寸。每条浴巾、手巾和洗脸巾均采用优质棉花制成，保证在您的皮肤上柔软，让您在淋浴后保持温暖干燥。 护理说明：由于使用了低扭曲环，我们的浴室毛巾提供了极好的柔软度。由于毛巾含有 100% 棉绒，您可能会在前几次使用时看到一些棉绒，但每次洗涤后应该会减少。为获得最佳使用效果，首次使用时请单独清洗。始终单独清洗毛巾，以减少棉绒。 Oeko-Tex 认证：我们的浴室毛巾套装由 OEKO-TEX 认证工厂制成。这些浴巾浴室套装非常适合任何浴室配件。这些豪华浴巾采用美丽的纯色设计，可与任何浴室装饰相配。 满意保证：具有优质酒店水疗品质的最佳浴巾。我们相信我们产品的耐用性和柔软性。但是，以防万一，如果您对购买不满意，我们提供 30 天退款保证。这是男士和女士、妈妈和爸爸的完美礼物，情人节 - 母亲 - 父亲节和圣诞节。', 2.00, 110, '1738929603960_91Zn2Ge-b-L._AC_SL1500_.jpg', 3000, '2025-02-07 20:00:03', '2025-02-07 20:00:03');
INSERT INTO `products` VALUES (289, 'LANE LINEN 16 件套浴巾套装 - 100% 纯棉浴室毛巾套装、高吸水性浴室毛巾、豪华浴巾套装、柔软毛巾、4 条浴巾、4 条手巾、8 条毛巾 - 铂金', '', '优质浴巾套装：使用我们的 600 GSM 100% 优质棉 16 件套固体高吸水毛巾套装，将酒店水疗氛围带回家。这些健身毛巾采用毛圈结构，不仅触感柔软，而且吸水性强，干燥方便舒适。 每套 16 件套铂金毛巾包括：4 条超大浴巾 - 28 英寸 x 54 英寸，4 条手巾 - 16 英寸 x 28 英寸和 8 条毛巾 - 13 英寸 x 13 英寸。每条浴巾、手巾和洗脸巾均采用优质棉花制成，保证在您的皮肤上柔软，让您在淋浴后保持温暖干燥。 护理说明：由于使用了低扭曲环，我们的浴室毛巾提供了极好的柔软度。由于毛巾含有 100% 棉绒，您可能会在前几次使用时看到一些棉绒，但每次洗涤后应该会减少。为获得最佳使用效果，首次使用时请单独清洗。始终单独清洗毛巾，以减少棉绒。 Oeko-Tex 认证：我们的浴室毛巾套装由 OEKO-TEX 认证工厂制成。这些浴巾浴室套装非常适合任何浴室配件。这些豪华浴巾采用美丽的纯色设计，可与任何浴室装饰相配。 满意保证：具有优质酒店水疗品质的最佳浴巾。我们相信我们产品的耐用性和柔软性。但是，以防万一，如果您对购买不满意，我们提供 30 天退款保证。这是男士和女士、妈妈和爸爸的完美礼物，情人节 - 母亲 - 父亲节和圣诞节。', 2.00, 110, '1738929612927_81lqVnewYlL._AC_SL1500_.jpg', 3000, '2025-02-07 20:00:12', '2025-02-07 20:00:12');
INSERT INTO `products` VALUES (290, 'LANE LINEN 16 件套浴巾套装 - 100% 纯棉浴室毛巾套装、高吸水性浴室毛巾、豪华浴巾套装、柔软毛巾、4 条浴巾、4 条手巾、8 条毛巾 - 铂金', '', '优质浴巾套装：使用我们的 600 GSM 100% 优质棉 16 件套固体高吸水毛巾套装，将酒店水疗氛围带回家。这些健身毛巾采用毛圈结构，不仅触感柔软，而且吸水性强，干燥方便舒适。 每套 16 件套铂金毛巾包括：4 条超大浴巾 - 28 英寸 x 54 英寸，4 条手巾 - 16 英寸 x 28 英寸和 8 条毛巾 - 13 英寸 x 13 英寸。每条浴巾、手巾和洗脸巾均采用优质棉花制成，保证在您的皮肤上柔软，让您在淋浴后保持温暖干燥。 护理说明：由于使用了低扭曲环，我们的浴室毛巾提供了极好的柔软度。由于毛巾含有 100% 棉绒，您可能会在前几次使用时看到一些棉绒，但每次洗涤后应该会减少。为获得最佳使用效果，首次使用时请单独清洗。始终单独清洗毛巾，以减少棉绒。 Oeko-Tex 认证：我们的浴室毛巾套装由 OEKO-TEX 认证工厂制成。这些浴巾浴室套装非常适合任何浴室配件。这些豪华浴巾采用美丽的纯色设计，可与任何浴室装饰相配。 满意保证：具有优质酒店水疗品质的最佳浴巾。我们相信我们产品的耐用性和柔软性。但是，以防万一，如果您对购买不满意，我们提供 30 天退款保证。这是男士和女士、妈妈和爸爸的完美礼物，情人节 - 母亲 - 父亲节和圣诞节。', 2.00, 110, '1738929617526_91VrcBo1BEL._AC_SL1500_.jpg', 3000, '2025-02-07 20:00:17', '2025-02-07 20:00:17');
INSERT INTO `products` VALUES (291, '小垃圾袋 4 加仑 - 100 个装 4 加仑垃圾袋，办公室卧室浴室小垃圾袋，白色 4 加仑小垃圾桶衬垫', '', '4 加仑垃圾袋 - 尺寸为 17.7 英寸宽 x 19.7 英寸高，这些小垃圾袋可轻松容纳高达 4 加仑的垃圾桶。尺寸恰到好处，非常适合大多数小型垃圾桶 实用耐用性 - 小垃圾袋足够坚固，可以处理日常生活垃圾，除非是尖锐的物体。星形密封底部确保强度并避免泄漏 100 计数 - 总共 100 计数的超值，可以持续很长时间 半透明和穿孔 - 白色半透明，便于垃圾分类。穿孔，易于撕裂 用途广泛 - 使用我们的无味4加仑垃圾袋处理日常家庭垃圾需求。适合作为办公室、卧室、厨房和浴室垃圾袋。出色的小垃圾桶衬垫，满足您的日常清洁需求', 2.00, 110, '1738929850591_61FOUHlcOWL._AC_SL1500_.jpg', 3000, '2025-02-07 20:04:10', '2025-02-07 20:04:10');
INSERT INTO `products` VALUES (292, '重型超强 13 加仑垃圾袋，高厨房垃圾袋由回收材料制成，包括沿海塑料，拉绳，防泄漏和穿刺，灰色，海边微风香味，80 个袋子', '', '大垃圾袋：此包装包含 80 个重型超强高厨房 13 加仑垃圾袋，由 35% 的回收材料制成，包括 10% 的沿海塑料*、灰色、海边微风香味 持续气味控制：高厨房垃圾袋具有持续气味控制和 Seaside Breeze 香味，可对抗难闻的气味，让您的厨房保持清新气味 6 合 1 保护：灵活的香味大垃圾袋由沿海和再生塑料制成，提供 6 个保护点，将垃圾保持在应有的位置：弯曲强度、坚韧的拉绳、气味控制以及防泄漏、穿刺和撕裂 可靠的拉绳闭合：这些厨房垃圾袋上的耐用拉绳使其易于运输重物、捐赠物、季节性物品等 100%满意保证：我们希望您对13加仑大小的重型垃圾袋感到满意，如果您有任何问题，请通过包装背面的热线号码与我们联系，以便我们提供帮助。', 2.00, 110, '1738929867368_81P0YlvPuxL._AC_SL1500_.jpg', 3000, '2025-02-07 20:04:27', '2025-02-07 20:04:27');
INSERT INTO `products` VALUES (293, '大型小垃圾袋，翻盖领带，薰衣草和甜香草香味，4加仑，26个装', '', '这个包装包含26个Hefty Flap Tie，小垃圾，白色，4加仑垃圾袋，带有薰衣草和甜香草香味，每个0.5毫米厚 迷你垃圾袋的尺寸非常适合用于浴室、卧室、汽车和家庭办公室的较小垃圾桶 翻盖系带开合便于密封和取出小垃圾袋 各种香味的小垃圾袋具有专利的Arm & Hammer气味中和剂，可以抵抗难闻的气味，保持厨房清新的气味。 超小号浴室垃圾袋采用可回收包装，确保环保', 2.00, 110, '1738929879030_81dXKhq96mL._AC_SL1500_.jpg', 3000, '2025-02-07 20:04:39', '2025-02-07 20:04:39');
INSERT INTO `products` VALUES (294, 'Charmount 4加仑垃圾袋 - 适用于浴室、厨房、卧室、办公室的小拉绳垃圾袋，60个装（升级 - 易于分离）', '', '抽绳封口 - 为了减少恶臭和便于携带，4 加仑垃圾袋设计有耐用的抽绳系带。它使我们的垃圾袋很容易捆绑和扔掉 坚固的结构：这些 4 加仑的袋子由耐用的材料制成，足够坚固，适合日常使用，防止泄漏和撕裂，保护您的垃圾安全 3-5 加仑容量 - 抽绳垃圾袋适用于 4 加仑垃圾桶（10-15L）。4 加仑垃圾袋的尺寸为 17.7 英寸宽 x 19.7 英寸高（45 厘米 x 50 厘米） 使用方便 - 4 加仑大小的小型垃圾袋总共有 60 个。轻松快速地分离一个新的，以便在袋子之间有一个漂亮的穿孔边缘 多用途 - 它不仅可以作为浴室、厨房、办公室、卧室、户外、汽车、宠物砂和婴儿尿布处理的小垃圾袋，而且是存放季节性物品和衣物的理想选择', 2.00, 110, '1738929896328_71OGD1bfPpL._AC_SL1500_.jpg', 3000, '2025-02-07 20:04:56', '2025-02-07 20:04:56');
INSERT INTO `products` VALUES (295, '100 个 4 加仑小黑色垃圾袋，耐用的 PE 材料，手柄，断点，46x60 厘米', '', '[坚固耐用的 4 加仑垃圾袋]：这些黑色小垃圾袋具有良好的韧性，不易撕裂。黑色垃圾袋已经过测试，可承受 15.43-17.63 磅（7-8 公斤）的最大重量，其强度足以满足日常生活需求，但要避免使用尖锐物品。 [4 加仑垃圾袋材料]：这些小黑色垃圾袋仅使用纯 PE 材料以确保您的安全和健康。小垃圾袋足够耐用，可以防止撕裂、防漏、防刺穿、有弹性。 [内置手柄和断点设计]：小垃圾袋采用手持设计，便于携带和悬挂，方便牢固地关闭丢弃物。这些 4 加仑垃圾袋的断点清晰，易于从卷筒中撕开。我们的小型黑色垃圾袋具有出色的抗穿刺和抗撕裂性。 [小黑色垃圾袋尺寸]：4 加仑垃圾袋尺寸为 46*60cm/18*23.62in.20 计数/卷，5 卷，共 100 计数。 [多用途 4 加仑垃圾袋]：小型垃圾袋不仅设计用于室内使用（用于办公室、厨房、客厅、卧室、浴室、碎纸机等），还适用于户外应用（猫砂、狗粪、汽车垃圾等）。', 2.00, 110, '1738929916888_51GPBjUuD5L._AC_SL1024_.jpg', 3000, '2025-02-07 20:05:16', '2025-02-07 20:05:16');
INSERT INTO `products` VALUES (296, 'The Honest Company Clean Conscious 无香湿巾 |超过 99% 的水、可堆肥、植物基、婴儿湿巾 |敏感肌肤低过敏性，EWG 验证 |Geo Mood，576 支', '', '清理生活中的所有烂摊子。可堆肥、植物性多用途湿巾由超过 99% 的水和仅 7 种透明成分制成，对婴儿的敏感皮肤温和安全，但对全家人都很好 低过敏性，无香料，经过皮肤科医生测试，并获得国家湿疹认可印章，这意味着您可以相信该产品是安全的，适合皮肤敏感的人 尿布任务及其他：这些水湿巾非常耐用且超厚，配有方便的翻盖分配器 - 可用于所有家用表面，用于锻炼后焕然一新，清洁宠物的爪子，擦拭弄脏的玩具、凌乱的手指和尘土飞扬的植物 低过敏性;经皮肤科医生测试;EWG 验证;零残忍;NEA 认可;可堆肥并在 8 周内分解 不含： 塑料布/织物， 香水， 对羟基苯甲酸酯， 酒精， 氯处理', 2.00, 110, '1738929960551_81pxubtHa0L._SL1500_.jpg', 3000, '2025-02-07 20:06:00', '2025-02-07 20:06:00');
INSERT INTO `products` VALUES (297, 'Bedsure 白色沙发毯 - GentleSoft 女士舒适柔软毯子，可爱的小女孩羊毛毯，米白色，50x60 英寸', '', '送给亲人的礼物：这款超柔软的条纹法兰绒情人节抛毯是任何场合的完美礼物。其舒适舒适的设计提供了一种周到的方式来表达您的关心，全年提供温暖和时尚。非常适合作为爱情节日的顶级情人节礼物之一。 超柔软：这款条纹法兰绒绒毯采用增强的优质微纤维。其蓬松和超舒适的柔软性一年四季都提供最大的舒适感，使其成为备受赞赏的爱情礼物选择，非常适合情人节的舒适夜晚。 温暖而轻便：这款柔软舒适的毯子在重量和保暖之间保持了理想的平衡。当您准备依偎在这款柔软、平静的毯子中时，享受被拥抱的乐趣，使其成为送给她的情人节礼物的绝佳选择。 精致设计：这款毛茸茸的毯子采用经典的条纹图案，毫不费力地提升了您房间的装饰。非常适合在床上、沙发上或任何您想舒适放松的地方使用，它是送给女性礼物的绝佳选择。 耐用：这款毛绒毯子采用整齐的缝线设计，增强了耐用性，耐用性强。独特的染色技术确保鲜艳的色彩，即使经过多次洗涤也不会褪色——一定会成为难忘的情人节礼物。', 2.00, 110, '1738929979438_617jWhurG3L._AC_SL1500_.jpg', 3000, '2025-02-07 20:06:19', '2025-02-07 20:06:19');
INSERT INTO `products` VALUES (298, 'LANE LINEN 100%埃及棉床单特大号 - 1000线程计数，4件套特大号床单套装，光滑缎面编织特大号床单，超豪华床单，16英寸深口袋特大号床单套装 - 白色床单', '', '豪华感觉：体验这款由 100% 埃及棉制成的优质棉白色国王床单套装带来的无与伦比的舒适和奢华。这些埃及床单具有 1000 支高支数，确保如丝般光滑的质地，让您尽情享受舒适奢华的睡眠。 非常适合特大号床：这些特大号白色床单埃及棉套装包括1张带有深口袋和完全弹性边缘的床单：79“ x 81” + 16“确保在特大号床垫上紧密且安全地贴合，1张白色平面特大号床单：112” x 104“和2个特大号枕头套：20” x 36“， 提供全面覆盖和无缝的床上外观。 透气凉爽的床单：这些白色的王白色床单具有出色的透气性，促进更好的气流并在整个晚上调节温度。这些特大号埃及棉床单注重舒适和美学，具有优雅和永恒的设计。它们有一系列经典颜色可供选择，毫不费力地与任何卧室装饰相得益彰，为您的睡眠空间增添一丝精致感。 丝般柔软且耐用：这些白色床单国王由 100% 埃及棉制成，以其卓越的柔软性和耐用性而闻名。为了确保让人联想到高端酒店床单的奢华品质，我们采用了两股纱线方法，实现了 1000 支的奢华纱线。请注意，由于制造过程的限制，线程计数可能会有高达 +/- 5% 的轻微差异。 易于护理：这些白色床单套装特大号在冷水中用温和的洗涤剂轻轻循环机洗，然后在低温或精细设置下烘干，以保持其柔软度和质量。我们所有的床单套装都通过了 OEKO-TEX 认证，并包装在可重复使用的棉袋中，展示了我们对质量和可持续性的承诺。', 2.00, 110, '1738929993881_71Gffcjm4UL._AC_SL1500_.jpg', 3000, '2025-02-07 20:06:33', '2025-02-07 20:06:33');
INSERT INTO `products` VALUES (299, 'VALITIC 曲酸淡斑去除皂条含维生素 C、视黄醇、胶原蛋白、姜黄 - 原味日本复合物注入透明质酸、维生素 E、乳木果油、卡斯蒂利亚橄榄油（2 包）', '', 'Dark Spot Corrector：原创的日本黑斑修正复合物，我们的肥皂促进平衡、更均匀的色调和健康的光泽;你可以用它来做你的脸、手、脖子、比基尼区域、大腿内侧和腋下。 维生素 C、视黄醇和胶原蛋白：作为组合，它们可以帮助您的皮肤从内到外保持水分，最大限度地减少阳光伤害、黑斑和瑕疵，从而获得光滑和容光焕发的皮肤 姜黄皮肤：有益皮肤的品质。我们的肥皂采用清洁皮肤的姜黄配制而成，有助于恢复水分平衡，让您的皮肤从晒伤、细纹和皱纹中恢复活力;姜黄还可以减少疤痕;这种用途组合可以帮助您的面部清除痤疮爆发 恢复活力、去角质和滋养黑斑区域：我们的肥皂含有透明质酸、维生素 E、乳木果油和卡斯蒂利亚橄榄油，可渗透、活化您的皮肤 不含 SLS 和对羟基苯甲酸酯：非常适合日常使用！这种姜黄皂可用于清洁大部分皮肤;首先，用温水润湿皮肤，将姜黄皂均匀涂抹在皮肤上;然后，按摩 20-30 秒，最后用水冲洗干净 安全使用说明：如果您对本产品的任何成分过敏，请勿使用本产品。使用前进行斑贴试验。如果出现刺激，请停止使用。开封后 8 个月内使用。仅按指示使用', 2.00, 110, '1738930006143_51iMh82b5UL._SL1205_.jpg', 3000, '2025-02-07 20:06:46', '2025-02-07 20:06:46');
INSERT INTO `products` VALUES (300, '商品', '商品型号', '商品信息', 10.00, 1, '1738931521592_1.png,1738931521610_wallhaven-d6edoj_1920x1080.png,1738931521623_锁屏.png', 2000, '2025-02-07 20:32:01', '2025-02-07 20:32:01');
INSERT INTO `products` VALUES (301, '商品名', '商品型号', '商品信息', 10.00, 1, '1738932607594_picX.png,1738932607603_picX1.png', 2000, '2025-02-07 20:50:07', '2025-02-07 20:50:07');
INSERT INTO `products` VALUES (302, '商品名', '商品型号', '商品信息', 10.00, 1, '1738932726078_picX.png,1738932726090_picX1.png', 2000, '2025-02-07 20:52:06', '2025-02-07 20:52:06');
INSERT INTO `products` VALUES (303, 'The Honest Company Clean Conscious 无香湿巾 |超过 99% 的水、可堆肥、植物基、婴儿湿巾 |敏感肌肤低过敏性，EWG 验证...', '', '清理生活中的所有烂摊子。可堆肥、植物性多用途湿巾由超过 99% 的水和仅 7 种透明成分制成，对婴儿的敏感皮肤温和安全，但对全家人都很好 低过敏性，无香料，经过皮肤科医生测试，并获得国家湿疹认可印章，这意味着您可以相信该产品是安全的，适合皮肤敏感的人 尿布任务及其他：这些水湿巾非常耐用且超厚，配有方便的翻盖分配器 - 可用于所有家用表面，用于锻炼后焕然一新，清洁宠物的爪子，擦拭弄脏的玩具、凌乱的手指和尘土飞扬的植物 低过敏性;经皮肤科医生测试;EWG 验证;零残忍;NEA 认可;可堆肥并在 8 周内分解 不含： 塑料布/织物， 香水， 对羟基苯甲酸酯， 酒精， 氯处理', 2.00, 110, '1738933695003_81pxubtHa0L._SL1500_.jpg', 3000, '2025-02-07 21:08:15', '2025-02-07 21:08:15');
INSERT INTO `products` VALUES (304, 'Sharpty - 塑料挂架 - 成人衣物挂架 - T恤，连衣裙，衣架和配件 - 缺口挂架，耐用且多功能的彩色衣物衣架（20包，白色）', '', 'Sharpty - 塑料挂架 - 成人衣物挂架 - T恤，连衣裙，衣架和配件 - 缺口挂架，耐用且多功能的彩色衣物衣架（20包，白色）', 2.00, 110, '1738934272902_71naMNm1qkL._AC_SL1500_.jpg,1738934272904_71Mly4479hL._AC_SL1500_.jpg', 3000, '2025-02-07 21:17:52', '2025-02-08 19:10:54');
INSERT INTO `products` VALUES (305, 'Sharpty - 塑料挂架 - 成人衣物挂架 - T恤，连衣裙，衣架和配件 - 缺口挂架，耐用且多功能的彩色衣物衣架（20包，白色）', '', 'Sharpty - 塑料挂架 - 成人衣物挂架 - T恤，连衣裙，衣架和配件 - 缺口挂架，耐用且多功能的彩色衣物衣架（20包，白色）', 2.00, 110, '1738934425226_71naMNm1qkL._AC_SL1500_.jpg,1738934425229_81JJAsHZpyL._AC_SL1500_.jpg,1738934425232_81inLyaZcfL._AC_SL1500_.jpg,1738934425235_81iSCLtuBOL._AC_SL1500_.jpg,1738934425239_71Mly4479hL._AC_SL1500_.jpg', 3000, '2025-02-07 21:20:25', '2025-02-07 21:20:25');
INSERT INTO `products` VALUES (306, 'Sharpty - 塑料挂架 - 成人衣物挂架 - T恤，连衣裙，衣架和配件 - 缺口挂架，耐用且多功能的彩色衣物衣架（20包，白色）', '', 'Sharpty - 塑料挂架 - 成人衣物挂架 - T恤，连衣裙，衣架和配件 - 缺口挂架，耐用且多功能的彩色衣物衣架（20包，白色）', 2.00, 110, '1738934434363_71naMNm1qkL._AC_SL1500_.jpg,1738934434366_81JJAsHZpyL._AC_SL1500_.jpg,1738934434369_81inLyaZcfL._AC_SL1500_.jpg,1738934434371_81iSCLtuBOL._AC_SL1500_.jpg,1738934434375_71Mly4479hL._AC_SL1500_.jpg', 3000, '2025-02-07 21:20:34', '2025-02-07 21:20:34');
INSERT INTO `products` VALUES (307, 'Sharpty - 塑料挂架 - 成人衣物挂架 - T恤，连衣裙，衣架和配件 - 缺口挂架，耐用且多功能的彩色衣物衣架（20包，白色）', '', '👚 最大化空间并保持整洁：Sharpty 塑料挂架设计成纤薄的外形，以充分利用您的衣柜空间，同时保持整洁有序！使用我们的高品质衣架可以节省时间，因为您可以轻松找到所需的衣服。 👚 耐用材料：采用增强塑料边缘和耐用材料制成，我们的衣架一定会提供完美的稳定性，以满足您的所有标准服装需求以及较重的外套或夹克！凭借其光滑的表面，无需担心衣服上的污垢、折痕或痕迹。 👚 嵌入式凹槽：这些多功能衣架非常适合制作服装，但也可用于其他配件，如领带、腰带、披肩、细带衬衫、背心、吊带衫，甚至女士内衣。这些防滑衣架配有缺口肩部，可将您的衣物牢固地固定到位。 👚 面料友好设计：我们的白色塑料衣架光滑、干净的表面对您的衣服很温和。没有粗糙或锋利的边缘可能会损坏或在您的衣服上留下不需要的折痕或痕迹。相信我们会为您的壁橱和橱柜提供最有价值的组织工具。 👚 无忧保修：我们提供 1 年全面保修。如果您因任何原因不满意，请告诉我们，我们将尽一切努力解决问题。依赖我们的优质衣架，让您的衣橱保持整洁！', 2.00, 110, '1738934467808_71naMNm1qkL._AC_SL1500_.jpg,1738934467811_71Mly4479hL._AC_SL1500_.jpg', 3000, '2025-02-07 21:21:07', '2025-02-07 21:21:07');
INSERT INTO `products` VALUES (308, '11', '11', '11', 10.00, 11, '1738936602398_1.png,1738936602409_wallhaven-d6edoj_1920x1080.png,1738937396501_1.png,1738937396519_wallhaven-d6edoj_1920x1080.png,1738937396531_锁屏.png,1739012561540_wallhaven-d6edoj_1920x1080.png,1739012561550_锁屏.png,1739012561551_1.png', 11, '2025-02-07 21:56:42', '2025-02-08 19:02:41');
INSERT INTO `products` VALUES (309, '测试商品123', '123', '123', 123.00, 123, '1739016451523_ts2.jpg,1739016451528_tx.jpg,1739016451529_photo_2024-03-27_13-20-37.jpg', 123, '2025-02-08 20:07:31', '2025-02-08 20:09:25');

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `product_id` int(11) NOT NULL COMMENT '商品ID',
  `rating` int(11) NOT NULL COMMENT '星级 1-5',
  `content` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '评价内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO `reviews` VALUES (4, 8, 101, 5, '你好', '2025-02-09 18:06:18');
INSERT INTO `reviews` VALUES (5, 9, 101, 5, '你好', '2025-02-09 18:11:45');
INSERT INTO `reviews` VALUES (6, 8, 101, 5, '你好', '2025-02-09 18:11:51');

-- ----------------------------
-- Table structure for sales_stats
-- ----------------------------
DROP TABLE IF EXISTS `sales_stats`;
CREATE TABLE `sales_stats`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售统计ID',
  `product_id` int(11) NOT NULL COMMENT '商品ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `quantity_sold` int(11) NOT NULL COMMENT '售出数量',
  `total_revenue` decimal(10, 2) NOT NULL COMMENT ' 总收入',
  `sold_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '售出时间  ',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `sales_stats_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `sales_stats_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sales_stats
-- ----------------------------
INSERT INTO `sales_stats` VALUES (2, 123, 14, 10, 150.00, '2025-02-10 13:13:03');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT ' 密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '邮箱',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '邮寄地址',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '头像',
  `role_id` int(11) NULL DEFAULT 0 COMMENT '角色ID 0是普通用户 1是管理员',
  `is_member` int(11) NOT NULL COMMENT '是否为会员0否 1是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (8, ' 李华门前的狗', '$2a$10$c7OHUV9BrkS1Ay5oTrPmxe753RPZVQmf9Ha9jKfAftfy9kWXnuZuy', 'testdog@test.com', '中国', '123123123123', '1738659715922_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-04 17:01:56');
INSERT INTO `users` VALUES (9, 'test', '$2a$10$4IdE1S96lfxYu6hf0KTJJODrBrBm8qGi4nnjN2GrINLVBHj9iRjQi', '2', '', '4', '1738659985986_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-04 17:06:26');
INSERT INTO `users` VALUES (10, 'test01', '$2a$10$b0modQYcxz.iYZ7Uu3OiLOKghHloPLHDfNPEO7IX/5QFFUFNaeSJq', '3', '', '3', '1738663689333_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-04 18:08:09');
INSERT INTO `users` VALUES (12, 'testa', '$2a$10$WGW.P4n2A7OVesxj7Upr9exdAj2VECnYFe8pToVE4Y9jT5kYzyp0G', '4', '', '2', '1738664069666_tx.png', 0, 0, '2025-02-04 18:14:30');
INSERT INTO `users` VALUES (14, 'admin', '$2a$10$G4Ni/wXl8NQg8oBjXlHfy.LDzg5NavX9w6XKRdytW2cp3SQNofFVG', 'miemie@mie.com', '羊村', '123123123', '1738992447933_ts2.jpg', 1, 1, '2025-02-07 12:51:32');
INSERT INTO `users` VALUES (15, 'e05ac899-d0ed-4ea8-95e8-36b5bc791b06', '$2a$10$/K4RnPAXEY93kxEW9ixHOeqd8F2itUyvRO5Ltha.vdBYYoRH7qis6', '', '', '', '1738998227577_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:03:48');
INSERT INTO `users` VALUES (16, 'ebddbed5-aa27-4c18-ab8a-71c308b8a85b', '$2a$10$BE9i4FhLweBV2mhB5eUXwuXKNs7U1hq6m/HENtI1oE9EfHO3.e4yq', '', '', '', '1738998228846_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:03:49');
INSERT INTO `users` VALUES (17, '35a0baed-c061-4f7b-9958-484004ef8b5c', '$2a$10$x40uuhtf1d59Xqzi4hAA/.RPCHPgYnYDqlVQf96EpQJrHs3P/mGoy', '', '', '', '1738998230091_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:03:50');
INSERT INTO `users` VALUES (18, '5a9b7aef-077a-4998-a34a-24db4ed9ba20', '$2a$10$6X/S3x3EW3xRp.ivlUIuKe4ars4ZI/RIDs7yDi8WKqaQoiXDUA7yq', '', '', '', '1738998231430_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:03:52');
INSERT INTO `users` VALUES (19, '4d776414-65ee-41c3-87f2-a9670ed8afde', '$2a$10$2/Z7SmvLQRi/ijc331USMuPK2orq.y7bUYeVVHEQmoIzUkLooglc6', '', '', '', '1738998233092_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:03:53');
INSERT INTO `users` VALUES (20, 'dcc2b376-6342-499c-8fda-62b370d3e154', '$2a$10$dYq2V.BKMcVThYEXEh6lyuv5owMD9trNB7gdVznbrDtv7xCBKG45O', '', '', '', '1738998233891_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:03:54');
INSERT INTO `users` VALUES (21, '6251223e-426c-46e1-affb-291f7041efac', '$2a$10$volpC0bvhgbhtmF4gFJDL.DQJI6SQZc74P4cKxXgaajIo8OxrkicW', '', '', '', '1738998235354_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:03:55');
INSERT INTO `users` VALUES (22, 'ba73f4bc-ba70-46ca-be65-0846c6f159f0', '$2a$10$WXDXhT2DYgSXWJJUcRntdueG7Qj.YVhSQiOnDD9Kbg5WUyrczA9wO', '', '', '', '1738998236533_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:03:57');
INSERT INTO `users` VALUES (23, 'b4395dc5-df2c-4fed-b9af-a34861420f07', '$2a$10$wBjPjnSWR/4REBJHHPq6dOtZTGWHTRjbKfW.6dFGX.MUtYTnbXuoi', '', '', '', '1738998237837_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:03:58');
INSERT INTO `users` VALUES (24, '88ae2042-a872-426b-b5c5-e384ba7e5f03', '$2a$10$7bViTwopSY8FJ/S0souw2.Olf0gjuuTziQaW2eH7ITXTi9SK/thwm', '', '', '', '1738998241244_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:04:01');
INSERT INTO `users` VALUES (25, '622668e4-805f-4f20-a7d5-1dd149d4345b', '$2a$10$sCiQUo6aGQLGZHVaiXXgs.LltqWz0kFTJMgep3RQMAIR57Rz6twjS', '', '', '', '1738998242365_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:04:02');
INSERT INTO `users` VALUES (26, '347d9f51-2cee-4c16-80f6-d63f5d1f1955', '$2a$10$tzicu.xiraPPipyuY09X0OTf351IzGITYmfahu0d5.Bb5WxlDQES.', '', '', '', '1738998243330_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:04:03');
INSERT INTO `users` VALUES (27, '407d8a06-463e-44e1-9609-23b727053547', '$2a$10$VPpQvXphozKWwAEvntZfoOBqlLwI5hMPXQyy1MEtgD6PimyQSzHnO', '', '', '', '1738998244152_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:04:04');
INSERT INTO `users` VALUES (28, 'a2c2bca4-2589-40e4-bd7b-31d6c491aaa2', '$2a$10$cUkHKY3sZWfvP859z6TcW.yahDm0cPXogsNyj7962HqGgm9wNxDeu', '', '', '', '1738998261961_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:04:22');
INSERT INTO `users` VALUES (29, 'f86de0c1-ca9a-4dee-88c7-c2ad08bd28fd', '$2a$10$wA7S5JEpygNKkkhcX7WnUOArT.buvQABVXQVHuO2Rz3GpZf3xuEVe', '', '', '', '1738998293930_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:04:54');
INSERT INTO `users` VALUES (30, '1a0ef587-bba5-45e8-bbe4-3f8714db8c8d', '$2a$10$41l2f9gIdKWeHsVljTkNBeaR87Nlulk.YjjQ8apg79j9ooYuyYyRC', '', '', '', '1738998295609_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:04:56');
INSERT INTO `users` VALUES (31, 'ddc5ed00-55df-4f4a-a072-a775329e0107', '$2a$10$QdyE1woSGwSLnvR7Q4ELseTuvIvMF2CHmSVCgqO3OM0xH5aV2YFAe', '', '', '', '1738998296932_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:04:57');
INSERT INTO `users` VALUES (32, 'e54c97b6-f412-4979-8dc5-d6393e217432', '$2a$10$zhStZ4OAxCNaBlwXPNNHKOaGiYL5vQblatehk/IPFa3Qv/D2Em4X6', '', '', '', '1738998298237_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:04:58');
INSERT INTO `users` VALUES (33, 'd1b2e1d7-b967-4bf2-8988-d64f09741ead', '$2a$10$HU9nvwtUuNAkkzsGLfkYbOjNKtGFhXlpoPkfAfvGKI3fCjUTkFmyW', '', '', '', '1738998306907_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:07');
INSERT INTO `users` VALUES (34, '63082688-a60e-40ac-b3a8-0c009ded4dfd', '$2a$10$IwsO.I6z58.VV17XNfhIRum9a7NFeyMztBHVLJWtgV3QWbnifF7zq', '', '', '', '1738998313363_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:13');
INSERT INTO `users` VALUES (35, '8984b60e-e1f1-4ca4-ae02-b54616d43f7b', '$2a$10$17kcekHra8DSF3vVstgaV.2GjJxSjTelFN5hkO1ttn89YORUu94TW', '', '', '', '1738998314577_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:15');
INSERT INTO `users` VALUES (36, '97ba141f-5d74-4a66-9710-3424d880a59f', '$2a$10$qjRPtri4MAN3WUvXxc.qWeTh3OpIttclgrBWaSl1ZprMqtS826Jcm', '', '', '', '1738998315887_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:16');
INSERT INTO `users` VALUES (37, '5deba88f-c6fb-40d2-9acb-cb65b7716099', '$2a$10$MMSiNjvprmjHobyhdThX5O3K.57LH1DTROOXWRdyYavw4QUfgBhkK', '', '', '', '1738998317063_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:17');
INSERT INTO `users` VALUES (38, 'b898cc26-c2e7-45e7-8b75-a5f83a0be50a', '$2a$10$L8Ejm2GDsK6pinUgReJEDeywl6LWSn7e9Jpwz3HhTuI5cQ/1/QqJS', '', '', '', '1738998318133_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:18');
INSERT INTO `users` VALUES (39, 'bf5d1c87-f66f-4b0f-9d4c-3a15dac4a1fa', '$2a$10$zmNIx7MHvMqvwrvsFPuBSOnUYJstkLKqsB0jLYpFDdAcVLERlHxJa', '', '', '', '1738998319305_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:19');
INSERT INTO `users` VALUES (40, 'c2de43b0-4590-4056-8fb3-a89b927c9e4e', '$2a$10$2WZKPi/3iBqlUbgdsz6ZsedveUG5i5ljn14SMiUSkVGoFsHarmS1G', '', '', '', '1738998320339_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:20');
INSERT INTO `users` VALUES (41, '47a6db26-233c-467f-aa47-0babf6e75103', '$2a$10$NCDB0yg7JVQ9xDeA/QjZCOwdcV4iSqdSrGXZI8LrWh9Gucb8N07ea', '', '', '', '1738998321453_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:22');
INSERT INTO `users` VALUES (42, 'a8bd8b6b-cdad-4fd2-9b66-db215dc61075', '$2a$10$c2oO4VFnWK.wPwVptsE2dOLHM/64iNTcOAz.aIc2XQ47jySm7PNk.', '', '', '', '1738998322635_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:23');
INSERT INTO `users` VALUES (43, '41d4ff16-fc1f-41dd-9752-c91104774147', '$2a$10$mk9jkc33C3n.g3iWrg6oZeUHhLfIZlkJI0K4U3URS3P1GJXxLBA2C', '', '', '', '1738998324264_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:24');
INSERT INTO `users` VALUES (44, 'ee32faba-a999-436d-860c-7d25b7708d42', '$2a$10$qPYRkelkMiu9Bak2h/yxVeF.mTOvm/OWvKY7ABh7i.fLBHHIJhmj6', '', '', '', '1738998325401_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:26');
INSERT INTO `users` VALUES (45, '373602b3-7501-4b23-a439-416f1b5fe61c', '$2a$10$sNnp/YiMYxwjz3UoQcsAjOBZKARpYGv6hD8ohkgbgIsGONTLIV9x.', '', '', '', '1738998326502_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:27');
INSERT INTO `users` VALUES (46, '6a7be27f-7193-4847-9739-fe661d18af29', '$2a$10$OjNloksZpnlnQWsV80GS2O7VcZec1XGAXaZoYNjzFjVxLI1HLfhqu', '', '', '', '1738998327835_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:28');
INSERT INTO `users` VALUES (47, 'bbc58752-e3bc-410a-afbb-13be977ba588', '$2a$10$3TT2hcpmNwmR8kTr8xufjukYtdxhLGu1Tf2xmGgjL7D3DoRWhVMlW', '', '', '', '1738998328861_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:29');
INSERT INTO `users` VALUES (48, 'ff0f2399-902b-45b0-a249-68d7436cfbab', '$2a$10$bn0Bm7Q8xkm.u4v5NMmJH.9rFS3WIHOZ7DNv1WpRkIhkL3I1Bwafa', '', '', '', '1738998329982_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:30');
INSERT INTO `users` VALUES (49, '3dc2e96b-380e-4f60-9535-650510740cb9', '$2a$10$mah/XbScP96pbksj6lUn3.uuLrmXj9GIsL0s8ROyMsl7vV7Ed3YO.', '', '', '', '1738998331218_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:31');
INSERT INTO `users` VALUES (50, '504e20d8-854f-416b-a52e-a4ca9ffc4ad2', '$2a$10$bP6pVTfKjAojRb0mGCq20ugFDJxDQLr2AkysHL9WO2ypXSog7qIdC', '', '', '', '1738998332232_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:32');
INSERT INTO `users` VALUES (51, 'afae2f0b-2e40-4bb0-8cf6-639fe404199f', '$2a$10$A6QX6xccJAdKgaPJq1kOdOdwP9aKarohulhT9Hy0CgvVpr8HESE3S', '', '', '', '1738998333448_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:34');
INSERT INTO `users` VALUES (52, '62e5f898-374d-4fdf-a364-1800f623b39f', '$2a$10$.gW3d2RlO8fVeFmCG4on9.9e.NTNOL0V/j.DRrJGR5hvMRwOzbXey', '', '', '', '1738998335277_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:35');
INSERT INTO `users` VALUES (53, '7130522f-25cb-47aa-ac9c-c7d82688bb96', '$2a$10$/NBnjIgcBLjUyAfwwKw/LeueBBjuiFx3Nm7YBakOoad/iI9F2Vr4q', '', '', '', '1738998336624_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:37');
INSERT INTO `users` VALUES (54, '59903cd8-1fb7-4b19-b17c-101ab2c638ae', '$2a$10$rGfAi7hafRKOlbaHmQ2kautoEg8.7Ra3o.AUao1aXb9MH/2mHvYeO', '', '', '', '1738998337833_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:38');
INSERT INTO `users` VALUES (55, '1b485e44-0cce-41d8-9818-cf511c0e7a2e', '$2a$10$/F8vmOBaofamxIfaj3L8Senmx/9fFggRT/sRDuHQU2u71T8c2kLR6', '', '', '', '1738998339489_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:40');
INSERT INTO `users` VALUES (56, 'd61c1f6b-34d4-4d19-9dcd-a9f495e8a90c', '$2a$10$veC3HIJlCErDz.m/IE8QluUM/oPeCZyiAsrfbytOPHqfaRuVI.R2a', '', '', '', '1738998340681_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:41');
INSERT INTO `users` VALUES (57, '8b24fec9-50d8-46a9-82b7-85886696bada', '$2a$10$LnDP8jwhu/pk69J4dBhwf.az4tKyjQRYf2H28r9cjimKY3ZEPhI.i', '', '', '', '1738998342019_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:42');
INSERT INTO `users` VALUES (58, '35f27357-3488-4956-b26e-2e7c8d7cf810', '$2a$10$gSGZSEzDt1tCuXvCSZM9ouCf.iq03PuFEcffKRe8it8AWLoldnz7K', '', '', '', '1738998343127_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:43');
INSERT INTO `users` VALUES (59, '25231dd9-ecbb-408a-947d-88d48281359b', '$2a$10$khwbPSJjBR//fyuOVxAlKOv12euPDrZYOS67qQxh1TttcVBcfeFn6', '', '', '', '1738998344291_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:44');
INSERT INTO `users` VALUES (60, '9ea496af-9577-4486-abee-c24b99d39083', '$2a$10$ik0ROYWOm51pLufe2z06Fu6Ehl38W3mOVuIWRHh1u7BvQI5Fn.2V2', '', '', '', '1738998345380_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:46');
INSERT INTO `users` VALUES (61, '4b0d5072-2e29-4789-b3ba-4e307524f83f', '$2a$10$Nv596akPadCZB9N9h9AlwusKxCcRwgsKyGygOruD2do1yL7JsmsPe', '', '', '', '1738998346575_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:47');
INSERT INTO `users` VALUES (62, '08ac0bac-82bb-469b-ae25-e5d4c9a60c3f', '$2a$10$8RA.LkCQLaTg/5srqmv2m.orjB6.j5/Ij6SsqN3tt0AGYcNjzoFUi', '', '', '', '1738998347932_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:48');
INSERT INTO `users` VALUES (63, '4cb3501b-2e9f-432e-b294-757a325fc7e2', '$2a$10$m6sJ1XKh7cZOpWDNpceanuzP9fT587icJ5dYayDP3CtJ1wI2aPfk2', '', '', '', '1738998348930_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:49');
INSERT INTO `users` VALUES (64, '75167dc3-a0d7-4089-9e25-1fa4f4c3afa7', '$2a$10$49BTGQuFYoJRRvGybDcHVuGPrtHmDUUG.yW27jc4/1Aq23XqW9SIG', '', '', '', '1738998350092_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:50');
INSERT INTO `users` VALUES (65, 'bb70e3df-1d79-4fa1-997e-305027b60bde', '$2a$10$XB52QNm16sqf1tfpN4FBAuwNMCLaFqivd/tHChTwilmXyVK4dbPqO', '', '', '', '1738998351693_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:52');
INSERT INTO `users` VALUES (66, '7c9a9904-2196-437c-aaac-90a5c760d76c', '$2a$10$ALgE/lXdN0YEG8.gommQo.lLWzbu5ip2geAP4qK0i9vesfoc/2TsG', '', '', '', '1738998353922_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:54');
INSERT INTO `users` VALUES (67, '787c83ef-2633-48db-a777-8576fc15a223', '$2a$10$OXRHnhsFkWK7W5d4SBhUCu.VPsiTIszUVJKaA8yfcV1s74Gwj5Wve', '', '', '', '1738998355467_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:56');
INSERT INTO `users` VALUES (68, '0b76da16-f1f5-4534-be42-76b125017859', '$2a$10$v8i99S/AKJmq8QeFQ3W0t.PA32TLVTw.lOYn9877iML6H19Tkmssm', '', '', '', '1738998356557_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:57');
INSERT INTO `users` VALUES (69, '3c5198b7-34b7-4634-a04e-078ad614fa6d', '$2a$10$J/odaTaAPL0cVt.dTxosJOaJtCj35Pu185Pkb.SDE5bsJZhDv8dZ.', '', '', '', '1738998357655_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:58');
INSERT INTO `users` VALUES (70, '545c0a2b-95a3-4be0-ac72-2b656e2cccf4', '$2a$10$GMNgvHuCxl3wpPWDOV5Gq.2awtlBLnaUvKEQ3R3jAIaX8gZpwN0Q2', '', '', '', '1738998358699_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:05:59');
INSERT INTO `users` VALUES (71, 'b5d29551-7204-49e4-9bc8-76dd3886d4e0', '$2a$10$/slQo7n8XMG9QSFkHs86w.Q1gzeF9zVQYy0vw77bnA/CXHmGB/8Tq', '', '', '', '1738998359805_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:00');
INSERT INTO `users` VALUES (72, '87c37d61-ad4b-4868-ad1a-23f829cf3073', '$2a$10$Mf.3htiP4j0wLh5BXftAHuXSLOakINyYxw8PPZ7FoMMXoY3FOCd4G', '', '', '', '1738998360829_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:01');
INSERT INTO `users` VALUES (73, '4d9ea0d8-7bce-4f25-bd7d-b8fdd2ebb2ba', '$2a$10$Vc7MgdZtkzgfAzwXVr0UO.TfJhphwBojmjPDKkPn6cNk1QZNAinnu', '', '', '', '1738998362096_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:02');
INSERT INTO `users` VALUES (74, 'b52a5600-e1cd-474e-8e29-24a75b54ca66', '$2a$10$zH7ddOjjOOEJLg09JzkkkO9gX/XIA0GcK0A2pCE67hT.i3MK9OdY6', '', '', '', '1738998363116_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:03');
INSERT INTO `users` VALUES (75, 'f63daeca-7699-406a-97af-b30041299111', '$2a$10$oadlF8n1caekd7eI.hWWwe8.SFSbZxeuQOl0zmQvRIStL3ycnhLN.', '', '', '', '1738998364123_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:04');
INSERT INTO `users` VALUES (76, 'dc89ec79-4d1b-4cc5-9be8-778b40285079', '$2a$10$fu2h/UB/iXgR/MNQA.g37OlNh0WI.rwQYyJlML3EwhKRnW59Z4CmK', '', '', '', '1738998365281_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:05');
INSERT INTO `users` VALUES (77, 'f0ad1b2f-3ddb-4a96-8dc0-b3da031cb1e0', '$2a$10$8D153OeRV1LcsKTUaDWeauXM9lpZJnbbwTUWJ7QpEUQ6n4jaSL5Re', '', '', '', '1738998366619_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:07');
INSERT INTO `users` VALUES (78, 'fa1ea899-6183-416f-97b2-b573774bc957', '$2a$10$qP/6LRTbTT2ahlgZcsS0XuaDfM9bco.NzlIPsAfnGf6ilImFVkCFS', '', '', '', '1738998367560_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:08');
INSERT INTO `users` VALUES (79, 'ddc47705-dc28-477f-955d-ab6290f74569', '$2a$10$UUg/zYx1jyIzzNBao2s6yO3yjIARADIoY7xAKesxsDEGNZ4r8cIzG', '', '', '', '1738998368896_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:09');
INSERT INTO `users` VALUES (80, '0533af54-f3ab-4a73-833b-0d05ccd54cc0', '$2a$10$h/sHbnr4E6mKYyGET0o/ze4mieZYdU39g.PkH2NT/YnkHLHCAh9o6', '', '', '', '1738998370003_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:10');
INSERT INTO `users` VALUES (81, 'a63612f2-5a02-44ed-8776-c70f2c49e96a', '$2a$10$o70W6z4F7pB6mA.oWaE.oeZvKaTNX7YyJCK0EoKj8VINuZCRZRDLa', '', '', '', '1738998371163_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:11');
INSERT INTO `users` VALUES (82, '296c0e32-7e79-4c0a-a68b-a3cde71b3ea6', '$2a$10$eY/o0D625pO7tLBmb.FrKejYSAcZIgcX2T9Eovtmo8RRTHnDc1Ooa', '', '', '', '1738998372434_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:13');
INSERT INTO `users` VALUES (83, '009727bc-37d7-4ed8-807f-32c5c3092a4a', '$2a$10$ob7M.5u5RwCIlQq.G8w/QuFrNK2t8rNFyl2HXcYwBtfRMs2XvwsE6', '', '', '', '1738998373911_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:14');
INSERT INTO `users` VALUES (84, '9c587bc8-f784-471e-b99e-8bd6629e783b', '$2a$10$Bx8.G3VZrwSnIRQLjxaxZuVbCmzcYQ6at84ZEH2brau9UpM3Uko7i', '', '', '', '1738998381839_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:22');
INSERT INTO `users` VALUES (85, '4dbd75d1-ac32-4953-bbd4-098ac5d6695a', '$2a$10$KWgSV/OhbAT06TRp0KIdruNAe2DeK/N8C3bd7MkD.SWchOtehVAUO', '', '', '', '1738998383151_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:23');
INSERT INTO `users` VALUES (86, 'a70776b2-123e-46c1-a7b4-dc5ecf76df48', '$2a$10$T4qvN7YSRUjsuMwizIfoaeHlAJQoTiEAW/VEqjIQ4T7twOJJkIGdy', '', '', '', '1738998384383_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:25');
INSERT INTO `users` VALUES (87, 'f9af1b83-9cd9-4595-bd4f-a8d8fd6d99a9', '$2a$10$1r0zX0AgwSyAG0zUq/WCseHn1jNgXBXiu796CYq9BVfyKbPJx3RFO', '', '', '', '1738998385522_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:26');
INSERT INTO `users` VALUES (88, '4a20a849-39cd-4818-b596-49c74f5f4525', '$2a$10$vYjFS8UTabjrDFVnvFeF8eclFVMJSrajddrYWbLhsne9iCs4CdwnW', '', '', '', '1738998386761_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:27');
INSERT INTO `users` VALUES (89, 'c41aca42-a80b-46a5-bd83-a5063dc9141a', '$2a$10$uku5YUBLs.PWEFJBsX8RjecmD.h9K/m0Q4dFWYnKvG9WsBp/v.Aw.', '', '', '', '1738998388048_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:28');
INSERT INTO `users` VALUES (90, 'd0b311bd-a1ab-4909-b885-d6ba03833ae7', '$2a$10$O.3mebGDUxnqRx8jhFoBUe5EmKR2DzEmBqUH737xza6xja1xHuLbW', '', '', '', '1738998389335_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:29');
INSERT INTO `users` VALUES (91, 'fffac622-eeea-44b3-b570-574e76e53fe1', '$2a$10$EtgqcOdthH.wrqpEv9HQKOL6qqmQvH8RZT3d97yqyIHfXkMfuEE4S', '', '', '', '1738998390377_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:30');
INSERT INTO `users` VALUES (92, '30a25f16-fcd6-4005-9929-7b661db95191', '$2a$10$UStNAn5RMT1srPLGljOAYOAe.UBHCFp/7YP4CCALgI1SfnZGku7ii', '', '', '', '1738998391786_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:32');
INSERT INTO `users` VALUES (93, '511ba27f-15c1-4a4e-bb37-66db7d197d27', '$2a$10$ZlnMBGpBL68gWCY4OOJwGOILKN/7y6VtTPrELIYx7wKj2B9VeaJG2', '', '', '', '1738998392895_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:33');
INSERT INTO `users` VALUES (94, '06c024c2-58e9-4ff5-917d-6a80e36501be', '$2a$10$9iruKnhWxB/IcvT.aZTZ.ucW7GbMVvn7LRBnStwmnvwiZHGJc8sPu', '', '', '', '1738998394107_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:34');
INSERT INTO `users` VALUES (95, '6f5cc085-c000-4dff-a455-4bd148de0d32', '$2a$10$SuSG0J/P.rlhBdjWEyiNNOOH438qsSxgiYykZsUPpn9kXw0Opdi0.', '', '', '', '1738998395407_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:36');
INSERT INTO `users` VALUES (96, 'd508a36b-041e-46fd-b1ab-b9feba8d99b9', '$2a$10$a2J0FgRCmQZXRoDzMrF5GuWmXwqEw9kjkKdD8k4d3vP84.WjSJ/9.', '', '', '', '1738998396510_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:37');
INSERT INTO `users` VALUES (97, 'e15acf8b-0c7d-48cf-95b4-e091b5252e01', '$2a$10$OF.BcTTJBCJLnsLBR00IkuoexOdYC5JjomM/WJvM7biaa4t0boR.i', '', '', '', '1738998397770_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:38');
INSERT INTO `users` VALUES (98, '2af0c234-0861-4152-beec-1e9b806d0a8b', '$2a$10$0.xeoyFGrPkI1NI9U/AJ1enSzS/nvLSu3x9Kiw3oC.ASgEU042fd6', '', '', '', '1738998399024_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:39');
INSERT INTO `users` VALUES (99, '4f6033ab-d227-497f-b808-f1b8328bc62d', '$2a$10$Yw6695GJ18WoZCqQsYLSy..ruwT2XAwDJWrBRTu08Cw/QXhw7/3SK', '', '', '', '1738998400067_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:40');
INSERT INTO `users` VALUES (100, 'a853084f-01d7-46db-a961-217b62c5a2b4', '$2a$10$TY73H07BpSOOV4YeaIGDEuAtDkV.1b/Io1AY4/cj/0np/Klosnrpe', '', '', '', '1738998401191_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:41');
INSERT INTO `users` VALUES (101, '05243c92-fa8d-4526-be3b-2a53c2650697', '$2a$10$XLc0gScCjC.9xEnMGNRBZuFj/AsroeNF2EmSp9Rzibq9Gn9wNzVYO', '', '', '', '1738998402274_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:42');
INSERT INTO `users` VALUES (102, '71205d8f-e066-49be-8143-12aceee37b78', '$2a$10$kVcDq.PO.Jq38q4plhxwoeh9WgicyQtkPXJjwaNlRj.JeqBm9gmtS', '', '', '', '1738998403309_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:43');
INSERT INTO `users` VALUES (103, '9a9e2061-f0c2-4169-be2a-42a6829ba2f3', '$2a$10$4aETx14FuN/LBvve77mvq.WvjqCG4/nw.b8gUx32Tt/iTS2ItGJpW', '', '', '', '1738998404388_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:44');
INSERT INTO `users` VALUES (104, '96ac1898-2a0f-4dd6-9f77-4d9e03f65ba9', '$2a$10$lJxKPG05cn7COBHHQ5atYOOHDJLd1B4RXULPP5VFBs67jYZRwmPya', '', '', '', '1738998405488_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:46');
INSERT INTO `users` VALUES (105, '090c1a22-33d6-43d1-9bb7-faf7c430645a', '$2a$10$S7G6om5sXMitLMP7JQojD.R0l/p6KTtXcb7H3m7JxY8Bf8l9iDEpe', '', '', '', '1738998406483_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:47');
INSERT INTO `users` VALUES (106, 'd08c02d9-2287-463c-8493-d12ef334f48f', '$2a$10$qGcMEBLuJPBYPdfD.0hVJ.65BOUGt0jqq19y6GSxQKoRzXj1U8Hqa', '', '', '', '1738998412281_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:52');
INSERT INTO `users` VALUES (107, '3ba4b443-5bd1-46fe-8ed5-d9f2f3b5e28c', '$2a$10$u04H7u/jFP04iNm2ynIuSeL2wfuNoaiD9tZ5UpEf6TsPdRnJFEqKe', '', '', '', '1738998413620_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:54');
INSERT INTO `users` VALUES (108, 'a3f23c4c-5b95-44a9-81e3-6c6f48b3f66b', '$2a$10$FF93OeGix44triUQ/9o5FuT3OwrrsFwUl0fSVbEqr2eePCsAbGqYW', '', '', '', '1738998415088_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:55');
INSERT INTO `users` VALUES (109, '568841fe-55f0-48a5-afde-b22f48af6ddd', '$2a$10$JvMqwkK7Oki8P3u9EB2d3..XmN5LchT48hdovKhc5qsZIM/dUgObW', '', '', '', '1738998416716_photo_2024-03-27_13-20-37.jpg', 0, 0, '2025-02-08 15:06:57');

SET FOREIGN_KEY_CHECKS = 1;
