/*
Navicat MySQL Data Transfer

Source Server         : 新健康小程序
Source Server Version : 80016
Source Host           : 39.98.197.245:3306
Source Database       : timo

Target Server Type    : MYSQL
Target Server Version : 80016
File Encoding         : 65001

Date: 2019-05-24 08:44:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `timo_sys_action_log`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_action_log`;
CREATE TABLE `timo_sys_action_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) DEFAULT NULL COMMENT '日志名称',
  `type` tinyint(4) DEFAULT NULL COMMENT '日志类型',
  `ipaddr` varchar(255) DEFAULT NULL COMMENT '操作IP地址',
  `clazz` varchar(255) DEFAULT NULL COMMENT '产生日志的类',
  `method` varchar(255) DEFAULT NULL COMMENT '产生日志的方法',
  `model` varchar(255) DEFAULT NULL COMMENT '产生日志的表',
  `record_id` bigint(20) DEFAULT NULL COMMENT '产生日志的数据id',
  `message` text COMMENT '日志消息',
  `create_date` datetime DEFAULT NULL COMMENT '记录时间',
  `oper_name` varchar(255) DEFAULT NULL COMMENT '产生日志的用户昵称',
  `oper_by` bigint(20) DEFAULT NULL COMMENT '产生日志的用户',
  PRIMARY KEY (`id`),
  KEY `FK32gm4dja0jetx58r9dc2uljiu` (`oper_by`),
  CONSTRAINT `FK32gm4dja0jetx58r9dc2uljiu` FOREIGN KEY (`oper_by`) REFERENCES `timo_sys_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2231 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for `timo_sys_dept`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_dept`;
CREATE TABLE `timo_sys_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) DEFAULT NULL COMMENT '部门名称',
  `pid` bigint(20) DEFAULT NULL COMMENT '父级ID',
  `pids` varchar(255) DEFAULT NULL COMMENT '所有父级编号',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态（1:正常,2:冻结,3:删除）',
  PRIMARY KEY (`id`),
  KEY `FKifwd1h4ciusl3nnxrpfpv316u` (`create_by`),
  KEY `FK83g45s1cjqqfpifhulqhv807m` (`update_by`),
  CONSTRAINT `FK83g45s1cjqqfpifhulqhv807m` FOREIGN KEY (`update_by`) REFERENCES `timo_sys_user` (`id`),
  CONSTRAINT `FKifwd1h4ciusl3nnxrpfpv316u` FOREIGN KEY (`create_by`) REFERENCES `timo_sys_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_dept
-- ----------------------------
INSERT INTO `timo_sys_dept` VALUES ('1', '系统管理员', '0', '[0]', '2', '系统设计者专用，客户或用户不可有该部门权限', '2018-12-02 17:41:23', '2019-05-14 17:41:43', '1', '1', '1');
INSERT INTO `timo_sys_dept` VALUES ('2', '超级管理员', '1', '[0],[1]', '1', '客户或用户的最高权限', '2018-12-02 17:51:04', '2019-05-20 14:08:57', '1', '1', '1');
INSERT INTO `timo_sys_dept` VALUES ('3', '管理员', '2', '[0],[1],[2]', '1', '管理员，有所属学校的管理权限', '2018-12-02 17:51:42', '2019-05-20 14:09:06', '1', '1', '1');
INSERT INTO `timo_sys_dept` VALUES ('4', '审核员', '3', '[0],[1],[2],[3]', '1', '审核员', '2018-12-02 17:51:55', '2019-05-20 15:42:29', '1', '1', '1');
INSERT INTO `timo_sys_dept` VALUES ('10', '二级审核员', '4', '[0],[1],[2],[3],[4]', '1', '二级审核员', '2019-05-14 17:27:40', '2019-05-20 09:00:47', '1', '1', '3');
INSERT INTO `timo_sys_dept` VALUES ('11', '三级审核员', '1', '[0],[1]', '2', '三级审核员', '2019-05-14 17:28:11', '2019-05-20 15:42:29', '1', '1', '1');
INSERT INTO `timo_sys_dept` VALUES ('12', '审核员三级', '10', '[0],[1],[2],[3],[4],[10]', '1', '', '2019-05-18 15:49:04', '2019-05-20 08:59:15', '3', '1', '3');

-- ----------------------------
-- Table structure for `timo_sys_dept_role`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_dept_role`;
CREATE TABLE `timo_sys_dept_role` (
  `dept_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`dept_id`,`role_id`),
  KEY `FKfrubw8st08shvsbvtg3kiwndc` (`role_id`),
  CONSTRAINT `FKfrubw8st08shvsbvtg3kiwndc` FOREIGN KEY (`role_id`) REFERENCES `timo_sys_role` (`id`),
  CONSTRAINT `FKpvu8vocmccq1oq7g94gn4pcyt` FOREIGN KEY (`dept_id`) REFERENCES `timo_sys_dept` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_dept_role
-- ----------------------------

-- ----------------------------
-- Table structure for `timo_sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_dict`;
CREATE TABLE `timo_sys_dict` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) DEFAULT NULL COMMENT '字典名称',
  `name` varchar(255) DEFAULT NULL COMMENT '字典键名',
  `type` tinyint(4) DEFAULT NULL COMMENT '字典类型',
  `value` text COMMENT '字典键值',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态（1:正常,2:冻结,3:删除）',
  PRIMARY KEY (`id`),
  KEY `FKag4shuprf2tjot9i1mhh37kk6` (`create_by`),
  KEY `FKoyng5jlifhsme0gc1lwiub0lr` (`update_by`),
  CONSTRAINT `FKag4shuprf2tjot9i1mhh37kk6` FOREIGN KEY (`create_by`) REFERENCES `timo_sys_user` (`id`),
  CONSTRAINT `FKoyng5jlifhsme0gc1lwiub0lr` FOREIGN KEY (`update_by`) REFERENCES `timo_sys_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_dict
-- ----------------------------
INSERT INTO `timo_sys_dict` VALUES ('1', '数据状态', 'DATA_STATUS', '2', '1:正常,2:冻结,3:删除', '', '2018-10-05 16:03:11', '2018-10-05 16:11:41', '1', '1', '1');
INSERT INTO `timo_sys_dict` VALUES ('2', '字典类型', 'DICT_TYPE', '2', '2:键值对', '', '2018-10-05 20:08:55', '2019-01-17 23:39:23', '1', '1', '1');
INSERT INTO `timo_sys_dict` VALUES ('3', '用户性别', 'USER_SEX', '2', '1:男,2:女', '', '2018-10-05 20:12:32', '2018-10-05 20:12:32', '1', '1', '1');
INSERT INTO `timo_sys_dict` VALUES ('4', '菜单类型', 'MENU_TYPE', '2', '1:一级菜单,2:子级菜单,3:不是菜单', '', '2018-10-05 20:24:57', '2018-10-13 13:56:05', '1', '1', '1');
INSERT INTO `timo_sys_dict` VALUES ('5', '搜索栏状态', 'SEARCH_STATUS', '2', '1:正常,2:冻结', '', '2018-10-05 20:25:45', '2019-02-26 00:34:34', '1', '1', '1');
INSERT INTO `timo_sys_dict` VALUES ('6', '日志类型', 'LOG_TYPE', '2', '1:业务,2:登录,3:系统', '', '2018-10-05 20:28:47', '2019-02-26 00:31:43', '1', '1', '1');

-- ----------------------------
-- Table structure for `timo_sys_file`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_file`;
CREATE TABLE `timo_sys_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) DEFAULT NULL COMMENT '文件名',
  `path` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `mime` varchar(255) DEFAULT NULL COMMENT 'MIME文件类型',
  `size` bigint(20) DEFAULT NULL COMMENT '文件大小',
  `md5` varchar(255) DEFAULT NULL COMMENT 'MD5值',
  `sha1` varchar(255) DEFAULT NULL COMMENT 'SHA1值',
  `create_by` bigint(20) DEFAULT NULL COMMENT '上传者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `FKkkles8yp0a156p4247cc22ovn` (`create_by`),
  CONSTRAINT `FKkkles8yp0a156p4247cc22ovn` FOREIGN KEY (`create_by`) REFERENCES `timo_sys_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_file
-- ----------------------------
INSERT INTO `timo_sys_file` VALUES ('1', '08582a007bfb4193850268d8ae3e94f1.jpg', '/upload/picture/20190520/08582a007bfb4193850268d8ae3e94f1.jpg', 'image/jpeg', '13807', '6c91ef0dd0419c00626e1ab890887aa6', 'bfa451ebd1d156de6ca701629cec619ba847cb8f', '1', '2019-05-20 09:46:01');

-- ----------------------------
-- Table structure for `timo_sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_menu`;
CREATE TABLE `timo_sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) DEFAULT NULL COMMENT '菜单名称',
  `pid` bigint(20) DEFAULT NULL COMMENT '父级编号',
  `pids` varchar(255) DEFAULT NULL COMMENT '所有父级编号',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL地址',
  `perms` varchar(255) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型（1:一级菜单,2:子级菜单,3:不是菜单）',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态（1:正常,2:冻结,3:删除）',
  PRIMARY KEY (`id`),
  KEY `FKoxg2hi96yr9pf2m0stjomr3we` (`create_by`),
  KEY `FKsiko0qcr8ddamvrxf1tk4opgc` (`update_by`),
  CONSTRAINT `FKoxg2hi96yr9pf2m0stjomr3we` FOREIGN KEY (`create_by`) REFERENCES `timo_sys_user` (`id`),
  CONSTRAINT `FKsiko0qcr8ddamvrxf1tk4opgc` FOREIGN KEY (`update_by`) REFERENCES `timo_sys_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_menu
-- ----------------------------
INSERT INTO `timo_sys_menu` VALUES ('1', '菜单管理', '2', '[0],[2]', '/system/menu/index', 'system:menu:index', '', '2', '3', '', '2018-09-29 00:02:10', '2019-02-24 16:10:40', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('2', '系统管理', '0', '[0]', '#', '#', 'fa fa-cog', '1', '2', '', '2018-09-29 00:05:50', '2019-02-27 21:34:56', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('3', '添加', '1', '[0],[2],[1]', '/system/menu/add', 'system:menu:add', '', '3', '1', '', '2018-09-29 00:06:57', '2019-02-24 16:12:59', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('4', '角色管理', '2', '[0],[2]', '/system/role/index', 'system:role:index', '', '2', '2', '', '2018-09-29 00:08:14', '2019-02-24 16:10:34', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('5', '添加', '4', '[0],[2],[4]', '/system/role/add', 'system:role:add', '', '3', '1', '', '2018-09-29 00:09:04', '2019-02-24 16:12:04', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('6', '主页', '0', '[0]', '/index', 'index', 'layui-icon layui-icon-home', '1', '1', '', '2018-09-29 00:09:56', '2019-02-27 21:34:56', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('7', '用户管理', '2', '[0],[2]', '/system/user/index', 'system:user:index', '', '2', '1', '', '2018-09-29 00:43:50', '2019-04-05 17:43:25', '1', '2', '1');
INSERT INTO `timo_sys_menu` VALUES ('8', '编辑', '1', '[0],[2],[1]', '/system/menu/edit', 'system:menu:edit', '', '3', '2', '', '2018-09-29 00:57:33', '2019-02-24 16:13:05', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('9', '详细', '1', '[0],[2],[1]', '/system/menu/detail', 'system:menu:detail', '', '3', '3', '', '2018-09-29 01:03:00', '2019-02-24 16:13:12', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('10', '修改状态', '1', '[0],[2],[1]', '/system/menu/status', 'system:menu:status', '', '3', '4', '', '2018-09-29 01:03:43', '2019-02-24 16:13:21', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('11', '编辑', '4', '[0],[2],[4]', '/system/role/edit', 'system:role:edit', '', '3', '2', '', '2018-09-29 01:06:13', '2019-02-24 16:12:10', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('12', '授权', '4', '[0],[2],[4]', '/system/role/auth', 'system:role:auth', '', '3', '3', '', '2018-09-29 01:06:57', '2019-02-24 16:12:17', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('13', '详细', '4', '[0],[2],[4]', '/system/role/detail', 'system:role:detail', '', '3', '4', '', '2018-09-29 01:08:00', '2019-02-24 16:12:24', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('14', '修改状态', '4', '[0],[2],[4]', '/system/role/status', 'system:role:status', '', '3', '5', '', '2018-09-29 01:08:22', '2019-02-24 16:12:43', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('15', '编辑', '7', '[0],[2],[7]', '/system/user/edit', 'system:user:edit', '', '3', '2', '', '2018-09-29 21:17:17', '2019-02-24 16:11:03', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('16', '添加', '7', '[0],[2],[7]', '/system/user/add', 'system:user:add', '', '3', '1', '', '2018-09-29 21:17:58', '2019-02-24 16:10:28', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('17', '修改密码', '7', '[0],[2],[7]', '/system/user/pwd', 'system:user:pwd', '', '3', '3', '', '2018-09-29 21:19:40', '2019-02-24 16:11:11', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('18', '权限分配', '136', '[0],[2],[7]', '/system/dept/role', 'system:dept:role', '', '3', '3', '', '2018-09-29 21:20:35', '2019-05-18 16:43:45', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('19', '详细', '7', '[0],[2],[7]', '/system/user/detail', 'system:user:detail', '', '3', '6', '', '2018-09-29 21:21:00', '2019-05-15 17:05:57', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('20', '修改状态', '7', '[0],[2],[7]', '/system/user/status', 'system:user:status', '', '3', '7', '', '2018-09-29 21:21:18', '2019-05-15 17:05:57', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('21', '字典管理', '2', '[0],[2]', '/system/dict/index', 'system:dict:index', '', '2', '5', '', '2018-10-05 00:55:52', '2019-02-24 16:14:24', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('22', '字典添加', '21', '[0],[2],[21]', '/system/dict/add', 'system:dict:add', '', '3', '1', '', '2018-10-05 00:56:26', '2019-02-24 16:14:10', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('23', '字典编辑', '21', '[0],[2],[21]', '/system/dict/edit', 'system:dict:edit', '', '3', '2', '', '2018-10-05 00:57:08', '2019-02-24 16:14:34', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('24', '字典详细', '21', '[0],[2],[21]', '/system/dict/detail', 'system:dict:detail', '', '3', '3', '', '2018-10-05 00:57:42', '2019-02-24 16:14:41', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('25', '修改状态', '21', '[0],[2],[21]', '/system/dict/status', 'system:dict:status', '', '3', '4', '', '2018-10-05 00:58:27', '2019-02-24 16:14:49', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('26', '行为日志', '2', '[0],[2]', '/system/actionLog/index', 'system:actionLog:index', '', '2', '6', '', '2018-10-14 16:52:01', '2019-02-27 21:34:15', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('27', '日志详细', '26', '[0],[2],[26]', '/system/actionLog/detail', 'system:actionLog:detail', '', '3', '1', '', '2018-10-14 21:07:11', '2019-02-27 21:34:15', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('28', '日志删除', '26', '[0],[2],[26]', '/system/actionLog/delete', 'system:actionLog:delete', '', '3', '2', '', '2018-10-14 21:08:17', '2019-02-27 21:34:15', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('30', '开发中心', '0', '[0]', '#', '#', 'fa fa-gavel', '1', '3', '', '2018-10-19 16:38:23', '2019-02-27 21:34:56', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('31', '代码生成', '30', '[0],[30]', '/dev/code', '#', '', '2', '1', '', '2018-10-19 16:39:04', '2019-03-13 17:43:58', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('125', '表单构建', '30', '[0],[30]', '/dev/build', '#', '', '2', '2', '', '2018-11-25 16:12:23', '2019-02-24 16:16:40', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('136', '部门管理', '2', '[0],[2]', '/system/dept/index', 'system:dept:index', '', '2', '4', '', '2018-12-02 16:33:23', '2019-02-24 16:10:50', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('137', '添加', '136', '[0],[2],[136]', '/system/dept/add', 'system:dept:add', '', '3', '1', '', '2018-12-02 16:33:23', '2019-02-24 16:13:34', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('138', '编辑', '136', '[0],[2],[136]', '/system/dept/edit', 'system:dept:edit', '', '3', '2', '', '2018-12-02 16:33:23', '2019-02-24 16:13:42', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('139', '详细', '136', '[0],[2],[136]', '/system/dept/detail', 'system:dept:detail', '', '3', '4', '', '2018-12-02 16:33:23', '2019-05-20 15:43:19', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('140', '改变状态', '136', '[0],[2],[136]', '/system/dept/status', 'system:dept:status', '', '3', '5', '', '2018-12-02 16:33:23', '2019-05-18 16:43:45', '1', '1', '1');
INSERT INTO `timo_sys_menu` VALUES ('146', '数据接口', '30', '[0],[30]', '/dev/swagger', '#', '', '2', '3', '', '2018-12-09 21:11:11', '2019-02-24 23:38:18', '1', '1', '1');

-- ----------------------------
-- Table structure for `timo_sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_role`;
CREATE TABLE `timo_sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) DEFAULT NULL COMMENT '角色名称（中文名）',
  `name` varchar(255) DEFAULT NULL COMMENT '标识名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建用户',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态（1:正常,2:冻结,3:删除）',
  PRIMARY KEY (`id`),
  KEY `FKdkwvv0rm6j3d5l6hwsy2dplol` (`create_by`),
  KEY `FKrouqqi3f2bgc5o83wdstlh6q4` (`update_by`),
  CONSTRAINT `FKdkwvv0rm6j3d5l6hwsy2dplol` FOREIGN KEY (`create_by`) REFERENCES `timo_sys_user` (`id`),
  CONSTRAINT `FKrouqqi3f2bgc5o83wdstlh6q4` FOREIGN KEY (`update_by`) REFERENCES `timo_sys_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_role
-- ----------------------------
INSERT INTO `timo_sys_role` VALUES ('1', '系统管理设计权限', 'admin', '开发人员', '2018-09-29 00:12:40', '2019-05-15 14:44:16', '1', '1', '1');
INSERT INTO `timo_sys_role` VALUES ('2', '超级管理员', 'group', '用户或客户的最高权限，有所有学校的权限', '2018-09-30 16:04:32', '2019-05-23 18:07:18', '1', '1', '1');
INSERT INTO `timo_sys_role` VALUES ('3', '管理员', 'group1', '管理员　有所属学校', '2018-09-30 16:24:20', '2019-05-15 14:58:29', '1', '1', '1');
INSERT INTO `timo_sys_role` VALUES ('16', '审核员', 'group2', '审核', '2019-05-14 17:45:49', '2019-05-20 14:12:07', '1', '1', '1');

-- ----------------------------
-- Table structure for `timo_sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_role_menu`;
CREATE TABLE `timo_sys_role_menu` (
  `role_id` bigint(20) NOT NULL,
  `menu_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `FKf3mud4qoc7ayew8nml4plkevo` (`menu_id`),
  CONSTRAINT `FKf3mud4qoc7ayew8nml4plkevo` FOREIGN KEY (`menu_id`) REFERENCES `timo_sys_menu` (`id`),
  CONSTRAINT `FKkeitxsgxwayackgqllio4ohn5` FOREIGN KEY (`role_id`) REFERENCES `timo_sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_role_menu
-- ----------------------------
INSERT INTO `timo_sys_role_menu` VALUES ('1', '1');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '2');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '2');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '2');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '2');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '3');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '4');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '5');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '6');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '6');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '6');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '6');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '7');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '7');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '7');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '7');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '8');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '9');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '10');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '11');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '12');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '13');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '14');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '15');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '15');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '15');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '15');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '16');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '16');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '16');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '16');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '17');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '17');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '17');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '17');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '18');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '18');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '18');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '18');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '19');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '19');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '19');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '19');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '20');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '20');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '20');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '20');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '21');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '22');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '23');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '24');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '25');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '26');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '27');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '28');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '30');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '31');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '125');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '136');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '136');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '136');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '136');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '137');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '137');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '137');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '137');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '138');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '138');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '138');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '138');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '139');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '139');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '139');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '139');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '140');
INSERT INTO `timo_sys_role_menu` VALUES ('2', '140');
INSERT INTO `timo_sys_role_menu` VALUES ('3', '140');
INSERT INTO `timo_sys_role_menu` VALUES ('16', '140');
INSERT INTO `timo_sys_role_menu` VALUES ('1', '146');

-- ----------------------------
-- Table structure for `timo_sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_user`;
CREATE TABLE `timo_sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(255) DEFAULT NULL COMMENT '用户昵称',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `salt` varchar(255) DEFAULT NULL COMMENT '密码盐',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `picture` varchar(255) DEFAULT NULL COMMENT '头像',
  `sex` varchar(255) DEFAULT NULL COMMENT '性别（1:男,2:女）',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态（1:正常,2:冻结,3:删除）',
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKb3pkx0wbo6o8i8lj0gxr37v1n` (`dept_id`),
  CONSTRAINT `FKb3pkx0wbo6o8i8lj0gxr37v1n` FOREIGN KEY (`dept_id`) REFERENCES `timo_sys_dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_user
-- ----------------------------
INSERT INTO `timo_sys_user` VALUES ('-123', 'admin6', '孟柯', '76bd6d66b626c5701883603da8b1f6a068826e9b60e541f51aa3e0d27d377f44', 'SU3W24', '4', null, '1', '', '', '2019-05-20 11:10:51', '2019-05-20 11:18:06', '1', '123123');
INSERT INTO `timo_sys_user` VALUES ('1', 'admin', '系统设计人员', '3dd0affe1e514fa059d00bf63134fe48d45acd3f350aaed83b0b54ef05579092', '3ABR79', '1', '/upload/picture/20190520/08582a007bfb4193850268d8ae3e94f1.jpg', '1', '10086@163.com', '', '2018-08-09 23:00:03', '2019-05-20 11:18:53', '1', '10086');
INSERT INTO `timo_sys_user` VALUES ('2', 'admin1', '小懒虫', '6eedf58b5cd2723005b92f4418bc3618079f4451cfc10266d5b6ffbb04f77e33', 'YW5zWP', '2', null, '2', '1008612@qq.com', '', '2018-09-30 16:25:22', '2019-05-23 15:36:45', '1', '1008682');
INSERT INTO `timo_sys_user` VALUES ('3', 'admin2', 'asdasd111', 'ee30c9d438d8b9f743c59ad6576af84875a143cba943f121e65096794421a49b', '5GeWHF', '3', null, '1', 'asd', '', '2019-05-16 19:00:14', '2019-05-20 11:08:14', '1', 'asd');
INSERT INTO `timo_sys_user` VALUES ('5', 'admin7', '1asd', '44278f56db82c172ac481c783f69630d8b220c22b8d246a481f8e384a81eb335', 'Onx4k2', '4', null, '1', '', '', '2019-05-20 11:14:58', '2019-05-20 15:40:08', '1', 'sadasd');

-- ----------------------------
-- Table structure for `timo_sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `timo_sys_user_role`;
CREATE TABLE `timo_sys_user_role` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FKhh52n8vd4ny9ff4x9fb8v65qx` (`role_id`),
  CONSTRAINT `FKb40xxfch70f5qnyfw8yme1n1s` FOREIGN KEY (`user_id`) REFERENCES `timo_sys_user` (`id`),
  CONSTRAINT `FKhh52n8vd4ny9ff4x9fb8v65qx` FOREIGN KEY (`role_id`) REFERENCES `timo_sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timo_sys_user_role
-- ----------------------------
