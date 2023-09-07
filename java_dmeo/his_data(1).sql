/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : his_data

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 26/07/2023 17:39:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '科室id',
  `dept_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '科室名称',
  `dept_category_id` tinyint NOT NULL COMMENT '科室分类id',
  `delete_mark` tinyint NOT NULL DEFAULT 1 COMMENT '删除标记 0未删除 1删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`dept_category_id` ASC) USING BTREE,
  CONSTRAINT `category_id` FOREIGN KEY (`dept_category_id`) REFERENCES `dept_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 144 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '普内科', 1, 0, '2023-07-18 21:40:17');
INSERT INTO `department` VALUES (2, '心血管内科', 1, 0, '2023-07-18 21:41:26');
INSERT INTO `department` VALUES (3, '肾内科', 1, 0, '2023-07-18 21:42:26');
INSERT INTO `department` VALUES (4, '普外科', 2, 0, '2023-07-18 21:43:15');
INSERT INTO `department` VALUES (5, '心外科', 2, 0, '2023-07-18 21:43:47');
INSERT INTO `department` VALUES (6, '烧伤科', 2, 0, '2023-07-18 21:44:12');
INSERT INTO `department` VALUES (7, '口腔科', 3, 0, '2023-07-18 21:45:02');
INSERT INTO `department` VALUES (8, '牙周科', 3, 0, '2023-07-18 21:46:00');
INSERT INTO `department` VALUES (9, '口腔正畸科', 3, 0, '2023-07-18 21:46:58');

-- ----------------------------
-- Table structure for dept_category
-- ----------------------------
DROP TABLE IF EXISTS `dept_category`;
CREATE TABLE `dept_category`  (
  `id` tinyint NOT NULL AUTO_INCREMENT COMMENT '科室分类id',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '科室分类名字',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dept_category
-- ----------------------------
INSERT INTO `dept_category` VALUES (1, '内科', '2023-07-18 21:28:38');
INSERT INTO `dept_category` VALUES (2, '外科', '2023-07-18 21:29:27');
INSERT INTO `dept_category` VALUES (3, '口腔科', '2023-07-18 21:31:15');

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '医生id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医生姓名',
  `dept_id` int NOT NULL COMMENT '科室id',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '职称',
  `sys_user_id` int NULL DEFAULT NULL COMMENT '拥有账号id',
  `fee` decimal(10, 2) NOT NULL COMMENT '诊断费用',
  `telephone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话号码',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dept_id`(`dept_id` ASC) USING BTREE,
  INDEX `sys_u_id`(`sys_user_id` ASC) USING BTREE,
  CONSTRAINT `dept_id` FOREIGN KEY (`dept_id`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sys_u_id` FOREIGN KEY (`sys_user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1007 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES (1001, '刘飒', 1, '主任医生', 3, 15.00, '18736648890', '2023-07-19 19:29:04');
INSERT INTO `doctor` VALUES (1002, '柯宇', 5, '医师', 4, 10.00, '18233775639', '2023-07-19 19:29:47');
INSERT INTO `doctor` VALUES (1003, '欧克', 9, '主治医生', 5, 12.00, '15278467654', '2023-07-19 19:30:34');
INSERT INTO `doctor` VALUES (1004, '扁鹊', 2, '主任医生', 6, 1.00, '16538740954', '2023-07-25 10:11:01');
INSERT INTO `doctor` VALUES (1005, '华佗', 4, '主任医生', 7, 1.00, '17428475621', '2023-07-25 10:12:04');
INSERT INTO `doctor` VALUES (1006, '李时珍', 8, '主任医生', 8, 1.00, '15638756473', '2023-07-25 10:13:03');

-- ----------------------------
-- Table structure for medical_record
-- ----------------------------
DROP TABLE IF EXISTS `medical_record`;
CREATE TABLE `medical_record`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '病历号',
  `doctor_id` int NOT NULL COMMENT '医生id',
  `patient_id` int NOT NULL COMMENT '病人id',
  `medical_history` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '既往史',
  `now_medical_history` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '现在史',
  `chief_complaint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '主诉',
  `patient_check` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '检查',
  `diagnosis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '诊断',
  `remedy` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '治疗',
  `orders` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '医嘱',
  `status` int NOT NULL DEFAULT 4 COMMENT '状态 0未诊 1确诊 2诊毕 4失效',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `d_id`(`doctor_id` ASC) USING BTREE,
  INDEX `p_id`(`patient_id` ASC) USING BTREE,
  CONSTRAINT `d_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `p_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10018 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of medical_record
-- ----------------------------
INSERT INTO `medical_record` VALUES (10015, 1001, 10002, NULL, NULL, '我去额为', NULL, NULL, NULL, NULL, 2, '2023-07-26 15:37:16');
INSERT INTO `medical_record` VALUES (10016, 1005, 10001, NULL, NULL, '腰酸背痛', NULL, NULL, NULL, NULL, 1, '2023-07-26 16:23:48');
INSERT INTO `medical_record` VALUES (10017, 1005, 10002, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4, '2023-07-26 16:24:20');

-- ----------------------------
-- Table structure for patient
-- ----------------------------
DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '患者id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份证',
  `year` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '年龄',
  `sex` int NOT NULL COMMENT '性别 0男 1女 2无',
  `telephone` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话号码',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_card_unique`(`id_card` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10007 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of patient
-- ----------------------------
INSERT INTO `patient` VALUES (10001, '何伟聪', '522601xxxxxxxx0001', '41岁', 0, '16733876453', '2023-07-19 19:33:54');
INSERT INTO `patient` VALUES (10002, '龙泉', '522601xxxxxxxx0002', '1岁', 0, '16733853453', '2023-07-24 09:59:53');
INSERT INTO `patient` VALUES (10003, '胡咯', '522601xxxxxxxx0003', '3岁', 1, '18909853545', '2023-07-25 10:04:03');
INSERT INTO `patient` VALUES (10005, '李鹿', '522601xxxxxxxx0004', '39岁', 0, '18537654726', '2023-07-25 10:07:29');
INSERT INTO `patient` VALUES (10006, '朱莉', '522601xxxxxxxx0005', '19岁', 1, '16374424753', '2023-07-25 10:08:32');

-- ----------------------------
-- Table structure for registered
-- ----------------------------
DROP TABLE IF EXISTS `registered`;
CREATE TABLE `registered`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '挂号id',
  `patient_id` int NOT NULL COMMENT '病人id',
  `registrar_id` int NOT NULL COMMENT '收费员id',
  `department` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '科室',
  `doctor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '医生姓名',
  `status` int NOT NULL DEFAULT 1 COMMENT '状态 0缴费 1缴费 2逾期作废',
  `book_time` datetime NOT NULL COMMENT '预约时间',
  `money` decimal(10, 2) NOT NULL COMMENT '费用',
  `medical_id` int UNSIGNED NULL DEFAULT NULL COMMENT '病历id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `r_id`(`registrar_id` ASC) USING BTREE,
  INDEX `pt_id`(`patient_id` ASC) USING BTREE,
  INDEX `me_id`(`medical_id` ASC) USING BTREE,
  CONSTRAINT `me_id` FOREIGN KEY (`medical_id`) REFERENCES `medical_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pt_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `r_id` FOREIGN KEY (`registrar_id`) REFERENCES `registrar` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10018 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registered
-- ----------------------------
INSERT INTO `registered` VALUES (10015, 10002, 1001, '内科', '刘飒', 0, '2023-07-27 17:36:00', 15.00, 10015, '2023-07-26 15:37:16');
INSERT INTO `registered` VALUES (10016, 10001, 1001, '外科', '华佗', 0, '2023-07-30 16:24:00', 1.00, 10016, '2023-07-26 16:23:48');
INSERT INTO `registered` VALUES (10017, 10002, 1001, '外科', '华佗', 1, '2023-07-29 16:28:00', 1.00, 10017, '2023-07-26 16:24:20');

-- ----------------------------
-- Table structure for registrar
-- ----------------------------
DROP TABLE IF EXISTS `registrar`;
CREATE TABLE `registrar`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '收费id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名字',
  `sys_user_id` int NULL DEFAULT NULL COMMENT '拥有账号id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`sys_user_id` ASC) USING BTREE,
  CONSTRAINT `user_id` FOREIGN KEY (`sys_user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1002 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registrar
-- ----------------------------
INSERT INTO `registrar` VALUES (1001, '浩然', 2, '2023-07-19 19:34:21');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `type` int NOT NULL COMMENT '区分类别 0医生 1收费员',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_unique`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '123456', 0, '2023-07-19 19:35:07');
INSERT INTO `sys_user` VALUES (2, '挂号员1', '123456', 1, '2023-07-19 19:40:19');
INSERT INTO `sys_user` VALUES (3, '刘飒', '123456', 0, '2023-07-25 11:18:59');
INSERT INTO `sys_user` VALUES (4, '柯宇', '123456', 0, '2023-07-25 11:19:21');
INSERT INTO `sys_user` VALUES (5, '欧克', '123456', 0, '2023-07-25 11:19:40');
INSERT INTO `sys_user` VALUES (6, '扁鹊', '123456', 0, '2023-07-25 11:19:55');
INSERT INTO `sys_user` VALUES (7, '华佗', '123456', 0, '2023-07-25 11:20:11');
INSERT INTO `sys_user` VALUES (8, '李时珍', '123456', 0, '2023-07-25 11:20:27');

-- ----------------------------
-- View structure for doctor_user_view
-- ----------------------------
DROP VIEW IF EXISTS `doctor_user_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `doctor_user_view` AS select `sys_user`.`id` AS `id`,`doctor`.`id` AS `doctor_id`,`doctor`.`name` AS `name`,`doctor`.`dept_id` AS `dept_id`,`doctor`.`title` AS `title`,`sys_user`.`username` AS `username`,`sys_user`.`password` AS `password`,`sys_user`.`type` AS `type` from (`doctor` join `sys_user` on((`doctor`.`sys_user_id` = `sys_user`.`id`)));

-- ----------------------------
-- View structure for medical_record_view
-- ----------------------------
DROP VIEW IF EXISTS `medical_record_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `medical_record_view` AS select `medical_record`.`id` AS `id`,`patient`.`name` AS `patient_name`,`patient`.`year` AS `year`,`patient`.`id_card` AS `id_card`,`patient`.`sex` AS `sex`,`doctor`.`id` AS `doctor_id`,`doctor`.`name` AS `doctor_name`,`medical_record`.`medical_history` AS `medical_history`,`medical_record`.`now_medical_history` AS `now_medical_history`,`medical_record`.`chief_complaint` AS `chief_complaint`,`medical_record`.`patient_check` AS `patient_check`,`medical_record`.`diagnosis` AS `diagnosis`,`medical_record`.`remedy` AS `remedy`,`medical_record`.`orders` AS `orders`,`medical_record`.`status` AS `status`,`doctor`.`dept_id` AS `dept_id`,`department`.`dept_name` AS `dept_name`,`medical_record`.`create_time` AS `create_time` from (((`medical_record` join `doctor` on((`medical_record`.`doctor_id` = `doctor`.`id`))) join `patient` on((`medical_record`.`patient_id` = `patient`.`id`))) join `department` on((`doctor`.`dept_id` = `department`.`id`)));

-- ----------------------------
-- View structure for registered_view
-- ----------------------------
DROP VIEW IF EXISTS `registered_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `registered_view` AS select `registered`.`id` AS `id`,`patient`.`name` AS `patient_name`,`patient`.`year` AS `year`,`patient`.`sex` AS `sex`,`registrar`.`name` AS `registrar_name`,`registered`.`department` AS `department`,`registered`.`doctor` AS `doctor`,`registered`.`medical_id` AS `medical_id`,`registered`.`book_time` AS `book_time`,`registered`.`status` AS `status`,`registered`.`money` AS `money`,`registered`.`create_time` AS `create_time` from ((`registered` join `patient` on((`registered`.`patient_id` = `patient`.`id`))) join `registrar` on((`registered`.`registrar_id` = `registrar`.`id`)));

-- ----------------------------
-- View structure for registrar_user_view
-- ----------------------------
DROP VIEW IF EXISTS `registrar_user_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `registrar_user_view` AS select `sys_user`.`id` AS `id`,`registrar`.`id` AS `registrar_id`,`registrar`.`name` AS `name`,`sys_user`.`username` AS `username`,`sys_user`.`password` AS `password`,`sys_user`.`type` AS `type` from (`registrar` join `sys_user` on((`registrar`.`sys_user_id` = `sys_user`.`id`)));

SET FOREIGN_KEY_CHECKS = 1;
