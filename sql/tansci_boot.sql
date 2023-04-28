/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : tansci_boot

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 28/04/2023 16:38:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for magic_api_backup
-- ----------------------------
DROP TABLE IF EXISTS `magic_api_backup`;
CREATE TABLE `magic_api_backup`  (
  `id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '原对象ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '原名称',
  `content` blob NULL COMMENT '备份内容',
  `tag` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '标签',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '类型',
  `create_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作人',
  `create_date` datetime NULL DEFAULT NULL COMMENT '备份时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'magic api 备份' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of magic_api_backup
-- ----------------------------

-- ----------------------------
-- Table structure for magic_api_file
-- ----------------------------
DROP TABLE IF EXISTS `magic_api_file`;
CREATE TABLE `magic_api_file`  (
  `file_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '路径',
  `file_content` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '内容',
  PRIMARY KEY (`file_path`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'magic api 接口表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of magic_api_file
-- ----------------------------
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/api/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/api/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"ee837d9cf48a4136bd4b596a1079ca87\",\r\n  \"name\" : \"api\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"0\",\r\n  \"path\" : \"/api\",\r\n  \"createTime\" : 1682665743106,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/api/test/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/api/test/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"fb7cdce56e894e50a698574bde1b5300\",\r\n  \"name\" : \"test\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"ee837d9cf48a4136bd4b596a1079ca87\",\r\n  \"path\" : \"/test\",\r\n  \"createTime\" : 1682665743110,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/api/test/保存.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"f4d54960f445472b888718e9a9d9828b\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fb7cdce56e894e50a698574bde1b5300\",\r\n  \"name\" : \"保存\",\r\n  \"createTime\" : 1682665743119,\r\n  \"updateTime\" : null,\r\n  \"lock\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"/save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : null,\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.insert(\"\"\"insert into magic_api_backup(content,create_by,create_date,id,name,tag,type) values (uuid() , #{body.content}, #{body.create_by}, #{body.create_date}, #{body.id}, #{body.name}, #{body.tag}, #{body.type})\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/api/test/修改.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"08df2915130943ff821ea827b7392355\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fb7cdce56e894e50a698574bde1b5300\",\r\n  \"name\" : \"修改\",\r\n  \"createTime\" : 1682665743120,\r\n  \"updateTime\" : null,\r\n  \"lock\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"/update\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : null,\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.update(\"\"\"update magic_api_backup set\nid = #{body.id}\n ?{body.content, ,content = #{body.content}}\n?{body.create_by, ,create_by = #{body.create_by}}\n?{body.create_date, ,create_date = #{body.create_date}}\n?{body.id, ,id = #{body.id}}\n?{body.name, ,name = #{body.name}}\n?{body.tag, ,tag = #{body.tag}}\n?{body.type, ,type = #{body.type}}\n where id = #{body.id}\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/api/test/列表.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"95f516069515411ca97d6c0cfe4b1a74\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fb7cdce56e894e50a698574bde1b5300\",\r\n  \"name\" : \"列表\",\r\n  \"createTime\" : 1682665743116,\r\n  \"updateTime\" : null,\r\n  \"lock\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"/list\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : null,\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.page(\"\"\"\r\nselect content,create_by,create_date,id,name,tag,type from magic_api_backup where 1=1\r\n    ?{content, and content = #{content} }\n    ?{create_by, and create_by = #{create_by} }\n    ?{create_date, and create_date = #{create_date} }\n    ?{id, and id = #{id} }\n    ?{name, and name = #{name} }\n    ?{tag, and tag = #{tag} }\n    ?{type, and type = #{type} }\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/api/test/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"386c16f35d9c43f6b1d5f46ad3337bed\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fb7cdce56e894e50a698574bde1b5300\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : 1682665743122,\r\n  \"updateTime\" : null,\r\n  \"lock\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"/delete\",\r\n  \"method\" : \"DELETE\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : null,\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.table(\'magic_api_backup\').where().eq(\'id\', id).delete()');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/api/test/详情.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"9bf6241f1fa648e498a5aef92916836b\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"fb7cdce56e894e50a698574bde1b5300\",\r\n  \"name\" : \"详情\",\r\n  \"createTime\" : 1682665743124,\r\n  \"updateTime\" : null,\r\n  \"lock\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"/get\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : null,\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.selectOne(\"\"\"select content,create_by,create_date,id,name,tag,type from magic_api_backup where id = #{id}\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/应用开发/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/应用开发/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"14084ee14d8441238efc10c8f88109f3\",\r\n  \"name\" : \"应用开发\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"0\",\r\n  \"path\" : \"lowcode\",\r\n  \"createTime\" : 1682236099251,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/应用开发/代码生成/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/应用开发/代码生成/group.json', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"81e7401f702f4a88bffa57faff60b81c\",\r\n  \"name\" : \"代码生成\",\r\n  \"type\" : \"api\",\r\n  \"parentId\" : \"14084ee14d8441238efc10c8f88109f3\",\r\n  \"path\" : \"code\",\r\n  \"createTime\" : 1682236131105,\r\n  \"updateTime\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"paths\" : [ ],\r\n  \"options\" : [ ]\r\n}');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/应用开发/代码生成/代码生成.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"ce3cf8ffb5ea4121a98a3162a79cff4f\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"81e7401f702f4a88bffa57faff60b81c\",\r\n  \"name\" : \"代码生成\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1682664500287,\r\n  \"lock\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"execute\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport org.ssssssss.magicapi.core.model.Option\r\nimport org.ssssssss.magicapi.core.model.ApiInfo\r\nimport org.ssssssss.magicapi.core.model.Group\r\nimport org.ssssssss.magicapi.core.service.MagicResourceService\r\nimport log\r\n\r\ninfo = info::json\r\n//创建组\r\nvar getGroup = (type) => {\r\n    var moduleGroup = MagicResourceService.tree(type).children.filter(it => {\r\n        return it.node.path == info.modulePath || it.node.path == info.modulePath.substring(1, info.modulePath.length())\r\n    })\r\n    if(moduleGroup.length == 0){\r\n        Group group = new Group();\r\n        group.setId(UUID.randomUUID().toString().replace(\'-\', \'\'));\r\n        group.setName(info.moduleName);\r\n        group.setPath(info.modulePath);\r\n        group.setParentId(\"0\");\r\n        group.setType(type)\r\n        MagicResourceService.saveGroup(group);\r\n        moduleGroup = group;\r\n    }else{\r\n        moduleGroup = moduleGroup[0].node\r\n    }\r\n    //创建功能组\r\n    var businessGroup = MagicResourceService.tree(type).children.filter(it => it.node.id == moduleGroup.id)[0].children.filter(it => {\r\n        return it.node.path == info.businessPath || it.node.path == info.businessPath.substring(1, info.businessPath.length())\r\n    })\r\n    if(businessGroup.length == 0){\r\n        Group group = new Group();\r\n        group.setId(UUID.randomUUID().toString().replace(\'-\', \'\'));\r\n        group.setName(info.businessName);\r\n        group.setPath(info.businessPath);\r\n        group.setParentId(moduleGroup.getId());\r\n        group.setType(type)\r\n        MagicResourceService.saveGroup(group);\r\n        businessGroup = group;\r\n    }else{\r\n        businessGroup = businessGroup[0].node\r\n    }\r\n\r\n    // 子表组\r\n    var subPath = \"/sub\"\r\n    var bGroup = MagicResourceService.tree(type).children.filter(it => it.node.id == moduleGroup.id)[0]\r\n    var subGroup = bGroup.children.filter(it => it.node.id == businessGroup.id )[0].children.filter(it =>{\r\n        return it.node.path == subPath || it.node.path == subPath.substring(1, subPath.length())\r\n    })\r\n    if(info.template == \"subTable\"){\r\n        if(subGroup.length == 0){\r\n            Group group = new Group();\r\n            group.setId(UUID.randomUUID().toString().replace(\'-\', \'\'));\r\n            group.setName(\"子表\");\r\n            group.setPath(\"/sub\");\r\n            group.setParentId(businessGroup.getId());\r\n            group.setType(type)\r\n            MagicResourceService.saveGroup(group);\r\n            subGroup = group;  \r\n        }else{\r\n            subGroup = subGroup[0].node\r\n        }\r\n    }\r\n\r\n    return {\r\n        moduleGroup,\r\n        businessGroup,\r\n        subGroup\r\n    }\r\n}\r\n//删除临时文件\r\nvar deleteFiles = (groupId, paths) => {\r\n    var listFiles = MagicResourceService.listFiles(groupId)\r\n    listFiles.forEach(it => {\r\n        if(paths.indexOf(it.path) != -1){\r\n            MagicResourceService.delete(it.id)\r\n        }\r\n    })\r\n}\r\n\r\nvar businessGroup = getGroup(\'api\').businessGroup\r\n//删除api接口\r\ndeleteFiles(businessGroup.getId(),[\'/list\', \'/save\', \'/get\', \'/delete\'])\r\n\r\nvar primary = db.selectValue(\"SELECT column_name FROM information_schema.COLUMNS WHERE table_name = #{tableName} and column_key = \'PRI\' and table_schema = #{dataSource} limit 1\")\r\nvar primaryLowerCamelCase = primary.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n\r\ncolumns = columns::json\r\nvar listFields = columns.map(item => item.columnName).join(\',\')\r\nvar wheres = \'\';\r\ncolumns.forEach(it => {\r\n    var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n    wheres += `    ?{${it.columnName}, and ${field} = #{${it.columnName}} }\\n`\r\n})\r\nwheres = wheres.substring(0,wheres.length() - 1)\r\n\r\n// 产生查询api接口\r\nApiInfo listApi = new ApiInfo()\r\nlistApi.setName(\"列表\")\r\nlistApi.setPath(\"/list\")\r\nlistApi.setMethod(\"GET\")\r\nlistApi.setGroupId(businessGroup.getId())\r\nlistApi.setScript(`return db.page(\"\"\"\r\nselect ${listFields} from ${tableName} where 1=1\r\n${wheres}\r\n\"\"\")`)\r\nMagicResourceService.saveFile(listApi)\r\n\r\n//产生增册改查api接口\r\nvar insertFields = \'\';\r\ncolumns.forEach(it => {\r\n    var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n    insertFields += `, #{body.`+it.columnName+`}`\r\n})\r\n\r\nApiInfo saveApi = new ApiInfo()\r\nsaveApi.setName(\"保存\")\r\nsaveApi.setPath(\"/save\")\r\nsaveApi.setMethod(\"POST\")\r\nsaveApi.setGroupId(businessGroup.getId())\r\nsaveApi.setScript(`return db.insert(\"\"\"insert into ${tableName}(${listFields}) values (uuid() ${insertFields})\"\"\")`)\r\nMagicResourceService.saveFile(saveApi)\r\n\r\n// 修改\r\nvar updateFields = \'\';\r\ncolumns.forEach(it => {\r\n    var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n    updateFields += `?{body.${it.columnName}, ,${field} = #{body.${it.columnName}}}\\n`\r\n})\r\nApiInfo updateApi = new ApiInfo()\r\nupdateApi.setName(\"修改\")\r\nupdateApi.setPath(\"/update\")\r\nupdateApi.setMethod(\"POST\")\r\nupdateApi.setGroupId(businessGroup.getId())\r\nupdateApi.setScript(`return db.update(\"\"\"update ${tableName} set\\n${primary} = #{body.${primary}}\\n ${updateFields} where ${primary} = #{body.${primary}}\"\"\")`)\r\nMagicResourceService.saveFile(updateApi)\r\n\r\nApiInfo deleteApi = new ApiInfo()\r\ndeleteApi.setName(\"删除\")\r\ndeleteApi.setPath(\"/delete\")\r\ndeleteApi.setMethod(\"DELETE\")\r\ndeleteApi.setGroupId(businessGroup.getId())\r\ndeleteApi.setScript(`return db.table(\'${tableName}\')${logic}.where().eq(\'${primary}\', ${primaryLowerCamelCase}).delete()`)\r\nMagicResourceService.saveFile(deleteApi)\r\n\r\n//产生单个行Api接口\r\nApiInfo getApi = new ApiInfo()\r\ngetApi.setName(\"详情\")\r\ngetApi.setPath(\"/get\")\r\ngetApi.setMethod(\"GET\")\r\ngetApi.setGroupId(businessGroup.getId())\r\ngetApi.setScript(`return db.selectOne(\"\"\"select ${listFields} from ${tableName} where ${primary} = #{${primaryLowerCamelCase}}\"\"\")`)\r\nMagicResourceService.saveFile(getApi)\r\n\r\n// 树列表接口\r\nif(info.template == \"tree\"){\r\n    ApiInfo treeApi = new ApiInfo()\r\n    treeApi.setName(\"树列表\")\r\n    treeApi.setPath(\"/tree\")\r\n    treeApi.setMethod(\"GET\")\r\n    treeApi.setGroupId(businessGroup.getId())\r\n    treeApi.setScript(`var toTree = (list,${info.treePid}) => select t.*,toTree(list,t.${info.treeId}) children from list t where t.${info.treePid} = ${info.treePid}\r\n        var list = toTree(db.select(\'select ${listFields} from ${tableName}\'),\'0\')\r\n        return {\r\n            list: list,\r\n            total: list.getLength()\r\n        }\r\n    `)\r\n    MagicResourceService.saveFile(treeApi)\r\n}\r\n\r\n// 主子表 api接口\r\nif(info.template == \"subTable\"){\r\n    subColumns = subColumns::json\r\n    var subGroup = getGroup(\'api\').subGroup\r\n    var subListFields = subColumns.map(it => it.columnName).join(\',\')\r\n    var subWheres = \'\';\r\n    subColumns.forEach(it => {\r\n        var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n        if(it.query){\r\n            if(it.where == \'in\'){\r\n                subWheres += `?{${it.columnName}, and ${field} in(#{`+it.columnName+`.split(\',\')}) }\\n`\r\n            }else if(it.where == \'like\'){\r\n                subWheres += `?{${it.columnName}, and ${field} like concat(\'%\',#{${it.columnName}},\'%\') }\\n`\r\n            }else{\r\n                subWheres += `?{${it.columnName}, and ${field} ${it.where} #{${it.columnName}} }\\n`\r\n            }\r\n        }\r\n    })\r\n    var subPrimary = db.selectValue(\"SELECT column_name FROM information_schema.COLUMNS WHERE table_name = #{subTableName} and column_key = \'PRI\' and table_schema = #{datasource} limit 1\")\r\n    var subPrimaryLowerCamelCase = subPrimary.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n    subWheres = subWheres.substring(0,subWheres.length() - 1)\r\n    \r\n    // 列表\r\n    ApiInfo subListApi = new ApiInfo()\r\n    subListApi.setName(\"列表\")\r\n    subListApi.setPath(\"/list\")\r\n    subListApi.setMethod(\"GET\")\r\n    subListApi.setGroupId(subGroup.getId())\r\n    subListApi.setScript(`return db.page(\"\"\"\r\n        select ${subListFields} from ${subTableName} where 1=1\r\n    ${subWheres}\r\n    \"\"\")`)\r\n    MagicResourceService.saveFile(subListApi)\r\n\r\n    // 保存\r\n    var insertSubFields = \'\';\r\n    subColumns.forEach(it => {\r\n        var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n        insertSubFields += `, #{body.`+it.columnName+`}`\r\n    })\r\n    ApiInfo subSaveApi = new ApiInfo()\r\n    subSaveApi.setName(\"保存\")\r\n    subSaveApi.setPath(\"/save\")\r\n    subSaveApi.setMethod(\"POST\")\r\n    subSaveApi.setGroupId(subGroup.getId())\r\n    subSaveApi.setScript(`return db.insert(\"\"\"insert into ${subTableName}(${subPrimary},${subListFields}) values (uuid() ${insertSubFields})\"\"\")`)\r\n    MagicResourceService.saveFile(subSaveApi)\r\n\r\n    // 修改\r\n    var updateSubFields = \'\';\r\n    subColumns.forEach(it => {\r\n        var field = it.columnName.replace(/([A-Z])/g,\"_$1\").toLowerCase()\r\n        updateSubFields += `?{body.${it.columnName}, ,${field} = #{body.${it.columnName}}}\\n`\r\n    })\r\n    ApiInfo subUpdateApi = new ApiInfo()\r\n    subUpdateApi.setName(\"修改\")\r\n    subUpdateApi.setPath(\"/update\")\r\n    subUpdateApi.setMethod(\"POST\")\r\n    subUpdateApi.setGroupId(subGroup.getId())\r\n    subUpdateApi.setScript(`return db.update(\"\"\"update ${subTableName} set \\n${subPrimary} = #{body.${subPrimary}}\\n ${updateSubFields} where ${subPrimary} = #{body.${subPrimary}}\"\"\")`)\r\n    MagicResourceService.saveFile(subUpdateApi)\r\n\r\n    // 删除\r\n    ApiInfo subDeleteApi = new ApiInfo()\r\n    subDeleteApi.setName(\"删除\")\r\n    subDeleteApi.setPath(\"/delete\")\r\n    subDeleteApi.setMethod(\"DELETE\")\r\n    subDeleteApi.setGroupId(subGroup.getId())\r\n    subDeleteApi.setScript(`return db.table(\'${subTableName}\')${subLogic}.where().eq(\'${subPrimary}\', ${subPrimaryLowerCamelCase}).delete()`)\r\n    MagicResourceService.saveFile(subDeleteApi)\r\n\r\n    // 详情\r\n    ApiInfo subGetApi = new ApiInfo()\r\n    subGetApi.setName(\"详情\")\r\n    subGetApi.setPath(\"/get\")\r\n    subGetApi.setMethod(\"GET\")\r\n    subGetApi.setGroupId(subGroup.getId())\r\n    subGetApi.setScript(`return db.selectOne(\"\"\"select ${subPrimary},${subListFields} from ${subTableName} where ${subPrimary} = #{${subPrimaryLowerCamelCase}}\"\"\")`)\r\n    MagicResourceService.saveFile(subGetApi)\r\n}\r\n\r\nvar moduleGroup = getGroup(\'api\').moduleGroup\r\nreturn moduleGroup.id\r\n');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/应用开发/代码生成/分页.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"1bb21656ec35481fa41731295740409f\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"81e7401f702f4a88bffa57faff60b81c\",\r\n  \"name\" : \"分页\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1682236855956,\r\n  \"lock\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"page\",\r\n  \"method\" : \"GET\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nreturn db.page(\"\"\"\r\n    select id,interface_id,data_source,table_name,table_comment,columns,sub_table_name,sub_table_comment,sub_columns,info,update_time,create_time\r\n    from sys_gen where 1=1\r\n    ?{tableName, and table_name like concat(\'%\',#{tableName},\'%\')}\r\n    order by update_time desc\r\n\"\"\")');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/应用开发/代码生成/删除.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"cca8b70f329e4539a3488b0a38a689e0\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"81e7401f702f4a88bffa57faff60b81c\",\r\n  \"name\" : \"删除\",\r\n  \"createTime\" : 1682237096069,\r\n  \"updateTime\" : null,\r\n  \"lock\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"delete\",\r\n  \"method\" : \"DELETE\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nimport org.ssssssss.magicapi.core.service.MagicResourceService\r\n\r\nvar interfaceId = db.selectValue(\"\"\"select interface_id from sys_gen where id = #{id}\"\"\")\r\nif(interfaceId != null){\r\n    MagicResourceService.delete(interfaceId)\r\n}\r\n\r\nreturn db.table(\"sys_gen\").where().eq(\"id\",id).delete()');
INSERT INTO `magic_api_file` VALUES ('/magic-api/api/应用开发/代码生成/添加.ms', '{\r\n  \"properties\" : { },\r\n  \"id\" : \"707914bc659149708f86be79732712ef\",\r\n  \"script\" : null,\r\n  \"groupId\" : \"81e7401f702f4a88bffa57faff60b81c\",\r\n  \"name\" : \"添加\",\r\n  \"createTime\" : null,\r\n  \"updateTime\" : 1682665721329,\r\n  \"lock\" : null,\r\n  \"createBy\" : null,\r\n  \"updateBy\" : null,\r\n  \"path\" : \"save\",\r\n  \"method\" : \"POST\",\r\n  \"parameters\" : [ ],\r\n  \"options\" : [ {\r\n    \"name\" : \"wrap_request_parameter\",\r\n    \"value\" : \"data\",\r\n    \"description\" : \"包装请求参数到一个变量中\",\r\n    \"required\" : false,\r\n    \"dataType\" : \"String\",\r\n    \"type\" : null,\r\n    \"defaultValue\" : null,\r\n    \"validateType\" : null,\r\n    \"error\" : null,\r\n    \"expression\" : null,\r\n    \"children\" : null\r\n  } ],\r\n  \"requestBody\" : \"\",\r\n  \"headers\" : [ ],\r\n  \"paths\" : [ ],\r\n  \"responseBody\" : null,\r\n  \"description\" : null,\r\n  \"requestBodyDefinition\" : null,\r\n  \"responseBodyDefinition\" : null\r\n}\r\n================================\r\nif(data.id){\r\n    data.updateTime = new Date()\r\n    data.createTime = new Date()\r\n}\r\nreturn db.table(\"sys_gen\").primary(\"id\", uuid()).save(data)');
INSERT INTO `magic_api_file` VALUES ('/magic-api/datasource/', 'this is directory');
INSERT INTO `magic_api_file` VALUES ('/magic-api/function/', 'this is directory');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键id',
  `parent_id` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '父ID',
  `group_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '分组名称',
  `type` int NULL DEFAULT NULL COMMENT '类型：0、系统，1、业务',
  `dic_value` int NOT NULL COMMENT '值',
  `dic_label` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名称',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `text1` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预留字段1',
  `text2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预留字段2',
  `text3` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预留字段3',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `group_name`(`group_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_dict` VALUES ('c7d736d70f722d15bebe282f4bd317d5', '504f58ac31fd50cd0f250d4bd165bf0b', 'business_type', 0, 1, '业务', 1, NULL, NULL, NULL, '2023-04-14 15:35:36', '2023-04-14 15:35:36', '');
INSERT INTO `sys_dict` VALUES ('df5903139958429ed65ee82424d69b1b', '402ab9a354ff5f9de90adb9e9afb33fb', 'user_gender', 1, 0, '男', 1, NULL, NULL, NULL, '2023-04-14 15:41:44', '2023-04-14 15:40:09', '男');
INSERT INTO `sys_dict` VALUES ('f60b86ff25cc5261dafdffdf78b590db', '504f58ac31fd50cd0f250d4bd165bf0b', 'business_type', 0, 0, '系统', 1, NULL, NULL, NULL, '2023-04-14 15:35:23', '2023-04-14 15:35:23', '');

-- ----------------------------
-- Table structure for sys_gen
-- ----------------------------
DROP TABLE IF EXISTS `sys_gen`;
CREATE TABLE `sys_gen`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `interface_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '接口ID',
  `data_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '数据源',
  `table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '表名',
  `table_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '表注释',
  `columns` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '字段信息json',
  `sub_table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '字表名称',
  `sub_table_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '子表注释',
  `sub_columns` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '子表字段信息json',
  `info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '生成信息json',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '生成表信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_gen
-- ----------------------------
INSERT INTO `sys_gen` VALUES ('a54cb7225aa84346843957cb3299ed1f', 'ee837d9cf48a4136bd4b596a1079ca87', 'tansci_boot', 'magic_api_backup', 'magic api 备份', '[{\"tableSchema\":\"tansci_boot\",\"tableName\":\"magic_api_backup\",\"columnName\":\"content\",\"columnComment\":\"备份内容\",\"columnKey\":\"\",\"dataType\":\"blob\",\"isNullable\":\"YES\",\"columnType\":\"blob\",\"columnLength\":\"65535\"},{\"tableSchema\":\"tansci_boot\",\"tableName\":\"magic_api_backup\",\"columnName\":\"create_by\",\"columnComment\":\"操作人\",\"columnKey\":\"\",\"dataType\":\"varchar\",\"isNullable\":\"YES\",\"columnType\":\"varchar(255)\",\"columnLength\":\"255\"},{\"tableSchema\":\"tansci_boot\",\"tableName\":\"magic_api_backup\",\"columnName\":\"create_date\",\"columnComment\":\"备份时间\",\"columnKey\":\"\",\"dataType\":\"datetime\",\"isNullable\":\"YES\",\"columnType\":\"datetime\",\"columnLength\":null},{\"tableSchema\":\"tansci_boot\",\"tableName\":\"magic_api_backup\",\"columnName\":\"id\",\"columnComment\":\"原对象ID\",\"columnKey\":\"PRI\",\"dataType\":\"varchar\",\"isNullable\":\"NO\",\"columnType\":\"varchar(32)\",\"columnLength\":\"32\"},{\"tableSchema\":\"tansci_boot\",\"tableName\":\"magic_api_backup\",\"columnName\":\"name\",\"columnComment\":\"原名称\",\"columnKey\":\"\",\"dataType\":\"varchar\",\"isNullable\":\"YES\",\"columnType\":\"varchar(255)\",\"columnLength\":\"255\"},{\"tableSchema\":\"tansci_boot\",\"tableName\":\"magic_api_backup\",\"columnName\":\"tag\",\"columnComment\":\"标签\",\"columnKey\":\"\",\"dataType\":\"varchar\",\"isNullable\":\"YES\",\"columnType\":\"varchar(32)\",\"columnLength\":\"32\"},{\"tableSchema\":\"tansci_boot\",\"tableName\":\"magic_api_backup\",\"columnName\":\"type\",\"columnComment\":\"类型\",\"columnKey\":\"\",\"dataType\":\"varchar\",\"isNullable\":\"YES\",\"columnType\":\"varchar(255)\",\"columnLength\":\"255\"}]', NULL, NULL, '[]', '{\"moduleName\":\"api\",\"modulePath\":\"/api\",\"businessName\":\"test\",\"businessPath\":\"/test\",\"template\":\"single\",\"pid\":\"\",\"treeId\":\"\",\"treePid\":\"\",\"subTable\":\"\",\"subTableKey\":\"\"}', NULL, '2023-04-28 15:09:03');

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
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '失败原因',
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
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件名称',
  `open_mode` int NULL DEFAULT 0 COMMENT '打开方式：0、默认，1、iframe，2、新标签页',
  `is_del` int NULL DEFAULT 0 COMMENT '是否删除：0、未删除，1、已删除',
  `keep_alive` int NULL DEFAULT NULL COMMENT '是否缓存：0、不缓存，1、缓存',
  `is_show` int NULL DEFAULT NULL COMMENT '是否显示：1显示，0不显示',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('06936eec3258c1fa675c8b6b697160f5', '1ec1c1cb127d83f6346904220b3ed20b', '', '', '', '列表', '', 'dict:list', 0, '', 0, 0, 0, 0, '2023-04-13 16:26:51', '2023-04-13 16:26:51', '');
INSERT INTO `sys_menu` VALUES ('07e1aebb5b69b55b7eb0ce79fed00f40', 'b1851d1b13594e71840103c11a37a004', '', '', '', '列表', '', 'org:list', 3, '', 0, 0, 0, 0, '2023-04-13 10:35:47', '2023-04-13 10:35:47', '');
INSERT INTO `sys_menu` VALUES ('11107c717306bd0d9e993cf32a94974e', 'b1851d1b13594e71840103c11a37a006', '', '', '', '删除', '', 'user:delete', 3, NULL, 0, 0, 0, 0, '2023-04-13 11:34:29', '2023-04-13 11:34:29', NULL);
INSERT INTO `sys_menu` VALUES ('120d967459a9e7323692b3fa49c1ba59', '0', 'monitor', '/monitor', 'Odometer', '系统监控', 'Monitor', NULL, 3, NULL, 0, 0, 1, 1, '2023-04-14 08:44:27', '2023-04-14 08:44:27', '');
INSERT INTO `sys_menu` VALUES ('1ec1c1cb127d83f6346904220b3ed20b', 'b1851d1b13594e71840103c11a37a002', 'dict', '/system/Dict', 'Coin', '字典管理', 'Dist', NULL, 5, NULL, 0, 0, 0, 1, '2023-04-13 16:26:19', '2023-04-13 16:26:19', NULL);
INSERT INTO `sys_menu` VALUES ('223588533ceb03066c89940863dc747e', 'b25838d6e06c6cdad82c1ad9b1096f26', 'codeGen', '/lowcode/CodeGen', 'SwitchFilled', '代码生成', 'CodeGen', NULL, 2, NULL, 0, 0, 1, 1, '2023-04-14 08:54:08', '2023-04-14 08:54:08', '');
INSERT INTO `sys_menu` VALUES ('44979f524b88ed2dfbf14e4267ebd045', 'b1851d1b13594e71840103c11a37a004', '', '', '', '删除', '', 'org:delete', 1, '', 0, 0, 0, 0, '2023-04-13 10:34:53', '2023-04-13 10:34:53', '');
INSERT INTO `sys_menu` VALUES ('5de088a93f0828a57e4c70959831458b', 'b1851d1b13594e71840103c11a37a004', '', '', '', '保存', '', 'org:save', 0, '', 0, 0, 0, 0, '2023-04-13 10:33:43', '2023-04-13 10:33:43', '');
INSERT INTO `sys_menu` VALUES ('5df7c65d51129baefee123ef3bc2d7de', 'ea83fb03d2117cb287973d6889984686', 'magicapi', 'https://www.ssssssss.org/magic-api/pages/quick/single/', 'Clock', '框架', 'magicapi', NULL, 2, '', 1, 0, 0, 1, '2023-04-11 11:25:08', '2023-04-11 11:25:08', NULL);
INSERT INTO `sys_menu` VALUES ('5e67672047d0a00bf861ba2255535238', '1ec1c1cb127d83f6346904220b3ed20b', '', '', '', '修改', '', 'dict:update', 2, '', 0, 0, 0, 0, '2023-04-13 16:27:29', '2023-04-13 16:27:29', '');
INSERT INTO `sys_menu` VALUES ('628431d108e3530ac37dfa2180dff376', '1ec1c1cb127d83f6346904220b3ed20b', '', '', '', '保存', '', 'dict:save', 1, '', 0, 0, 0, 0, '2023-04-13 16:27:07', '2023-04-13 16:27:07', '');
INSERT INTO `sys_menu` VALUES ('7b02ec134bcd2a74b7930ce03da4b8bb', '120d967459a9e7323692b3fa49c1ba59', 'loginLog', '/monitor/LoginLog', 'User', '登录日志', 'LoginLog', NULL, 1, NULL, 0, 0, 1, 1, '2023-04-14 08:48:07', '2023-04-14 08:48:07', '');
INSERT INTO `sys_menu` VALUES ('850a1c29af28318e6e470a14aaeb50e5', 'b1851d1b13594e71840103c11a37a006', '', '', '', '保存', '', 'user:save', 0, '', 0, 0, 0, 0, '2023-04-13 11:33:37', '2023-04-13 11:33:37', '');
INSERT INTO `sys_menu` VALUES ('9658b61b187ae33b7c8c39fc8c1265dc', '120d967459a9e7323692b3fa49c1ba59', 'onlineUser', '/monitor/OnlineUser', 'Avatar', '在线用户', 'OnlineUser', NULL, 3, NULL, 0, 0, 1, 1, '2023-04-14 08:50:35', '2023-04-14 08:50:35', '');
INSERT INTO `sys_menu` VALUES ('9a36ed1841e3e6d2da32df17980edaa2', 'b25838d6e06c6cdad82c1ad9b1096f26', 'interface', '/lowcode/Interface', 'Connection', '接口开发', 'Interface', NULL, 1, NULL, 0, 0, 1, 1, '2023-04-14 08:52:17', '2023-04-14 08:52:17', '');
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a002', '0', 'system', '/system', 'Tools', '系统管理', 'System', NULL, 1, NULL, 0, 0, 0, 1, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a003', 'b1851d1b13594e71840103c11a37a002', 'menu', '/system/Menu', 'Grid', '菜单管理', 'Menu', NULL, 2, NULL, 0, 0, 0, 1, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a004', 'b1851d1b13594e71840103c11a37a002', 'org', '/system/Org', 'SetUp', '组织管理', 'Org', NULL, 3, NULL, 0, 0, 0, 1, '2023-04-13 11:30:56', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a005', 'b1851d1b13594e71840103c11a37a002', 'role', '/system/Role', 'Help', '角色管理', 'Role', NULL, 4, NULL, 0, 0, 0, 1, '2023-04-13 11:32:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a006', 'b1851d1b13594e71840103c11a37a002', 'user', '/system/User', 'User', '用户管理', 'User', NULL, 5, NULL, 0, 0, 0, 1, '2023-04-13 11:32:34', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a007', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '保存', 'save', 'menu:save', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a008', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '删除', 'delete', 'menu:delete', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a009', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '修改', 'update', 'menu:update', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a010', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '详情', 'view', 'menu:view', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b1851d1b13594e71840103c11a37a011', 'b1851d1b13594e71840103c11a37a003', NULL, NULL, NULL, '列表', 'list', 'menu:list', 6, NULL, 0, 0, 0, 0, '2023-03-29 08:57:50', '2023-03-29 08:57:52', NULL);
INSERT INTO `sys_menu` VALUES ('b25838d6e06c6cdad82c1ad9b1096f26', '0', 'lowcode', '/lowcode', 'Edit', '应用开发', 'Lowcode', NULL, 4, NULL, 0, 0, 1, 1, '2023-04-14 08:46:15', '2023-04-14 08:46:15', '');
INSERT INTO `sys_menu` VALUES ('b4cfa05bff2269fee06788b32115851a', 'b1851d1b13594e71840103c11a37a006', '', '', '', '修改', '', 'user:update', 1, '', 0, 0, 0, 0, '2023-04-13 14:44:51', '2023-04-13 11:34:04', '');
INSERT INTO `sys_menu` VALUES ('b8db9ff560e383e59d604e19c9fbd3cb', 'b1851d1b13594e71840103c11a37a006', '', '', '', '列表', '', 'user:list', 4, '', 0, 0, 0, 0, '2023-04-13 11:34:49', '2023-04-13 11:34:49', '');
INSERT INTO `sys_menu` VALUES ('b9401c42bc1e58e0a48e6b3308cff617', '1ec1c1cb127d83f6346904220b3ed20b', '', '', '', '删除', '', 'dict:delete', 4, '', 0, 0, 0, 0, '2023-04-13 16:27:48', '2023-04-13 16:27:48', '');
INSERT INTO `sys_menu` VALUES ('ea83fb03d2117cb287973d6889984686', '0', 'demo', '/demo', 'ChromeFilled', '菜单实例', 'Demo', NULL, 2, '', 0, 0, 1, 1, '2023-04-11 11:10:46', '2023-04-11 11:10:46', NULL);
INSERT INTO `sys_menu` VALUES ('f3138bd5b256d82f9eebe07c6679cf15', 'b1851d1b13594e71840103c11a37a004', '', '', '', '修改', '', 'org:update', 2, '', 0, 0, 0, 0, '2023-04-13 10:35:17', '2023-04-13 10:35:17', '');
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0666', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '列表', 'list', 'role:list', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0667', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '添加', 'save', 'role:save', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0668', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '修改', 'update', 'role:update', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0669', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '删除', 'delete', 'role:delete', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0670', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '菜单权限', 'menu', 'role:menu', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0671', 'b1851d1b13594e71840103c11a37a005', NULL, NULL, NULL, '数据权限', 'data', 'role:data', 1, '', 0, 0, 0, 0, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('f8b972bc005a9c6691a43b76839b0675', 'ea83fb03d2117cb287973d6889984686', 'Iframe', 'https://www.bing.com/?mkt=zh-CN', 'Bicycle', '必应', 'Iframe', NULL, 1, '', 1, 0, 0, 1, '2023-04-11 11:26:05', '2023-04-11 11:12:16', NULL);
INSERT INTO `sys_menu` VALUES ('fdaf429afb33d54beeee7eaea93e5e96', '120d967459a9e7323692b3fa49c1ba59', 'operLog', '/monitor/OperLog', 'Cpu', '操作日志', 'OperLog', NULL, 2, NULL, 0, 0, 1, 1, '2023-04-14 08:49:04', '2023-04-14 08:49:04', '');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键id',
  `module` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '功能模块',
  `method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作方法',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `message` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `req_param` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '请求参数',
  `res_param` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '响应参数',
  `take_up_time` int NULL DEFAULT NULL COMMENT '耗时',
  `user_id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作用户id',
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作用户名称',
  `status` int NULL DEFAULT NULL COMMENT '状态：0、成功，1、失败',
  `uri` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '请求url',
  `ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '请求IP',
  `unusual` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '异常信息',
  `version` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '版本号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '操作日志' ROW_FORMAT = DYNAMIC;

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
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `is_del` int(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '删除状态：0、正常，1、删除',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '组织' ROW_FORMAT = DYNAMIC;

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
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色编码',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '0：全部，1：自定义，2：本级级子级，3：本级',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `is_del` int NULL DEFAULT 0 COMMENT '是否删除：0未删除，1已删除',
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
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '06936eec3258c1fa675c8b6b697160f5');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '07e1aebb5b69b55b7eb0ce79fed00f40');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '11107c717306bd0d9e993cf32a94974e');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '1ec1c1cb127d83f6346904220b3ed20b');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '44979f524b88ed2dfbf14e4267ebd045');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '5de088a93f0828a57e4c70959831458b');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '5e67672047d0a00bf861ba2255535238');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '628431d108e3530ac37dfa2180dff376');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', '850a1c29af28318e6e470a14aaeb50e5');
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
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b4cfa05bff2269fee06788b32115851a');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b8db9ff560e383e59d604e19c9fbd3cb');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'b9401c42bc1e58e0a48e6b3308cff617');
INSERT INTO `sys_role_menu` VALUES ('534a37c366ec47878a6b0c85703d0bc3', 'f3138bd5b256d82f9eebe07c6679cf15');
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
  `type` int NULL DEFAULT NULL COMMENT '用户类型：1、管理员，2、普通用户',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` int NULL DEFAULT NULL COMMENT '性别：0、男，1、女',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `is_login` int NULL DEFAULT 0 COMMENT '禁止登录：0未禁用，1已禁用',
  `is_del` int NULL DEFAULT 0 COMMENT '删除标识：0未删除，1已删除',
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
INSERT INTO `sys_user` VALUES ('3ad1bd6b76c2e5573ea1805b7d68c6a9', 'system', '管理者', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 2, '18810011002', '', 0, '2023-04-03', 1, 0, NULL, '甘肃兰州', NULL, 'system@qq.com', NULL, '2023-04-14 15:50:12', '2023-04-13 14:41:21', '普通管理者');
INSERT INTO `sys_user` VALUES ('534a37c366ec47878a6b0c85703d0bc2', 'admin', '管理员', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, NULL, NULL, 0, '2023-03-29', 0, 0, '', '', '', '', NULL, '2023-04-14 15:48:44', '2023-03-29 08:49:27', NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户id',
  `role_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('3ad1bd6b76c2e5573ea1805b7d68c6a9', '441b6dae329b3a20ad8b4f4ca8f83a0b');
INSERT INTO `sys_user_role` VALUES ('534a37c366ec47878a6b0c85703d0bc2', '534a37c366ec47878a6b0c85703d0bc3');

SET FOREIGN_KEY_CHECKS = 1;
