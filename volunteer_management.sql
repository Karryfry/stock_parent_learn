/*
 Navicat MySQL Data Transfer

 Source Server         : mysql01
 Source Server Type    : MySQL
 Source Server Version : 50740
 Source Host           : localhost:3306
 Source Schema         : volunteer_management

 Target Server Type    : MySQL
 Target Server Version : 50740
 File Encoding         : 65001

 Date: 05/03/2025 16:50:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activities
-- ----------------------------
DROP TABLE IF EXISTS `activities`;
CREATE TABLE `activities`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` datetime(0) NOT NULL,
  `end_time` datetime(0) NOT NULL,
  `location` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `organizer` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activities
-- ----------------------------
INSERT INTO `activities` VALUES (1, '社区清洁活动', '2023-10-15 09:00:00', '2023-10-15 12:00:00', '社区公园', '帮助清理社区公园的垃圾。', '社区服务中心');
INSERT INTO `activities` VALUES (2, '敬老院慰问活动', '2023-10-20 14:00:00', '2023-10-20 17:00:00', '阳光敬老院', '为敬老院的老人表演节目并陪伴聊天。', '志愿者协会');
INSERT INTO `activities` VALUES (3, '校园植树活动', '2023-10-25 10:00:00', '2023-10-25 12:00:00', '学校操场', '在校园内种植树木，美化环境。', '学校后勤部');

-- ----------------------------
-- Table structure for participations
-- ----------------------------
DROP TABLE IF EXISTS `participations`;
CREATE TABLE `participations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `volunteer_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  `participation_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `service_hours` decimal(5, 2) NOT NULL,
  `status` enum('已报名','已参加','已取消') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '已报名',
  `feedback` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `volunteer_id`(`volunteer_id`) USING BTREE,
  INDEX `activity_id`(`activity_id`) USING BTREE,
  CONSTRAINT `participations_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `participations_ibfk_2` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of participations
-- ----------------------------
INSERT INTO `participations` VALUES (1, 1, 1, '2023-10-15 08:50:00', 3.00, '已参加', '活动很有意义，希望下次还能参加。');
INSERT INTO `participations` VALUES (2, 2, 2, '2023-10-20 13:50:00', 3.00, '已报名', NULL);
INSERT INTO `participations` VALUES (3, 3, 3, '2023-10-25 09:50:00', 2.00, '已取消', NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` enum('admin','user') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'user',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', 'admin');
INSERT INTO `users` VALUES (2, 'user1', 'user123', 'user');
INSERT INTO `users` VALUES (3, 'user2', 'user123', 'user');
INSERT INTO `users` VALUES (4, 'user3', 'user123', 'user');
INSERT INTO `users` VALUES (5, 'user4', 'user123', 'user');

-- ----------------------------
-- Table structure for volunteers
-- ----------------------------
DROP TABLE IF EXISTS `volunteers`;
CREATE TABLE `volunteers`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `student_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gender` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `age` tinyint(4) NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `student_id`(`student_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `volunteers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of volunteers
-- ----------------------------
INSERT INTO `volunteers` VALUES (1, 2, '张三', '2021001', '13800138001', '男', 20, 'zhangsan@example.com', '北京市海淀区');
INSERT INTO `volunteers` VALUES (2, 3, '李四', '2021002', '13800138002', '女', 21, 'lisi@example.com', '上海市浦东新区');
INSERT INTO `volunteers` VALUES (3, 4, '王五', '2021003', '13800138003', '男', 22, 'wangwu@example.com', '广州市天河区');
INSERT INTO `volunteers` VALUES (4, 5, '李永松', '2021004', '13800138004', '男', 23, '', '武汉市东西湖区');

SET FOREIGN_KEY_CHECKS = 1;
