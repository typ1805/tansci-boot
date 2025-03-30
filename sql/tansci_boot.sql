/*
 Navicat Premium Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : tansci_boot

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 30/03/2025 23:23:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for act_app_appdef
-- ----------------------------
DROP TABLE IF EXISTS `act_app_appdef`;
CREATE TABLE `act_app_appdef`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `REV_` int NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `VERSION_` int NOT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_APP_DEF_UNIQ`(`KEY_` ASC, `VERSION_` ASC, `TENANT_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_APP_DEF_DPLY`(`DEPLOYMENT_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_APP_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_app_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_app_appdef
-- ----------------------------

-- ----------------------------
-- Table structure for act_app_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_app_databasechangelog`;
CREATE TABLE `act_app_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_app_databasechangelog
-- ----------------------------
INSERT INTO `act_app_databasechangelog` VALUES ('1', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2025-03-25 21:15:35', 1, 'EXECUTED', '8:496fc778bdf2ab13f2e1926d0e63e0a2', 'createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...', '', NULL, '4.9.1', NULL, NULL, '2908534544');
INSERT INTO `act_app_databasechangelog` VALUES ('2', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2025-03-25 21:15:35', 2, 'EXECUTED', '8:ccea9ebfb6c1f8367ca4dd473fcbb7db', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_APP_DEPLOYMENT', '', NULL, '4.9.1', NULL, NULL, '2908534544');
INSERT INTO `act_app_databasechangelog` VALUES ('3', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2025-03-25 21:15:35', 3, 'EXECUTED', '8:f1f8aff320aade831944ebad24355f3d', 'createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF', '', NULL, '4.9.1', NULL, NULL, '2908534544');

-- ----------------------------
-- Table structure for act_app_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_app_databasechangeloglock`;
CREATE TABLE `act_app_databasechangeloglock`  (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_app_databasechangeloglock
-- ----------------------------
INSERT INTO `act_app_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_app_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_app_deployment`;
CREATE TABLE `act_app_deployment`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_app_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for act_app_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_app_deployment_resource`;
CREATE TABLE `act_app_deployment_resource`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_BYTES_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_APP_RSRC_DPL`(`DEPLOYMENT_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_APP_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_app_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_app_deployment_resource
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_casedef
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_casedef`;
CREATE TABLE `act_cmmn_casedef`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `REV_` int NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `VERSION_` int NOT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` bit(1) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `DGRM_RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `HAS_START_FORM_KEY_` bit(1) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_CASE_DEF_UNIQ`(`KEY_` ASC, `VERSION_` ASC, `TENANT_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_CASE_DEF_DPLY`(`DEPLOYMENT_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_CASE_DEF_DPLY` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_cmmn_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_casedef
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_databasechangelog`;
CREATE TABLE `act_cmmn_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_databasechangelog
-- ----------------------------
INSERT INTO `act_cmmn_databasechangelog` VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:26', 1, 'EXECUTED', '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:26', 2, 'EXECUTED', '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:27', 3, 'EXECUTED', '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:27', 4, 'EXECUTED', '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('5', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:31', 5, 'EXECUTED', '8:70349de472f87368dcdec971a10311a0', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_CMMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_CASE_INST; modifyDataType columnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; modifyDataType columnName=T...', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:31', 6, 'EXECUTED', '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:31', 7, 'EXECUTED', '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:31', 8, 'EXECUTED', '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:32', 9, 'EXECUTED', '8:4cb4782b9bdec5ced2a64c525aa7b3a0', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:32', 10, 'EXECUTED', '8:341c16be247f5d17badc9809da8691f9', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:32', 11, 'EXECUTED', '8:d7c4da9276bcfffbfb0ebfb25e3f7b05', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:33', 12, 'EXECUTED', '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:33', 13, 'EXECUTED', '8:7550626f964ab5518464709408333ec1', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('14', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:33', 14, 'EXECUTED', '8:086b40b3a05596dcc8a8d7479922d494', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('16', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:33', 15, 'EXECUTED', '8:a697a222ddd99dd15b36516a252f1c63', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');
INSERT INTO `act_cmmn_databasechangelog` VALUES ('17', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2025-03-25 21:15:34', 16, 'EXECUTED', '8:d3706c5813a9b97fd2a59d12a9523946', 'createIndex indexName=ACT_IDX_HI_CASE_INST_END, tableName=ACT_CMMN_HI_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '2908523183');

-- ----------------------------
-- Table structure for act_cmmn_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_databasechangeloglock`;
CREATE TABLE `act_cmmn_databasechangeloglock`  (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_databasechangeloglock
-- ----------------------------
INSERT INTO `act_cmmn_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_cmmn_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_deployment`;
CREATE TABLE `act_cmmn_deployment`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_deployment_resource`;
CREATE TABLE `act_cmmn_deployment_resource`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_BYTES_` longblob NULL,
  `GENERATED_` bit(1) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_CMMN_RSRC_DPL`(`DEPLOYMENT_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_CMMN_RSRC_DPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_cmmn_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_deployment_resource
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_hi_case_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_case_inst`;
CREATE TABLE `act_cmmn_hi_case_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `REV_` int NOT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PARENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `STATE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NULL DEFAULT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LAST_REACTIVATION_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_REACTIVATION_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_CASE_INST_END`(`END_TIME_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_hi_case_inst
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_hi_mil_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_mil_inst`;
CREATE TABLE `act_cmmn_hi_mil_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `REV_` int NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `TIME_STAMP_` datetime(3) NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_hi_mil_inst
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_hi_plan_item_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_hi_plan_item_inst`;
CREATE TABLE `act_cmmn_hi_plan_item_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `REV_` int NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `STATE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `IS_STAGE_` bit(1) NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ITEM_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ITEM_DEFINITION_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_AVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_ENABLED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_DISABLED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_STARTED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_SUSPENDED_TIME_` datetime(3) NULL DEFAULT NULL,
  `COMPLETED_TIME_` datetime(3) NULL DEFAULT NULL,
  `OCCURRED_TIME_` datetime(3) NULL DEFAULT NULL,
  `TERMINATED_TIME_` datetime(3) NULL DEFAULT NULL,
  `EXIT_TIME_` datetime(3) NULL DEFAULT NULL,
  `ENDED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `ENTRY_CRITERION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EXIT_CRITERION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SHOW_IN_OVERVIEW_` bit(1) NULL DEFAULT NULL,
  `EXTRA_VALUE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DERIVED_CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LAST_UNAVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_hi_plan_item_inst
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_ru_case_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_case_inst`;
CREATE TABLE `act_cmmn_ru_case_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `REV_` int NOT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PARENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `STATE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `LOCK_TIME_` datetime(3) NULL DEFAULT NULL,
  `IS_COMPLETEABLE_` bit(1) NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LAST_REACTIVATION_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_REACTIVATION_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_CASE_INST_CASE_DEF`(`CASE_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_CASE_INST_PARENT`(`PARENT_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_CASE_INST_REF_ID_`(`REFERENCE_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_CASE_INST_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_ru_case_inst
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_ru_mil_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_mil_inst`;
CREATE TABLE `act_cmmn_ru_mil_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `TIME_STAMP_` datetime(3) NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_MIL_CASE_DEF`(`CASE_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_MIL_CASE_INST`(`CASE_INST_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_MIL_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_MIL_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_ru_mil_inst
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_ru_plan_item_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_plan_item_inst`;
CREATE TABLE `act_cmmn_ru_plan_item_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `REV_` int NOT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `IS_STAGE_` bit(1) NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `STATE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `ITEM_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ITEM_DEFINITION_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `IS_COMPLETEABLE_` bit(1) NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` bit(1) NULL DEFAULT NULL,
  `VAR_COUNT_` int NULL DEFAULT NULL,
  `SENTRY_PART_INST_COUNT_` int NULL DEFAULT NULL,
  `LAST_AVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_ENABLED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_DISABLED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_STARTED_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_SUSPENDED_TIME_` datetime(3) NULL DEFAULT NULL,
  `COMPLETED_TIME_` datetime(3) NULL DEFAULT NULL,
  `OCCURRED_TIME_` datetime(3) NULL DEFAULT NULL,
  `TERMINATED_TIME_` datetime(3) NULL DEFAULT NULL,
  `EXIT_TIME_` datetime(3) NULL DEFAULT NULL,
  `ENDED_TIME_` datetime(3) NULL DEFAULT NULL,
  `ENTRY_CRITERION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EXIT_CRITERION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EXTRA_VALUE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DERIVED_CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LAST_UNAVAILABLE_TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_PLAN_ITEM_CASE_DEF`(`CASE_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_PLAN_ITEM_CASE_INST`(`CASE_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_PLAN_ITEM_STAGE_INST`(`STAGE_INST_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_PLAN_ITEM_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_ru_plan_item_inst
-- ----------------------------

-- ----------------------------
-- Table structure for act_cmmn_ru_sentry_part_inst
-- ----------------------------
DROP TABLE IF EXISTS `act_cmmn_ru_sentry_part_inst`;
CREATE TABLE `act_cmmn_ru_sentry_part_inst`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `REV_` int NOT NULL,
  `CASE_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CASE_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PLAN_ITEM_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ON_PART_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `IF_PART_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TIME_STAMP_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_SENTRY_CASE_DEF`(`CASE_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_SENTRY_CASE_INST`(`CASE_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_SENTRY_PLAN_ITEM`(`PLAN_ITEM_INST_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_SENTRY_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_cmmn_casedef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SENTRY_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_cmmn_ru_case_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SENTRY_PLAN_ITEM` FOREIGN KEY (`PLAN_ITEM_INST_ID_`) REFERENCES `act_cmmn_ru_plan_item_inst` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_cmmn_ru_sentry_part_inst
-- ----------------------------

-- ----------------------------
-- Table structure for act_co_content_item
-- ----------------------------
DROP TABLE IF EXISTS `act_co_content_item`;
CREATE TABLE `act_co_content_item`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MIME_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TASK_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTENT_STORE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTENT_STORE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `FIELD_` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTENT_AVAILABLE_` bit(1) NULL DEFAULT b'0',
  `CREATED_` timestamp(6) NULL DEFAULT NULL,
  `CREATED_BY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LAST_MODIFIED_` timestamp(6) NULL DEFAULT NULL,
  `LAST_MODIFIED_BY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTENT_SIZE_` bigint NULL DEFAULT 0,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `idx_contitem_taskid`(`TASK_ID_` ASC) USING BTREE,
  INDEX `idx_contitem_procid`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `idx_contitem_scope`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_co_content_item
-- ----------------------------

-- ----------------------------
-- Table structure for act_co_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_co_databasechangelog`;
CREATE TABLE `act_co_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_co_databasechangelog
-- ----------------------------
INSERT INTO `act_co_databasechangelog` VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2025-03-25 21:15:22', 1, 'EXECUTED', '8:7644d7165cfe799200a2abdd3419e8b6', 'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.9.1', NULL, NULL, '2908522090');
INSERT INTO `act_co_databasechangelog` VALUES ('2', 'flowable', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2025-03-25 21:15:22', 2, 'EXECUTED', '8:fe7b11ac7dbbf9c43006b23bbab60bab', 'addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.9.1', NULL, NULL, '2908522090');

-- ----------------------------
-- Table structure for act_co_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_co_databasechangeloglock`;
CREATE TABLE `act_co_databasechangeloglock`  (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_co_databasechangeloglock
-- ----------------------------
INSERT INTO `act_co_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_dmn_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_databasechangelog`;
CREATE TABLE `act_dmn_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_databasechangelog
-- ----------------------------
INSERT INTO `act_dmn_databasechangelog` VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2025-03-25 21:15:18', 1, 'EXECUTED', '8:c8701f1c71018b55029f450b2e9a10a1', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '2908518521');
INSERT INTO `act_dmn_databasechangelog` VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2025-03-25 21:15:18', 2, 'EXECUTED', '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '2908518521');
INSERT INTO `act_dmn_databasechangelog` VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2025-03-25 21:15:19', 3, 'EXECUTED', '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '2908518521');
INSERT INTO `act_dmn_databasechangelog` VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2025-03-25 21:15:19', 4, 'EXECUTED', '8:f73aabc4529e7292c2942073d1cff6f9', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '2908518521');
INSERT INTO `act_dmn_databasechangelog` VALUES ('5', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2025-03-25 21:15:19', 5, 'EXECUTED', '8:3e03528582dd4eeb4eb41f9b9539140d', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_DMN_DEPLOYMENT; modifyDataType columnName=START_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION; modifyDataType columnName=END_TIME_, tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '2908518521');
INSERT INTO `act_dmn_databasechangelog` VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2025-03-25 21:15:19', 6, 'EXECUTED', '8:646c6a061e0b6e8a62e69844ff96abb0', 'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '2908518521');
INSERT INTO `act_dmn_databasechangelog` VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2025-03-25 21:15:19', 7, 'EXECUTED', '8:215a499ff7ae77685b55355245b8b708', 'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION', '', NULL, '4.9.1', NULL, NULL, '2908518521');
INSERT INTO `act_dmn_databasechangelog` VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2025-03-25 21:15:19', 8, 'EXECUTED', '8:5355bee389318afed91a11702f2df032', 'addColumn tableName=ACT_DMN_DECISION', '', NULL, '4.9.1', NULL, NULL, '2908518521');
INSERT INTO `act_dmn_databasechangelog` VALUES ('9', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2025-03-25 21:15:19', 9, 'EXECUTED', '8:0fe82086431b1953d293f0199f805876', 'createIndex indexName=ACT_IDX_DMN_INSTANCE_ID, tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '2908518521');

-- ----------------------------
-- Table structure for act_dmn_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_databasechangeloglock`;
CREATE TABLE `act_dmn_databasechangeloglock`  (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_databasechangeloglock
-- ----------------------------
INSERT INTO `act_dmn_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_dmn_decision
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_decision`;
CREATE TABLE `act_dmn_decision`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `VERSION_` int NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DECISION_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_DMN_DEC_UNIQ`(`KEY_` ASC, `VERSION_` ASC, `TENANT_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_decision
-- ----------------------------

-- ----------------------------
-- Table structure for act_dmn_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_deployment`;
CREATE TABLE `act_dmn_deployment`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for act_dmn_deployment_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_deployment_resource`;
CREATE TABLE `act_dmn_deployment_resource`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_BYTES_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_deployment_resource
-- ----------------------------

-- ----------------------------
-- Table structure for act_dmn_hi_decision_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_dmn_hi_decision_execution`;
CREATE TABLE `act_dmn_hi_decision_execution`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DECISION_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NULL DEFAULT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `INSTANCE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ACTIVITY_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `FAILED_` bit(1) NULL DEFAULT b'0',
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `EXECUTION_JSON_` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_DMN_INSTANCE_ID`(`INSTANCE_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_dmn_hi_decision_execution
-- ----------------------------

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log`  (
  `LOG_NR_` bigint NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DATA_` longblob NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`LOG_NR_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_evt_log
-- ----------------------------

-- ----------------------------
-- Table structure for act_fo_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_databasechangelog`;
CREATE TABLE `act_fo_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_fo_databasechangelog
-- ----------------------------
INSERT INTO `act_fo_databasechangelog` VALUES ('1', 'activiti', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2025-03-25 21:15:20', 1, 'EXECUTED', '8:033ebf9380889aed7c453927ecc3250d', 'createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '2908520554');
INSERT INTO `act_fo_databasechangelog` VALUES ('2', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2025-03-25 21:15:20', 2, 'EXECUTED', '8:986365ceb40445ce3b27a8e6b40f159b', 'addColumn tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '2908520554');
INSERT INTO `act_fo_databasechangelog` VALUES ('3', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2025-03-25 21:15:21', 3, 'EXECUTED', '8:abf482518ceb09830ef674e52c06bf15', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '2908520554');
INSERT INTO `act_fo_databasechangelog` VALUES ('4', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2025-03-25 21:15:21', 4, 'EXECUTED', '8:2087829f22a4b2298dbf530681c74854', 'modifyDataType columnName=DEPLOY_TIME_, tableName=ACT_FO_FORM_DEPLOYMENT; modifyDataType columnName=SUBMITTED_DATE_, tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '2908520554');
INSERT INTO `act_fo_databasechangelog` VALUES ('5', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2025-03-25 21:15:21', 5, 'EXECUTED', '8:b4be732b89e5ca028bdd520c6ad4d446', 'createIndex indexName=ACT_IDX_FORM_DEF_UNIQ, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '2908520554');
INSERT INTO `act_fo_databasechangelog` VALUES ('6', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2025-03-25 21:15:21', 6, 'EXECUTED', '8:384bbd364a649b67c3ca1bcb72fe537f', 'createIndex indexName=ACT_IDX_FORM_TASK, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_PROC, tableName=ACT_FO_FORM_INSTANCE; createIndex indexName=ACT_IDX_FORM_SCOPE, tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '2908520554');

-- ----------------------------
-- Table structure for act_fo_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_databasechangeloglock`;
CREATE TABLE `act_fo_databasechangeloglock`  (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_fo_databasechangeloglock
-- ----------------------------
INSERT INTO `act_fo_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for act_fo_form_definition
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_definition`;
CREATE TABLE `act_fo_form_definition`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `VERSION_` int NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_FORM_DEF_UNIQ`(`KEY_` ASC, `VERSION_` ASC, `TENANT_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_fo_form_definition
-- ----------------------------

-- ----------------------------
-- Table structure for act_fo_form_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_deployment`;
CREATE TABLE `act_fo_form_deployment`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_fo_form_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for act_fo_form_instance
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_instance`;
CREATE TABLE `act_fo_form_instance`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FORM_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `TASK_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SUBMITTED_DATE_` datetime(3) NULL DEFAULT NULL,
  `SUBMITTED_BY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `FORM_VALUES_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_FORM_TASK`(`TASK_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_FORM_PROC`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_FORM_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_fo_form_instance
-- ----------------------------

-- ----------------------------
-- Table structure for act_fo_form_resource
-- ----------------------------
DROP TABLE IF EXISTS `act_fo_form_resource`;
CREATE TABLE `act_fo_form_resource`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_BYTES_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_fo_form_resource
-- ----------------------------

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `BYTES_` longblob NULL,
  `GENERATED_` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_FK_BYTEARR_DEPL`(`DEPLOYMENT_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------
INSERT INTO `act_ge_bytearray` VALUES ('6cfc6a43-0984-11f0-82ff-4ccc6a2e3718', 1, '默认模型', '6cfc6a42-0984-11f0-82ff-4ccc6a2e3718', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A63616D756E64613D22687474703A2F2F63616D756E64612E6F72672F736368656D612F312E302F62706D6E2220786D6C6E733A64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F4449222069643D227369642D33383432326661652D653033652D343361332D626566342D62643333623332303431623222207461726765744E616D6573706163653D22687474703A2F2F62706D6E2E696F2F62706D6E22206578706F727465723D2262706D6E2D6A73202868747470733A2F2F64656D6F2E62706D6E2E696F2922206578706F7274657256657273696F6E3D22352E312E32223E0A20203C70726F636573732069643D22636F64652D306163653439373132616462616636666665336638626438326233393164653222206E616D653D22E9BB98E8AEA4E6A8A1E59E8B2220697345786563757461626C653D2274727565222063616D756E64613A76657273696F6E5461673D22302E302E31223E0A202020203C73746172744576656E742069643D224576656E745F3135796E6D6F3922206E616D653D22E5BC80E5A78B223E0A2020202020203C6F7574676F696E673E466C6F775F3175356E79387A3C2F6F7574676F696E673E0A202020203C2F73746172744576656E743E0A202020203C7461736B2069643D2241637469766974795F3033647670723622206E616D653D22E5AEA1E6A0B8223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C63616D756E64613A696E7075744F75747075743E0A202020202020202020203C63616D756E64613A696E707574506172616D65746572206E616D653D22496E7075745F3030633470353822202F3E0A202020202020202020203C63616D756E64613A6F7574707574506172616D65746572206E616D653D224F75747075745F30727468366F3222202F3E0A20202020202020203C2F63616D756E64613A696E7075744F75747075743E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A2020202020203C696E636F6D696E673E466C6F775F3175356E79387A3C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F3032716F7A686D3C2F6F7574676F696E673E0A202020203C2F7461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3175356E79387A2220736F757263655265663D224576656E745F3135796E6D6F3922207461726765745265663D2241637469766974795F3033647670723622202F3E0A202020203C696E7465726D6564696174655468726F774576656E742069643D224576656E745F3075307830647622206E616D653D22E7BB93E69D9F223E0A2020202020203C696E636F6D696E673E466C6F775F3032716F7A686D3C2F696E636F6D696E673E0A202020203C2F696E7465726D6564696174655468726F774576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3032716F7A686D2220736F757263655265663D2241637469766974795F3033647670723622207461726765745265663D224576656E745F3075307830647622202F3E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242706D6E4469616772616D5F31223E0A202020203C62706D6E64693A42504D4E506C616E652069643D2242706D6E506C616E655F31222062706D6E456C656D656E743D22636F64652D3061636534393731326164626166366666653366386264383262333931646532223E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F3135796E6D6F395F6469222062706D6E456C656D656E743D224576656E745F3135796E6D6F39223E0A20202020202020203C6F6D6764633A426F756E647320783D223238322220793D22323532222077696474683D22333622206865696768743D22333622202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D223238392220793D22323935222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F303364767072365F6469222062706D6E456C656D656E743D2241637469766974795F30336476707236223E0A20202020202020203C6F6D6764633A426F756E647320783D223337302220793D22323330222077696474683D2231303022206865696768743D22383022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F307530783064765F6469222062706D6E456C656D656E743D224576656E745F30753078306476223E0A20202020202020203C6F6D6764633A426F756E647320783D223532322220793D22323532222077696474683D22333622206865696768743D22333622202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D223532392220793D22323935222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F3175356E79387A5F6469222062706D6E456C656D656E743D22466C6F775F3175356E79387A223E0A20202020202020203C64693A776179706F696E7420783D223331382220793D2232373022202F3E0A20202020202020203C64693A776179706F696E7420783D223337302220793D2232373022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F3032716F7A686D5F6469222062706D6E456C656D656E743D22466C6F775F3032716F7A686D223E0A20202020202020203C64693A776179706F696E7420783D223437302220793D2232373022202F3E0A20202020202020203C64693A776179706F696E7420783D223532322220793D2232373022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E0A, 0);
INSERT INTO `act_ge_bytearray` VALUES ('f35f896e-0d73-11f0-ba00-4ccc6a2e3718', 1, '默认模型', 'f35f896d-0d73-11f0-ba00-4ccc6a2e3718', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A63616D756E64613D22687474703A2F2F63616D756E64612E6F72672F736368656D612F312E302F62706D6E2220786D6C6E733A64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F4449222069643D227369642D33383432326661652D653033652D343361332D626566342D62643333623332303431623222207461726765744E616D6573706163653D22687474703A2F2F62706D6E2E696F2F62706D6E22206578706F727465723D2262706D6E2D6A73202868747470733A2F2F64656D6F2E62706D6E2E696F2922206578706F7274657256657273696F6E3D22352E312E32223E0A20203C70726F636573732069643D22636F64652D306163653439373132616462616636666665336638626438326233393164653222206E616D653D22E9BB98E8AEA4E6A8A1E59E8B2220697345786563757461626C653D2274727565222063616D756E64613A76657273696F6E5461673D22302E302E31223E0A202020203C73746172744576656E742069643D224576656E745F3135796E6D6F3922206E616D653D22E5BC80E5A78B223E0A2020202020203C6F7574676F696E673E466C6F775F3175356E79387A3C2F6F7574676F696E673E0A202020203C2F73746172744576656E743E0A202020203C7461736B2069643D2241637469766974795F3033647670723622206E616D653D22E5AEA1E6A0B8223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C63616D756E64613A696E7075744F75747075743E0A202020202020202020203C63616D756E64613A696E707574506172616D65746572206E616D653D22496E7075745F3030633470353822202F3E0A202020202020202020203C63616D756E64613A6F7574707574506172616D65746572206E616D653D224F75747075745F30727468366F3222202F3E0A20202020202020203C2F63616D756E64613A696E7075744F75747075743E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A2020202020203C696E636F6D696E673E466C6F775F3175356E79387A3C2F696E636F6D696E673E0A2020202020203C6F7574676F696E673E466C6F775F3032716F7A686D3C2F6F7574676F696E673E0A202020203C2F7461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3175356E79387A2220736F757263655265663D224576656E745F3135796E6D6F3922207461726765745265663D2241637469766974795F3033647670723622202F3E0A202020203C696E7465726D6564696174655468726F774576656E742069643D224576656E745F3075307830647622206E616D653D22E7BB93E69D9F223E0A2020202020203C696E636F6D696E673E466C6F775F3032716F7A686D3C2F696E636F6D696E673E0A202020203C2F696E7465726D6564696174655468726F774576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3032716F7A686D2220736F757263655265663D2241637469766974795F3033647670723622207461726765745265663D224576656E745F3075307830647622202F3E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242706D6E4469616772616D5F31223E0A202020203C62706D6E64693A42504D4E506C616E652069643D2242706D6E506C616E655F31222062706D6E456C656D656E743D22636F64652D3061636534393731326164626166366666653366386264383262333931646532223E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F3135796E6D6F395F6469222062706D6E456C656D656E743D224576656E745F3135796E6D6F39223E0A20202020202020203C6F6D6764633A426F756E647320783D223238322220793D22323532222077696474683D22333622206865696768743D22333622202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D223238392220793D22323935222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D2241637469766974795F303364767072365F6469222062706D6E456C656D656E743D2241637469766974795F30336476707236223E0A20202020202020203C6F6D6764633A426F756E647320783D223337302220793D22323330222077696474683D2231303022206865696768743D22383022202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C202F3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652069643D224576656E745F307530783064765F6469222062706D6E456C656D656E743D224576656E745F30753078306476223E0A20202020202020203C6F6D6764633A426F756E647320783D223532322220793D22323532222077696474683D22333622206865696768743D22333622202F3E0A20202020202020203C62706D6E64693A42504D4E4C6162656C3E0A202020202020202020203C6F6D6764633A426F756E647320783D223532392220793D22323935222077696474683D22323222206865696768743D22313422202F3E0A20202020202020203C2F62706D6E64693A42504D4E4C6162656C3E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F3175356E79387A5F6469222062706D6E456C656D656E743D22466C6F775F3175356E79387A223E0A20202020202020203C64693A776179706F696E7420783D223331382220793D2232373022202F3E0A20202020202020203C64693A776179706F696E7420783D223337302220793D2232373022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652069643D22466C6F775F3032716F7A686D5F6469222062706D6E456C656D656E743D22466C6F775F3032716F7A686D223E0A20202020202020203C64693A776179706F696E7420783D223437302220793D2232373022202F3E0A20202020202020203C64693A776179706F696E7420783D223532322220793D2232373022202F3E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E0A, 0);

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property`  (
  `NAME_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `VALUE_` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REV_` int NULL DEFAULT NULL,
  PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
INSERT INTO `act_ge_property` VALUES ('batch.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` VALUES ('cfg.task-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` VALUES ('common.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` VALUES ('entitylink.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` VALUES ('eventsubscription.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` VALUES ('identitylink.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` VALUES ('job.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` VALUES ('next.dbid', '1', 1);
INSERT INTO `act_ge_property` VALUES ('schema.history', 'create(6.8.1.0)', 1);
INSERT INTO `act_ge_property` VALUES ('schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` VALUES ('task.schema.version', '6.8.1.0', 1);
INSERT INTO `act_ge_property` VALUES ('variable.schema.version', '6.8.1.0', 1);

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT 1,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ACT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ACT_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `TRANSACTION_ORDER_` int NULL DEFAULT NULL,
  `DURATION_` bigint NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_START`(`START_TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_END`(`END_TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_PROCINST`(`PROC_INST_ID_` ASC, `ACT_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_EXEC`(`EXECUTION_ID_` ASC, `ACT_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `URL_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CONTENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ACTION_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `MESSAGE_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `FULL_MSG_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `VAR_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REV_` int NULL DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DOUBLE_` double NULL DEFAULT NULL,
  `LONG_` bigint NULL DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_PROC_INST`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_ACT_INST`(`ACT_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_TIME`(`TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_NAME`(`NAME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_TASK_ID`(`TASK_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_entitylink`;
CREATE TABLE `act_hi_entitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `LINK_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PARENT_ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ROOT_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ROOT_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_ENT_LNK_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC, `LINK_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_ENT_LNK_REF_SCOPE`(`REF_SCOPE_ID_` ASC, `REF_SCOPE_TYPE_` ASC, `LINK_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_ENT_LNK_ROOT_SCOPE`(`ROOT_SCOPE_ID_` ASC, `ROOT_SCOPE_TYPE_` ASC, `LINK_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_ENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC, `LINK_TYPE_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_entitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_USER`(`USER_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_SUB_SCOPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_TASK`(`TASK_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT 1,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `DURATION_` bigint NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `START_ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `END_ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `PROC_INST_ID_`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PRO_INST_END`(`END_TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PRO_I_BUSKEY`(`BUSINESS_KEY_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PRO_SUPER_PROCINST`(`SUPER_PROCESS_INSTANCE_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT 1,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) NULL DEFAULT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `DURATION_` bigint NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PRIORITY_` int NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) NULL DEFAULT NULL,
  `FORM_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_TASK_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_TASK_SUB_SCOPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_TASK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_TASK_INST_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_tsk_log
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_tsk_log`;
CREATE TABLE `act_hi_tsk_log`  (
  `ID_` bigint NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DATA_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_tsk_log
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT 1,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `VAR_TYPE_` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DOUBLE_` double NULL DEFAULT NULL,
  `LONG_` bigint NULL DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `META_INFO_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_NAME_TYPE`(`NAME_` ASC, `VAR_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_VAR_SCOPE_ID_TYPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_VAR_SUB_ID_TYPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_PROC_INST`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_TASK_ID`(`TASK_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_EXE`(`EXECUTION_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_id_bytearray`;
CREATE TABLE `act_id_bytearray`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `BYTES_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_bytearray
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_group
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `USER_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `VALUE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PASSWORD_` longblob NULL,
  `PARENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_info
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership`  (
  `USER_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `GROUP_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`, `GROUP_ID_`) USING BTREE,
  INDEX `ACT_FK_MEMB_GROUP`(`GROUP_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_membership
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_priv
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv`;
CREATE TABLE `act_id_priv`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_UNIQ_PRIV_NAME`(`NAME_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_priv
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_priv_mapping
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv_mapping`;
CREATE TABLE `act_id_priv_mapping`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `PRIV_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_FK_PRIV_MAPPING`(`PRIV_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_PRIV_USER`(`USER_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_PRIV_GROUP`(`GROUP_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `act_id_priv` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_priv_mapping
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_property
-- ----------------------------
DROP TABLE IF EXISTS `act_id_property`;
CREATE TABLE `act_id_property`  (
  `NAME_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `VALUE_` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REV_` int NULL DEFAULT NULL,
  PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_property
-- ----------------------------
INSERT INTO `act_id_property` VALUES ('schema.version', '6.8.1.0', 1);

-- ----------------------------
-- Table structure for act_id_token
-- ----------------------------
DROP TABLE IF EXISTS `act_id_token`;
CREATE TABLE `act_id_token`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `TOKEN_VALUE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TOKEN_DATE_` timestamp(3) NULL DEFAULT NULL,
  `IP_ADDRESS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `USER_AGENT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TOKEN_DATA_` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_token
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `FIRST_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `LAST_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DISPLAY_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EMAIL_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PWD_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PICTURE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------

-- ----------------------------
-- Table structure for act_procdef_info
-- ----------------------------
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE `act_procdef_info`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_UNIQ_INFO_PROCDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_INFO_PROCDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_INFO_JSON_BA`(`INFO_JSON_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_procdef_info
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ENGINE_VERSION_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------
INSERT INTO `act_re_deployment` VALUES ('6cfc6a42-0984-11f0-82ff-4ccc6a2e3718', '默认模型', NULL, NULL, '', '2025-03-25 22:21:21.730', NULL, NULL, '6cfc6a42-0984-11f0-82ff-4ccc6a2e3718', NULL);
INSERT INTO `act_re_deployment` VALUES ('f35f896d-0d73-11f0-ba00-4ccc6a2e3718', '默认模型', NULL, NULL, '', '2025-03-30 22:33:30.401', NULL, NULL, 'f35f896d-0d73-11f0-ba00-4ccc6a2e3718', NULL);

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int NULL DEFAULT NULL,
  `META_INFO_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_FK_MODEL_SOURCE`(`EDITOR_SOURCE_VALUE_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_MODEL_SOURCE_EXTRA`(`EDITOR_SOURCE_EXTRA_VALUE_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_MODEL_DEPLOYMENT`(`DEPLOYMENT_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `VERSION_` int NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint NULL DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint NULL DEFAULT NULL,
  `SUSPENSION_STATE_` int NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  `ENGINE_VERSION_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DERIVED_VERSION_` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_UNIQ_PROCDEF`(`KEY_` ASC, `VERSION_` ASC, `DERIVED_VERSION_` ASC, `TENANT_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_actinst`;
CREATE TABLE `act_ru_actinst`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT 1,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ACT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ACT_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `DURATION_` bigint NULL DEFAULT NULL,
  `TRANSACTION_ORDER_` int NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_START`(`START_TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_END`(`END_TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_PROC`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_PROC_ACT`(`PROC_INST_ID_` ASC, `ACT_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_EXEC`(`EXECUTION_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_EXEC_ACT`(`EXECUTION_ID_` ASC, `ACT_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_RU_ACTI_TASK`(`TASK_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_actinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_deadletter_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_deadletter_job`;
CREATE TABLE `act_ru_deadletter_job`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_DEADLETTER_JOB_CORRELATION_ID`(`CORRELATION_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_DJOB_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_DJOB_SUB_SCOPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_DJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_FK_DEADLETTER_JOB_EXECUTION`(`EXECUTION_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_DEADLETTER_JOB_PROC_DEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_deadletter_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_entitylink`;
CREATE TABLE `act_ru_entitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LINK_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PARENT_ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ROOT_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ROOT_SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_ENT_LNK_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC, `LINK_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_ENT_LNK_REF_SCOPE`(`REF_SCOPE_ID_` ASC, `REF_SCOPE_TYPE_` ASC, `LINK_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_ENT_LNK_ROOT_SCOPE`(`ROOT_SCOPE_ID_` ASC, `ROOT_SCOPE_TYPE_` ASC, `LINK_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_ENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC, `LINK_TYPE_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_entitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `EVENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CONFIGURATION_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_EVENT_SUBSCR_CONFIG_`(`CONFIGURATION_` ASC) USING BTREE,
  INDEX `ACT_IDX_EVENT_SUBSCR_SCOPEREF_`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_FK_EVENT_EXEC`(`EXECUTION_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PARENT_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `IS_ACTIVE_` tinyint NULL DEFAULT NULL,
  `IS_CONCURRENT_` tinyint NULL DEFAULT NULL,
  `IS_SCOPE_` tinyint NULL DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint NULL DEFAULT NULL,
  `IS_MI_ROOT_` tinyint NULL DEFAULT NULL,
  `SUSPENSION_STATE_` int NULL DEFAULT NULL,
  `CACHED_ENT_STATE_` int NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `START_ACT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint NULL DEFAULT NULL,
  `EVT_SUBSCR_COUNT_` int NULL DEFAULT NULL,
  `TASK_COUNT_` int NULL DEFAULT NULL,
  `JOB_COUNT_` int NULL DEFAULT NULL,
  `TIMER_JOB_COUNT_` int NULL DEFAULT NULL,
  `SUSP_JOB_COUNT_` int NULL DEFAULT NULL,
  `DEADLETTER_JOB_COUNT_` int NULL DEFAULT NULL,
  `EXTERNAL_WORKER_JOB_COUNT_` int NULL DEFAULT NULL,
  `VAR_COUNT_` int NULL DEFAULT NULL,
  `ID_LINK_COUNT_` int NULL DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REFERENCE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `REFERENCE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `BUSINESS_STATUS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_EXEC_BUSKEY`(`BUSINESS_KEY_` ASC) USING BTREE,
  INDEX `ACT_IDC_EXEC_ROOT`(`ROOT_PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_EXEC_REF_ID_`(`REFERENCE_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_EXE_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_EXE_PARENT`(`PARENT_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_EXE_SUPER`(`SUPER_EXEC_` ASC) USING BTREE,
  INDEX `ACT_FK_EXE_PROCDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_external_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_external_job`;
CREATE TABLE `act_ru_external_job`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `RETRIES_` int NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_EXTERNAL_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_EXTERNAL_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_EXTERNAL_JOB_CORRELATION_ID`(`CORRELATION_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_EJOB_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_EJOB_SUB_SCOPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_EJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_EXTERNAL_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_EXTERNAL_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_external_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_history_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_history_job`;
CREATE TABLE `act_ru_history_job`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `RETRIES_` int NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ADV_HANDLER_CFG_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_history_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_USER`(`USER_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_GROUP`(`GROUP_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_SUB_SCOPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_ATHRZ_PROCEDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_TSKASS_TASK`(`TASK_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_IDL_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `RETRIES_` int NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_JOB_CORRELATION_ID`(`CORRELATION_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_JOB_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_JOB_SUB_SCOPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_JOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_FK_JOB_EXECUTION`(`EXECUTION_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_JOB_PROC_DEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_suspended_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_suspended_job`;
CREATE TABLE `act_ru_suspended_job`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `RETRIES_` int NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_SUSPENDED_JOB_CORRELATION_ID`(`CORRELATION_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_SJOB_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_SJOB_SUB_SCOPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_SJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_FK_SUSPENDED_JOB_EXECUTION`(`EXECUTION_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_SUSPENDED_JOB_PROC_DEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_suspended_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROPAGATED_STAGE_INST_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DELEGATION_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PRIORITY_` int NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUSPENSION_STATE_` int NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  `FORM_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CLAIM_TIME_` datetime(3) NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint NULL DEFAULT NULL,
  `VAR_COUNT_` int NULL DEFAULT NULL,
  `ID_LINK_COUNT_` int NULL DEFAULT NULL,
  `SUB_TASK_COUNT_` int NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_TASK_CREATE`(`CREATE_TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_TASK_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_TASK_SUB_SCOPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_TASK_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_FK_TASK_EXE`(`EXECUTION_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_TASK_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_TASK_PROCDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_timer_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_timer_job`;
CREATE TABLE `act_ru_timer_job`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CORRELATION_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `RETRIES_` int NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID`(`EXCEPTION_STACK_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID`(`CUSTOM_VALUES_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_TIMER_JOB_CORRELATION_ID`(`CORRELATION_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_TIMER_JOB_DUEDATE`(`DUEDATE_` ASC) USING BTREE,
  INDEX `ACT_IDX_TJOB_SCOPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_TJOB_SUB_SCOPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_TJOB_SCOPE_DEF`(`SCOPE_DEFINITION_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_FK_TIMER_JOB_EXECUTION`(`EXECUTION_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_TIMER_JOB_PROCESS_INSTANCE`(`PROCESS_INSTANCE_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_TIMER_JOB_PROC_DEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_timer_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `DOUBLE_` double NULL DEFAULT NULL,
  `LONG_` bigint NULL DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `META_INFO_` varchar(4000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_RU_VAR_SCOPE_ID_TYPE`(`SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_RU_VAR_SUB_ID_TYPE`(`SUB_SCOPE_ID_` ASC, `SCOPE_TYPE_` ASC) USING BTREE,
  INDEX `ACT_FK_VAR_BYTEARRAY`(`BYTEARRAY_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_VARIABLE_TASK_ID`(`TASK_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_VAR_EXE`(`EXECUTION_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_VAR_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE,
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------

-- ----------------------------
-- Table structure for flow_model
-- ----------------------------
DROP TABLE IF EXISTS `flow_model`;
CREATE TABLE `flow_model`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键ID',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '编码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `task_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务ID',
  `status` int NULL DEFAULT NULL COMMENT '状态：0、未部署，1、已部署',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工作流模型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flow_model
-- ----------------------------
INSERT INTO `flow_model` VALUES ('e9606169-0982-11f0-b559-4ccc6a2e3718', 'code-0ace49712adbaf6ffe3f8bd82b391de2', '默认模型', '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:camunda=\"http://camunda.org/schema/1.0/bpmn\" xmlns:di=\"http://www.omg.org/spec/DD/20100524/DI\" id=\"sid-38422fae-e03e-43a3-bef4-bd33b32041b2\" targetNamespace=\"http://bpmn.io/bpmn\" exporter=\"bpmn-js (https://demo.bpmn.io)\" exporterVersion=\"5.1.2\">\n  <process id=\"code-0ace49712adbaf6ffe3f8bd82b391de2\" name=\"默认模型\" isExecutable=\"true\" camunda:versionTag=\"0.0.1\">\n    <startEvent id=\"Event_15ynmo9\" name=\"开始\">\n      <outgoing>Flow_1u5ny8z</outgoing>\n    </startEvent>\n    <task id=\"Activity_03dvpr6\" name=\"审核\">\n      <extensionElements>\n        <camunda:inputOutput>\n          <camunda:inputParameter name=\"Input_00c4p58\" />\n          <camunda:outputParameter name=\"Output_0rth6o2\" />\n        </camunda:inputOutput>\n      </extensionElements>\n      <incoming>Flow_1u5ny8z</incoming>\n      <outgoing>Flow_02qozhm</outgoing>\n    </task>\n    <sequenceFlow id=\"Flow_1u5ny8z\" sourceRef=\"Event_15ynmo9\" targetRef=\"Activity_03dvpr6\" />\n    <intermediateThrowEvent id=\"Event_0u0x0dv\" name=\"结束\">\n      <incoming>Flow_02qozhm</incoming>\n    </intermediateThrowEvent>\n    <sequenceFlow id=\"Flow_02qozhm\" sourceRef=\"Activity_03dvpr6\" targetRef=\"Event_0u0x0dv\" />\n  </process>\n  <bpmndi:BPMNDiagram id=\"BpmnDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BpmnPlane_1\" bpmnElement=\"code-0ace49712adbaf6ffe3f8bd82b391de2\">\n      <bpmndi:BPMNShape id=\"Event_15ynmo9_di\" bpmnElement=\"Event_15ynmo9\">\n        <omgdc:Bounds x=\"282\" y=\"252\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"289\" y=\"295\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_03dvpr6_di\" bpmnElement=\"Activity_03dvpr6\">\n        <omgdc:Bounds x=\"370\" y=\"230\" width=\"100\" height=\"80\" />\n        <bpmndi:BPMNLabel />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_0u0x0dv_di\" bpmnElement=\"Event_0u0x0dv\">\n        <omgdc:Bounds x=\"522\" y=\"252\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds x=\"529\" y=\"295\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge id=\"Flow_1u5ny8z_di\" bpmnElement=\"Flow_1u5ny8z\">\n        <di:waypoint x=\"318\" y=\"270\" />\n        <di:waypoint x=\"370\" y=\"270\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_02qozhm_di\" bpmnElement=\"Flow_02qozhm\">\n        <di:waypoint x=\"470\" y=\"270\" />\n        <di:waypoint x=\"522\" y=\"270\" />\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n', 'f35f896d-0d73-11f0-ba00-4ccc6a2e3718', 1, '1', '2025-03-30 22:33:30', '2025-03-25 22:10:31', '');

-- ----------------------------
-- Table structure for flw_channel_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_channel_definition`;
CREATE TABLE `flw_channel_definition`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `VERSION_` int NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `IMPLEMENTATION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_CHANNEL_DEF_UNIQ`(`KEY_` ASC, `VERSION_` ASC, `TENANT_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_channel_definition
-- ----------------------------

-- ----------------------------
-- Table structure for flw_ev_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangelog`;
CREATE TABLE `flw_ev_databasechangelog`  (
  `ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `AUTHOR` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `FILENAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MD5SUM` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `COMMENTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TAG` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LIQUIBASE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CONTEXTS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `LABELS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_ev_databasechangelog
-- ----------------------------
INSERT INTO `flw_ev_databasechangelog` VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2025-03-25 21:15:16', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.9.1', NULL, NULL, '2908515820');
INSERT INTO `flw_ev_databasechangelog` VALUES ('2', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2025-03-25 21:15:16', 2, 'EXECUTED', '8:0ea825feb8e470558f0b5754352b9cda', 'addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '2908515820');
INSERT INTO `flw_ev_databasechangelog` VALUES ('3', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2025-03-25 21:15:16', 3, 'EXECUTED', '8:3c2bb293350b5cbe6504331980c9dcee', 'customChange', '', NULL, '4.9.1', NULL, NULL, '2908515820');

-- ----------------------------
-- Table structure for flw_ev_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangeloglock`;
CREATE TABLE `flw_ev_databasechangeloglock`  (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime NULL DEFAULT NULL,
  `LOCKEDBY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_ev_databasechangeloglock
-- ----------------------------
INSERT INTO `flw_ev_databasechangeloglock` VALUES (1, b'0', NULL, NULL);

-- ----------------------------
-- Table structure for flw_event_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_definition`;
CREATE TABLE `flw_event_definition`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `VERSION_` int NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_IDX_EVENT_DEF_UNIQ`(`KEY_` ASC, `VERSION_` ASC, `TENANT_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_event_definition
-- ----------------------------

-- ----------------------------
-- Table structure for flw_event_deployment
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_deployment`;
CREATE TABLE `flw_event_deployment`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOY_TIME_` datetime(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_event_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for flw_event_resource
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_resource`;
CREATE TABLE `flw_event_resource`  (
  `ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `RESOURCE_BYTES_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_event_resource
-- ----------------------------

-- ----------------------------
-- Table structure for flw_ru_batch
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch`;
CREATE TABLE `flw_ru_batch`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `SEARCH_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SEARCH_KEY2_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NOT NULL,
  `COMPLETE_TIME_` datetime(3) NULL DEFAULT NULL,
  `STATUS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `BATCH_DOC_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_ru_batch
-- ----------------------------

-- ----------------------------
-- Table structure for flw_ru_batch_part
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch_part`;
CREATE TABLE `flw_ru_batch_part`  (
  `ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NULL DEFAULT NULL,
  `BATCH_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `SCOPE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SEARCH_KEY_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `SEARCH_KEY2_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NOT NULL,
  `COMPLETE_TIME_` datetime(3) NULL DEFAULT NULL,
  `STATUS_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `RESULT_DOC_ID_` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `FLW_IDX_BATCH_PART`(`BATCH_ID_` ASC) USING BTREE,
  CONSTRAINT `FLW_FK_BATCH_PART_PARENT` FOREIGN KEY (`BATCH_ID_`) REFERENCES `flw_ru_batch` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flw_ru_batch_part
-- ----------------------------

-- ----------------------------
-- Table structure for lc_pages
-- ----------------------------
DROP TABLE IF EXISTS `lc_pages`;
CREATE TABLE `lc_pages`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '页面标题',
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '副标题',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父页面',
  `pageschema` json NULL COMMENT '页面json',
  `status` int NULL DEFAULT NULL COMMENT '状态：0、正常，1、禁用',
  `classify` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类编码',
  `creator_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '页面开发' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lc_pages
-- ----------------------------
INSERT INTO `lc_pages` VALUES ('306eeeb4daa0674cbf4026f6910ba5a0', '表格例子', '支持增删改查', '0', '{\"id\": \"u:e6cbae2af395\", \"body\": [{\"id\": \"pages_crud\", \"api\": {\"url\": \"/tansci/lowcode/lcPages/page\", \"data\": {\"size\": \"${perPage}\", \"title\": \"${title}\", \"current\": \"${page}\"}, \"method\": \"get\", \"messages\": {}, \"responseData\": {\"data\": \"${result.records}\"}}, \"name\": \"pages_crud\", \"type\": \"crud\", \"filter\": {\"id\": \"u:5ad1c4a6d950\", \"body\": [{\"id\": \"u:f75f39cb2469\", \"name\": \"title\", \"type\": \"input-text\", \"placeholder\": \"请输入名称\"}, {\"id\": \"u:c5f5700a399d\", \"name\": \"city\", \"type\": \"input-city\", \"label\": \"城市选择\", \"allowCity\": true, \"extractValue\": true, \"allowDistrict\": true}], \"title\": \"条件搜索\", \"actions\": [{\"id\": \"u:351ace1a07f0\", \"icon\": \"fa fa-plus\", \"size\": \"sm\", \"type\": \"button\", \"label\": \"添加\", \"dialog\": {\"body\": {\"api\": \"/tansci/lcPages/save\", \"body\": [{\"name\": \"title\", \"type\": \"input-text\", \"label\": \"名称\", \"required\": true}, {\"name\": \"remarks\", \"type\": \"input-text\", \"label\": \"描述\", \"required\": true}], \"name\": \"sample-edit-form\", \"type\": \"form\"}, \"title\": \"添加\"}, \"target\": \"pages_crud\", \"actionType\": \"dialog\"}, {\"id\": \"u:6309a99bd03a\", \"size\": \"sm\", \"type\": \"reset\", \"label\": \"重置\"}, {\"id\": \"u:e541fe6332bc\", \"size\": \"sm\", \"type\": \"submit\", \"label\": \"查询\", \"level\": \"primary\"}], \"submitText\": \"\"}, \"columns\": [{\"id\": \"u:6ce5ff1520ad\", \"name\": \"id\", \"type\": \"text\", \"label\": \"ID\"}, {\"id\": \"u:0044e13a9da6\", \"name\": \"title\", \"type\": \"text\", \"label\": \"页面标题\"}, {\"id\": \"u:e03d48488d41\", \"name\": \"subtitle\", \"type\": \"text\", \"label\": \"副标题\"}, {\"id\": \"u:d1fe9b9479cf\", \"name\": \"status\", \"type\": \"status\", \"label\": \"状态\", \"source\": {\"0\": {\"icon\": \"fa fa-check-circle\", \"color\": \"#67C23A\", \"label\": \"已发布\"}, \"1\": {\"icon\": \"fa fa-times-circle\", \"color\": \"#F56C6C\", \"label\": \"未发布\"}}}, {\"id\": \"u:91aadb1310ce\", \"name\": \"remarks\", \"type\": \"text\", \"label\": \"描述\"}, {\"id\": \"u:91aadb1310ce\", \"name\": \"updateTime\", \"type\": \"text\", \"label\": \"更新时间\"}, {\"id\": \"u:91aadb1310ce\", \"name\": \"createTime\", \"type\": \"text\", \"label\": \"创建时间\"}, {\"id\": \"u:b53dd325281b\", \"type\": \"operation\", \"label\": \"操作\", \"width\": 130, \"buttons\": [{\"id\": \"u:19ee43a7c211\", \"type\": \"button\", \"label\": \"详情\", \"level\": \"link\", \"dialog\": {\"body\": {\"body\": [{\"name\": \"title\", \"type\": \"static\", \"label\": \"名称\"}, {\"type\": \"divider\"}, {\"name\": \"remarks\", \"type\": \"static\", \"label\": \"描述\"}, {\"type\": \"divider\"}, {\"name\": \"status\", \"type\": \"static\", \"label\": \"状态\"}, {\"type\": \"divider\"}, {\"name\": \"updateTime\", \"type\": \"static\", \"label\": \"更新时间\"}, {\"type\": \"divider\"}, {\"name\": \"pageschema\", \"type\": \"json\", \"label\": \"内容\"}], \"type\": \"form\"}, \"size\": \"lg\", \"title\": \"查看\"}, \"actionType\": \"dialog\"}, {\"id\": \"u:4cde2885b9f0\", \"type\": \"button\", \"label\": \"编辑\", \"level\": \"link\", \"dialog\": {\"body\": {\"api\": \"/tansci/lcPages/update\", \"body\": [{\"name\": \"title\", \"type\": \"input-text\", \"label\": \"名称\", \"required\": true}, {\"name\": \"remarks\", \"type\": \"input-text\", \"label\": \"描述\", \"required\": true}], \"name\": \"sample-edit-form\", \"type\": \"form\"}, \"title\": \"编辑\"}, \"actionType\": \"dialog\"}, {\"id\": \"u:dd3568d00c3a\", \"api\": \"get:/tansci/lcPages/delete/${id}\", \"type\": \"button\", \"label\": \"删除\", \"level\": \"link\", \"className\": \"text-danger\", \"actionType\": \"ajax\", \"confirmText\": \"您确认要删除?\"}], \"toggled\": true}], \"messages\": {}, \"draggable\": false, \"bulkActions\": [], \"perPageAvailable\": [10]}], \"type\": \"page\", \"title\": \"\", \"toolbar\": []}', 0, '56d41ddc-f09e-11ee-a7f7-e0be038740d4', '534a37c366ec47878a6b0c85703d0bc2', '2024-04-02 11:31:29', '2023-05-11 11:24:39', '支持增删改查、分页、筛选的表格例子');
INSERT INTO `lc_pages` VALUES ('7f08e688-de5a-11ed-8f49-00163e228eed', '轮播图', '轮播图', '0', '{\"id\": \"u:a457fe5d710c\", \"body\": [{\"id\": \"u:b008adde5469\", \"body\": [{\"id\": \"u:ee0376499f18\", \"type\": \"carousel\", \"height\": \"300\", \"options\": [{\"image\": \"https://aisuda.bce.baidu.com/amis/static/photo/3893101144_bff2dc9.jpg\"}, {\"image\": \"https://aisuda.bce.baidu.com/amis/static/photo/bd3eb13533fa828b13b24500f31f4134960a5a44_81bbc2d.jpg\"}, {\"image\": \"https://aisuda.bce.baidu.com/amis/static/photo/da6376bf988c_3360340.jpg\"}], \"controlsTheme\": \"light\"}], \"type\": \"panel\", \"title\": \"直接页面配置\"}], \"type\": \"page\", \"style\": {\"boxShadow\": \" 0px 0px 0px 0px transparent\"}, \"pullRefresh\": {\"disabled\": true}, \"asideResizor\": false}', 0, '56d41ddc-f09e-11ee-a7f7-e0be038740d4', NULL, '2024-04-02 11:32:10', '2023-05-11 10:58:43', '轮播图测试');
INSERT INTO `lc_pages` VALUES ('ce620f517565f989d718385d4e4033ac', 'aaaa', '啊啊', NULL, NULL, NULL, 'ce620f517565f989d718385d4e4033ac', '534a37c366ec47878a6b0c85703d0bc2', '2024-04-02 11:31:50', '2023-05-12 08:55:56', 'aaaa');

-- ----------------------------
-- Table structure for lc_pages_classify
-- ----------------------------
DROP TABLE IF EXISTS `lc_pages_classify`;
CREATE TABLE `lc_pages_classify`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父页面',
  `creator_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '页面开发' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lc_pages_classify
-- ----------------------------
INSERT INTO `lc_pages_classify` VALUES ('306eeeb4daa0674cbf4026f6910ba5a0', '根节点', '0', NULL, '2024-04-02 11:05:58', '2023-05-11 11:24:39', '支持增删改查、分页、筛选的表格例子');
INSERT INTO `lc_pages_classify` VALUES ('56d41ddc-f09e-11ee-a7f7-e0be038740d4', '已绑定', '306eeeb4daa0674cbf4026f6910ba5a0', NULL, '2024-04-02 11:08:54', '2024-04-02 11:08:54', '');
INSERT INTO `lc_pages_classify` VALUES ('ce620f517565f989d718385d4e4033ac', '未绑定', '306eeeb4daa0674cbf4026f6910ba5a0', NULL, '2024-04-02 11:08:44', '2023-05-12 08:55:56', 'aaaa');

-- ----------------------------
-- Table structure for lc_pages_menu
-- ----------------------------
DROP TABLE IF EXISTS `lc_pages_menu`;
CREATE TABLE `lc_pages_menu`  (
  `pages_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '页面id',
  `menu_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`pages_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '页面菜单关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lc_pages_menu
-- ----------------------------
INSERT INTO `lc_pages_menu` VALUES ('306eeeb4daa0674cbf4026f6910ba5a0', 'd2df5734-1ca6-11ee-8b16-e0be038740d4');
INSERT INTO `lc_pages_menu` VALUES ('7f08e688-de5a-11ed-8f49-00163e228eed', 'eb404f1c-1ca6-11ee-8b16-e0be038740d4');

-- ----------------------------
-- Table structure for magic_api_backup
-- ----------------------------
DROP TABLE IF EXISTS `magic_api_backup`;
CREATE TABLE `magic_api_backup`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '原对象ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '原名称',
  `content` blob NULL COMMENT '备份内容',
  `tag` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作人',
  `create_date` datetime NULL DEFAULT NULL COMMENT '备份时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'magic api 备份' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of magic_api_backup
-- ----------------------------

-- ----------------------------
-- Table structure for magic_api_file
-- ----------------------------
DROP TABLE IF EXISTS `magic_api_file`;
CREATE TABLE `magic_api_file`  (
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '路径',
  `file_content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  PRIMARY KEY (`file_path`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'magic api 接口表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of magic_api_file
-- ----------------------------
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"fc09d5b985f44120956d5d4f9fbd3658\",\r\n  \"name\" : \"应用管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"0\",\r\n  \"path\" : \"lowcode\",\r\n  \"createTime\" : 1688627828353,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/接口生成/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/接口生成/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"3766b233e65047908e6ade58f6a91cef\",\r\n  \"name\" : \"接口生成\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"fc09d5b985f44120956d5d4f9fbd3658\",\r\n  \"path\" : \"generator\",\r\n  \"createTime\" : 1706837176932,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/接口生成/分页.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"72d2a17d7417416ab095d82cfb5114cd\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"3766b233e65047908e6ade58f6a91cef\",\r\n  \"name\" : \"分页\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1706843973047,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"page\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : null,\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.page(\"\"\"\r\n    select * from sys_gen \r\n    where 1=1\r\n    ?{tableName, and table_name like concat(\'%\',#{tableName},\'%\')}\r\n    ?{tableComment, and table_comment like concat(\'%\',#{tableComment},\'%\')}\r\n    order by update_time desc\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/接口生成/删除接口.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"836d46dce24045c78408f44db6dfda7d\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"3766b233e65047908e6ade58f6a91cef\",\r\n  \"name\" : \"删除接口\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1706843980275,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"delete/{id}\",\r\n  \"method\" : \"DELETE\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : null,\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport org.ssssssss.magicapi.core.service.MagicResourceService\r\n\r\nvar interfaceId = db.selectValue(\"\"\"select interface_id from sys_gen where id = #{id}\"\"\")\r\nif(interfaceId != null){\r\n    MagicResourceService.delete(interfaceId)\r\n}\r\n\r\nreturn db.table(\"sys_gen\").where().eq(\"id\",id).delete()');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/接口生成/接口生成.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"470d902b51e5466d899789de871a426f\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"3766b233e65047908e6ade58f6a91cef\",\r\n  \"name\" : \"接口生成\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1711505784847,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"execute\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport org.ssssssss.magicapi.core.model.Option;\r\nimport org.ssssssss.magicapi.core.model.ApiInfo;\r\nimport org.ssssssss.magicapi.core.model.Group;\r\nimport org.ssssssss.magicapi.core.service.MagicResourceService;\r\nimport log;\r\n\r\ninfo = info::json\r\nvar permissionPrefix = (info.modulePath + info.businessPath).replace(/^\\//,\'\').replace(/\\/\\//, \'/\').replace(\'/\', \':\')\r\n\r\n//创建组\r\nvar getGroup = (type) => {\r\n    var moduleGroup = MagicResourceService.tree(type).children.filter(it => {\r\n        return it.node.path == info.modulePath || it.node.path == info.modulePath.substring(1, info.modulePath.length())\r\n    })\r\n    if(moduleGroup.length == 0){\r\n        Group group = new Group();\r\n        group.setId(UUID.randomUUID().toString().replace(\'-\', \'\'));\r\n        group.setName(info.moduleName);\r\n        group.setPath(info.modulePath);\r\n        group.setParentId(\"0\");\r\n        group.setType(type)\r\n        MagicResourceService.saveGroup(group);\r\n        moduleGroup = group;\r\n    }else{\r\n        moduleGroup = moduleGroup[0].node\r\n    }\r\n    //创建功能组\r\n    var businessGroup = MagicResourceService.tree(type).children.filter(it => it.node.id == moduleGroup.id)[0].children.filter(it => {\r\n        return it.node.path == info.businessPath || it.node.path == info.businessPath.substring(1, info.businessPath.length())\r\n    })\r\n    if(businessGroup.length == 0){\r\n        Group group = new Group();\r\n        group.setId(UUID.randomUUID().toString().replace(\'-\', \'\'));\r\n        group.setName(info.businessName);\r\n        group.setPath(info.businessPath);\r\n        group.setParentId(moduleGroup.getId());\r\n        group.setType(type)\r\n        MagicResourceService.saveGroup(group);\r\n        businessGroup = group;\r\n    }else{\r\n        businessGroup = businessGroup[0].node\r\n    }\r\n\r\n    // 子表组\r\n    var subPath = \"/sub\"\r\n    var bGroup = MagicResourceService.tree(type).children.filter(it => it.node.id == moduleGroup.id)[0]\r\n    var subGroup = bGroup.children.filter(it => it.node.id == businessGroup.id )[0].children.filter(it =>{\r\n        return it.node.path == subPath || it.node.path == subPath.substring(1, subPath.length())\r\n    })\r\n    if(info.template == \"subTable\"){\r\n        if(subGroup.length == 0){\r\n            Group group = new Group();\r\n            group.setId(UUID.randomUUID().toString().replace(\'-\', \'\'));\r\n            group.setName(\"子表\");\r\n            group.setPath(\"/sub\");\r\n            group.setParentId(businessGroup.getId());\r\n            group.setType(type)\r\n            MagicResourceService.saveGroup(group);\r\n            subGroup = group;  \r\n        }else{\r\n            subGroup = subGroup[0].node\r\n        }\r\n    }\r\n\r\n    return {\r\n        moduleGroup,\r\n        businessGroup,\r\n        subGroup\r\n    }\r\n}\r\n//删除临时文件\r\nvar deleteFiles = (groupId, paths) => {\r\n    var listFiles = MagicResourceService.listFiles(groupId)\r\n    listFiles.forEach(it => {\r\n        if(paths.indexOf(it.path) != -1){\r\n            MagicResourceService.delete(it.id)\r\n        }\r\n    })\r\n}\r\n\r\nvar businessGroup = getGroup(\'api\').businessGroup\r\n//删除api接口\r\ndeleteFiles(businessGroup.getId(),[\'/list\', \'/save\', \'/get\', \'/delete\'])\r\n\r\ncolumns = columns::json\r\nvar listFields = columns.filter(it => it.list).map(it => it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()).join(\',\')\r\nvar wheres = \'\';\r\ncolumns.forEach(it => {\r\n    var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n    if(it.query){\r\n        if(it.where == \'in\'){\r\n            wheres += `    ?{${it.columnName}, and ${field} in(#{`+it.columnName+`.split(\',\')}) }\\n`\r\n        }else if(it.where == \'like\'){\r\n            wheres += `    ?{${it.columnName}, and ${field} like concat(\'%\',#{${it.columnName}},\'%\') }\\n`\r\n        }else{\r\n            wheres += `    ?{${it.columnName}, and ${field} ${it.where} #{${it.columnName}} }\\n`\r\n        }\r\n    }\r\n})\r\n//取得数据库的表信息\r\ndatasource = datasource || \'\'\r\nvar commonField = db[datasource].select(\"\"\"\r\n    SELECT\r\n        column_name\r\n    FROM\r\n        information_schema.COLUMNS\r\n    WHERE\r\n        table_name = #{tableName} AND column_name IN ( \'is_del\', \'create_by\', \'create_date\', \'update_by\', \'update_date\' ) AND table_schema = DATABASE()\r\n\"\"\")\r\ncommonField = commonField.map(it => it.columnName)\r\nvar primary = db[datasource].selectValue(\"SELECT column_name FROM information_schema.COLUMNS WHERE table_name = #{tableName} and column_key = \'PRI\' and table_schema = database() limit 1\")\r\nvar primaryLowerCamelCase = primary.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n\r\nvar logic = \'\'\r\nif(commonField.contains(\'is_del\')){\r\n    logic = \'.logic()\'\r\n    wheres += `    and is_del = 0\\n`\r\n}\r\nwheres = wheres.substring(0,wheres.length() - 1)\r\n\r\nvar datasourceScript = datasource ? `.${datasource}` : \'\';\r\n\r\n// 产生查询api接口\r\nApiInfo listApi = new ApiInfo()\r\nlistApi.setName(\"列表\")\r\nlistApi.setPath(\"/list\")\r\nlistApi.setMethod(\"GET\")\r\nlistApi.setGroupId(businessGroup.getId())\r\nlistApi.setScript(`return db${datasourceScript}.page(\"\"\"\r\nselect ${primary},${listFields} from ${tableName} where 1=1\r\n${wheres}\r\n\"\"\")`)\r\n// listApi.setOption([new Option(\'permission\', `${permissionPrefix}:view`, \'允许拥有该权限的访问\')])\r\nMagicResourceService.saveFile(listApi)\r\n\r\nvar saveMethod = \'save(data)\'\r\nif(commonField.size() >= 4){\r\n    saveMethod = \'saveOrUpdate(data)\'\r\n}\r\n\r\n//产生增册改查api接口\r\nvar insertFields = \'\';\r\ncolumns.forEach(it => {\r\n    var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n    insertFields += `, #{body.`+it.columnName+`}`\r\n})\r\n\r\nApiInfo saveApi = new ApiInfo()\r\nsaveApi.setName(\"保存\")\r\nsaveApi.setPath(\"/save\")\r\nsaveApi.setMethod(\"POST\")\r\nsaveApi.setGroupId(businessGroup.getId())\r\nsaveApi.setScript(`return db.insert(\"\"\"insert into ${tableName}(${primary},${listFields}) values (uuid() ${insertFields})\"\"\")`)\r\n// saveApi.setOption([new Option(\'wrap_request_parameter\', \'data\'), new Option(\'permission\', `${permissionPrefix}:save`, \'允许拥有该权限的访问\')])\r\nMagicResourceService.saveFile(saveApi)\r\n\r\n// 修改\r\nvar updateFields = \'\';\r\ncolumns.forEach(it => {\r\n    var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n    updateFields += `?{body.${it.columnName}, ,${field} = #{body.${it.columnName}}}\\n`\r\n})\r\nApiInfo updateApi = new ApiInfo()\r\nupdateApi.setName(\"修改\")\r\nupdateApi.setPath(\"/update\")\r\nupdateApi.setMethod(\"POST\")\r\nupdateApi.setGroupId(businessGroup.getId())\r\nupdateApi.setScript(`return db.update(\"\"\"update ${tableName} set \\n${primary} = #{body.${primary}}\\n ${updateFields} where ${primary} = #{body.${primary}}\"\"\")`)\r\n// updateApi.setOption([new Option(\'wrap_request_parameter\', \'data\'), new Option(\'permission\', `${permissionPrefix}:save`, \'允许拥有该权限的访问\')])\r\nMagicResourceService.saveFile(updateApi)\r\n\r\nApiInfo deleteApi = new ApiInfo()\r\ndeleteApi.setName(\"删除\")\r\ndeleteApi.setPath(\"/delete\")\r\ndeleteApi.setMethod(\"DELETE\")\r\ndeleteApi.setGroupId(businessGroup.getId())\r\ndeleteApi.setScript(`return db${datasourceScript}.table(\'${tableName}\')${logic}.where().eq(\'${primary}\', ${primaryLowerCamelCase}).delete()`)\r\n// deleteApi.setOption([new Option(\'permission\', `${permissionPrefix}:delete`, \'允许拥有该权限的访问\')])\r\nMagicResourceService.saveFile(deleteApi)\r\n\r\nvar saveFields = columns.filter(it => it.save).map(it => it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()).join(\',\')\r\n//产生单个行Api接口\r\nApiInfo getApi = new ApiInfo()\r\ngetApi.setName(\"详情\")\r\ngetApi.setPath(\"/get\")\r\ngetApi.setMethod(\"GET\")\r\ngetApi.setGroupId(businessGroup.getId())\r\ngetApi.setScript(`return db${datasourceScript}.selectOne(\"\"\"select ${saveFields} from ${tableName} where ${primary} = #{${primaryLowerCamelCase}}\"\"\")`)\r\n// getApi.setOption([new Option(\'permission\', `${permissionPrefix}:view`, \'允许拥有该权限的访问\')])\r\nMagicResourceService.saveFile(getApi)\r\n\r\n// 树列表接口\r\nif(info.template == \"tree\"){\r\n    ApiInfo treeApi = new ApiInfo()\r\n    treeApi.setName(\"树列表\")\r\n    treeApi.setPath(\"/tree\")\r\n    treeApi.setMethod(\"GET\")\r\n    treeApi.setGroupId(businessGroup.getId())\r\n    treeApi.setScript(`var toTree = (list,${info.treePid}) => select t.*,toTree(list,t.${info.treeId}) children from list t where t.${info.treePid} = ${info.treePid}\r\n        var list = toTree(db.select(\'select ${listFields} from ${datasourceScript?datasourceScript+\'.\':\'\'}${tableName}\'),\'0\')\r\n        return {\r\n            list: list,\r\n            total: list.getLength()\r\n        }\r\n    `)\r\n    // treeApi.setOption([new Option(\'permission\', `${permissionPrefix}:view`, \'允许拥有该权限的访问\')])\r\n    MagicResourceService.saveFile(treeApi)\r\n}\r\n\r\n// 主子表 api接口\r\nif(info.template == \"subTable\"){\r\n    var subGroup = getGroup(\'api\').subGroup\r\n    subColumns = subColumns::json\r\n    var subListFields = subColumns.filter(it => it.list).map(it => it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()).join(\',\')\r\n    var subWheres = \'\';\r\n    subColumns.forEach(it => {\r\n        var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n        if(it.query){\r\n            if(it.where == \'in\'){\r\n                subWheres += `?{${it.columnName}, and ${field} in(#{`+it.columnName+`.split(\',\')}) }\\n`\r\n            }else if(it.where == \'like\'){\r\n                subWheres += `?{${it.columnName}, and ${field} like concat(\'%\',#{${it.columnName}},\'%\') }\\n`\r\n            }else{\r\n                subWheres += `?{${it.columnName}, and ${field} ${it.where} #{${it.columnName}} }\\n`\r\n            }\r\n        }\r\n    })\r\n    var subPrimary = db[datasource].selectValue(\"SELECT column_name FROM information_schema.COLUMNS WHERE table_name = #{subTableName} and column_key = \'PRI\' and table_schema = database() limit 1\")\r\n    var subPrimaryLowerCamelCase = subPrimary.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n    var subLogic = \'\'\r\n    if(subListFields.contains(\'is_del\')){\r\n        subLogic = \'.logic()\'\r\n        subWheres += `    and is_del = 0\\n`\r\n    }\r\n    subWheres = subWheres.substring(0,subWheres.length() - 1)\r\n    \r\n    // 列表\r\n    ApiInfo subListApi = new ApiInfo()\r\n    subListApi.setName(\"列表\")\r\n    subListApi.setPath(\"/list\")\r\n    subListApi.setMethod(\"GET\")\r\n    subListApi.setGroupId(subGroup.getId())\r\n    subListApi.setScript(`return db${datasourceScript}.page(\"\"\"\r\n        select ${subListFields} from ${subTableName} where 1=1\r\n    ${subWheres}\r\n    \"\"\")`)\r\n    // subListApi.setOption([new Option(\'permission\', `${permissionPrefix}:view`, \'允许拥有该权限的访问\')])\r\n    MagicResourceService.saveFile(subListApi)\r\n\r\n    // 保存\r\n    var insertSubFields = \'\';\r\n    subColumns.forEach(it => {\r\n        var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n        insertSubFields += `, #{body.`+it.columnName+`}`\r\n    })\r\n    ApiInfo subSaveApi = new ApiInfo()\r\n    subSaveApi.setName(\"保存\")\r\n    subSaveApi.setPath(\"/save\")\r\n    subSaveApi.setMethod(\"POST\")\r\n    subSaveApi.setGroupId(subGroup.getId())\r\n    subSaveApi.setScript(`return db.insert(\"\"\"insert into ${subTableName}(${subPrimary},${subListFields}) values (uuid() ${insertSubFields})\"\"\")`)\r\n    // subSaveApi.setOption([new Option(\'wrap_request_parameter\', \'data\'), new Option(\'permission\', `${permissionPrefix}:save`, \'允许拥有该权限的访问\')])\r\n    MagicResourceService.saveFile(subSaveApi)\r\n\r\n    // 修改\r\n    var updateSubFields = \'\';\r\n    subColumns.forEach(it => {\r\n        var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n        updateSubFields += `?{body.${it.columnName}, ,${field} = #{body.${it.columnName}}}\\n`\r\n    })\r\n    ApiInfo subUpdateApi = new ApiInfo()\r\n    subUpdateApi.setName(\"修改\")\r\n    subUpdateApi.setPath(\"/update\")\r\n    subUpdateApi.setMethod(\"POST\")\r\n    subUpdateApi.setGroupId(subGroup.getId())\r\n    subUpdateApi.setScript(`return db.update(\"\"\"update ${subTableName} set \\n${subPrimary} = #{body.${subPrimary}}\\n ${updateSubFields} where ${subPrimary} = #{body.${subPrimary}}\"\"\")`)\r\n    // subUpdateApi.setOption([new Option(\'wrap_request_parameter\', \'data\'), new Option(\'permission\', `${permissionPrefix}:save`, \'允许拥有该权限的访问\')])\r\n    MagicResourceService.saveFile(subUpdateApi)\r\n\r\n    // 删除\r\n    ApiInfo subDeleteApi = new ApiInfo()\r\n    subDeleteApi.setName(\"删除\")\r\n    subDeleteApi.setPath(\"/delete\")\r\n    subDeleteApi.setMethod(\"DELETE\")\r\n    subDeleteApi.setGroupId(subGroup.getId())\r\n    subDeleteApi.setScript(`return db${datasourceScript}.table(\'${subTableName}\')${subLogic}.where().eq(\'${subPrimary}\', ${subPrimaryLowerCamelCase}).delete()`)\r\n    // subDeleteApi.setOption([new Option(\'permission\', `${permissionPrefix}:delete`, \'允许拥有该权限的访问\')])\r\n    MagicResourceService.saveFile(subDeleteApi)\r\n\r\n    var subSaveFields = subColumns.filter(it => it.save).map(it => it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()).join(\',\')\r\n    // 详情\r\n    ApiInfo subGetApi = new ApiInfo()\r\n    subGetApi.setName(\"详情\")\r\n    subGetApi.setPath(\"/get\")\r\n    subGetApi.setMethod(\"GET\")\r\n    subGetApi.setGroupId(subGroup.getId())\r\n    subGetApi.setScript(`return db${datasourceScript}.selectOne(\"\"\"select ${subPrimary},${subSaveFields} from ${subTableName} where ${subPrimary} = #{${subPrimaryLowerCamelCase}}\"\"\")`)\r\n    // subGetApi.setOption([new Option(\'permission\', `${permissionPrefix}:view`, \'允许拥有该权限的访问\')])\r\n    MagicResourceService.saveFile(subGetApi)\r\n}\r\n\r\nvar moduleGroup = getGroup(\'api\').moduleGroup\r\nreturn moduleGroup.id\r\n');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/接口生成/新增接口.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"0631fbe5d71c4a6990dc45bbcadd35e5\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"3766b233e65047908e6ade58f6a91cef\",\r\n  \"name\" : \"新增接口\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1706848294180,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.insert(\"\"\"\r\n    INSERT INTO `sys_gen` (`id`, `interface_id`,`data_source`, `table_name`, `table_comment`, `columns`, `sub_table_name`, `sub_table_comment`, `sub_columns`, `info`, `update_time`, `create_time`) \r\n    VALUES (uuid(),#{interfaceId},#{dataSource},#{tableName},#{tableComment},#{columns},#{subTableName},#{sub_tableComment},#{subColumns},#{info},now(),now())\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/接口生成/根据表查列.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"8a8899e6a39e442ca51d08db50067cc0\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"3766b233e65047908e6ade58f6a91cef\",\r\n  \"name\" : \"根据表查列\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1706848387714,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"columns\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.select(\"\"\"\r\n    SELECT column_name,column_comment,column_type,case when is_nullable = \'YES\' then 0 else 1 end required\r\n    FROM information_schema.COLUMNS \r\n    WHERE table_name = #{name}\r\n    AND column_name != \'id\'\r\n    AND table_schema = DATABASE()\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/接口生成/表列表.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"2274d01e99954f35bacde40c983db2f8\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"3766b233e65047908e6ade58f6a91cef\",\r\n  \"name\" : \"表列表\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1706843981698,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"tables\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : null,\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.select(\"\"\"\r\n    select table_schema,table_name,table_comment \r\n    from information_schema.tables \r\n    where table_schema = #{name}\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"name\" : \"页面管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"fc09d5b985f44120956d5d4f9fbd3658\",\r\n  \"path\" : \"lcPages\",\r\n  \"createTime\" : 1688627828384,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/保存.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"a3ec119d481146d8940e01a203a733a1\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"name\" : \"保存\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1712020971583,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.insert(\"\"\"\r\n    INSERT INTO lc_pages(`id`, `title`, `subtitle`, `parent_id`, `pageschema`, `status`, `creator_id`, `classify`, `update_time`, `create_time`, `remarks`) \r\n    VALUES \r\n    (uuid(), #{body.title},#{body.subtitle},#{body.parentId},#{body.pageschema},0,#{body.creatorId},#{body.classify},now(),now(),#{body.remarks})\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/修改.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"b63cac7294f94a74bdf5794f88679780\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"name\" : \"修改\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1712021004644,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"update\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.update(\"\"\"\r\n    update lc_pages set \r\n    update_time = now()\r\n    ?{body.title, ,`title` = #{body.title}}\r\n    ?{body.subtitle, ,`subtitle` = #{body.subtitle}}\r\n    ?{body.pageschema, ,`pageschema` = #{body.pageschema}}\r\n    ?{body.status, ,`status` = #{body.status}}\r\n    ?{body.parentId, ,`parent_id` = #{body.parentId}}\r\n    ?{body.creatorId, ,`creator_id` = #{body.creatorId}}\r\n    ?{body.classify, ,`classify` = #{body.classify}}\r\n    ?{body.remarks, ,`remarks` = #{body.remarks}}\r\n    where id = #{body.id}\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/分类管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/分类管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"2125a0c95fd0461bb41723c516b4d229\",\r\n  \"name\" : \"分类管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"path\" : \"classify\",\r\n  \"createTime\" : 1712020553642,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/分类管理/保存.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"c673f0c0287142148d6783ab416a2a76\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"2125a0c95fd0461bb41723c516b4d229\",\r\n  \"name\" : \"保存\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1712020875321,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.insert(\"\"\"\r\n    INSERT INTO `lc_pages_classify` (`id`, `parent_id`, `name`,`creator_id`,`update_time`, `create_time`,`remarks`) \r\n    values (uuid(),#{body.parentId},#{body.name},#{body.creatorId},now(), now(),#{body.remarks})\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/分类管理/修改.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"ad0191d21c834a068f9c601c74f13d9b\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"2125a0c95fd0461bb41723c516b4d229\",\r\n  \"name\" : \"修改\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1712027156763,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"update\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.update(\"\"\"\r\n    update lc_pages_classify set \r\n    update_time = now() \r\n    ?{body.parentId, ,`parent_id` = #{body.parentId}}\r\n    ?{body.name, ,`name` = #{body.name}}\r\n    ?{body.remarks, ,`remarks` = #{body.remarks}}\r\n    where id = #{body.id}\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/分类管理/列表.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"6d63eb2030ca456fa3aba1d976c4986a\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"2125a0c95fd0461bb41723c516b4d229\",\r\n  \"name\" : \"列表\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1712022873564,\r\n  \"lock\" : \"0\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"list\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar list = db.select(\"\"\"\r\n    select * \r\n    from lc_pages_classify\r\n    where 1 = 1\r\n    ?{name, and name = #{name}}\r\n\"\"\")\r\n\r\nif (list.length == 1) {\r\n    return list;\r\n}\r\nlist.filter(item => {\r\n    var arr = list.filter(child => item.id == child.parentId);\r\n    arr.length > 0 ? (item.children = arr) : false;\r\n    return item.parentId == \'0\';\r\n})\r\n\r\nreturn list.filter(item => item.parentId == \'0\');');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/分类管理/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"cf71ab8e4ff848e7aefa1c6eb4644e02\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"2125a0c95fd0461bb41723c516b4d229\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1712026703236,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"delete/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.transaction(()=>{\r\n    var row = db.table(\"lc_pages_classify\").where().eq(\"id\", id).delete();\r\n    if(row){\r\n        // 删除子集\r\n        db.table(\"lc_pages_classify\").where().eq(\"parent_id\", id).delete();\r\n    }\r\n    return row;\r\n});');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/分页.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"0b62bb303bc9442f8b0a9b0757d62c8c\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"name\" : \"分页\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1712020970046,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"page\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar list = db.page(\"\"\"\r\n    select p.*,GROUP_CONCAT(menu_id) as menu_ids\r\n    from lc_pages p\r\n    left join lc_pages_menu m on m.pages_id = p.id\r\n    where 1 = 1\r\n    ?{status != null, and status = #{status}}\r\n    ?{parentId, and parent_id = #{parentId}}\r\n    ?{creatorId, and creator_id = #{creatorId}}\r\n    ?{title, and title = #{title}}\r\n    ?{classify, and classify = #{classify}}\r\n    GROUP BY p.id\r\n    order by update_time desc\r\n\"\"\")\r\nreturn list');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"2bfd044cf07f42b4a9c1ce7402b8de4e\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : 1688627828397,\r\n  \"updateTime\" : 1688517379847,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"delete/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    db.table(\"lc_pages\").where().eq(\"id\", id).delete()\r\n    db.table(\"lc_pages_menu\").where().eq(\"pages_id\", id).delete()\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/批量删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"33fbeebccb774feaba2e5276843658e5\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"name\" : \"批量删除\",\r\n  \"createTime\" : 1688627828399,\r\n  \"updateTime\" : 1688517378271,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"batchDelete\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    for(item in body.ids){\r\n        db.table(\"lc_pages\").where().eq(\"id\", item).delete()\r\n        db.table(\"lc_pages_menu\").where().eq(\"pages_id\", item).delete()\r\n    }\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/根据ID获取页面信息.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"c39d0fa055c848a4b073f604e9cac7b7\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"name\" : \"根据ID获取页面信息\",\r\n  \"createTime\" : 1688627828402,\r\n  \"updateTime\" : 1688517376767,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"get/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.table(\"lc_pages\").where().eq(\"id\",id).selectOne()');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/根据菜单ID获取页面信息.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"ab48add7e308465fb5a77d7cb4c52218\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"name\" : \"根据菜单ID获取页面信息\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688697302675,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"pagesInfo/{menuId}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar info = db.selectOne(\"\"\"select * from lc_pages_menu where menu_id = #{menuId}\"\"\")\r\nif(info == null){\r\n     exit 500, \'该菜单未绑定页面!\'\r\n}\r\n\r\nreturn db.table(\"lc_pages\").where().eq(\"id\",info.pagesId).selectOne()');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/应用管理/页面管理/绑定菜单.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"6e26766b5468454ea95c2d856d8fb45f\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"469af969df9e4fe4bf2c70a9608a517e\",\r\n  \"name\" : \"绑定菜单\",\r\n  \"createTime\" : 1688627828409,\r\n  \"updateTime\" : 1688517366542,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"bindMenu\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    db.table(\"lc_pages_menu\").where().eq(\"pages_id\", body.id).delete()\r\n    if(body.menuIds){\r\n        for(item in body.menuIds){\r\n            db.table(\"lc_pages_menu\").where().eq(\"menu_id\", item).delete()\r\n            db.insert(\"\"\"insert into lc_pages_menu(pages_id,menu_id)values(#{body.id},#{item})\"\"\")\r\n        }\r\n    }\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统监控/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统监控/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"da560e6b25b844519c3ac1c34112e298\",\r\n  \"name\" : \"系统监控\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"0\",\r\n  \"path\" : \"monitor\",\r\n  \"createTime\" : 1688700280021,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统监控/在线用户.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"b2cd6dc8ddc84ec6bb3b66b9ee4ebee3\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"da560e6b25b844519c3ac1c34112e298\",\r\n  \"name\" : \"在线用户\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1708933795963,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"onlineUser\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport cn.dev33.satoken.stp.StpUtil;\r\nimport log;\r\n\r\nvar tokens = StpUtil.searchTokenValue(\"\", 0, -1, true).map(item => {return item.substring(item.lastIndexOf(\':\')+1,item.length())});\r\nlog.info(\"{}\",tokens)\r\nreturn db.page(\"\"\"\r\n    select * from sys_login_log\r\n    where token in (#{tokens})\r\n    ?{username, and username like concat(\'%\', #{username}, \'%\')}\r\n    ?{ip, and ip like concat(\'%\', #{ip}, \'%\')}\r\n    order by create_time desc\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统监控/操作日志.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"a890089249404ace83909a07caf072b4\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"da560e6b25b844519c3ac1c34112e298\",\r\n  \"name\" : \"操作日志\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688701069367,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"operLog\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.page(\"\"\"\r\n    select * from sys_oper_log\r\n    where 1 = 1\r\n    ?{username, and user_name like concat(\'%\', #{username}, \'%\')}\r\n    ?{ip, and ip like concat(\'%\', #{ip}, \'%\')}\r\n    order by create_time desc\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统监控/登录日志.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"bc0e3bef99ef41698c8a6157898d0869\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"da560e6b25b844519c3ac1c34112e298\",\r\n  \"name\" : \"登录日志\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688700847430,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"loginLog\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.page(\"\"\"\r\n    select * from sys_login_log\r\n    where 1 = 1\r\n    ?{username, and username like concat(\'%\', #{username}, \'%\')}\r\n    ?{ip, and ip like concat(\'%\', #{ip}, \'%\')}\r\n    order by create_time desc\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统监控/踢人.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"d52169146d8941139854d462852e4e2e\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"da560e6b25b844519c3ac1c34112e298\",\r\n  \"name\" : \"踢人\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688701260804,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"kick/{kick}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport \'cn.dev33.satoken.stp.StpUtil\';\r\n\r\nreturn StpUtil.logoutByTokenValue(token);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"acff5ad7aae64de2acb03e1d16a58ce2\",\r\n  \"name\" : \"系统管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"0\",\r\n  \"path\" : \"/system\",\r\n  \"createTime\" : 1688627065391,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/字典管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/字典管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"79b4851948504948ad76ca5310c94bfd\",\r\n  \"name\" : \"字典管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"acff5ad7aae64de2acb03e1d16a58ce2\",\r\n  \"path\" : \"dict\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688694277933,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/字典管理/保存.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"fd2d0d2447754c18ba57c68e8402647c\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"79b4851948504948ad76ca5310c94bfd\",\r\n  \"name\" : \"保存\",\r\n  \"createTime\" : 1688627065458,\r\n  \"updateTime\" : 1688517335971,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.insert(\"\"\"\r\n    INSERT INTO sys_dict(`id`, `parent_id`, `group_name`, `type`, `dic_value`, `dic_label`, `sort`, `text1`, `text2`, `text3`, `update_time`, `create_time`, `remarks`) \r\n    VALUES \r\n    (uuid(), #{body.parentId},#{body.groupName},#{body.type},#{body.dicValue},#{body.dicLabel},#{body.sort},#{body.text1},#{body.text2},#{body.text3},now(),now(),#{body.remarks})\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/字典管理/修改.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"35c262b4bd4e4cd29c3f852e5d487cbd\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"79b4851948504948ad76ca5310c94bfd\",\r\n  \"name\" : \"修改\",\r\n  \"createTime\" : 1688627065461,\r\n  \"updateTime\" : 1688517341169,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"update\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.update(\"\"\"\r\n    update sys_dict set \r\n    update_time = now()\r\n    ?{body.parentId, ,`parent_id` = #{body.parentId}}\r\n    ?{body.groupNme, ,`group_name` = #{body.groupName}}\r\n    ?{body.type, ,`type` = #{body.type}}\r\n    ?{body.dicValue, ,`dic_value` = #{body.dicValue}}\r\n    ?{body.dicLabel, ,`dic_label` = #{body.dicLabel}}\r\n    ?{body.sort, ,`sort` = #{body.sort}}\r\n    ?{body.text1, ,`text1` = #{body.text1}}\r\n    ?{body.text2, ,`text2` = #{body.text2}}\r\n    ?{body.text3, ,`text3` = #{body.text3}}\r\n    ?{body.remarks, ,`remarks` = #{body.remarks}}\r\n    where id = #{body.id}\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/字典管理/列表.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"42c28b72bc3e4560b407282a40737ba9\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"79b4851948504948ad76ca5310c94bfd\",\r\n  \"name\" : \"列表\",\r\n  \"createTime\" : 1688627065464,\r\n  \"updateTime\" : 1688517337704,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"list\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.select(\"\"\"\r\n    select d.* \r\n    from sys_dict d\r\n    where 1 = 1\r\n    ?{parentId, and parent_id = #{parentId}}\r\n    ?{groupName, and group_name = #{groupName}}\r\n    ?{dicValue, and dic_value = #{dicValue}}\r\n    order by sort\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/字典管理/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"4c658ae507574ce9a0503ac8fea346ae\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"79b4851948504948ad76ca5310c94bfd\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : 1688627065467,\r\n  \"updateTime\" : 1688517339291,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"delete/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    var list = db.select(\"\"\"\r\n        with recursive t as (	\r\n            select id from sys_dict where id = #{id}\r\n            union all\r\n            select a.id from sys_dict a \r\n            join t on a.parent_id = t.id\r\n        )\r\n        select id from t\r\n    \"\"\")\r\n\r\n    for(item in list){\r\n        db.table(\"sys_dict\").where().eq(\"id\", item.id).delete()\r\n    }\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/字典管理/字典树.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"45ee381e52c64cc9ad8263b1dfbe6709\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"79b4851948504948ad76ca5310c94bfd\",\r\n  \"name\" : \"字典树\",\r\n  \"createTime\" : 1688627065470,\r\n  \"updateTime\" : 1688517343301,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"tree\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar list = db.select(\"\"\"\r\n    select d.* \r\n    from sys_dict d\r\n    where 1 = 1\r\n    ?{parentId, and parent_id = #{parentId}}\r\n    ?{groupName, and group_name = #{groupName}}\r\n    ?{dicValue, and dic_value = #{dicValue}}\r\n    order by sort\r\n\"\"\")\r\n\r\nif (list.length == 1) {\r\n    return list;\r\n}\r\nlist.filter(item => {\r\n    var arr = list.filter(child => item.id == child.parentId);\r\n    arr.length > 0 ? (item.children = arr) : false;\r\n    return item.parentId == 0;\r\n})\r\n\r\nreturn list.filter(item => item.parentId == 0);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/安全/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/安全/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"1e5946084f1b47b5aea7fb8b2829c2cd\",\r\n  \"name\" : \"安全\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"acff5ad7aae64de2acb03e1d16a58ce2\",\r\n  \"path\" : \"auth\",\r\n  \"createTime\" : 1688628736494,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/安全/登出.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"80444160d7dd4f59991a792b1dafd4ab\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"1e5946084f1b47b5aea7fb8b2829c2cd\",\r\n  \"name\" : \"登出\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688634354515,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"logout\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport \'cn.dev33.satoken.stp.StpUtil\';\r\nStpUtil.logout();\r\nexit 200');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/安全/登录.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"60a768ae9748403dbcdf07e598511aa8\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"1e5946084f1b47b5aea7fb8b2829c2cd\",\r\n  \"name\" : \"登录\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688718639967,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"login\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ {\r\n    \"name\" : \"require_login\",\r\n    \"value\" : \"false\",\r\n    \"description\" : \"该接口需要登录才允许访问\",\r\n    \"required\" : false,\r\n    \"dataType\" : \"String\",\r\n    \"type\" : null,\r\n    \"defaultValue\" : null,\r\n    \"validateType\" : null,\r\n    \"error\" : null,\r\n    \"expression\" : null,\r\n    \"children\" : null\r\n  } ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport cn.dev33.satoken.stp.StpUtil;\r\nimport cn.hutool.http.useragent.UserAgentUtil;\r\nimport cn.hutool.http.useragent.UserAgent;\r\nimport com.tansci.utils.Sha256Util;\r\nimport com.tansci.utils.SystemUtils;\r\nimport com.tansci.model.CodeCacheMap;\r\nimport request;\r\n\r\nUserAgent ua = UserAgentUtil.parse(request.getHeaders(\"User-Agent\")[0])\r\n// 判断验证码\r\nif(!body.code || CodeCacheMap.get(body.code) != body.code){\r\n    exit 0, \'验证码有误，请重新获取！\'\r\n}\r\nCodeCacheMap.remove(body.code)\r\n\r\nvar user = db.table(\"sys_user\").where().eq(\"username\",body.username).selectOne();\r\nvar log = {\r\n    username: body.username,\r\n    type: \'成功\',\r\n    ip: request.getClientIP(),\r\n    browser: ua.getBrowser().toString(),\r\n    os: ua.getOs().toString(),\r\n    address: SystemUtils.getAddress(request.getClientIP()),\r\n    message: \'成功\'\r\n}\r\n\r\nif(!user || user.password != Sha256Util.getSHA256(body.password)){\r\n    log.failPassword = body.password\r\n    log.type = \'失败\'\r\n    log.message = \'用户名或密码错误\'\r\n    db.insert(\"\"\"\r\n        insert into sys_login_log(id,username,fail_password,type,browser,os,address,ip,message,create_time) values \r\n        (uuid(),#{log.username},#{log.failPassword},#{log.type},#{log.browser},#{log.os},#{log.address},#{log.ip},#{log.message},now())\r\n    \"\"\")    \r\n    exit 0,\'用户名或密码错误!\'\r\n}\r\n\r\nif(user.isLogin == 1){\r\n    log.type = \"失败\"\r\n    log.message = \"该账号已被禁用\"\r\n    db.insert(\"\"\"\r\n        insert into sys_login_log(id,username,fail_password,type,browser,os,address,ip,message,create_time) values \r\n        (uuid(),#{log.username},#{log.failPassword},#{log.type},#{log.browser},#{log.os},#{log.address},#{log.ip},#{log.message},now())\r\n    \"\"\")\r\n    exit 0,\'该账号已被禁用!\'\r\n}\r\n\r\nStpUtil.login(user.id)\r\nvar token = StpUtil.getTokenValueByLoginId(user.id)\r\nlog.token = token\r\ndb.insert(\"\"\"\r\n    insert into sys_login_log(id,username,fail_password,type,browser,os,address,ip,token,message,create_time) values \r\n    (uuid(),#{log.username},#{log.failPassword},#{log.type},#{log.browser},#{log.os},#{log.address},#{log.ip},#{log.token},#{log.message},now())\r\n\"\"\")\r\nreturn StpUtil.getTokenValueByLoginId(user.id)');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/安全/获取当前用户权限.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"7a1ae4380b62499b83b68312f821e8ef\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"1e5946084f1b47b5aea7fb8b2829c2cd\",\r\n  \"name\" : \"获取当前用户权限\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688712188050,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"permissions\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : null,\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport \'cn.dev33.satoken.stp.StpUtil\';\r\n\r\nvar userId = StpUtil.getLoginId()\r\nreturn db.select(\"\"\"\r\n    select DISTINCT m.permission \r\n    from sys_menu m\r\n    left join sys_role_menu rm on rm.menu_id = m.id\r\n    left join sys_user_role ur on ur.role_id = rm.role_id \r\n    where m.is_del = 0\r\n    and m.permission != \'\'\r\n    and m.permission IS NOT NULL\r\n    ?{userId && userId != \'1\', and ur.user_id = #{userId}}\r\n\"\"\").map((it) => {return it.permission})');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/安全/获取验证码.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"f1a4ad9f555c43d487773c175fbe5b9f\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"1e5946084f1b47b5aea7fb8b2829c2cd\",\r\n  \"name\" : \"获取验证码\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1708928493064,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"code\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ {\r\n    \"name\" : \"require_login\",\r\n    \"value\" : \"false\",\r\n    \"description\" : \"该接口需要登录才允许访问\",\r\n    \"required\" : false,\r\n    \"dataType\" : \"String\",\r\n    \"type\" : null,\r\n    \"defaultValue\" : null,\r\n    \"validateType\" : null,\r\n    \"error\" : null,\r\n    \"expression\" : null,\r\n    \"children\" : null\r\n  } ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : \"{\\n    \\\"code\\\": 500,\\n    \\\"message\\\": \\\"系统内部出现错误\\\",\\n    \\\"result\\\": null\\n}\",\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\n// 纯数字\r\nimport cn.hutool.captcha.CaptchaUtil;\r\nimport cn.hutool.captcha.LineCaptcha;\r\nimport cn.hutool.captcha.generator.RandomGenerator;\r\nimport java.io.ByteArrayOutputStream;\r\nimport java.io.OutputStream;\r\nimport com.tansci.model.CodeCacheMap;\r\n\r\nvar lineCaptcha = CaptchaUtil.createLineCaptcha(100, 60);\r\nlineCaptcha.setGenerator(new RandomGenerator(\"0123456789\", 4));\r\nCodeCacheMap.put(lineCaptcha.getCode(),lineCaptcha.getCode())\r\n\r\nOutputStream bOut = new ByteArrayOutputStream();\r\nlineCaptcha.write(bOut)\r\nreturn bOut.toByteArray()\r\n\r\n// 数字字母组合\r\n// import cn.hutool.captcha.CaptchaUtil;\r\n// import cn.hutool.captcha.LineCaptcha;\r\n// import java.io.ByteArrayOutputStream;\r\n// import java.io.OutputStream;\r\n// import com.tansci.model.CodeCacheMap;\r\n\r\n// var lineCaptcha = CaptchaUtil.createLineCaptcha(100, 60);\r\n// CodeCacheMap.put(lineCaptcha.getCode(),lineCaptcha.getCode())\r\n\r\n// OutputStream bOut = new ByteArrayOutputStream();\r\n// lineCaptcha.write(bOut)\r\n// return bOut.toByteArray()');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"b8fda8d83a3449cbacc8a1ee5e040ab8\",\r\n  \"name\" : \"工作流\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"acff5ad7aae64de2acb03e1d16a58ce2\",\r\n  \"path\" : \"work\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1742909385448,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/模型管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/模型管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"5ec3f09f11014fb3b108c89b6885218a\",\r\n  \"name\" : \"模型管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"b8fda8d83a3449cbacc8a1ee5e040ab8\",\r\n  \"path\" : \"model\",\r\n  \"createTime\" : 1742909403621,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/模型管理/修改.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"626ccce183a14523b50b363df2c8816b\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5ec3f09f11014fb3b108c89b6885218a\",\r\n  \"name\" : \"修改\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1743343719448,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"update\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.update(\"\"\"\r\n    update flow_model set \r\n    update_time = now()\r\n    ?{body.code, ,`code` = #{body.code}}\r\n    ?{body.name, ,`name` = #{body.name}}\r\n    ?{body.content, ,`content` = #{body.content}}\r\n    ?{body.taskId, ,`task_id` = #{body.taskId}}\r\n    ?{body.status, ,`status` = #{body.status}}\r\n    ?{body.remarks, ,`remarks` = #{body.remarks}}\r\n    where id = #{body.id}\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/模型管理/分页.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"2b5be8ee089a4f9f83c0faa1879232cf\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5ec3f09f11014fb3b108c89b6885218a\",\r\n  \"name\" : \"分页\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1742909452825,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"page\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.page(\"\"\"\r\n    select * from flow_model\r\n    where 1 = 1\r\n    ?{status != null , and status = #{status}}\r\n    ?{name , and name like concat(\'%\',#{name},\'%\')}\r\n    order by update_time desc \r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/模型管理/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"53fb519a3be9489989975af84b8878d5\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5ec3f09f11014fb3b108c89b6885218a\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1742909454687,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"delete/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.table(\"flow_model\").where().eq(\"id\", id).delete()');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/模型管理/新增.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"04e32ed909d44e0dadd93e51c6c22cfb\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5ec3f09f11014fb3b108c89b6885218a\",\r\n  \"name\" : \"新增\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1742910195992,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport \'cn.dev33.satoken.stp.StpUtil\';\r\n\r\nvar userId = StpUtil.getLoginId()\r\nreturn db.insert(\"\"\"\r\n    INSERT INTO flow_model(`id`, `code`, `name`, `content`, `status`, `create_by`, `update_time`, `create_time`, `remarks`) \r\n    VALUES (uuid(),#{body.code},#{body.name},#{body.content},0,#{userId},now(),now(),#{body.remarks})\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/模型管理/详情.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"ff40df477ac44402a079de10e9b8ef3d\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5ec3f09f11014fb3b108c89b6885218a\",\r\n  \"name\" : \"详情\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1742909456419,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"details\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.selectOne(\"\"\"\r\n    select * from flow_model where id = #{id}\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"流程管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"b8fda8d83a3449cbacc8a1ee5e040ab8\",\r\n  \"path\" : \"workflow\",\r\n  \"createTime\" : 1742910704023,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/任务列表.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"copy1743346708057d27976\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"任务列表\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1743346785768,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"taskList\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nreturn flowableService.taskList();');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/任务审批通过.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"copy1742910941772d263\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"任务审批通过\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1742910991392,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"approveTask\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nif(!body.taskId){\r\n    exit 500, \'请求参数有误！\';\r\n}\r\n\r\nreturn flowableService.approveTask(\r\n    body.taskId::string\r\n);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/任务被拒绝.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"copy1742910967305d92063\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"任务被拒绝\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1742910989741,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"rejectTask\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nif(!body.taskId){\r\n    exit 500, \'请求参数有误！\';\r\n}\r\n\r\nreturn flowableService.rejectTask(\r\n    body.taskId::string\r\n);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/删除正在运行的流程.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"copy1743346641682d80629\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"删除正在运行的流程\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1743346772692,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"deleteProcessInstance\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nif(!val1 || !val2){\r\n    exit 500, \'请求参数有误！\';\r\n}\r\n\r\nreturn flowableService.deleteProcessInstance(\r\n    val1::string,\r\n    val2::string,\r\n);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/删除流程.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"copy1743346606264d56690\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"删除流程\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1743346770977,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"deleteDeployment\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nif(!id){\r\n    exit 500, \'请求参数有误！\';\r\n}\r\n\r\nreturn flowableService.deleteDeployment(\r\n    id::string\r\n);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/启动流程.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"copy1742910840666d8340\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"启动流程\",\r\n  \"createTime\" : 1742910876719,\r\n  \"updateTime\" : 1742910994718,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"startProcessInstance\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nif(!body.processId){\r\n    exit 500, \'请求参数有误！\';\r\n}\r\n\r\nreturn flowableService.startProcessInstance(\r\n    body.processId::string\r\n);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/挂起流程.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"copy1743346586145d31739\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"挂起流程\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1743346769430,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"suspendProcess\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nif(!id){\r\n    exit 500, \'请求参数有误！\';\r\n}\r\n\r\nreturn flowableService.suspendProcess(\r\n    id::string\r\n);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/模型列表.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"copy1742910883850d24391\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"模型列表\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1743346762163,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"modelList\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nreturn flowableService.modelList();');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/流程定义.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"copy1743346466922d96978\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"流程定义\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1743346767414,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"processDefinitionList\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nreturn flowableService.processDefinitionList();');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/激活流程.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"f4adebe0f19e4c2a8e5af39f890bf974\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"激活流程\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1743346765823,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"activateProcess\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nif(!id){\r\n    exit 500, \'请求参数有误！\';\r\n}\r\n\r\nreturn flowableService.activateProcess(\r\n    id::string\r\n);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/工作流/流程管理/部署流程.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"576744c3f8994ca9a761fa7b608be940\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"5d2432706bca4d168ddd547cd5681807\",\r\n  \"name\" : \"部署流程\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1743346514657,\r\n  \"lock\" : \"0\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"deployProcess\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.service.FlowableService as flowableService;\r\n\r\nif(!body.name || !body.xml){\r\n    exit 500, \'请求参数有误！\';\r\n}\r\n\r\nreturn flowableService.deployProcess(\r\n    body.name::string,\r\n    body.xml::string\r\n);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/用户管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/用户管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"fc83134da85f4beaa18511d00d4ff661\",\r\n  \"name\" : \"用户管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"acff5ad7aae64de2acb03e1d16a58ce2\",\r\n  \"path\" : \"user\",\r\n  \"createTime\" : 1688627065423,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/用户管理/保存.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"6bdc64e2ac314291a4c6ee857edeb458\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fc83134da85f4beaa18511d00d4ff661\",\r\n  \"name\" : \"保存\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1708659604274,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport com.tansci.utils.Sha256Util;\r\n\r\nvar count = db.selectInt(\"\"\"select count(*) from sys_user where username = #{body.username}\"\"\")\r\nif(count > 0){\r\n    exit 500, \'用户名称已存在！\'\r\n}\r\n\r\nvar id = uuid();\r\nvar password = Sha256Util.getSHA256(body.password);\r\nvar row = db.insert(\"\"\"\r\n    INSERT INTO sys_user(`id`, `username`, `password`, `nickname`, `type`, `phone`,`avatar`,`gender`,`birthday`,`address`,`email`, `is_del`, `update_time`, `create_time`, `remarks`) \r\n    VALUES \r\n    (#{id}, #{body.username},#{password},#{body.nickname},#{body.type},#{body.phone},#{body.avatar},#{body.gender},#{body.birthday},#{body.address},#{body.email},0,now(),now(),#{body.remarks})\r\n\"\"\")\r\n\r\ndb.insert(\"\"\"insert into sys_user_role(user_id,role_id)values(#{id},#{body.roleId})\"\"\")\r\n\r\nreturn row');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/用户管理/修改.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"064dd0495efd4c3999e3236cd8f1f94b\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fc83134da85f4beaa18511d00d4ff661\",\r\n  \"name\" : \"修改\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688699586759,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"update\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar row = db.update(\"\"\"\r\n    update sys_user set \r\n    update_time = now()\r\n    ?{body.nickname, ,`nickname` = #{body.nickname}}\r\n    ?{body.type, ,`type` = #{body.type}}\r\n    ?{body.phone, ,`phone` = #{body.phone}}\r\n    ?{body.avatar, ,`avatar` = #{body.avatar}}\r\n    ?{body.gender, ,`gender` = #{body.gender}}\r\n    ?{body.birthday, ,`birthday` = #{body.birthday}}\r\n    ?{body.address, ,`address` = #{body.address}}\r\n    ?{body.email, ,`email` = #{body.email}}\r\n    ?{body.isDel != null, ,`is_del` = #{body.isDel}}\r\n    ?{body.isLogin != null, ,`is_login` = #{body.isLogin}}\r\n    ?{body.remarks, ,`remarks` = #{body.remarks}}\r\n    where id = #{body.id}\r\n\"\"\")\r\n\r\nif(body.roleId != null){\r\n    db.update(\"\"\"update sys_user_role set role_id = #{body.roleId} where user_id = #{body.id}\"\"\")\r\n}\r\n\r\nreturn row;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/用户管理/分页.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"396c586ab1a74de6aad78a0549d57952\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fc83134da85f4beaa18511d00d4ff661\",\r\n  \"name\" : \"分页\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1742627057580,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"page\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.page(\"\"\"\r\n    select u.*,ur.role_id\r\n    from sys_user u\r\n    left join sys_user_role ur on ur.user_id = u.id\r\n    where is_del = 0\r\n    ?{username , and username = #{username}}\r\n    ?{status != null , and status = #{status}}\r\n    ?{phone , and phone = #{phone}}\r\n    ?{nickname , and nickname like concat(\'%\',#{nickname},\'%\')}\r\n    order by update_time desc \r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/用户管理/列表.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"b2c3b55a5a2e4a23bfc7af17e6143b8f\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fc83134da85f4beaa18511d00d4ff661\",\r\n  \"name\" : \"列表\",\r\n  \"createTime\" : 1688627065488,\r\n  \"updateTime\" : 1688690611112,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"list\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.select(\"\"\"\r\n    select * from sys_user\r\n    where is_del = 0\r\n    ?{username , and username = #{username}}\r\n    ?{status != null , and status = #{status}}\r\n    ?{phone , and phone = #{phone}}\r\n    ?{name , and name like concat(\'%\',#{name},\'%\')}\r\n    order by update_time desc \r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/用户管理/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"8370e79fd2694d5f86085f0bd7a0efe8\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fc83134da85f4beaa18511d00d4ff661\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : 1688627065491,\r\n  \"updateTime\" : 1688517330950,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"delete/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    db.table(\"sys_user\").where().eq(\"id\", id).delete()\r\n    db.table(\"sys_user_role\").where().eq(\"user_id\", id).delete()\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/用户管理/详情.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"01cc62375d6c4a86b050d64e60cf5872\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fc83134da85f4beaa18511d00d4ff661\",\r\n  \"name\" : \"详情\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688720745924,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"info\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport cn.dev33.satoken.stp.StpUtil;\r\n\r\nvar userId = StpUtil.getLoginId();\r\nvar user = db.table(\"sys_user\").where().eq(\"id\", userId).selectOne();\r\nuser.authorities = db.select(\"\"\"\r\n    select DISTINCT m.permission \r\n    from sys_menu m\r\n    left join sys_role_menu rm on rm.menu_id = m.id\r\n    left join sys_user_role ur on ur.role_id = rm.role_id \r\n    where m.is_del = 0\r\n    and m.permission != \'\'\r\n    and m.permission IS NOT NULL\r\n    ?{userId && userId != \'1\', and ur.user_id = #{userId}}\r\n\"\"\").map((it) => {return it.permission})\r\nreturn user;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/组织管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/组织管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"125a5f6a629d4afdbeca4cd45d3457fe\",\r\n  \"name\" : \"组织管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"acff5ad7aae64de2acb03e1d16a58ce2\",\r\n  \"path\" : \"org\",\r\n  \"createTime\" : 1688627065434,\r\n  \"updateTime\" : 1688634824150,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/组织管理/保存.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"ffb91faa7d574362ab4e6caf5ee5ea59\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"125a5f6a629d4afdbeca4cd45d3457fe\",\r\n  \"name\" : \"保存\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688690620885,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar code = uuid().substring(10)\r\nreturn db.insert(\"\"\"\r\n    INSERT INTO sys_org(`id`, `parent_id`, `name`, `code`, `sort`, `is_del`, `update_time`, `create_time`, `remarks`) \r\n    VALUES \r\n    (uuid(), #{body.parentId},#{body.name},#{code},#{body.sort},0,now(),now(),#{body.remarks})\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/组织管理/修改.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"3f8916b149cb447688ae10594819b807\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"125a5f6a629d4afdbeca4cd45d3457fe\",\r\n  \"name\" : \"修改\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688690626789,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"update\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.update(\"\"\"\r\n    update sys_org set \r\n    update_time = now()\r\n    ?{body.parentId, ,`parent_id` = #{body.parentId}}\r\n    ?{body.name, ,`name` = #{body.name}}\r\n    ?{body.code, ,`code` = #{body.code}}\r\n    ?{body.sort, ,`sort` = #{body.sort}}\r\n    ?{body.is_del, ,`is_del` = #{body.is_del}}\r\n    ?{body.remarks, ,`remarks` = #{body.remarks}}\r\n    where id = #{body.id}\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/组织管理/列表.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"fcec72133bc249cd8174de03e9e393ed\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"125a5f6a629d4afdbeca4cd45d3457fe\",\r\n  \"name\" : \"列表\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688700062821,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"list\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport \'cn.dev33.satoken.stp.StpUtil\';\r\n\r\nvar userId = StpUtil.getLoginId();\r\n\r\nvar list = db.select(\"\"\"\r\n    select DISTINCT * from (\r\n        with recursive t as (	\r\n            select * from sys_org \r\n            where 1 = 1\r\n            ?{userId && userId != 1, and id = (\r\n                    select ro.org_id\r\n                    from sys_user u\r\n                    left join sys_user_role ur on u.id = ur.user_id\r\n                    left join sys_role_org ro on ur.role_id = ro.role_id \r\n                    where u.id = #{userId}\r\n                )\r\n            }\r\n            union all\r\n            select a.* from sys_org a \r\n            join t on a.parent_id = t.id\r\n        )\r\n        select t.* from t\r\n    ) o\r\n\"\"\")\r\n\r\nif (list.length == 1) {\r\n    return list;\r\n}\r\nlist.filter(item => {\r\n    var arr = list.filter(child => item.id == child.parentId);\r\n    arr.length > 0 ? (item.children = arr) : false;\r\n    return item.parentId == 0;\r\n})\r\n\r\nreturn list.filter(item => item.parentId == 0);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/组织管理/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"9bf5a6729ad345b1b79eddd263dc84af\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"125a5f6a629d4afdbeca4cd45d3457fe\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688690624815,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"delete/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    var list = db.select(\"\"\"\r\n        with recursive t as (	\r\n            select id from sys_org where id = #{id}\r\n            union all\r\n            select a.id from sys_org a \r\n            join t on a.parent_id = t.id\r\n        )\r\n        select id from t\r\n    \"\"\")\r\n\r\n    for(item in list){\r\n        db.table(\"sys_org\").where().eq(\"id\", item.id).delete()\r\n    }\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/菜单管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/菜单管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"67b2ce258e24491194b74992958c74aa\",\r\n  \"name\" : \"菜单管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"acff5ad7aae64de2acb03e1d16a58ce2\",\r\n  \"path\" : \"/menu\",\r\n  \"createTime\" : 1688627065445,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/菜单管理/保存.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"cb156d8c8c38401eb8405ddb80de2d30\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"67b2ce258e24491194b74992958c74aa\",\r\n  \"name\" : \"保存\",\r\n  \"createTime\" : 1688627065511,\r\n  \"updateTime\" : 1688517299257,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.insert(\"\"\"\r\n    INSERT INTO sys_menu(`id`, `parent_id`, `name`, `url`, `icon`, `chinese_name`, `english_name`, `permission`, `sort`, `component`, `component_type`, `open_mode`, `is_del`, `keep_alive`, `is_show`, `update_time`, `create_time`, `remarks`) \r\n    VALUES \r\n    (uuid(), #{body.parentId},#{body.name},#{body.url},#{body.icon},#{body.chineseName},#{body.englishName},#{body.permission},#{body.sort},#{body.component},#{body.componentType},#{body.openMode},0,#{body.keepAlive},#{body.isShow},now(),now(),#{body.remarks})\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/菜单管理/修改.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"30ec3c62eca74e5695f2f96ddd6c1e10\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"67b2ce258e24491194b74992958c74aa\",\r\n  \"name\" : \"修改\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1708928338654,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"update\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.update(\"\"\"\r\n    update sys_menu set \r\n    update_time = now()\r\n    ?{body.parentId, ,`parent_id` = #{body.parentId}}\r\n    ?{body.name, ,`name` = #{body.name}}\r\n    ?{body.url, ,`url` = #{body.url}}\r\n    ?{body.icon, ,`icon` = #{body.icon}}\r\n    ?{body.chineseName, ,`chinese_name` = #{body.chineseName}}\r\n    ?{body.englishName, ,`english_name` = #{body.englishName}}\r\n    ?{body.permission, ,`permission` = #{body.permission}}\r\n    ?{body.sort != null, ,`sort` = #{body.sort}}\r\n    ?{body.component, ,`component` = #{body.component}}\r\n    ?{body.componentType != null, ,`component_type` = #{body.componentType}}\r\n    ?{body.openMode != null, ,`open_mode` = #{body.openMode}}\r\n    ?{body.isDel != null, ,`is_del` = #{body.isDel}}\r\n    ?{body.keepAlive != null, ,`keep_alive` = #{body.keepAlive}}\r\n    ?{body.isShow != null, ,`is_show` = #{body.isShow}}\r\n    ?{body.remarks, ,`remarks` = #{body.remarks}}\r\n    where id = #{body.id}\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/菜单管理/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"26ff3d166de34575a3bf6d41465c80e7\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"67b2ce258e24491194b74992958c74aa\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : 1688627065524,\r\n  \"updateTime\" : 1688517304774,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"delete/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    var list = db.select(\"\"\"\r\n        with recursive t as (	\r\n            select id from sys_menu where id = #{id}\r\n            union all\r\n            select a.id from sys_menu a \r\n            join t on a.parent_id = t.id\r\n        )\r\n        select id from t\r\n    \"\"\")\r\n\r\n    for(item in list){\r\n        db.table(\"sys_menu\").where().eq(\"id\", item.id).delete()\r\n        db.table(\"sys_role_menu\").where().eq(\"menu_id\", item.id)\r\n    }\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/菜单管理/菜单树.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"f90132707c3e401c926eaf2ada6ec81a\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"67b2ce258e24491194b74992958c74aa\",\r\n  \"name\" : \"菜单树\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688721005404,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"tree\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport \'cn.dev33.satoken.stp.StpUtil\';\r\n\r\nvar userId = StpUtil.getLoginId();\r\n\r\nvar menus = db.select(\"\"\"\r\n    select m.* \r\n    from sys_menu m\r\n    where m.is_del = 0\r\n    ?{isShow  != null, and m.is_show = #{isShow}}\r\n    ?{userId && userId != 1, and m.id in (\r\n        select rm.menu_id \r\n        from sys_role_menu rm\r\n        left join sys_user_role ur on ur.role_id = rm.role_id\r\n        where ur.user_id = #{userId})\r\n    }\r\n    order by sort asc\r\n\"\"\")\r\n\r\nif (menus.length == 1) {\r\n    return menus;\r\n}\r\nmenus.filter(item => {\r\n    var arr = menus.filter(child => item.id == child.parentId);\r\n    arr.length > 0 ? (item.children = arr) : false;\r\n    return item.parentId == 0;\r\n})\r\n\r\nreturn menus.filter(item => item.parentId == 0);');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/菜单管理/菜单路由.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"62020bd7a49949378e90ce2d14fef8f7\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"67b2ce258e24491194b74992958c74aa\",\r\n  \"name\" : \"菜单路由\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1689229170425,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"menus\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport \'cn.dev33.satoken.stp.StpUtil\';\r\n\r\nvar userId = StpUtil.getLoginId();\r\n\r\nvar list = db.select(\"\"\"\r\n    select m.* \r\n    from sys_menu m\r\n    where m.is_del = 0\r\n    and m.is_show = 1\r\n    ?{userId && userId != 1, and m.id in (\r\n        select rm.menu_id \r\n        from sys_role_menu rm\r\n        left join sys_user_role ur on ur.role_id = rm.role_id\r\n        where ur.user_id = #{userId})\r\n    }\r\n    order by sort asc\r\n\"\"\")\r\n\r\nvar menus = []\r\nlist.each(item => {\r\n    menus.push({\r\n        id: item.id,\r\n        parentId: item.parentId,\r\n        path: item.url,\r\n        name: item.name,\r\n        icon: item.icon,\r\n        sort: item.sort,\r\n        component: item.component == null || item.component == \'\' ? \"Layout\" : item.component,\r\n        componentType: item.componentType,\r\n        isShow: item.isShow,\r\n        meta: {\r\n            title: item.chineseName,\r\n            keepAlive: item.keepAlive,\r\n            isShow: item.isShow,\r\n            id: item.id,\r\n            openMode: item.openMode,\r\n            type: item.componentType,\r\n        }\r\n    })\r\n})\r\n\r\nif (menus.length == 1) {\r\n    return menus;\r\n}\r\nmenus.filter(item => {\r\n    var arr = menus.filter(child => item.id == child.parentId);\r\n    arr.length > 0 ? (item.children = arr) : false;\r\n    return item.parentId == 0;\r\n})\r\n\r\nvar _menus = menus.filter(item => item.parentId == 0);\r\n_menus.each(item=>{\r\n    if(!item.children){\r\n        item.children = [{\r\n            id: item.id,\r\n            parentId: item.parentId,\r\n            path: item.path,\r\n            name: item.name,\r\n            icon: item.icon,\r\n            sort: item.sort,\r\n            component: item.component,\r\n            componentType: item.componentType,\r\n            isShow: item.isShow,\r\n            meta: item.meta\r\n        }]\r\n        item.componentType = 0;\r\n    }\r\n})\r\n\r\n\r\nreturn _menus;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"角色管理\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"acff5ad7aae64de2acb03e1d16a58ce2\",\r\n  \"path\" : \"role\",\r\n  \"createTime\" : 1688627065453,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/保存.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"963fbdab7f1e4c5482d94467994e076b\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"保存\",\r\n  \"createTime\" : 1688627065553,\r\n  \"updateTime\" : 1688517313199,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar code = uuid().substring(0,10)\r\nreturn db.insert(\"\"\"\r\n    INSERT INTO sys_role(`id`, `name`, `code`, `permission`, `sort`, `is_del`, `creator`, `update_time`, `create_time`, `remarks`) \r\n    VALUES \r\n    (uuid(), #{body.name},#{code},#{body.permission},#{body.sort},0,#{body.creator},now(),now(),#{body.remarks})\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/修改.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"62c0822e34124adcb52c79d9f2e128f3\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"修改\",\r\n  \"createTime\" : 1688627065559,\r\n  \"updateTime\" : 1688517323756,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"update\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.update(\"\"\"\r\n    update sys_role set \r\n    update_time = now()\r\n    ?{body.name, ,`name` = #{body.name}}\r\n    ?{body.code, ,`code` = #{body.code}}\r\n    ?{body.sort, ,`sort` = #{body.sort}}\r\n    ?{body.is_del, ,`is_del` = #{body.is_del}}\r\n    ?{body.permission, ,`permission` = #{body.permission}}\r\n    ?{body.remarks, ,`remarks` = #{body.remarks}}\r\n    where id = #{body.id}\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/分页.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"d8a1114e2da54d7c857d4c54d5bc5880\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"分页\",\r\n  \"createTime\" : 1688627065564,\r\n  \"updateTime\" : 1688517316978,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"page\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.page(\"\"\"\r\n    select * from sys_role\r\n    where is_del = 0\r\n    ?{code , and code = #{code}}\r\n    ?{name , and name like concat(\'%\',#{name},\'%\')}\r\n    order by sort \r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/列表.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"71851668125c451f9e322f0c5f7828a8\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"列表\",\r\n  \"createTime\" : 1688627065570,\r\n  \"updateTime\" : 1688517320177,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"list\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.select(\"\"\"\r\n    select * from sys_role\r\n    where is_del = 0\r\n    ?{code , and code = #{code}}\r\n    ?{name , and name like concat(\'%\',#{name},\'%\')}\r\n    order by sort \r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"f3450863db7c4600b8fb199e5c07eaec\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688698546137,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"delete/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    db.table(\"sys_role\").where().eq(\"id\", id).delete()\r\n    db.table(\"sys_role_menu\").where().eq(\"role_id\", id).delete()\r\n    db.table(\"sys_user_role\").where().eq(\"role_id\", id).delete()\r\n    db.table(\"sys_user_org\").where().eq(\"role_id\", id).delete()\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/数据权限.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"06ca5c4e8ce04fbc85bece6274208bec\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"数据权限\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688698471253,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"dataPermissions\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    db.table(\"sys_role_org\").where().eq(\"role_id\", body.id).delete()\r\n\r\n    for(item in body.orgIds){\r\n        db.insert(\"\"\"INSERT INTO sys_role_org (role_id,org_id) VALUES (#{body.id}, #{item})\"\"\")\r\n    }\r\n\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/获取权限组织.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"9ea9a1c0a8a24a6e9e9b584c87d94a28\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"获取权限组织\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1688698474013,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"orgList/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport \'@get:/system/org/list\' as getOrg;\r\n\r\nvar list = db.select(\"\"\"select * from sys_role_org where role_id = #{id}\"\"\");\r\nvar selected = list.map((item) =>{\r\n    return item.orgId\r\n})\r\nreturn {\r\n    list: getOrg(),\r\n    selected: selected\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/获取权限菜单.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"95c1495b484e4f06ab5f1399e45fb643\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"获取权限菜单\",\r\n  \"createTime\" : 1688627065578,\r\n  \"updateTime\" : 1688517318645,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"menuList/{id}\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport \'@get:/system/menu/tree\' as getTree;\r\n\r\nvar list = db.select(\"\"\"select * from sys_role_menu where role_id = #{id}\"\"\");\r\n\r\nvar ids = list.map((item) =>{\r\n    return item.menuId\r\n})\r\n\r\nreturn {\r\n    list: getTree(),\r\n    selected: ids\r\n}');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/api/系统管理/角色管理/菜单权限.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"e6b1376d15e44edea70becac58caeb35\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"e3e7b79651ef4023bf808869bda70162\",\r\n  \"name\" : \"菜单权限\",\r\n  \"createTime\" : 1688627065583,\r\n  \"updateTime\" : 1688517315336,\r\n  \"lock\" : \"1\",\r\n  \"createBy\" : null,\r\n  \"updateBy\" : \"admin\",\r\n  \"path\" : \"menuPermissions\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nvar val = db.transaction(()=>{\r\n    db.table(\"sys_role_menu\").where().eq(\"role_id\", body.id).delete()\r\n\r\n    for(item in body.menuIds){\r\n        db.insert(\"\"\"INSERT INTO sys_role_menu (role_id,menu_id) VALUES (#{body.id}, #{item})\"\"\")\r\n    }\r\n\r\n    return \"OK\"\r\n});\r\n\r\nreturn val;');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/datasource/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/tansci-api/function/', 'this is directory');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键id',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '父ID',
  `group_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分组名称',
  `type` int NULL DEFAULT NULL COMMENT '类型：0、系统，1、业务',
  `dic_value` int NOT NULL COMMENT '值',
  `dic_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `text1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预留字段1',
  `text2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预留字段2',
  `text3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预留字段3',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `group_name`(`group_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('3048f7228cf80e7f366b60f7138ce1ef', '46de04fc892b613abe4a5ecb88f4cd47', 'oper_log_status', 1, 0, '成功', 1, NULL, NULL, NULL, '2023-04-14 14:41:26', '2023-04-14 10:36:18', '操作成功');
INSERT INTO `sys_dict` VALUES ('3292493cc1195fc6ad1934e19d4bab2f', '7afe0187e05ce3465c810a49331babc8', 'user_type', 1, 1, '管理员', 1, NULL, NULL, NULL, '2023-04-14 15:40:40', '2023-04-14 15:40:40', '管理员');
INSERT INTO `sys_dict` VALUES ('402ab9a354ff5f9de90adb9e9afb33fb', '0', 'user_gender', 1, -1, '用户性别', 0, NULL, NULL, NULL, '2023-04-14 15:39:38', '2023-04-14 15:39:38', '用户性别');
INSERT INTO `sys_dict` VALUES ('46de04fc892b613abe4a5ecb88f4cd47', '0', 'oper_log_status', 1, -1, '操作日志状态', 0, NULL, NULL, NULL, '2023-04-14 10:35:49', '2023-04-14 10:35:49', '操作日志状态');
INSERT INTO `sys_dict` VALUES ('504f58ac31fd50cd0f250d4bd165bf0b', '0', 'business_type', 0, -1, '业务类型', 0, NULL, NULL, NULL, '2023-04-14 15:34:37', '2023-04-14 15:34:37', '业务类型');
INSERT INTO `sys_dict` VALUES ('565a9c6f24904ec7a4f084fa96c5434b', '7afe0187e05ce3465c810a49331babc8', 'user_type', 1, 2, '普通用户', 2, NULL, NULL, NULL, '2023-04-14 15:41:07', '2023-04-14 15:41:07', '普通用户');
INSERT INTO `sys_dict` VALUES ('7afe0187e05ce3465c810a49331babc8', '0', 'user_type', 1, -1, '用户类型', 0, NULL, NULL, NULL, '2023-04-14 15:39:15', '2023-04-14 15:39:15', '用户类型');
INSERT INTO `sys_dict` VALUES ('ba3ed2cc3a8c450f8a150ee5bbb09abe', '46de04fc892b613abe4a5ecb88f4cd47', 'oper_log_status', 1, 1, '失败', 2, NULL, NULL, NULL, '2023-04-14 14:41:31', '2023-04-14 10:36:43', '操作失败');
INSERT INTO `sys_dict` VALUES ('bd4b42486c1b522b07cec0d870834952', '402ab9a354ff5f9de90adb9e9afb33fb', 'user_gender', 1, 1, '女', 2, NULL, NULL, NULL, '2023-04-14 15:41:57', '2023-04-14 15:41:57', '女');
INSERT INTO `sys_dict` VALUES ('bf5d5e35-0d72-11f0-8434-4ccc6a2e3718', '0', 'model_status', 1, -1, '流程模型状态', 0, NULL, NULL, NULL, '2025-03-30 22:24:53', '2025-03-30 22:24:53', '流程模型状态');
INSERT INTO `sys_dict` VALUES ('c7d736d70f722d15bebe282f4bd317d5', '504f58ac31fd50cd0f250d4bd165bf0b', 'business_type', 0, 1, '业务', 1, NULL, NULL, NULL, '2023-04-14 15:35:36', '2023-04-14 15:35:36', '');
INSERT INTO `sys_dict` VALUES ('ca22496d-0d72-11f0-8434-4ccc6a2e3718', 'bf5d5e35-0d72-11f0-8434-4ccc6a2e3718', 'model_status', 1, 0, '未部署', 0, NULL, NULL, NULL, '2025-03-30 22:25:11', '2025-03-30 22:25:11', '');
INSERT INTO `sys_dict` VALUES ('d3a9d955-0d72-11f0-8434-4ccc6a2e3718', 'bf5d5e35-0d72-11f0-8434-4ccc6a2e3718', 'model_status', 1, 1, '已部署', 1, NULL, NULL, NULL, '2025-03-30 22:25:27', '2025-03-30 22:25:27', '');
INSERT INTO `sys_dict` VALUES ('df5903139958429ed65ee82424d69b1b', '402ab9a354ff5f9de90adb9e9afb33fb', 'user_gender', 1, 0, '男', 1, NULL, NULL, NULL, '2023-04-14 15:41:44', '2023-04-14 15:40:09', '男');
INSERT INTO `sys_dict` VALUES ('f60b86ff25cc5261dafdffdf78b590db', '504f58ac31fd50cd0f250d4bd165bf0b', 'business_type', 0, 0, '系统', 1, NULL, NULL, NULL, '2023-04-14 15:35:23', '2023-04-14 15:35:23', '');

-- ----------------------------
-- Table structure for sys_gen
-- ----------------------------
DROP TABLE IF EXISTS `sys_gen`;
CREATE TABLE `sys_gen`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `interface_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接口编码',
  `data_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '数据源',
  `table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表名',
  `table_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表注释',
  `columns` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '字段信息json',
  `sub_table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字表名称',
  `sub_table_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表注释',
  `sub_columns` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '子表字段信息json',
  `info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '生成信息json',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '生成表信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_gen
-- ----------------------------

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录账号',
  `fail_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '失败密码',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '登录类型（成功、失败）',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '浏览器',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作系统',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地理位置',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'token',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '失败原因',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单链接',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
  `chinese_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '中文名称',
  `english_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '英文名称',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件名称',
  `component_type` int NULL DEFAULT 0 COMMENT '组件类型：0、默认，1、amis',
  `open_mode` int NULL DEFAULT 0 COMMENT '打开方式：0、默认，1、iframe，2、新标签页',
  `is_del` int NULL DEFAULT 0 COMMENT '是否删除：0、未删除，1、已删除',
  `keep_alive` int NULL DEFAULT NULL COMMENT '是否缓存：0、不缓存，1、缓存',
  `is_show` int NULL DEFAULT NULL COMMENT '是否显示：1显示，0不显示',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('02470e78-c178-11ee-a758-e0be038740d4', 'b25838d6e06c6cdad82c1ad9b1096f26', 'codeGen', '/lowcode/CodeGen', 'FolderRemove', '接口生成', 'APIGeneration', NULL, 2, NULL, 0, 0, 0, 1, 1, '2024-02-02 11:06:07', '2024-02-02 11:06:07', '');
INSERT INTO `sys_menu` VALUES ('06936eec3258c1fa675c8b6b697160f5', '1ec1c1cb127d83f6346904220b3ed20b', '', '', '', '列表', '', 'dict:list', 0, '', 0, 0, 0, 0, 0, '2023-04-13 16:26:51', '2023-04-13 16:26:51', '');
INSERT INTO `sys_menu` VALUES ('07e1aebb5b69b55b7eb0ce79fed00f40', 'b1851d1b13594e71840103c11a37a004', '', '', '', '列表', '', 'org:list', 3, '', 0, 0, 0, 0, 0, '2023-04-13 10:35:47', '2023-04-13 10:35:47', '');
INSERT INTO `sys_menu` VALUES ('0a59255aac53f421613c4d8516fcc305', '1cda1e6f35077cb1f89007fa36343a3d', '', '', '', '保存', '', 'pages:save', 0, NULL, 0, 0, 0, 0, 0, '2023-05-11 11:16:50', '2023-05-11 11:16:50', '');
INSERT INTO `sys_menu` VALUES ('0e769d6164cff598ae7215c99849bd1c', '1cda1e6f35077cb1f89007fa36343a3d', '', '', '', '删除', '', 'pages:delete', 2, NULL, 0, 0, 0, 0, 0, '2023-05-11 11:17:35', '2023-05-11 11:17:35', '');
INSERT INTO `sys_menu` VALUES ('11107c717306bd0d9e993cf32a94974e', 'b1851d1b13594e71840103c11a37a006', '', '', '', '删除', '', 'user:delete', 3, NULL, 0, 0, 0, 0, 0, '2023-04-13 11:34:29', '2023-04-13 11:34:29', NULL);
INSERT INTO `sys_menu` VALUES ('120d967459a9e7323692b3fa49c1ba59', '0', 'monitor', '/monitor', 'Odometer', '系统监控', 'Monitor', NULL, 4, NULL, 0, 0, 0, 1, 1, '2025-03-22 10:21:17', '2023-04-14 08:44:27', '');
INSERT INTO `sys_menu` VALUES ('1cda1e6f35077cb1f89007fa36343a3d', 'b25838d6e06c6cdad82c1ad9b1096f26', 'lcPages', '/lowcode/LcPages', 'Ticket', '页面管理', 'LcPages', NULL, 1, NULL, 0, 0, 0, 1, 1, '2023-07-07 17:07:55', '2023-05-11 10:52:58', '');
INSERT INTO `sys_menu` VALUES ('1ec1c1cb127d83f6346904220b3ed20b', 'b1851d1b13594e71840103c11a37a002', 'dict', '/system/Dict', 'Coin', '字典管理', 'Dist', NULL, 5, NULL, 0, 0, 0, 0, 1, '2023-04-13 16:26:19', '2023-04-13 16:26:19', NULL);
INSERT INTO `sys_menu` VALUES ('2a3d3641-c178-11ee-a758-e0be038740d4', '02470e78-c178-11ee-a758-e0be038740d4', '', '', '', '保存', '', 'generator:save', 0, NULL, 0, 0, 0, 0, 0, '2024-02-02 11:07:14', '2024-02-02 11:07:14', '');
INSERT INTO `sys_menu` VALUES ('37536b9d-c178-11ee-a758-e0be038740d4', '02470e78-c178-11ee-a758-e0be038740d4', '', '', '', '修改', '', 'generator:update', 1, NULL, 0, 0, 0, 0, 0, '2024-02-02 11:07:36', '2024-02-02 11:07:36', '');
INSERT INTO `sys_menu` VALUES ('3afbad18e475a7f7a4aeec6ab6e6c0fc', '1cda1e6f35077cb1f89007fa36343a3d', '', '', '', '修改', '', 'pages:update', 1, NULL, 0, 0, 0, 0, 0, '2023-05-11 11:17:13', '2023-05-11 11:17:13', '');
INSERT INTO `sys_menu` VALUES ('44692cac-c178-11ee-a758-e0be038740d4', '02470e78-c178-11ee-a758-e0be038740d4', '', '', '', '删除', '', 'generator:delete', 2, NULL, 0, 0, 0, 0, 0, '2024-02-02 11:07:58', '2024-02-02 11:07:58', '');
INSERT INTO `sys_menu` VALUES ('44979f524b88ed2dfbf14e4267ebd045', 'b1851d1b13594e71840103c11a37a004', '', '', '', '删除', '', 'org:delete', 1, '', 0, 0, 0, 0, 0, '2023-04-13 10:34:53', '2023-04-13 10:34:53', '');
INSERT INTO `sys_menu` VALUES ('5de088a93f0828a57e4c70959831458b', 'b1851d1b13594e71840103c11a37a004', '', '', '', '保存', '', 'org:save', 0, '', 0, 0, 0, 0, 0, '2023-04-13 10:33:43', '2023-04-13 10:33:43', '');
INSERT INTO `sys_menu` VALUES ('5df7c65d51129baefee123ef3bc2d7de', 'ea83fb03d2117cb287973d6889984686', 'magicapi', 'https://www.ssssssss.org/magic-api/pages/quick/single/', 'Clock', '框架', 'magicapi', NULL, 2, '', 0, 1, 0, 0, 1, '2023-04-11 11:25:08', '2023-04-11 11:25:08', NULL);
INSERT INTO `sys_menu` VALUES ('5e67672047d0a00bf861ba2255535238', '1ec1c1cb127d83f6346904220b3ed20b', '', '', '', '修改', '', 'dict:update', 2, '', 0, 0, 0, 0, 0, '2023-04-13 16:27:29', '2023-04-13 16:27:29', '');
INSERT INTO `sys_menu` VALUES ('628431d108e3530ac37dfa2180dff376', '1ec1c1cb127d83f6346904220b3ed20b', '', '', '', '保存', '', 'dict:save', 1, '', 0, 0, 0, 0, 0, '2023-04-13 16:27:07', '2023-04-13 16:27:07', '');
INSERT INTO `sys_menu` VALUES ('68de23e6-06c2-11f0-b559-4ccc6a2e3718', '7840fc2e-0401-11f0-b559-4ccc6a2e370', 'modelAdd', '/work/ModelAdd', 'DocumentAdd', '新增模型', 'ModelAdd', NULL, 1, NULL, 0, 2, 0, 1, 1, '2025-03-30 22:37:03', '2025-03-22 10:07:30', '');
INSERT INTO `sys_menu` VALUES ('7840fc2e-0401-11f0-b559-4ccc6a2e370', '0', 'work', '/work', 'Operation', '工作流', 'Work', NULL, 3, NULL, 0, 0, 0, 1, 1, '2025-03-22 10:21:10', '2025-03-18 22:01:20', '');
INSERT INTO `sys_menu` VALUES ('7840fc2e-0401-11f0-b559-4ccc6a2e3718', '7840fc2e-0401-11f0-b559-4ccc6a2e370', 'model', '/work/Model', 'Operation', '模型管理', 'Model', NULL, 0, NULL, 0, 0, 0, 1, 1, '2025-03-25 21:18:13', '2025-03-18 22:01:20', '');
INSERT INTO `sys_menu` VALUES ('7b02ec134bcd2a74b7930ce03da4b8bb', '120d967459a9e7323692b3fa49c1ba59', 'loginLog', '/monitor/LoginLog', 'User', '登录日志', 'LoginLog', NULL, 1, NULL, 0, 0, 0, 1, 1, '2023-04-14 08:48:07', '2023-04-14 08:48:07', '');
INSERT INTO `sys_menu` VALUES ('850a1c29af28318e6e470a14aaeb50e5', 'b1851d1b13594e71840103c11a37a006', '', '', '', '保存', '', 'user:save', 0, '', 0, 0, 0, 0, 0, '2023-04-13 11:33:37', '2023-04-13 11:33:37', '');
INSERT INTO `sys_menu` VALUES ('9658b61b187ae33b7c8c39fc8c1265dc', '120d967459a9e7323692b3fa49c1ba59', 'onlineUser', '/monitor/OnlineUser', 'Avatar', '在线用户', 'OnlineUser', NULL, 3, NULL, 0, 0, 0, 1, 1, '2023-04-14 08:50:35', '2023-04-14 08:50:35', '');
INSERT INTO `sys_menu` VALUES ('9a36ed1841e3e6d2da32df17980edaa2', 'b25838d6e06c6cdad82c1ad9b1096f26', 'interface', '/lowcode/Interface', 'Connection', '接口开发', 'Interface', NULL, 2, NULL, 0, 0, 0, 1, 1, '2023-07-07 17:08:04', '2023-04-14 08:52:17', '');
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a002', '0', 'system', '/system', 'Tools', '系统管理', 'System', NULL, 1, NULL, 0, 0, 0, 0, 1, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a003', 'b1851d1b13594e71840103c11a37a002', 'menu', '/system/Menu', 'Grid', '菜单管理', 'Menu', NULL, 2, NULL, 0, 0, 0, 0, 1, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a004', 'b1851d1b13594e71840103c11a37a002', 'org', '/system/Org', 'SetUp', '组织管理', 'Org', NULL, 3, NULL, 0, 0, 0, 0, 1, '2023-04-13 11:30:56', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a005', 'b1851d1b13594e71840103c11a37a002', 'role', '/system/Role', 'Help', '角色管理', 'Role', NULL, 4, NULL, 0, 0, 0, 0, 1, '2023-04-13 11:32:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a006', 'b1851d1b13594e71840103c11a37a002', 'user', '/system/User', 'User', '用户管理', 'User', NULL, 5, NULL, 0, 0, 0, 0, 1, '2023-04-13 11:32:34', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a007', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '保存', 'save', 'menu:save', 6, NULL, 0, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a008', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '删除', 'delete', 'menu:delete', 6, NULL, 0, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a009', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '修改', 'update', 'menu:update', 6, NULL, 0, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a010', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '详情', 'view', 'menu:view', 6, NULL, 0, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a011', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '列表', 'list', 'menu:list', 6, NULL, 0, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b25838d6e06c6cdad82c1ad9b1096f26', '0', 'lowcode', '/lowcode', 'Edit', '应用开发', 'Lowcode', NULL, 2, NULL, 0, 0, 0, 1, 1, '2023-07-07 17:06:37', '2023-04-14 08:46:15', '');
INSERT INTO `sys_menu` VALUES ('b4cfa05bff2269fee06788b32115851a', 'b1851d1b13594e71840103c11a37a006', '', '', '', '修改', '', 'user:update', 1, '', 0, 0, 0, 0, 0, '2023-04-13 14:44:51', '2023-04-13 11:34:04', '');
INSERT INTO `sys_menu` VALUES ('b8db9ff560e383e59d604e19c9fbd3cb', 'b1851d1b13594e71840103c11a37a006', '', '', '', '列表', '', 'user:list', 4, '', 0, 0, 0, 0, 0, '2023-04-13 11:34:49', '2023-04-13 11:34:49', '');
INSERT INTO `sys_menu` VALUES ('b9401c42bc1e58e0a48e6b3308cff617', '1ec1c1cb127d83f6346904220b3ed20b', '', '', '', '删除', '', 'dict:delete', 4, '', 0, 0, 0, 0, 0, '2023-04-13 16:27:48', '2023-04-13 16:27:48', '');
INSERT INTO `sys_menu` VALUES ('d2df5734-1ca6-11ee-8b16-e0be038740d4', 'ea83fb03d2117cb287973d6889984686', 'table', '/table', 'Camera', '表格示例', 'table', NULL, 3, NULL, 1, 0, 0, 1, 1, '2023-07-07 17:15:32', '2023-07-07 17:15:32', '');
INSERT INTO `sys_menu` VALUES ('db608f30-06ba-11f0-b559-4ccc6a2e3718', '7840fc2e-0401-11f0-b559-4ccc6a2e3718', '', '', '', '保存', '', 'model:save', 0, NULL, 0, 0, 0, 0, 0, '2025-03-25 21:18:30', '2025-03-22 09:13:26', '');
INSERT INTO `sys_menu` VALUES ('e5c47de2-06ba-11f0-b559-4ccc6a2e3718', '7840fc2e-0401-11f0-b559-4ccc6a2e3718', '', '', '', '修改', '', 'model:update', 1, NULL, 0, 0, 0, 0, 0, '2025-03-25 21:18:37', '2025-03-22 09:13:43', '');
INSERT INTO `sys_menu` VALUES ('ea83fb03d2117cb287973d6889984686', '0', 'demo', '/demo', 'ChromeFilled', '菜单实例', 'Demo', NULL, 5, '', 0, 0, 0, 1, 1, '2023-07-07 17:06:06', '2023-04-11 11:10:46', '实例');
INSERT INTO `sys_menu` VALUES ('eb404f1c-1ca6-11ee-8b16-e0be038740d4', 'ea83fb03d2117cb287973d6889984686', 'images', '/images', 'Football', '轮播图', 'images', NULL, 4, NULL, 1, 0, 0, 1, 1, '2023-07-07 17:16:13', '2023-07-07 17:16:13', '');
INSERT INTO `sys_menu` VALUES ('f3138bd5b256d82f9eebe07c6679cf15', 'b1851d1b13594e71840103c11a37a004', '', '', '', '修改', '', 'org:update', 2, '', 0, 0, 0, 0, 0, '2023-04-13 10:35:17', '2023-04-13 10:35:17', '');
INSERT INTO `sys_menu` VALUES ('f4b37ac9-06ba-11f0-b559-4ccc6a2e3718', '7840fc2e-0401-11f0-b559-4ccc6a2e3718', '', '', '', '删除', '', 'model:delete', 2, NULL, 0, 0, 0, 0, 0, '2025-03-25 21:18:46', '2025-03-22 09:14:08', '');
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0666', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '列表', 'list', 'role:list', 1, '', 0, 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0667', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '添加', 'save', 'role:save', 1, '', 0, 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0668', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '修改', 'update', 'role:update', 1, '', 0, 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0669', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '删除', 'delete', 'role:delete', 1, '', 0, 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0670', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '菜单权限', 'menu', 'role:menu', 1, '', 0, 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0671', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '数据权限', 'data', 'role:data', 1, '', 0, 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0675', 'ea83fb03d2117cb287973d6889984686', 'Iframe', 'https://www.bing.com/?mkt=zh-CN', 'Bicycle', '必应', 'Iframe', NULL, 1, '', 0, 1, 0, 0, 1, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('fc793c0e-097b-11f0-b559-4ccc6a2e3718', '7840fc2e-0401-11f0-b559-4ccc6a2e370', 'flowable', '/work/Flowable', 'ScaleToOriginal', '流程管理', 'Flowable', NULL, 2, NULL, 0, 0, 0, 1, 1, '2025-03-30 22:43:18', '2025-03-25 21:20:56', '');
INSERT INTO `sys_menu` VALUES ('fdaf429afb33d54beeee7eaea93e5e96', '120d967459a9e7323692b3fa49c1ba59', 'operLog', '/monitor/OperLog', 'Cpu', '操作日志', 'OperLog', NULL, 2, NULL, 0, 0, 0, 1, 1, '2023-04-14 08:49:04', '2023-04-14 08:49:04', '');
INSERT INTO `sys_menu` VALUES ('fe325d23-06ba-11f0-b559-4ccc6a2e3718', '7840fc2e-0401-11f0-b559-4ccc6a2e3718', '', '', '', '列表', '', 'model:list', 3, NULL, 0, 0, 0, 0, 0, '2025-03-25 21:18:54', '2025-03-22 09:14:24', '');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键id',
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '功能模块',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作方法',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作类型',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作描述',
  `req_param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '请求参数',
  `res_param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '响应参数',
  `take_up_time` int NULL DEFAULT NULL COMMENT '耗时',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作用户id',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作用户名称',
  `status` int NULL DEFAULT NULL COMMENT '状态：0、成功，1、失败',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求url',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求IP',
  `unusual` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '异常信息',
  `version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '版本号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_org`;
CREATE TABLE `sys_org`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键id',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `is_del` int(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '删除状态：0、正常，1、删除',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '组织' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_org
-- ----------------------------
INSERT INTO `sys_org` VALUES ('534a37c366ec47878a6b0c85703d0001', '534a37c366ec47878a6b0c85703d0bc4', '兰州子公司', 'SO00002', 2, 0, '2023-03-29 08:53:41', '2023-03-29 08:53:43', NULL);
INSERT INTO `sys_org` VALUES ('534a37c366ec47878a6b0c85703d0bc4', '0', '总公司', 'SO00001', 0, 0, '2023-03-29 08:53:41', '2023-03-29 08:53:43', NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色编码',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '0：全部，1：自定义，2：本级级子级，3：本级',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `is_del` int NULL DEFAULT 0 COMMENT '是否删除：0未删除，1已删除',
  `creator` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

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
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色id',
  `menu_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '06936eec3258c1fa675c8b6b697160f5');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '07e1aebb5b69b55b7eb0ce79fed00f40');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '0a59255aac53f421613c4d8516fcc305');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '0e769d6164cff598ae7215c99849bd1c');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '11107c717306bd0d9e993cf32a94974e');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '120d967459a9e7323692b3fa49c1ba59');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '1cda1e6f35077cb1f89007fa36343a3d');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '1ec1c1cb127d83f6346904220b3ed20b');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '223588533ceb03066c89940863dc747e');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '3afbad18e475a7f7a4aeec6ab6e6c0fc');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '44979f524b88ed2dfbf14e4267ebd045');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '5de088a93f0828a57e4c70959831458b');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '5df7c65d51129baefee123ef3bc2d7de');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '5e67672047d0a00bf861ba2255535238');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '628431d108e3530ac37dfa2180dff376');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '7b02ec134bcd2a74b7930ce03da4b8bb');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '850a1c29af28318e6e470a14aaeb50e5');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '9658b61b187ae33b7c8c39fc8c1265dc');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '9a36ed1841e3e6d2da32df17980edaa2');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a002');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a003');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a004');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a005');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a006');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a007');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a008');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a009');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a010');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b1851d1b13594e71840103c11a37a011');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b25838d6e06c6cdad82c1ad9b1096f26');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b4cfa05bff2269fee06788b32115851a');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b8db9ff560e383e59d604e19c9fbd3cb');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b9401c42bc1e58e0a48e6b3308cff617');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'ea83fb03d2117cb287973d6889984686');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'ed9b00353e7f4cf6c446b2d631db8029');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f3138bd5b256d82f9eebe07c6679cf15');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0666');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0667');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0668');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0669');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0670');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0671');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f8b972bc005a9c6691a43b76839b0675');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'fb9f883cfbacefcaf0805eeea895fd32');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'fdaf429afb33d54beeee7eaea93e5e96');

-- ----------------------------
-- Table structure for sys_role_org
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_org`;
CREATE TABLE `sys_role_org`  (
  `org_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组织机构id',
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色id',
  PRIMARY KEY (`org_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户组织机构关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_org
-- ----------------------------
INSERT INTO `sys_role_org` VALUES ('534a37c366ec47878a6b0c85703d0bc4', '534a37c366ec47878a6b0c85703d0bc3');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主键',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名/昵称',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `type` int NULL DEFAULT NULL COMMENT '用户类型：1、管理员，2、普通用户',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` int NULL DEFAULT NULL COMMENT '性别：0、男，1、女',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `is_login` int NULL DEFAULT 0 COMMENT '禁止登录：0未禁用，1已禁用',
  `is_del` int NULL DEFAULT 0 COMMENT '删除标识：0未删除，1已删除',
  `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '唯一标识',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号码',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `create_by` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`, `username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '管理员', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, NULL, NULL, 0, '2023-03-29', 0, 0, '', '', '', '', NULL, '2023-04-14 15:48:44', '2023-03-29 08:49:27', NULL);
INSERT INTO `sys_user` VALUES ('3ad1bd6b76c2e5573ea1805b7d68c6a9', 'system', '管理者', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, '18810011002', '', 0, '2023-04-03', 0, 0, NULL, '甘肃兰州', NULL, 'system@qq.com', NULL, '2023-07-07 11:08:29', '2023-04-13 14:41:21', '普通管理者');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户角色' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '534a37c366ec47878a6b0c85703d0bc3');
INSERT INTO `sys_user_role` VALUES ('3ad1bd6b76c2e5573ea1805b7d68c6a9', '441b6dae329b3a20ad8b4f4ca8f83a0b');

SET FOREIGN_KEY_CHECKS = 1;
