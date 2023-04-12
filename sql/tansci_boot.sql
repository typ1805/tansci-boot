/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : tansci_boot

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 12/04/2023 16:23:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dic
-- ----------------------------
DROP TABLE IF EXISTS `sys_dic`;
CREATE TABLE `sys_dic`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `parent_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '父ID',
  `group_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组名称',
  `type` int(1) NULL DEFAULT NULL COMMENT '类型：0、系统，1、业务',
  `dic_value` int(11) NOT NULL COMMENT '值',
  `dic_label` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `sort` int(10) NULL DEFAULT NULL COMMENT '排序',
  `text1` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预留字段1',
  `text2` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预留字段2',
  `text3` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预留字段3',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `group_name`(`group_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dic
-- ----------------------------

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录账号',
  `fail_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '失败密码',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录类型（成功、失败）',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '浏览器',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作系统',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地理位置',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'token',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '父id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单链接',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  `chinese_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '中文名称',
  `english_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '英文名称',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限',
  `sort` int(12) NULL DEFAULT NULL COMMENT '排序',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件名称',
  `open_mode` int(1) NULL DEFAULT 0 COMMENT '打开方式：0、默认，1、iframe，2、新标签页',
  `is_del` int(1) NULL DEFAULT 0 COMMENT '是否删除：0、未删除，1、已删除',
  `keep_alive` int(1) NULL DEFAULT NULL COMMENT '是否缓存：0、不缓存，1、缓存',
  `is_show` int(1) NULL DEFAULT NULL COMMENT '是否显示：1显示，0不显示',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('5df7c65d51129baefee123ef3bc2d7de', 'ea83fb03d2117cb287973d6889984686', 'magicapi', 'https://www.ssssssss.org/magic-api/pages/quick/single/', 'Clock', '框架', 'magicapi', NULL, 2, '', 1, 0, 0, 1, '2023-04-11 11:25:08', '2023-04-11 11:25:08', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a002', '0', 'system', '/system', 'Tools', '系统管理', 'System', NULL, 1, NULL, 0, 0, 0, 1, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a003', 'b1851d1b13594e71840103c11a37a002', 'menu', '/system/Menu', 'Grid', '菜单管理', 'Menu', NULL, 2, NULL, 0, 0, 0, 1, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a004', 'b1851d1b13594e71840103c11a37a002', 'org', '/system/Org', 'QuestionFilled', '组织管理', 'Org', NULL, 3, NULL, 0, 0, 0, 1, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a005', 'b1851d1b13594e71840103c11a37a002', 'role', '/system/Role', 'Grid', '权限管理', 'Role', NULL, 4, NULL, 0, 0, 0, 1, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a006', 'b1851d1b13594e71840103c11a37a002', 'user', '/system/User', 'Grid', '用户管理', 'User', NULL, 5, NULL, 0, 0, 0, 1, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a007', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '保存', 'save', 'menu:save', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a008', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '删除', 'delete', 'menu:delete', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a009', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '修改', 'update', 'menu:update', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a010', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '详情', 'view', 'menu:view', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a011', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '列表', 'list', 'menu:list', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('ea83fb03d2117cb287973d6889984686', '0', 'demo', '/demo', 'ChromeFilled', '菜单实例', 'Demo', NULL, 2, '', 0, 0, 1, 1, '2023-04-11 11:10:46', '2023-04-11 11:10:46', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0666', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '列表', 'list', 'role:list', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0667', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '添加', 'save', 'role:save', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0668', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '修改', 'update', 'role:update', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0669', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '删除', 'delete', 'role:delete', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0670', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '菜单权限', 'menu', 'role:menu', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0671', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '数据权限', 'data', 'role:data', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0675', 'ea83fb03d2117cb287973d6889984686', 'Iframe', 'https://www.bing.com/?mkt=zh-CN', 'Bicycle', '必应', 'Iframe', NULL, 1, '', 1, 0, 0, 1, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `module` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '功能模块',
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作方法',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `req_param` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `res_param` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '响应参数',
  `take_up_time` int(64) NULL DEFAULT NULL COMMENT '耗时',
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户id',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户名称',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态：0、成功，1、失败',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求url',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求IP',
  `unusual` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '异常信息',
  `version` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '版本号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键id',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  `sort` int(10) NULL DEFAULT NULL COMMENT '排序',
  `is_del` int(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '删除状态：0、正常，1、删除',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '组织' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES ('534a37c366ec47878a6b0c85703d0bc4', '0', '总公司', 'SO00001', 0, 0, '2023-03-29 08:53:41', '2023-03-29 08:53:43', NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色编码',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '0：全部，1：自定义，2：本级级子级，3：本级',
  `sort` int(1) NULL DEFAULT NULL COMMENT '排序',
  `is_del` int(1) NULL DEFAULT 0 COMMENT '是否删除：0未删除，1已删除',
  `creator` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('441b6dae329b3a20ad8b4f4ca8f83a0b', '普通用户', '1020cb789f', '2', 0, 0, '534a37c366ec47878a6b0c85703d0bc2', '2023-04-12 14:29:16', '2023-04-12 14:29:16', '');
INSERT INTO `sys_role` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '管理员', 'SR000001', '0', 0, 0, NULL, '2023-04-12 14:27:40', '2023-03-29 08:51:39', '管理员');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色id',
  `menu_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a002');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a003');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a004');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a005');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a006');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a007');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a008');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a009');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a011');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0666');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0667');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0668');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0669');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0670');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0671');

-- ----------------------------
-- Table structure for sys_role_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_org`;
CREATE TABLE `sys_role_org`  (
  `org_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '组织机构id',
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色id',
  PRIMARY KEY (`org_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户组织机构关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_org
-- ----------------------------
INSERT INTO `sys_role_org` VALUES ('534a37c366ec47878a6b0c85703d0bc4', '534a37c366ec47878a6b0c85703d0bc3');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登录名',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名/昵称',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `type` int(1) NULL DEFAULT NULL COMMENT '用户类型：1、管理员，2、普通用户',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` int(1) NULL DEFAULT NULL COMMENT '性别：0、男，1、女',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `is_login` int(1) NULL DEFAULT 0 COMMENT '禁止登录：0未禁用，1已禁用',
  `is_del` int(1) NULL DEFAULT 0 COMMENT '删除标识：0未删除，1已删除',
  `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '唯一标识',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证号码',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`, `username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('534a37c366ec47878a6b0c85703d0bc2', 'admin', '管理员', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, NULL, NULL, 0, '2023-03-29', NULL, 0, '', '', '', '', NULL, '2023-03-29 08:49:24', '2023-03-29 08:49:27', NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id',
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('534a37c366ec47878a6b0c85703d0bc2', '534a37c366ec47878a6b0c85703d0bc3');

SET FOREIGN_KEY_CHECKS = 1;
