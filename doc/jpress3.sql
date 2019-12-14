/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : jpress3

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 13/12/2019 21:22:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for area_manage
-- ----------------------------
DROP TABLE IF EXISTS `area_manage`;
CREATE TABLE `area_manage` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int(11) unsigned NOT NULL COMMENT '区域经理ID',
  `area_code` varchar(20) DEFAULT NULL COMMENT '区域码',
  `area_name` varchar(256) DEFAULT NULL COMMENT '区域名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='区域管理';

-- ----------------------------
-- Records of area_manage
-- ----------------------------
BEGIN;
INSERT INTO `area_manage` VALUES (1, 4, '320000', '江苏省');
COMMIT;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(11) DEFAULT NULL COMMENT '子版本的文章id',
  `slug` varchar(128) DEFAULT NULL COMMENT 'slug',
  `title` varchar(256) DEFAULT '' COMMENT '标题',
  `content` longtext COMMENT '内容',
  `edit_mode` varchar(32) DEFAULT 'html' COMMENT '编辑模式，默认为html，其他可选项包括html，markdown ..',
  `summary` text COMMENT '摘要',
  `link_to` varchar(512) DEFAULT NULL COMMENT '连接到(常用于谋文章只是一个连接)',
  `thumbnail` varchar(512) DEFAULT NULL COMMENT '缩略图',
  `style` varchar(32) DEFAULT NULL COMMENT '样式',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '用户ID',
  `order_number` int(11) DEFAULT '0' COMMENT '排序编号',
  `status` varchar(32) DEFAULT NULL COMMENT '状态',
  `comment_status` tinyint(1) DEFAULT '1' COMMENT '评论状态，默认允许评论',
  `comment_count` int(11) unsigned DEFAULT '0' COMMENT '评论总数',
  `comment_time` datetime DEFAULT NULL COMMENT '最后评论时间',
  `view_count` int(11) unsigned DEFAULT '0' COMMENT '访问量',
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `modified` datetime DEFAULT NULL COMMENT '最后更新日期',
  `flag` varchar(256) DEFAULT NULL COMMENT '标识，通常用于对某几篇文章进行标识，从而实现单独查询',
  `meta_keywords` varchar(512) DEFAULT NULL COMMENT 'SEO关键字',
  `meta_description` varchar(512) DEFAULT NULL COMMENT 'SEO描述信息',
  `remarks` text COMMENT '备注信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `user_id` (`user_id`),
  KEY `created` (`created`),
  KEY `view_count` (`view_count`),
  KEY `order_number` (`order_number`),
  KEY `status` (`status`),
  KEY `flag` (`flag`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章表';

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级分类的ID',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '分类创建的用户ID',
  `slug` varchar(128) DEFAULT NULL COMMENT 'slug',
  `title` varchar(512) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容描述',
  `summary` text COMMENT '摘要',
  `style` varchar(32) DEFAULT NULL COMMENT '模板样式',
  `type` varchar(32) DEFAULT NULL COMMENT '类型，比如：分类、tag、专题',
  `icon` varchar(128) DEFAULT NULL COMMENT '图标',
  `count` int(11) unsigned DEFAULT '0' COMMENT '该分类的内容数量',
  `order_number` int(11) DEFAULT '0' COMMENT '排序编码',
  `flag` varchar(256) DEFAULT NULL COMMENT '标识',
  `meta_keywords` varchar(256) DEFAULT NULL COMMENT 'SEO关键字',
  `meta_description` varchar(256) DEFAULT NULL COMMENT 'SEO描述内容',
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `modified` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`),
  KEY `typeslug` (`type`,`slug`),
  KEY `order_number` (`order_number`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章分类表。标签、专题、类别等都属于category。';

-- ----------------------------
-- Table structure for article_category_mapping
-- ----------------------------
DROP TABLE IF EXISTS `article_category_mapping`;
CREATE TABLE `article_category_mapping` (
  `article_id` int(11) unsigned NOT NULL COMMENT '文章ID',
  `category_id` int(11) unsigned NOT NULL COMMENT '分类ID',
  PRIMARY KEY (`article_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章和分类的多对多关系表';

-- ----------------------------
-- Table structure for article_comment
-- ----------------------------
DROP TABLE IF EXISTS `article_comment`;
CREATE TABLE `article_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(11) unsigned DEFAULT NULL COMMENT '回复的评论ID',
  `article_id` int(11) unsigned DEFAULT NULL COMMENT '评论的内容ID',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '评论的用户ID',
  `author` varchar(128) DEFAULT NULL COMMENT '评论的作者',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `wechat` varchar(64) DEFAULT NULL COMMENT '微信号',
  `qq` varchar(32) DEFAULT NULL COMMENT 'qq号',
  `content` text COMMENT '评论的内容',
  `reply_count` int(11) unsigned DEFAULT '0' COMMENT '评论的回复数量',
  `order_number` int(11) DEFAULT '0' COMMENT '排序编号，常用语置顶等',
  `vote_up` int(11) unsigned DEFAULT '0' COMMENT '“顶”的数量',
  `vote_down` int(11) unsigned DEFAULT '0' COMMENT '“踩”的数量',
  `status` varchar(32) DEFAULT NULL COMMENT '评论的状态',
  `created` datetime DEFAULT NULL COMMENT '评论的时间',
  PRIMARY KEY (`id`),
  KEY `content_id` (`article_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章评论表';

-- ----------------------------
-- Table structure for attachment
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID主键',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '上传附件的用户ID',
  `title` text COMMENT '标题',
  `description` text COMMENT '附件描述',
  `path` varchar(512) DEFAULT NULL COMMENT '路径',
  `mime_type` varchar(128) DEFAULT NULL COMMENT 'mime',
  `suffix` varchar(32) DEFAULT NULL COMMENT '附件的后缀',
  `type` varchar(32) DEFAULT NULL COMMENT '类型',
  `flag` varchar(256) DEFAULT NULL COMMENT '标示',
  `order_number` int(11) DEFAULT '0' COMMENT '排序字段',
  `accessible` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可以被访问',
  `created` datetime DEFAULT NULL COMMENT '上传时间',
  `modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created` (`created`),
  KEY `suffix` (`suffix`),
  KEY `mime_type` (`mime_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='附件表，用于保存用户上传的附件内容。';

-- ----------------------------
-- Records of attachment
-- ----------------------------
BEGIN;
INSERT INTO `attachment` VALUES (1, 2, '1559596943937.jpeg', NULL, '/attachment/20191213/4ff67331c79442bfaf74e1b17ff84ab6.jpeg', 'image/jpeg', '.jpeg', NULL, NULL, 0, 1, '2019-12-13 15:22:13', NULL);
INSERT INTO `attachment` VALUES (2, 2, '1559596943937.jpeg', NULL, '/attachment/20191213/61616fca72884f55bede1b8bd7692f8a.jpeg', 'image/jpeg', '.jpeg', NULL, NULL, 0, 1, '2019-12-13 15:22:27', NULL);
INSERT INTO `attachment` VALUES (3, 2, '1559596943937.jpeg', NULL, '/attachment/20191213/372ec2a652b4440e8055e20794f65bdf.jpeg', 'image/jpeg', '.jpeg', NULL, NULL, 0, 1, '2019-12-13 15:48:25', NULL);
INSERT INTO `attachment` VALUES (4, 2, '433249', NULL, '/attachment/20191213/a9404468d50442fd8ade480897c34478null', 'application/octet-stream', NULL, NULL, NULL, 0, 1, '2019-12-13 15:48:40', NULL);
INSERT INTO `attachment` VALUES (5, 2, '1559596943937.jpeg', NULL, '/attachment/20191213/dab57af852ef43f08f0ac5f2aa8306c3.jpeg', 'image/jpeg', '.jpeg', NULL, NULL, 0, 1, '2019-12-13 15:48:56', NULL);
COMMIT;

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '例如：无门槛50元优惠券 | 单品最高减2000元''',
  `icon` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint(2) DEFAULT NULL COMMENT '1满减券  2叠加满减券  3无门槛券  ',
  `with_amount` decimal(10,2) DEFAULT NULL COMMENT '满多少金额',
  `with_member` tinyint(1) DEFAULT NULL COMMENT '会员可用',
  `with_award` tinyint(1) DEFAULT NULL COMMENT '是否是推广奖励券',
  `with_owner` tinyint(1) DEFAULT NULL COMMENT '是不是只有领取人可用，如果不是，领取人可以随便给其他人用',
  `with_multi` tinyint(1) DEFAULT NULL COMMENT '是否多人可用，如果是，拥有者可用分享给任何人',
  `amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '优惠券金额',
  `award_amount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '奖励金额，大咖可以使用自己的优惠码推广用户，用户获得优惠，大咖获得奖励金额',
  `quota` int(11) unsigned NOT NULL COMMENT '配额：发券数量',
  `take_count` int(11) unsigned DEFAULT '0' COMMENT '已领取的优惠券数量',
  `used_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '已使用的优惠券数量',
  `start_time` datetime DEFAULT NULL COMMENT '发放开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '发放结束时间',
  `valid_type` tinyint(2) DEFAULT NULL COMMENT '时效:1绝对时效（XXX-XXX时间段有效）  2相对时效（领取后N天有效）',
  `valid_start_time` datetime DEFAULT NULL COMMENT '使用开始时间',
  `valid_end_time` datetime DEFAULT NULL COMMENT '使用结束时间',
  `valid_days` int(11) DEFAULT NULL COMMENT '自领取之日起有效天数',
  `status` tinyint(2) DEFAULT NULL COMMENT '1生效 2失效 3已结束',
  `create_user_id` int(11) unsigned DEFAULT NULL COMMENT '创建用户',
  `options` text COLLATE utf8mb4_unicode_ci,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠券';

-- ----------------------------
-- Table structure for coupon_code
-- ----------------------------
DROP TABLE IF EXISTS `coupon_code`;
CREATE TABLE `coupon_code` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) unsigned DEFAULT NULL COMMENT '类型ID',
  `title` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '优惠券标题',
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '优惠码',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '用户ID',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 1未领取 2未使用、3使用中、9不能使用',
  `valid_time` datetime DEFAULT NULL COMMENT '领取时间',
  `created` datetime DEFAULT NULL COMMENT '创建时间，创建时可能不会有人领取',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠券领取记录';

-- ----------------------------
-- Table structure for coupon_product
-- ----------------------------
DROP TABLE IF EXISTS `coupon_product`;
CREATE TABLE `coupon_product` (
  `product_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品的类型，默认是 product',
  `product_id` int(11) unsigned NOT NULL COMMENT '商品的id',
  `coupon_id` int(11) unsigned NOT NULL COMMENT '优惠券ID',
  PRIMARY KEY (`product_type`,`product_id`,`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠券关联商品信息表';

-- ----------------------------
-- Table structure for coupon_used_record
-- ----------------------------
DROP TABLE IF EXISTS `coupon_used_record`;
CREATE TABLE `coupon_used_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `used_user_id` int(11) unsigned NOT NULL COMMENT '使用优惠码的用户',
  `used_user_nickname` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '使用优惠码的用户ID',
  `used_order_id` int(11) unsigned DEFAULT NULL COMMENT '订单ID',
  `user_payment_id` int(10) unsigned DEFAULT NULL COMMENT '支付的ID',
  `code_id` int(11) unsigned NOT NULL COMMENT '优惠码ID',
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '优惠码名称',
  `code_user_id` int(11) unsigned NOT NULL COMMENT '优惠券归属的用户ID',
  `code_user_nickname` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '优惠券归属的用户昵称',
  `created` datetime DEFAULT NULL COMMENT '使用时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠券使用记录';

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned DEFAULT NULL COMMENT '会员组id',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '用户id',
  `duetime` datetime DEFAULT NULL COMMENT '到期时间',
  `remark` text COLLATE utf8mb4_unicode_ci,
  `source` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(2) DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员信息';

-- ----------------------------
-- Table structure for member_dist_amount
-- ----------------------------
DROP TABLE IF EXISTS `member_dist_amount`;
CREATE TABLE `member_dist_amount` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL COMMENT '会员组',
  `product_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品类型',
  `product_id` int(11) unsigned NOT NULL COMMENT '产品的ID',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '分销的收益',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  `modified` int(11) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `proinfo` (`group_id`,`product_type`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员分销收益表';

-- ----------------------------
-- Table structure for member_group
-- ----------------------------
DROP TABLE IF EXISTS `member_group`;
CREATE TABLE `member_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '会员名称',
  `title` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `icon` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '会员ICON',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '会员内容、简介',
  `summary` text COLLATE utf8mb4_unicode_ci COMMENT '摘要',
  `thumbnail` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '缩略图',
  `video` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '视频',
  `order_number` int(11) DEFAULT '0' COMMENT '排序编号',
  `price` decimal(10,2) DEFAULT NULL COMMENT '加入的会员价格',
  `limited_price` decimal(10,2) DEFAULT NULL COMMENT '限时价格',
  `limited_time` datetime DEFAULT NULL COMMENT '限时价格到期时间',
  `dist_enable` tinyint(1) DEFAULT NULL COMMENT '是否启用分销功能',
  `dist_amount` decimal(10,2) DEFAULT NULL COMMENT '分销收益金额',
  `valid_term` int(11) DEFAULT NULL COMMENT '有效时间（单位天）',
  `flag` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标识',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态',
  `with_ucenter` tinyint(1) DEFAULT NULL COMMENT '是否显示在用户中心',
  `options` text COLLATE utf8mb4_unicode_ci,
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flag` (`flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员组信息';

-- ----------------------------
-- Table structure for member_joined_record
-- ----------------------------
DROP TABLE IF EXISTS `member_joined_record`;
CREATE TABLE `member_joined_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '用户',
  `group_id` int(11) unsigned DEFAULT NULL COMMENT '加入的会员组',
  `group_name` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '会员组名称',
  `join_price` decimal(10,2) DEFAULT NULL COMMENT '加入的价格',
  `join_count` int(11) DEFAULT NULL COMMENT '加入份数，可能会一次购买多份（多年）会员。',
  `join_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '加入的类型：付费加入、免费赠送等',
  `join_from` tinyint(2) DEFAULT NULL COMMENT '加入来源：后台手动添加，用户自己购买',
  `valid_term` int(11) DEFAULT NULL COMMENT '加入的有效时间',
  `options` text COLLATE utf8mb4_unicode_ci,
  `created` datetime DEFAULT NULL COMMENT '加入的时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员加入记录';

-- ----------------------------
-- Table structure for member_price
-- ----------------------------
DROP TABLE IF EXISTS `member_price`;
CREATE TABLE `member_price` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` int(11) unsigned NOT NULL,
  `group_id` int(11) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL COMMENT '会员价',
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proinfo` (`product_type`,`product_id`,`group_id`),
  KEY `pid` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员价格表';

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `pid` int(11) unsigned DEFAULT NULL COMMENT '父级ID',
  `text` varchar(128) DEFAULT NULL COMMENT '文本内容',
  `url` varchar(512) DEFAULT NULL COMMENT '链接的url',
  `target` varchar(32) DEFAULT NULL COMMENT '打开的方式',
  `icon` varchar(64) DEFAULT NULL COMMENT '菜单的icon',
  `flag` varchar(32) DEFAULT NULL COMMENT '菜单标识',
  `type` varchar(32) DEFAULT '' COMMENT '菜单类型：主菜单、顶部菜单、底部菜单',
  `order_number` int(11) DEFAULT '0' COMMENT '排序字段',
  `relative_table` varchar(32) DEFAULT NULL COMMENT '该菜单是否和其他表关联',
  `relative_id` int(11) unsigned DEFAULT NULL COMMENT '关联的具体数据id',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  `modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `order_number` (`order_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜单表';

-- ----------------------------
-- Table structure for option
-- ----------------------------
DROP TABLE IF EXISTS `option`;
CREATE TABLE `option` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `key` varchar(128) DEFAULT NULL COMMENT '配置KEY',
  `value` text COMMENT '配置内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COMMENT='配置信息表，用来保存网站的所有配置信息。';

-- ----------------------------
-- Records of option
-- ----------------------------
BEGIN;
INSERT INTO `option` VALUES (1, 'jpress_version', 'v3.0.0-rc.2');
INSERT INTO `option` VALUES (2, 'jpress_version_code', '3');
INSERT INTO `option` VALUES (5, 'api_prohibit_urls', NULL);
INSERT INTO `option` VALUES (6, 'csrf_token', 'c982dac53b394a5d8962f22567fc2d56');
INSERT INTO `option` VALUES (7, 'api_test_secret', NULL);
INSERT INTO `option` VALUES (8, 'api_test_urls', NULL);
INSERT INTO `option` VALUES (9, 'api_app_id', 'appidi8thcGWps7Ki5Sh2');
INSERT INTO `option` VALUES (10, 'api_enable', 'true');
INSERT INTO `option` VALUES (11, 'api_secret', 'secretDWrKVEopj96eLckR');
INSERT INTO `option` VALUES (12, 'connection_sms_appid', 'n8fhjIPA9hbE0XhR');
INSERT INTO `option` VALUES (13, 'connection_email_password', NULL);
INSERT INTO `option` VALUES (14, 'connection_sms_enable', 'true');
INSERT INTO `option` VALUES (15, 'connection_email_ssl_enable', 'false');
INSERT INTO `option` VALUES (16, 'connection_sms_type', 'aliyun');
INSERT INTO `option` VALUES (17, 'connection_email_enable', 'false');
INSERT INTO `option` VALUES (18, 'connection_email_account', NULL);
INSERT INTO `option` VALUES (19, 'connection_sms_appsecret', 'TwFXz2AOyKvo2jpcBFXvxqHgLKNPgO');
INSERT INTO `option` VALUES (20, 'connection_email_smtp', NULL);
INSERT INTO `option` VALUES (21, 'addon-install:io.jpress.addon.entre', 'true');
INSERT INTO `option` VALUES (22, 'addon-start:io.jpress.addon.entre', 'true');
INSERT INTO `option` VALUES (23, 'web_subtitle', '官网');
INSERT INTO `option` VALUES (24, 'web_ipc_no', NULL);
INSERT INTO `option` VALUES (25, 'web_title', '不一社区');
INSERT INTO `option` VALUES (26, 'web_domain', 'http://192.168.43.248:8080');
INSERT INTO `option` VALUES (27, 'web_mater_mobile', NULL);
INSERT INTO `option` VALUES (28, 'web_mater_wxopenid', NULL);
INSERT INTO `option` VALUES (29, 'web_mater_email', NULL);
INSERT INTO `option` VALUES (30, 'web_name', '不一社区');
INSERT INTO `option` VALUES (31, 'web_copyright', NULL);
COMMIT;

-- ----------------------------
-- Table structure for payment_record
-- ----------------------------
DROP TABLE IF EXISTS `payment_record`;
CREATE TABLE `payment_record` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_title` varchar(256) DEFAULT '' COMMENT '商品名称',
  `product_summary` varchar(512) DEFAULT NULL COMMENT '产品描述，产品摘要',
  `product_relative_id` varchar(64) DEFAULT NULL COMMENT '相关产品ID',
  `product_relative_type` varchar(32) DEFAULT NULL COMMENT '相关产品类型',
  `product_relative_type_text` varchar(64) DEFAULT NULL,
  `trx_no` varchar(50) NOT NULL COMMENT '支付流水号',
  `trx_type` varchar(30) DEFAULT NULL COMMENT '交易业务类型  ：消费、充值等',
  `trx_nonce_str` varchar(64) DEFAULT NULL COMMENT '签名随机字符串，一般是用来防止重放攻击',
  `payer_user_id` int(11) unsigned DEFAULT NULL COMMENT '付款人编号',
  `payer_name` varchar(256) DEFAULT NULL COMMENT '付款人名称',
  `payer_fee` decimal(20,6) DEFAULT '0.000000' COMMENT '付款方手续费',
  `order_ip` varchar(30) DEFAULT NULL COMMENT '下单ip(客户端ip,从网关中获取)',
  `order_referer_url` varchar(1024) DEFAULT NULL COMMENT '从哪个页面链接过来的(可用于防诈骗)',
  `order_from` varchar(30) DEFAULT NULL COMMENT '订单来源',
  `pay_status` tinyint(2) DEFAULT NULL COMMENT '支付状态：1生成订单未支付（预支付）、 2支付失败、 9自动在线支付成功、 10支付宝转账支付成功、 11微信转账支付成功、 12线下支付支付成功（一般是银行转账等）、 13其他支付方式支付成功',
  `pay_type` varchar(50) DEFAULT NULL COMMENT '支付类型编号',
  `pay_bank_type` varchar(128) DEFAULT NULL COMMENT '支付银行类型',
  `pay_amount` decimal(20,6) DEFAULT '0.000000' COMMENT '订单金额',
  `pay_success_amount` decimal(20,6) DEFAULT NULL COMMENT '成功支付金额',
  `pay_success_time` datetime DEFAULT NULL COMMENT '支付成功时间',
  `pay_success_proof` varchar(256) DEFAULT NULL COMMENT '支付证明，手动入账时需要截图',
  `pay_success_remarks` varchar(256) DEFAULT NULL COMMENT '支付备注',
  `pay_complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `refund_no` varchar(64) DEFAULT NULL COMMENT '退款流水号',
  `refund_amount` int(11) DEFAULT NULL COMMENT '退款金额',
  `refund_desc` varchar(256) DEFAULT NULL COMMENT '退款描述',
  `refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  `thirdparty_type` varchar(32) DEFAULT NULL COMMENT '第三方支付平台',
  `thirdparty_appid` varchar(32) DEFAULT NULL COMMENT '微信appid 或者 支付宝的appid，thirdparty 指的是支付的第三方比如微信、支付宝、PayPal等',
  `thirdparty_mch_id` varchar(32) DEFAULT NULL COMMENT '商户号',
  `thirdparty_trade_type` varchar(16) DEFAULT NULL COMMENT '交易类型',
  `thirdparty_transaction_id` varchar(32) DEFAULT NULL,
  `thirdparty_user_openid` varchar(64) DEFAULT NULL,
  `remark` text COMMENT '备注',
  `status` tinyint(2) DEFAULT NULL COMMENT 'payment状态：1预支付、 2支付失败、 9支付成功、 11预退款、 12退款中、 13退款失败、 19退款成功',
  `options` text,
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trx_no` (`trx_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付记录表';

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `action_key` varchar(512) NOT NULL DEFAULT '' COMMENT '唯一标识',
  `node` varchar(512) NOT NULL DEFAULT '' COMMENT '属于大的分类，可能是Controller、大的DIV、或菜单组',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT '权限的类型：url、页面元素、菜单',
  `text` varchar(1024) DEFAULT NULL COMMENT '菜单描述',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `node_actionKey` (`node`(191),`action_key`(191))
) ENGINE=InnoDB AUTO_INCREMENT=324 DEFAULT CHARSET=utf8mb4 COMMENT='权限表';

-- ----------------------------
-- Records of permission
-- ----------------------------
BEGIN;
INSERT INTO `permission` VALUES (1, '/admin/addon/test', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (2, '/api/jsonws/invoke', 'io.jpress.addon.entre.JSONWSRouteController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (3, '/admin', 'io.jpress.web.admin._AdminController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (4, '/admin/addon', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (5, '/admin/addon/changelog', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (6, '/admin/addon/doDel', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (7, '/admin/addon/doInstall', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (8, '/admin/addon/doStart', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (9, '/admin/addon/doStop', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (10, '/admin/addon/doUninstall', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (11, '/admin/addon/doUploadAndInstall', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (12, '/admin/addon/doUploadAndUpgrade', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (13, '/admin/addon/install', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (14, '/admin/addon/readme', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (15, '/admin/addon/upgrade', 'io.jpress.web.admin._AddonController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (16, '/admin/article', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (17, '/admin/article/category', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (18, '/admin/article/comment', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (19, '/admin/article/commentEdit', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (20, '/admin/article/commentReply', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (21, '/admin/article/doCategoryDel', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (22, '/admin/article/doCategorySave', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (23, '/admin/article/doChangeEditMode', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (24, '/admin/article/doCommentAuditByIds', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (25, '/admin/article/doCommentDel', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (26, '/admin/article/doCommentDelByIds', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (27, '/admin/article/doCommentReply', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (28, '/admin/article/doCommentSave', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (29, '/admin/article/doCommentStatusChange', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (30, '/admin/article/doDel', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (31, '/admin/article/doDelByIds', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (32, '/admin/article/doDraft', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (33, '/admin/article/doNormal', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (34, '/admin/article/doTagSave', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (35, '/admin/article/doTrash', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (36, '/admin/article/doWriteSave', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (37, '/admin/article/setting', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (38, '/admin/article/tag', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (39, '/admin/article/write', 'io.jpress.module.article.controller._ArticleController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (40, '/admin/attachment', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (41, '/admin/attachment/browse', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (42, '/admin/attachment/detail', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (43, '/admin/attachment/doBatchDelRootFile', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (44, '/admin/attachment/doDel', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (45, '/admin/attachment/doDelRootFile', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (46, '/admin/attachment/doUpdate', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (47, '/admin/attachment/doUplaodRootFile', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (48, '/admin/attachment/root', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (49, '/admin/attachment/setting', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (50, '/admin/attachment/upload', 'io.jpress.web.admin._AttachmentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (51, '/admin/doLogin', 'io.jpress.web.admin._AdminController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (52, '/admin/doLogout', 'io.jpress.web.admin._AdminController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (53, '/admin/entre/area_manage', 'io.jpress.module.entre.controller._AreaManageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (54, '/admin/entre/area_manage/areaMngers', 'io.jpress.module.entre.controller._AreaManageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (55, '/admin/entre/area_manage/audit', 'io.jpress.module.entre.controller._AreaManageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (56, '/admin/entre/area_manage/customer', 'io.jpress.module.entre.controller._AreaManageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (57, '/admin/entre/area_manage/doDel', 'io.jpress.module.entre.controller._AreaManageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (58, '/admin/entre/area_manage/doSave', 'io.jpress.module.entre.controller._AreaManageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (59, '/admin/entre/area_manage/edit', 'io.jpress.module.entre.controller._AreaManageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (60, '/admin/finance/coupon', 'io.jpress.web.admin._CouponController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (61, '/admin/finance/coupon/doDel', 'io.jpress.web.admin._CouponController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (62, '/admin/finance/coupon/doDelByIds', 'io.jpress.web.admin._CouponController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (63, '/admin/finance/coupon/doSave', 'io.jpress.web.admin._CouponController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (64, '/admin/finance/coupon/edit', 'io.jpress.web.admin._CouponController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (65, '/admin/finance/coupon/takes', 'io.jpress.web.admin._CouponController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (66, '/admin/finance/coupon/useds', 'io.jpress.web.admin._CouponController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (67, '/admin/finance/doPayUpdate', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (68, '/admin/finance/doPayoutProcess', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (69, '/admin/finance/doPayoutRefuse', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (70, '/admin/finance/payDetail', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (71, '/admin/finance/payUpdate', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (72, '/admin/finance/paylist', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (73, '/admin/finance/payout', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (74, '/admin/finance/payoutdetail', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (75, '/admin/finance/payoutprocess', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (76, '/admin/finance/payoutrefuse', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (77, '/admin/finance/setting', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (78, '/admin/finance/setting_notify', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (79, '/admin/finance/setting_pay', 'io.jpress.web.admin._FinanceController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (80, '/admin/login', 'io.jpress.web.admin._AdminController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (81, '/admin/option/doDeleteByKey', 'io.jpress.web.admin._OptionController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (82, '/admin/option/doSave', 'io.jpress.web.admin._OptionController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (83, '/admin/option/doSaveOrUpdate', 'io.jpress.web.admin._OptionController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (84, '/admin/order', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (85, '/admin/order/deliver', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (86, '/admin/order/detail', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (87, '/admin/order/doUpdateDeliver', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (88, '/admin/order/doUpdateInvoice', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (89, '/admin/order/doUpdatePaystatus', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (90, '/admin/order/doUpdatePrice', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (91, '/admin/order/doUpdateRemark', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (92, '/admin/order/invoice', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (93, '/admin/order/remark', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (94, '/admin/order/updatePaystatus', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (95, '/admin/order/updatePrice', 'io.jpress.web.admin._OrderController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (96, '/admin/page', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (97, '/admin/page/comment', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (98, '/admin/page/commentEdit', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (99, '/admin/page/commentReply', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (100, '/admin/page/doChangeEditMode', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (101, '/admin/page/doCommentAuditByIds', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (102, '/admin/page/doCommentDel', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (103, '/admin/page/doCommentDelByIds', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (104, '/admin/page/doCommentReply', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (105, '/admin/page/doCommentStatusChange', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (106, '/admin/page/doDel', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (107, '/admin/page/doDelByIds', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (108, '/admin/page/doDraft', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (109, '/admin/page/doNormal', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (110, '/admin/page/doTrash', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (111, '/admin/page/doWriteSave', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (112, '/admin/page/setting', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (113, '/admin/page/write', 'io.jpress.module.page.controller._PageController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (114, '/admin/permission', 'io.jpress.web.admin._PermissionController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (115, '/admin/permission/syncPermissions', 'io.jpress.web.admin._PermissionController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (116, '/admin/product', 'io.jpress.module.product.controller._ProductController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (117, '/admin/product/category', 'io.jpress.module.product.controller._ProductCategoryController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (118, '/admin/product/category/doDel', 'io.jpress.module.product.controller._ProductCategoryController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (119, '/admin/product/category/doSave', 'io.jpress.module.product.controller._ProductCategoryController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (120, '/admin/product/comment', 'io.jpress.module.product.controller._ProductCommentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (121, '/admin/product/comment/doDel', 'io.jpress.module.product.controller._ProductCommentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (122, '/admin/product/comment/doDelByIds', 'io.jpress.module.product.controller._ProductCommentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (123, '/admin/product/comment/doSave', 'io.jpress.module.product.controller._ProductCommentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (124, '/admin/product/comment/edit', 'io.jpress.module.product.controller._ProductCommentController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (125, '/admin/product/doDel', 'io.jpress.module.product.controller._ProductController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (126, '/admin/product/doDelByIds', 'io.jpress.module.product.controller._ProductController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (127, '/admin/product/doDraft', 'io.jpress.module.product.controller._ProductController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (128, '/admin/product/doNormal', 'io.jpress.module.product.controller._ProductController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (129, '/admin/product/doSave', 'io.jpress.module.product.controller._ProductController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (130, '/admin/product/doTrash', 'io.jpress.module.product.controller._ProductController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (131, '/admin/product/edit', 'io.jpress.module.product.controller._ProductController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (132, '/admin/product/setting', 'io.jpress.module.product.controller._ProductController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (133, '/admin/product/tag', 'io.jpress.module.product.controller._ProductTagController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (134, '/admin/product/tag/doDel', 'io.jpress.module.product.controller._ProductTagController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (135, '/admin/product/tag/doSave', 'io.jpress.module.product.controller._ProductTagController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (136, '/admin/setting', 'io.jpress.web.admin._SettingController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (137, '/admin/setting/api', 'io.jpress.web.admin._SettingController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (138, '/admin/setting/cdn', 'io.jpress.web.admin._SettingController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (139, '/admin/setting/connection', 'io.jpress.web.admin._SettingController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (140, '/admin/setting/icons', 'io.jpress.web.admin._SettingController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (141, '/admin/setting/reg', 'io.jpress.web.admin._SettingController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (142, '/admin/setting/seo', 'io.jpress.web.admin._SettingController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (143, '/admin/setting/testEmail', 'io.jpress.web.admin._SettingController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (144, '/admin/setting/tools', 'io.jpress.web.admin._SettingController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (145, '/admin/setting/tools/markdown', 'io.jpress.module.article.controller._MarkdownImport', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (146, '/admin/setting/tools/markdown/doMarkdownImport', 'io.jpress.module.article.controller._MarkdownImport', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (147, '/admin/setting/tools/wechat', 'io.jpress.module.article.controller._WechatArticleImport', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (148, '/admin/setting/tools/wechat/doImport', 'io.jpress.module.article.controller._WechatArticleImport', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (149, '/admin/setting/tools/wechat/replaceLast', 'io.jpress.module.article.controller._WechatArticleImport', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (150, '/admin/setting/tools/wordpress', 'io.jpress.module.article.controller._WordpressImport', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (151, '/admin/setting/tools/wordpress/doWordPressImport', 'io.jpress.module.article.controller._WordpressImport', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (152, '/admin/template', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (153, '/admin/template/doDelFile', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (154, '/admin/template/doEditSave', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (155, '/admin/template/doEnable', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (156, '/admin/template/doInstall', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (157, '/admin/template/doMenuDel', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (158, '/admin/template/doMenuSave', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (159, '/admin/template/doUninstall', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (160, '/admin/template/doUploadFile', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (161, '/admin/template/edit', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (162, '/admin/template/install', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (163, '/admin/template/menu', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (164, '/admin/template/setting', 'io.jpress.web.admin._TemplateController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (165, '/admin/user', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (166, '/admin/user/detail', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (167, '/admin/user/detail/avatar', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (168, '/admin/user/detail/communication', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (169, '/admin/user/detail/finance', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (170, '/admin/user/detail/member', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (171, '/admin/user/detail/other', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (172, '/admin/user/detail/pwd', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (173, '/admin/user/detail/role', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (174, '/admin/user/detail/signature', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (175, '/admin/user/detail/tag', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (176, '/admin/user/detail/utm', 'io.jpress.web.admin._UserInfoController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (177, '/admin/user/doAdd', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (178, '/admin/user/doAddGroupRolePermission', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (179, '/admin/user/doAddRolePermission', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (180, '/admin/user/doChangeRoleByIds', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (181, '/admin/user/doDelGroupRolePermission', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (182, '/admin/user/doDelRolePermission', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (183, '/admin/user/doMemberDel', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (184, '/admin/user/doMemberRenewal', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (185, '/admin/user/doMemberSave', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (186, '/admin/user/doMgroupDel', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (187, '/admin/user/doMgroupDelByIds', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (188, '/admin/user/doMgroupSave', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (189, '/admin/user/doRoleDel', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (190, '/admin/user/doRoleDelByIds', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (191, '/admin/user/doRoleSave', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (192, '/admin/user/doSaveAvatar', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (193, '/admin/user/doSaveUser', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (194, '/admin/user/doSendEmail', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (195, '/admin/user/doSendSms', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (196, '/admin/user/doSendWechat', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (197, '/admin/user/doTagDel', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (198, '/admin/user/doTagSave', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (199, '/admin/user/doUpdatePwd', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (200, '/admin/user/doUpdateUserRoles', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (201, '/admin/user/doUpdateUserTags', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (202, '/admin/user/doUserDel', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (203, '/admin/user/doUserDelByIds', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (204, '/admin/user/doUserStatusChange', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (205, '/admin/user/edit', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (206, '/admin/user/me', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (207, '/admin/user/memberRenewal', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (208, '/admin/user/memberedit', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (209, '/admin/user/mgroup', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (210, '/admin/user/mgroupEdit', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (211, '/admin/user/mgroupjoined', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (212, '/admin/user/permissions', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (213, '/admin/user/role', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (214, '/admin/user/roleEdit', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (215, '/admin/user/rolePermissions', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (216, '/admin/user/sendMsg', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (217, '/admin/user/sendMsg/sms', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (218, '/admin/user/sendMsg/wechat', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (219, '/admin/user/tag', 'io.jpress.web.admin._UserController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (220, '/admin/wechat/addons', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (221, '/admin/wechat/base', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (222, '/admin/wechat/doCloseAddon', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (223, '/admin/wechat/doDelReply', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (224, '/admin/wechat/doDelReplyByIds', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (225, '/admin/wechat/doEnableAddon', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (226, '/admin/wechat/doMenuDel', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (227, '/admin/wechat/doMenuSave', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (228, '/admin/wechat/doMenuSync', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (229, '/admin/wechat/doReplySave', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (230, '/admin/wechat/keyword', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (231, '/admin/wechat/keywordWrite', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (232, '/admin/wechat/menu', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (233, '/admin/wechat/miniprogram', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (234, '/admin/wechat/reply', 'io.jpress.web.admin._WechatController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (235, '/api/article', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (236, '/api/article/categories', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (237, '/api/article/category', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (238, '/api/article/commentPaginate', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (239, '/api/article/list', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (240, '/api/article/paginate', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (241, '/api/article/postComment', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (242, '/api/article/relevantList', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (243, '/api/article/save', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (244, '/api/article/tagArticles', 'io.jpress.module.article.api.ArticleApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (245, '/api/option', 'io.jpress.web.api.OptionApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (246, '/api/page', 'io.jpress.module.page.controller.PageApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (247, '/api/page/list', 'io.jpress.module.page.controller.PageApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (248, '/api/product', 'io.jpress.module.product.api.ProductApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (249, '/api/product/list', 'io.jpress.module.product.api.ProductApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (250, '/api/product/relevantList', 'io.jpress.module.product.api.ProductApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (251, '/api/user', 'io.jpress.web.api.UserApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (252, '/api/user/me', 'io.jpress.web.api.UserApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (253, '/api/user/save', 'io.jpress.web.api.UserApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (254, '/api/wechat/mp/code2session', 'io.jpress.web.api.WechatMiniProgramApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (255, '/api/wechat/mp/decryptUserInfo', 'io.jpress.web.api.WechatMiniProgramApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (256, '/api/wechat/mp/doGetOrCreateUser', 'io.jpress.web.api.WechatMiniProgramApiController', 'action', NULL, '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (257, 'order', 'order', 'menu', '财务', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (258, 'order:/admin/order', 'order', 'menu', '订单管理', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (259, 'order:/admin/finance/paylist', 'order', 'menu', '支付记录', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (260, 'order:/admin/finance/payout', 'order', 'menu', '提现管理', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (261, 'order:/admin/finance/coupon', 'order', 'menu', '优惠券', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (262, 'order:/admin/finance/setting', 'order', 'menu', '基础设置', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (263, 'order:/admin/finance/setting_pay', 'order', 'menu', '收款设置', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (264, 'order:/admin/finance/setting_notify', 'order', 'menu', '通知设置', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (265, 'user', 'user', 'menu', '用户', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (266, 'user:/admin/user', 'user', 'menu', '用户管理', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (267, 'user:/admin/user/tag', 'user', 'menu', '用户标签', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (268, 'user:/admin/user/mgroup', 'user', 'menu', '会员组', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (269, 'user:/admin/user/sendMsg', 'user', 'menu', '发消息', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (270, 'user:/admin/user/role', 'user', 'menu', '角色', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (271, 'user:/admin/permission', 'user', 'menu', '权限', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (272, 'user:/admin/user/me', 'user', 'menu', '我的资料', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (273, 'wechat_pubulic_account', 'wechat_pubulic_account', 'menu', '微信', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (274, 'wechat_pubulic_account:/admin/wechat/reply', 'wechat_pubulic_account', 'menu', '默认回复', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (275, 'wechat_pubulic_account:/admin/wechat/keyword', 'wechat_pubulic_account', 'menu', '自动回复', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (276, 'wechat_pubulic_account:/admin/wechat/addons', 'wechat_pubulic_account', 'menu', '运营插件', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (277, 'wechat_pubulic_account:/admin/wechat/menu', 'wechat_pubulic_account', 'menu', '菜单设置', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (278, 'wechat_pubulic_account:/admin/wechat/base', 'wechat_pubulic_account', 'menu', '基础设置', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (279, 'wechat_pubulic_account:/admin/wechat/miniprogram', 'wechat_pubulic_account', 'menu', '小程序', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (280, 'template', 'template', 'menu', '模板', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (281, 'template:/admin/template', 'template', 'menu', '所有模板', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (282, 'template:/admin/template/install', 'template', 'menu', '安装', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (283, 'template:/admin/template/menu', 'template', 'menu', '菜单', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (284, 'template:/admin/template/setting', 'template', 'menu', '设置', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (285, 'template:/admin/template/edit', 'template', 'menu', '编辑', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (286, 'addon', 'addon', 'menu', '插件', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (287, 'addon:/admin/addon', 'addon', 'menu', '所有插件', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (288, 'addon:/admin/addon/install', 'addon', 'menu', '安装', '2019-12-13 15:54:10', NULL);
INSERT INTO `permission` VALUES (289, 'addon:/admin/addon/test', 'addon', 'menu', '插件测试', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (290, 'system', 'system', 'menu', '系统', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (291, 'system:/admin/setting', 'system', 'menu', '常规', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (292, 'system:/admin/setting/connection', 'system', 'menu', '通信', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (293, 'system:/admin/setting/api', 'system', 'menu', '接口', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (294, 'system:/admin/setting/reg', 'system', 'menu', '登录注册', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (295, 'system:/admin/setting/cdn', 'system', 'menu', '网站加速', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (296, 'system:/admin/setting/seo', 'system', 'menu', '搜索优化', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (297, 'system:/admin/setting/tools', 'system', 'menu', '小工具箱', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (298, 'entre', 'entre', 'menu', '业务管理', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (299, 'entre:/admin/entre/area_manage', 'entre', 'menu', '区域管理', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (300, 'entre:/admin/entre/area_manage/customer', 'entre', 'menu', '客户管理', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (301, 'article', 'article', 'menu', '文章', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (302, 'article:/admin/article', 'article', 'menu', '文章管理', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (303, 'article:/admin/article/write', 'article', 'menu', '写文章', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (304, 'article:/admin/article/category', 'article', 'menu', '分类', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (305, 'article:/admin/article/tag', 'article', 'menu', '标签', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (306, 'article:/admin/article/comment', 'article', 'menu', '评论', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (307, 'article:/admin/article/setting', 'article', 'menu', '设置', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (308, 'page', 'page', 'menu', '页面', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (309, 'page:/admin/page', 'page', 'menu', '页面管理', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (310, 'page:/admin/page/write', 'page', 'menu', '新建', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (311, 'page:/admin/page/comment', 'page', 'menu', '评论', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (312, 'page:/admin/page/setting', 'page', 'menu', '设置', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (313, 'product', 'product', 'menu', '商品', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (314, 'product:/admin/product', 'product', 'menu', '商品列表', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (315, 'product:/admin/product/category', 'product', 'menu', '分类', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (316, 'product:/admin/product/tag', 'product', 'menu', '标签', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (317, 'product:/admin/product/comment', 'product', 'menu', '评论', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (318, 'product:/admin/product/setting', 'product', 'menu', '设置', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (319, 'attachment', 'attachment', 'menu', '附件', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (320, 'attachment:/admin/attachment', 'attachment', 'menu', '所有附件', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (321, 'attachment:/admin/attachment/upload', 'attachment', 'menu', '上传', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (322, 'attachment:/admin/attachment/setting', 'attachment', 'menu', '设置', '2019-12-13 15:54:11', NULL);
INSERT INTO `permission` VALUES (323, 'attachment:/admin/attachment/root', 'attachment', 'menu', '根目录', '2019-12-13 15:54:11', NULL);
COMMIT;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `slug` varchar(128) DEFAULT NULL COMMENT 'slug',
  `title` varchar(256) DEFAULT '' COMMENT '标题',
  `content` longtext COMMENT '内容',
  `summary` text COMMENT '摘要',
  `usp` text COMMENT '产品卖点',
  `thumbnail` varchar(512) DEFAULT NULL COMMENT '缩略图',
  `specs` varchar(512) DEFAULT NULL COMMENT '产品规格',
  `video` varchar(512) DEFAULT NULL COMMENT '视频',
  `video_cover` varchar(512) DEFAULT NULL,
  `style` varchar(32) DEFAULT NULL COMMENT '样式',
  `order_number` int(11) DEFAULT '0' COMMENT '排序编号',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '商品的用户ID',
  `user_divide_type` int(11) DEFAULT NULL COMMENT '商品的销售分成类型：0平台所有，1用户所有，2按比例分成',
  `user_divide_ratio` int(11) DEFAULT NULL COMMENT '用户分成比例',
  `price` decimal(10,2) DEFAULT NULL COMMENT '商品价格',
  `origin_price` decimal(10,2) DEFAULT NULL COMMENT '原始价格',
  `limited_price` decimal(10,2) DEFAULT NULL COMMENT '限时优惠价（早鸟价）',
  `limited_time` datetime DEFAULT NULL COMMENT '限时优惠截止时间',
  `dist_enable` tinyint(1) DEFAULT NULL COMMENT '是否启用分销',
  `dist_amount` decimal(10,2) DEFAULT NULL COMMENT '分销收益的金额',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态',
  `comment_status` tinyint(1) DEFAULT '1' COMMENT '评论状态，默认允许评论',
  `comment_count` int(11) unsigned DEFAULT '0' COMMENT '评论总数',
  `comment_time` datetime DEFAULT NULL COMMENT '最后评论时间',
  `view_count` int(11) unsigned DEFAULT '0' COMMENT '访问量',
  `real_view_count` int(11) unsigned DEFAULT '0' COMMENT '真实访问量',
  `sales_count` int(11) unsigned DEFAULT '0' COMMENT '销售量，用于放在前台显示',
  `real_sales_count` int(11) unsigned DEFAULT '0' COMMENT '真实的访问量',
  `stock` int(11) DEFAULT NULL COMMENT '剩余库存',
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `modified` datetime DEFAULT NULL COMMENT '最后更新日期',
  `flag` varchar(256) DEFAULT NULL COMMENT '标识，通常用于对某几篇文章进行标识，从而实现单独查询',
  `meta_keywords` varchar(512) DEFAULT NULL COMMENT 'SEO关键字',
  `meta_description` varchar(512) DEFAULT NULL COMMENT 'SEO描述信息',
  `remarks` text COMMENT '备注信息',
  `options` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `user_id` (`user_id`),
  KEY `created` (`created`),
  KEY `view_count` (`view_count`),
  KEY `order_number` (`order_number`),
  KEY `sales_count` (`sales_count`),
  KEY `status` (`status`),
  KEY `flag` (`flag`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级分类的ID',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '分类创建的用户ID',
  `slug` varchar(128) DEFAULT NULL COMMENT 'slug',
  `title` varchar(512) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容描述',
  `summary` text COMMENT '摘要',
  `style` varchar(32) DEFAULT NULL COMMENT '模板样式',
  `type` varchar(32) DEFAULT NULL COMMENT '类型，比如：分类、tag、专题',
  `icon` varchar(128) DEFAULT NULL COMMENT '图标',
  `count` int(11) unsigned DEFAULT '0' COMMENT '该分类的内容数量',
  `order_number` int(11) DEFAULT '0' COMMENT '排序编码',
  `flag` varchar(256) DEFAULT NULL COMMENT '标识',
  `meta_keywords` varchar(256) DEFAULT NULL COMMENT 'SEO关键字',
  `meta_description` varchar(256) DEFAULT NULL COMMENT 'SEO描述内容',
  `options` text,
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `modified` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`),
  KEY `typeslug` (`type`,`slug`),
  KEY `order_number` (`order_number`),
  KEY `pid` (`pid`),
  KEY `flag` (`flag`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表。标签、专题、类别等都属于category。';

-- ----------------------------
-- Table structure for product_category_mapping
-- ----------------------------
DROP TABLE IF EXISTS `product_category_mapping`;
CREATE TABLE `product_category_mapping` (
  `product_id` int(11) unsigned NOT NULL COMMENT '文章ID',
  `category_id` int(11) unsigned NOT NULL COMMENT '分类ID',
  PRIMARY KEY (`product_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品和分类的多对多关系表';

-- ----------------------------
-- Table structure for product_comment
-- ----------------------------
DROP TABLE IF EXISTS `product_comment`;
CREATE TABLE `product_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(11) unsigned DEFAULT NULL COMMENT '回复的评论ID',
  `product_id` int(11) unsigned DEFAULT NULL COMMENT '评论的产品ID',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '评论的用户ID',
  `author` varchar(128) DEFAULT NULL COMMENT '评论的作者',
  `content` text COMMENT '评论的内容',
  `reply_count` int(11) unsigned DEFAULT '0' COMMENT '评论的回复数量',
  `order_number` int(11) DEFAULT '0' COMMENT '排序编号，常用语置顶等',
  `vote_up` int(11) unsigned DEFAULT '0' COMMENT '“顶”的数量',
  `vote_down` int(11) unsigned DEFAULT '0' COMMENT '“踩”的数量',
  `status` tinyint(2) DEFAULT NULL COMMENT '评论的状态',
  `created` datetime DEFAULT NULL COMMENT '评论的时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品评论表';

-- ----------------------------
-- Table structure for product_image
-- ----------------------------
DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `src` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `order_number` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productid` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品图片表';

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '角色名称',
  `description` text COMMENT '角色的描述',
  `flag` varchar(64) DEFAULT '' COMMENT '角色标识，全局唯一，jpsa 为超级管理员',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, '默认角色', '这个是系统自动创建的默认角色', 'jpsa', '2019-09-02 11:39:29', '2019-09-02 11:39:29');
INSERT INTO `role` VALUES (2, '业务管理员', '总业务管理员', NULL, '2019-12-13 15:53:34', NULL);
INSERT INTO `role` VALUES (3, '区域管理员', '区域管理员', NULL, '2019-12-13 16:28:11', NULL);
COMMIT;

-- ----------------------------
-- Table structure for role_permission_mapping
-- ----------------------------
DROP TABLE IF EXISTS `role_permission_mapping`;
CREATE TABLE `role_permission_mapping` (
  `role_id` int(11) unsigned NOT NULL COMMENT '角色ID',
  `permission_id` int(11) unsigned NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和权限的多对多映射表';

-- ----------------------------
-- Records of role_permission_mapping
-- ----------------------------
BEGIN;
INSERT INTO `role_permission_mapping` VALUES (2, 2);
INSERT INTO `role_permission_mapping` VALUES (2, 3);
INSERT INTO `role_permission_mapping` VALUES (2, 51);
INSERT INTO `role_permission_mapping` VALUES (2, 52);
INSERT INTO `role_permission_mapping` VALUES (2, 53);
INSERT INTO `role_permission_mapping` VALUES (2, 54);
INSERT INTO `role_permission_mapping` VALUES (2, 55);
INSERT INTO `role_permission_mapping` VALUES (2, 56);
INSERT INTO `role_permission_mapping` VALUES (2, 57);
INSERT INTO `role_permission_mapping` VALUES (2, 58);
INSERT INTO `role_permission_mapping` VALUES (2, 59);
INSERT INTO `role_permission_mapping` VALUES (2, 80);
INSERT INTO `role_permission_mapping` VALUES (2, 165);
INSERT INTO `role_permission_mapping` VALUES (2, 166);
INSERT INTO `role_permission_mapping` VALUES (2, 167);
INSERT INTO `role_permission_mapping` VALUES (2, 168);
INSERT INTO `role_permission_mapping` VALUES (2, 169);
INSERT INTO `role_permission_mapping` VALUES (2, 170);
INSERT INTO `role_permission_mapping` VALUES (2, 171);
INSERT INTO `role_permission_mapping` VALUES (2, 172);
INSERT INTO `role_permission_mapping` VALUES (2, 173);
INSERT INTO `role_permission_mapping` VALUES (2, 174);
INSERT INTO `role_permission_mapping` VALUES (2, 175);
INSERT INTO `role_permission_mapping` VALUES (2, 176);
INSERT INTO `role_permission_mapping` VALUES (2, 177);
INSERT INTO `role_permission_mapping` VALUES (2, 178);
INSERT INTO `role_permission_mapping` VALUES (2, 179);
INSERT INTO `role_permission_mapping` VALUES (2, 180);
INSERT INTO `role_permission_mapping` VALUES (2, 181);
INSERT INTO `role_permission_mapping` VALUES (2, 182);
INSERT INTO `role_permission_mapping` VALUES (2, 183);
INSERT INTO `role_permission_mapping` VALUES (2, 184);
INSERT INTO `role_permission_mapping` VALUES (2, 185);
INSERT INTO `role_permission_mapping` VALUES (2, 186);
INSERT INTO `role_permission_mapping` VALUES (2, 187);
INSERT INTO `role_permission_mapping` VALUES (2, 188);
INSERT INTO `role_permission_mapping` VALUES (2, 189);
INSERT INTO `role_permission_mapping` VALUES (2, 190);
INSERT INTO `role_permission_mapping` VALUES (2, 191);
INSERT INTO `role_permission_mapping` VALUES (2, 192);
INSERT INTO `role_permission_mapping` VALUES (2, 193);
INSERT INTO `role_permission_mapping` VALUES (2, 194);
INSERT INTO `role_permission_mapping` VALUES (2, 195);
INSERT INTO `role_permission_mapping` VALUES (2, 196);
INSERT INTO `role_permission_mapping` VALUES (2, 197);
INSERT INTO `role_permission_mapping` VALUES (2, 198);
INSERT INTO `role_permission_mapping` VALUES (2, 199);
INSERT INTO `role_permission_mapping` VALUES (2, 200);
INSERT INTO `role_permission_mapping` VALUES (2, 201);
INSERT INTO `role_permission_mapping` VALUES (2, 202);
INSERT INTO `role_permission_mapping` VALUES (2, 203);
INSERT INTO `role_permission_mapping` VALUES (2, 204);
INSERT INTO `role_permission_mapping` VALUES (2, 205);
INSERT INTO `role_permission_mapping` VALUES (2, 206);
INSERT INTO `role_permission_mapping` VALUES (2, 207);
INSERT INTO `role_permission_mapping` VALUES (2, 208);
INSERT INTO `role_permission_mapping` VALUES (2, 209);
INSERT INTO `role_permission_mapping` VALUES (2, 210);
INSERT INTO `role_permission_mapping` VALUES (2, 211);
INSERT INTO `role_permission_mapping` VALUES (2, 212);
INSERT INTO `role_permission_mapping` VALUES (2, 213);
INSERT INTO `role_permission_mapping` VALUES (2, 214);
INSERT INTO `role_permission_mapping` VALUES (2, 215);
INSERT INTO `role_permission_mapping` VALUES (2, 216);
INSERT INTO `role_permission_mapping` VALUES (2, 217);
INSERT INTO `role_permission_mapping` VALUES (2, 218);
INSERT INTO `role_permission_mapping` VALUES (2, 219);
INSERT INTO `role_permission_mapping` VALUES (2, 251);
INSERT INTO `role_permission_mapping` VALUES (2, 252);
INSERT INTO `role_permission_mapping` VALUES (2, 253);
INSERT INTO `role_permission_mapping` VALUES (2, 265);
INSERT INTO `role_permission_mapping` VALUES (2, 266);
INSERT INTO `role_permission_mapping` VALUES (2, 272);
INSERT INTO `role_permission_mapping` VALUES (2, 298);
INSERT INTO `role_permission_mapping` VALUES (2, 299);
INSERT INTO `role_permission_mapping` VALUES (2, 300);
INSERT INTO `role_permission_mapping` VALUES (3, 3);
INSERT INTO `role_permission_mapping` VALUES (3, 51);
INSERT INTO `role_permission_mapping` VALUES (3, 52);
INSERT INTO `role_permission_mapping` VALUES (3, 53);
INSERT INTO `role_permission_mapping` VALUES (3, 54);
INSERT INTO `role_permission_mapping` VALUES (3, 55);
INSERT INTO `role_permission_mapping` VALUES (3, 56);
INSERT INTO `role_permission_mapping` VALUES (3, 57);
INSERT INTO `role_permission_mapping` VALUES (3, 58);
INSERT INTO `role_permission_mapping` VALUES (3, 59);
INSERT INTO `role_permission_mapping` VALUES (3, 80);
INSERT INTO `role_permission_mapping` VALUES (3, 298);
INSERT INTO `role_permission_mapping` VALUES (3, 300);
COMMIT;

-- ----------------------------
-- Table structure for single_page
-- ----------------------------
DROP TABLE IF EXISTS `single_page`;
CREATE TABLE `single_page` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `slug` varchar(128) DEFAULT NULL COMMENT 'slug',
  `title` text COMMENT '标题',
  `content` longtext COMMENT '内容',
  `edit_mode` varchar(32) DEFAULT 'html' COMMENT '编辑模式：html可视化，markdown ..',
  `link_to` varchar(512) DEFAULT NULL COMMENT '链接',
  `summary` text COMMENT '摘要',
  `thumbnail` varchar(128) DEFAULT NULL COMMENT '缩略图',
  `style` varchar(32) DEFAULT NULL COMMENT '样式',
  `flag` varchar(32) DEFAULT NULL COMMENT '标识',
  `status` varchar(32) NOT NULL DEFAULT '0' COMMENT '状态',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问量',
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `modified` datetime DEFAULT NULL COMMENT '最后更新日期',
  `meta_keywords` varchar(256) DEFAULT NULL COMMENT 'SEO关键字',
  `meta_description` varchar(256) DEFAULT NULL COMMENT 'SEO描述信息',
  `remarks` text COMMENT '备注信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='单页表';

-- ----------------------------
-- Table structure for single_page_comment
-- ----------------------------
DROP TABLE IF EXISTS `single_page_comment`;
CREATE TABLE `single_page_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(11) unsigned DEFAULT NULL COMMENT '回复的评论ID',
  `page_id` int(11) unsigned DEFAULT NULL COMMENT '评论的内容ID',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '评论的用户ID',
  `author` varchar(128) DEFAULT NULL COMMENT '评论的作者',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `wechat` varchar(64) DEFAULT NULL COMMENT '微信号',
  `qq` varchar(32) DEFAULT NULL COMMENT 'qq号',
  `content` text COMMENT '评论的内容',
  `reply_count` int(11) unsigned DEFAULT '0' COMMENT '评论的回复数量',
  `order_number` int(11) DEFAULT '0' COMMENT '排序编号，常用语置顶等',
  `vote_up` int(11) unsigned DEFAULT '0' COMMENT '“顶”的数量',
  `vote_down` int(11) unsigned DEFAULT '0' COMMENT '“踩”的数量',
  `status` varchar(32) DEFAULT NULL COMMENT '评论的状态',
  `created` datetime DEFAULT NULL COMMENT '评论的时间',
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='页面评论表';

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(128) DEFAULT NULL COMMENT '登录名',
  `nickname` varchar(128) DEFAULT NULL COMMENT '昵称',
  `realname` varchar(128) DEFAULT NULL COMMENT '实名',
  `identity` varchar(128) DEFAULT NULL COMMENT '身份',
  `password` varchar(128) DEFAULT NULL COMMENT '密码',
  `salt` varchar(32) DEFAULT NULL COMMENT '盐',
  `anonym` varchar(32) DEFAULT NULL COMMENT '匿名ID',
  `email` varchar(64) DEFAULT NULL COMMENT '邮件',
  `email_status` varchar(32) DEFAULT NULL COMMENT '邮箱状态（是否认证等）',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机电话',
  `mobile_status` varchar(32) DEFAULT NULL COMMENT '手机状态（是否认证等）',
  `gender` varchar(16) DEFAULT NULL COMMENT '性别',
  `signature` varchar(2048) DEFAULT NULL COMMENT '签名',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `company` varchar(256) DEFAULT NULL COMMENT '公司',
  `occupation` varchar(256) DEFAULT NULL COMMENT '职位、职业',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  `zipcode` varchar(128) DEFAULT NULL COMMENT '邮政编码',
  `site` varchar(256) DEFAULT NULL COMMENT '个人网址',
  `graduateschool` varchar(256) DEFAULT NULL COMMENT '毕业学校',
  `education` varchar(256) DEFAULT NULL COMMENT '学历',
  `avatar` varchar(256) DEFAULT NULL COMMENT '头像',
  `idcardtype` varchar(128) DEFAULT NULL COMMENT '证件类型：身份证 护照 军官证等',
  `idcard` varchar(128) DEFAULT NULL COMMENT '证件号码',
  `remark` varchar(2048) DEFAULT NULL COMMENT '备注',
  `status` varchar(32) DEFAULT NULL COMMENT '状态',
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `create_source` varchar(128) DEFAULT NULL COMMENT '用户来源（可能来之oauth第三方）',
  `logged` datetime DEFAULT NULL COMMENT '最后的登录时间',
  `activated` datetime DEFAULT NULL COMMENT '激活时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `mobile` (`mobile`),
  KEY `created` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表，保存用户信息。';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'admin', '10', 'admin', NULL, 'b7bdb416eb2228f7483dfddb96d2c95efdad1ceaa47d06108b5b4782c5d8a087', 'iZuC5x5WUt9G52WEsbKkfjlbjH_TGQM5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ok', '2019-09-02 11:39:29', 'web_register', '2019-12-13 16:41:24', '2019-09-02 11:39:29');
INSERT INTO `user` VALUES (2, 'a1', 'a1', '刘洪义', NULL, 'd03595221c18c97ecf24b6f5cad1e94cb57c64d054dbf42aa90370471b8821f0', 'DXfZBYgrvKHfxAwCmNi5ubzJTtVKxBTU', 'efd4475f33764f0faf36f9776f53b4c6', 'a1@qq.com', NULL, '13961879161', 'ok', NULL, NULL, NULL, NULL, NULL, '锡沪路102', NULL, NULL, NULL, NULL, NULL, NULL, '320829197909280212', '{&quot;backImgsrc&quot;:&quot;/attachment/20191213/61616fca72884f55bede1b8bd7692f8a.jpeg&quot;,&quot;contactPicsList&quot;:[&quot;/attachment/20191213/372ec2a652b4440e8055e20794f65bdf.jpeg&quot;,&quot;/attachment/20191213/dab57af852ef43f08f0ac5f2aa8306c3.jpeg&quot;],&quot;contactStatus&quot;:&quot;topay&quot;,&quot;faceOrderNo&quot;:&quot;21576222255790&quot;,&quot;facebizCode&quot;:&quot;L0Xk0THxTLdbn4sm7b4QHQW58CSABYBkFkmbRqgvHjcPaeDn1mDs1n1T9jr6cBno&quot;,&quot;frontImgsrc&quot;:&quot;/attachment/20191213/4ff67331c79442bfaf74e1b17ff84ab6.jpeg&quot;,&quot;proxyAreaCode&quot;:&quot;320205&quot;,&quot;proxyAreaName&quot;:&quot;江苏省-无锡市-锡山区&quot;,&quot;proxyCommunity&quot;:&quot;锡沪路102号&quot;,&quot;proxyIdx&quot;:&quot;2&quot;,&quot;proxyName&quot;:&quot;社区个人(19800元)&quot;,&quot;proxySpace&quot;:&quot;40&quot;,&quot;verStatus&quot;:&quot;9&quot;}', 'ok', '2019-12-13 14:38:00', 'web_register', '2019-12-13 15:30:16', NULL);
INSERT INTO `user` VALUES (3, 'dy', 'dy', NULL, NULL, 'ce066d4813f5f490035949cbbb48759dac3ef1bb58561c4b1d60c5c1b84a789a', 'zRxGtY4tkFsNX9YKPpbyJNLS4Vy8umjr', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ok', '2019-12-13 15:57:17', 'admin_create', '2019-12-13 20:21:46', NULL);
INSERT INTO `user` VALUES (4, 'js', 'js', NULL, NULL, '5a2a0f0eac8e2c9b265281d6316dcbd18b3e21d65ccec5e9ca012e1d01ef76a2', '8uz7q1AztVCKWfmuXlW9P7n1QaSyLzAs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ok', '2019-12-13 16:31:30', 'admin_create', '2019-12-13 20:25:00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `province` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '省',
  `city` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '市',
  `district` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '区（县）',
  `detail` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '详细地址到门牌号',
  `zipcode` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮政编码',
  `width_default` tinyint(1) DEFAULT '0' COMMENT '是否默认,1是，0否',
  `options` text COLLATE utf8mb4_unicode_ci,
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收货地址';

-- ----------------------------
-- Table structure for user_amount
-- ----------------------------
DROP TABLE IF EXISTS `user_amount`;
CREATE TABLE `user_amount` (
  `user_id` int(11) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `modified` datetime NOT NULL,
  `created` datetime DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户余额';

-- ----------------------------
-- Table structure for user_amount_payout
-- ----------------------------
DROP TABLE IF EXISTS `user_amount_payout`;
CREATE TABLE `user_amount_payout` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '申请提现用户',
  `user_real_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户的真实名字',
  `user_idcard` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户的身份证号码',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '提现金额',
  `pay_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提现类型',
  `pay_to` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提现账号：可能是微信的openId，可能是支付宝账号，可能是银行账号',
  `pay_success_proof` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提现成功证明，一般是转账截图',
  `fee` decimal(10,2) DEFAULT NULL COMMENT '提现手续费',
  `statement_id` int(11) unsigned DEFAULT NULL COMMENT '申请提现成功后会生成一个扣款记录',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态',
  `remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户备注',
  `feedback` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '回绝提现时给出原因',
  `options` text COLLATE utf8mb4_unicode_ci,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='提现申请表';

-- ----------------------------
-- Table structure for user_amount_statement
-- ----------------------------
DROP TABLE IF EXISTS `user_amount_statement`;
CREATE TABLE `user_amount_statement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '用户',
  `action` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '金额变动原因',
  `action_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '金额变动名称',
  `action_desc` text COLLATE utf8mb4_unicode_ci COMMENT '金额变动描述',
  `action_relative_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '相关的表名',
  `action_relative_id` int(11) unsigned DEFAULT NULL COMMENT '相关的id',
  `action_order_id` int(11) unsigned DEFAULT NULL COMMENT '相关的订单ID',
  `action_payment_id` int(11) unsigned DEFAULT NULL COMMENT '相关的支付ID',
  `old_amount` decimal(10,2) NOT NULL COMMENT '用户之前的余额',
  `change_amount` decimal(10,2) NOT NULL COMMENT '变动金额',
  `new_amount` decimal(10,2) NOT NULL COMMENT '变动之后的余额',
  `options` text COLLATE utf8mb4_unicode_ci,
  `created` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户余额流水情况';

-- ----------------------------
-- Table structure for user_cart
-- ----------------------------
DROP TABLE IF EXISTS `user_cart`;
CREATE TABLE `user_cart` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '购买的用户',
  `seller_id` int(11) unsigned DEFAULT NULL COMMENT '商品的所属用户',
  `dist_user_id` int(11) unsigned DEFAULT NULL COMMENT '分销用户',
  `product_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品的类别，默认是 product ，但是未来可能是 模板、文件、视频等等...',
  `product_type_text` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` int(11) unsigned DEFAULT NULL,
  `product_title` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品标题',
  `product_summary` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_spec` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品规格',
  `product_thumbnail` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品缩略图',
  `product_link` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品详情页',
  `product_price` decimal(10,2) NOT NULL COMMENT '商品加入购物车时的价格',
  `product_count` int(11) NOT NULL DEFAULT '1' COMMENT '商品数量',
  `with_virtual` tinyint(1) DEFAULT NULL COMMENT '是否是虚拟产品，1是，0不是。虚拟产品支付完毕后立即交易完成。是虚拟产品，虚拟产品支付完毕后立即交易完成',
  `with_refund` tinyint(1) DEFAULT NULL COMMENT '是否支持退款，1支持，0不支持。',
  `view_path` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '查看的网址路径，访问时时，会添加orderid',
  `view_text` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '查看的文章内容，比如：查看、下载',
  `view_effective_time` int(11) unsigned DEFAULT NULL COMMENT '可访问的有效时间，单位秒',
  `comment_path` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selected` tinyint(1) NOT NULL DEFAULT '0' COMMENT '选中状态',
  `options` text COLLATE utf8mb4_unicode_ci,
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `pinfo` (`product_type`,`product_id`),
  KEY `userselected` (`user_id`,`selected`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购物车';

-- ----------------------------
-- Table structure for user_favorite
-- ----------------------------
DROP TABLE IF EXISTS `user_favorite`;
CREATE TABLE `user_favorite` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned NOT NULL COMMENT '收藏用户',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收藏数据的类型',
  `type_text` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `summary` text COLLATE utf8mb4_unicode_ci COMMENT '摘要',
  `thumbnail` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '缩略图',
  `link` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '详情页',
  `options` text COLLATE utf8mb4_unicode_ci,
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`),
  KEY `usertype` (`user_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户收藏';

-- ----------------------------
-- Table structure for user_openid
-- ----------------------------
DROP TABLE IF EXISTS `user_openid`;
CREATE TABLE `user_openid` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '用户ID',
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方类型：wechat，dingding，qq...',
  `value` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方的openId的值',
  `access_token` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '可能用不到',
  `expired_time` datetime DEFAULT NULL COMMENT 'access_token的过期时间',
  `nickname` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `options` text COLLATE utf8mb4_unicode_ci,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `type_value` (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账号绑定信息表';

-- ----------------------------
-- Table structure for user_order
-- ----------------------------
DROP TABLE IF EXISTS `user_order`;
CREATE TABLE `user_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ns` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `product_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品的类型',
  `product_title` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '商品的名称',
  `product_summary` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buyer_id` int(11) unsigned DEFAULT NULL COMMENT '购买人',
  `buyer_nickname` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '购买人昵称',
  `buyer_msg` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户留言',
  `order_total_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总金额，购买人员应该付款的金额',
  `order_real_amount` decimal(10,2) DEFAULT NULL COMMENT '订单的真实金额，销售人员可以在后台修改支付金额，一般情况下 order_real_amount = order_total_amount',
  `coupon_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '优惠码',
  `coupon_amount` decimal(10,2) DEFAULT NULL COMMENT '优惠金额',
  `pay_status` tinyint(2) DEFAULT NULL COMMENT '支付状态：1未付款、 2用户标识已经线下付款完成、3用户标识已经通过微信或者支付宝等工具支付完成 、9已经付款（线上支付）、10已经下线支付、11已经通过微信或支付宝等工具支付',
  `pay_success_amount` decimal(10,2) DEFAULT NULL COMMENT '支付成功的金额',
  `pay_success_time` datetime DEFAULT NULL COMMENT '支付时间',
  `pay_success_proof` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付证明，手动入账时需要截图',
  `pay_success_remarks` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付备注',
  `payment_id` int(11) unsigned DEFAULT NULL COMMENT '支付记录',
  `payment_outer_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方订单号',
  `payment_outer_user` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方支付用户，一般情况下是用户的openId',
  `delivery_id` int(11) unsigned DEFAULT NULL COMMENT '发货情况',
  `delivery_type` tinyint(2) DEFAULT NULL,
  `delivery_status` tinyint(2) DEFAULT NULL,
  `delivery_addr_username` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人地址',
  `delivery_addr_mobile` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人手机号（电话）',
  `delivery_addr_province` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人省',
  `delivery_addr_city` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人的城市',
  `delivery_addr_district` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人的区（县）',
  `delivery_addr_detail` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人的详细地址',
  `delivery_addr_zipcode` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人地址邮政编码',
  `invoice_id` int(11) DEFAULT NULL COMMENT '发票',
  `invoice_status` tinyint(2) DEFAULT NULL COMMENT '发票开具状态：1 未申请发票、 2 发票申请中、 3 发票开具中、 8 无需开具发票、 9发票已经开具',
  `remarks` text COLLATE utf8mb4_unicode_ci COMMENT '管理员后台憋住',
  `options` text COLLATE utf8mb4_unicode_ci COMMENT 'json字段扩展',
  `trade_status` tinyint(2) DEFAULT NULL COMMENT '交易状态：1交易中、 2交易完成（但是可以申请退款） 、3取消交易 、4申请退款、 5拒绝退款、 6退款中、 7退款完成、 9交易结束',
  `del_status` tinyint(2) DEFAULT NULL COMMENT '删除状态：1 正常 ，2 回收站 3 已经删除',
  `modified` datetime DEFAULT NULL COMMENT '修改时间',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ns` (`ns`),
  KEY `buyer_id` (`buyer_id`),
  KEY `payment_id` (`payment_id`),
  KEY `buyer_status` (`buyer_id`,`trade_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- ----------------------------
-- Table structure for user_order_delivery
-- ----------------------------
DROP TABLE IF EXISTS `user_order_delivery`;
CREATE TABLE `user_order_delivery` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '快递公司',
  `number` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '快递单号',
  `start_time` datetime DEFAULT NULL COMMENT '快递发货时间',
  `finish_time` datetime DEFAULT NULL COMMENT '快递送达时间',
  `addr_username` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人地址',
  `addr_mobile` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人手机号（电话）',
  `addr_province` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人省',
  `addr_city` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人的城市',
  `addr_district` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人的区（县）',
  `addr_detail` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人的详细地址',
  `addr_zipcode` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收件人地址邮政编码',
  `status` tinyint(2) DEFAULT NULL COMMENT '发货状态',
  `options` text COLLATE utf8mb4_unicode_ci COMMENT 'json字段扩展',
  `modified` datetime DEFAULT NULL COMMENT '修改时间',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='发货信息表';

-- ----------------------------
-- Table structure for user_order_invoice
-- ----------------------------
DROP TABLE IF EXISTS `user_order_invoice`;
CREATE TABLE `user_order_invoice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票类型',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票抬头',
  `content` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票内容',
  `identity` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纳税人识别号',
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '单位名称',
  `mobile` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票收取人手机号',
  `email` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发票收取人邮箱',
  `status` tinyint(2) DEFAULT NULL COMMENT '发票状态',
  `options` text COLLATE utf8mb4_unicode_ci COMMENT 'json字段扩展',
  `modified` datetime DEFAULT NULL COMMENT '修改时间',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='发票信息表';

-- ----------------------------
-- Table structure for user_order_item
-- ----------------------------
DROP TABLE IF EXISTS `user_order_item`;
CREATE TABLE `user_order_item` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) unsigned NOT NULL COMMENT '订单id',
  `order_ns` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单号',
  `buyer_id` int(11) unsigned NOT NULL COMMENT '购买人',
  `buyer_nickname` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '购买人昵称',
  `buyer_msg` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户留言（备注）',
  `seller_id` int(11) unsigned DEFAULT NULL COMMENT '卖家id',
  `dist_user_id` int(10) unsigned DEFAULT NULL COMMENT '分销员',
  `dist_amount` decimal(10,2) DEFAULT NULL COMMENT '分销金额',
  `product_id` int(11) unsigned DEFAULT NULL COMMENT '产品id',
  `product_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品的类别，默认是 product ，但是未来可能是 模板、文件、视频等等...',
  `product_type_text` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_title` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品标题',
  `product_summary` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_spec` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_thumbnail` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品缩略图',
  `product_link` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品链接',
  `product_price` decimal(10,2) DEFAULT NULL COMMENT '产品价格',
  `product_count` int(11) DEFAULT NULL COMMENT '产品数量',
  `with_virtual` tinyint(1) DEFAULT NULL COMMENT '是否是虚拟产品，1是，0不是。虚拟产品支付完毕后立即交易完成。是虚拟产品，虚拟产品支付完毕后立即交易完成',
  `with_refund` tinyint(1) DEFAULT NULL COMMENT '是否支持退款，1支持，0不支持。',
  `delivery_cost` decimal(10,2) DEFAULT NULL,
  `delivery_id` int(11) unsigned DEFAULT NULL,
  `other_cost` decimal(10,2) DEFAULT NULL,
  `other_cost_remark` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '具体金额 = 产品价格+运费+其他价格 - 分销金额',
  `pay_amount` decimal(10,2) DEFAULT NULL COMMENT '支付金额 = 产品价格+运费+其他价格',
  `view_path` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '查看的网址路径，访问时时，会添加orderid',
  `view_text` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '查看的文章内容，比如：查看、下载',
  `view_effective_time` int(11) unsigned DEFAULT NULL COMMENT '可访问的有效时间，单位秒',
  `comment_path` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论的路径',
  `invoice_id` int(11) unsigned DEFAULT NULL,
  `invoice_status` tinyint(2) DEFAULT NULL,
  `status` tinyint(2) DEFAULT NULL COMMENT '状态：1交易中、 2交易完成（但是可以申请退款） 、3取消交易 、4申请退款、 5拒绝退款、 6退款中、 7退款完成、 9交易结束',
  `refund_no` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '退款订单号',
  `refund_amount` decimal(10,2) DEFAULT NULL COMMENT '退款金额',
  `refund_desc` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '退款描述',
  `refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  `options` text COLLATE utf8mb4_unicode_ci,
  `modified` datetime DEFAULT NULL COMMENT '修改时间',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单明细表';

-- ----------------------------
-- Table structure for user_role_mapping
-- ----------------------------
DROP TABLE IF EXISTS `user_role_mapping`;
CREATE TABLE `user_role_mapping` (
  `user_id` int(11) unsigned NOT NULL COMMENT '用户ID',
  `role_id` int(11) unsigned NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色的多对多映射表';

-- ----------------------------
-- Records of user_role_mapping
-- ----------------------------
BEGIN;
INSERT INTO `user_role_mapping` VALUES (1, 1);
INSERT INTO `user_role_mapping` VALUES (3, 2);
INSERT INTO `user_role_mapping` VALUES (4, 3);
COMMIT;

-- ----------------------------
-- Table structure for user_tag
-- ----------------------------
DROP TABLE IF EXISTS `user_tag`;
CREATE TABLE `user_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `slug` varchar(128) DEFAULT NULL COMMENT 'slug',
  `title` varchar(512) DEFAULT NULL COMMENT '标题',
  `content` text COMMENT '内容描述',
  `type` varchar(32) DEFAULT NULL COMMENT 'tag类别，用于以后扩展',
  `count` int(11) unsigned DEFAULT '0' COMMENT '该分类的用户数量',
  `order_number` int(11) DEFAULT '0' COMMENT '排序编码',
  `options` text,
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `modified` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户标签。';

-- ----------------------------
-- Table structure for user_tag_mapping
-- ----------------------------
DROP TABLE IF EXISTS `user_tag_mapping`;
CREATE TABLE `user_tag_mapping` (
  `user_id` int(11) unsigned NOT NULL COMMENT '用户ID',
  `tag_id` int(11) unsigned NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`user_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和标签的多对多关系表';

-- ----------------------------
-- Table structure for utm
-- ----------------------------
DROP TABLE IF EXISTS `utm`;
CREATE TABLE `utm` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '用户ID',
  `anonym` varchar(32) DEFAULT NULL COMMENT '匿名标识',
  `action_key` varchar(512) DEFAULT NULL COMMENT '访问路径',
  `action_query` varchar(512) DEFAULT NULL COMMENT '访问参数',
  `action_name` varchar(128) DEFAULT NULL COMMENT '访问路径名称',
  `source` varchar(32) DEFAULT NULL COMMENT '渠道',
  `medium` varchar(32) DEFAULT NULL COMMENT ' 媒介',
  `campaign` varchar(128) DEFAULT NULL,
  `content` varchar(128) DEFAULT NULL COMMENT '来源内容',
  `term` varchar(256) DEFAULT NULL COMMENT '关键词',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP',
  `agent` varchar(1024) DEFAULT NULL COMMENT '浏览器',
  `referer` varchar(1024) DEFAULT NULL COMMENT '来源的url',
  `se` varchar(32) DEFAULT NULL COMMENT 'Search Engine 搜索引擎',
  `sek` varchar(512) DEFAULT NULL COMMENT 'Search Engine Keyword 搜索引擎关键字',
  `device_id` varchar(128) DEFAULT NULL COMMENT '设备ID',
  `platform` varchar(128) DEFAULT NULL COMMENT '平台',
  `system` varchar(128) DEFAULT NULL COMMENT '系统',
  `brand` varchar(128) DEFAULT NULL COMMENT '硬件平台',
  `model` varchar(128) DEFAULT NULL COMMENT '硬件型号',
  `network` varchar(128) DEFAULT NULL COMMENT '网络情况',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户行为记录表';

-- ----------------------------
-- Records of utm
-- ----------------------------
BEGIN;
INSERT INTO `utm` VALUES ('0042a7e54bad4c6090d54449c9863d1b', NULL, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:49');
INSERT INTO `utm` VALUES ('00db2076c7604df980efe412d1f5ef5e', 1, NULL, '/admin/user/doAddGroupRolePermission', 'roleId=3&groupId=..._AreaManageController&csrf_token=ef08140509d84e12a10cd2b3d1f4c82d', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:30:04');
INSERT INTO `utm` VALUES ('00e9a2f8644e401c8168aa76b8459bb3', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:07');
INSERT INTO `utm` VALUES ('01e15ef78edc467eb2b09629a9edeceb', NULL, NULL, '/admin/template', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:41:11');
INSERT INTO `utm` VALUES ('01f26136da7a4a68ad271c0883c828f9', 1, NULL, '/admin/permission/syncPermissions', 'csrf_token=3cf29f3ad21340f28d8d042d33658084', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:10');
INSERT INTO `utm` VALUES ('02668a891d2949a89f61ae10bf1297f8', 1, NULL, '/admin/user/doDelRolePermission', 'roleId=2&permissionId=267&csrf_token=ec11a57047ed4e48997d28fef56e7ec8', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:12:06');
INSERT INTO `utm` VALUES ('02c0bca9254441a2b8d9f49679ebf8bf', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:28:26');
INSERT INTO `utm` VALUES ('038bae0b282945acb8ec78cdc29101da', 1, NULL, '/me', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:26:24');
INSERT INTO `utm` VALUES ('03ce2047151b466ca767b3bda88810d8', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/permissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:27');
INSERT INTO `utm` VALUES ('041714aaecd04421b52564774ecbd1e1', 2, NULL, '/api/user/me', 'sign=d2fe97ee23c6451475c951f8370e7759&appId=appidi8thcGWps7Ki5Sh2&t=1576222160522', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:29:21');
INSERT INTO `utm` VALUES ('047506368cf8418883589bbd9c63bce9', 1, NULL, '/me', 'sign=e670d1c59a9ea85e37aba349b48634cd&appId=appidi8thcGWps7Ki5Sh2&t=1576207603207', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:27:42');
INSERT INTO `utm` VALUES ('04e58ee733d149c5b95ee89276ba9d9d', 1, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:21:01');
INSERT INTO `utm` VALUES ('0530355da74d4f2ea818fb5967f4b3c4', 2, NULL, '/me/doSmsSend', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:45:15');
INSERT INTO `utm` VALUES ('06161de7fda34e16a08e6bd5a110c36d', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:43');
INSERT INTO `utm` VALUES ('0665b67c68784a849ea79894946230b4', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:48');
INSERT INTO `utm` VALUES ('07b3d5429e7a4bf6838246effe2ec52f', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:21:48');
INSERT INTO `utm` VALUES ('0829a022ccdf485e9872945f1f8a3f2f', 1, NULL, '/api/user/me', 'sign=752ce9474299494b6c8921a5ed076b67&appId=appidi8thcGWps7Ki5Sh2&t=1576207603213', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:33:26');
INSERT INTO `utm` VALUES ('08fc931c75464129aa7e0de953547b02', 1, NULL, '/admin/user/doAddRolePermission', 'roleId=2&permissionId=298&csrf_token=55435073bcfa4fa5873e247096d30913', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:55:02');
INSERT INTO `utm` VALUES ('09652400349246a19dd0cfde84724e67', NULL, NULL, '/install/gotoStep3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/install/step2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:23:53');
INSERT INTO `utm` VALUES ('0a60b9f97b734c118bd1b305ec9840f0', 1, NULL, '/admin/article/doDelByIds', 'ids=1&csrf_token=349061404d9141588fab552f868b717d', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/article', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:37');
INSERT INTO `utm` VALUES ('0a8cdf2c1a2b4c9bb7b92dbb75374b4a', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:53:40');
INSERT INTO `utm` VALUES ('0b81ab8d49aa45ac8ddb7b31aa881947', 1, NULL, '/admin/addon/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:30:51');
INSERT INTO `utm` VALUES ('0be0e3a17fd249a69f43e658e88c4ad8', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:44');
INSERT INTO `utm` VALUES ('0c12358a0df64d028fffab9166dc0bf0', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:20');
INSERT INTO `utm` VALUES ('0c52720f254b44aca928cb0982ea3a10', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:13:01');
INSERT INTO `utm` VALUES ('0c9ecdc35b0f45d98cd66071941996ce', NULL, NULL, '/install/step3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/install/step2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:28');
INSERT INTO `utm` VALUES ('0cfb904b6b224064a30eb5894cdd37b8', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/permissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:10');
INSERT INTO `utm` VALUES ('0d261ec456064b5a98f093848b96b924', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:00');
INSERT INTO `utm` VALUES ('0e5842869fd6459fa19186aca3f5afc3', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:05:35');
INSERT INTO `utm` VALUES ('0f877b794c3144a69bc154079fd0a10f', 3, NULL, '/admin/doLogout', 'csrf_token=9d4ac39d233e4c4ab184f598f4c314fb', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:17:21');
INSERT INTO `utm` VALUES ('118f1707bdae42bfa876236a2df1abfc', 1, NULL, '/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:59:40');
INSERT INTO `utm` VALUES ('11b28d6fb1324d8a884deddb9654c3b5', 1, NULL, '/admin/user/doDelGroupRolePermission', 'roleId=2&groupId=..._UserController&csrf_token=335dfa3ac3ec40d4a0a26c972041f7db', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:28');
INSERT INTO `utm` VALUES ('14b9f93309b64fdd88b6928964cb5187', 3, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:13:00');
INSERT INTO `utm` VALUES ('155358a980e44eeb9f618d4c44aff5bc', 1, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:12');
INSERT INTO `utm` VALUES ('15d3742390d24f5ba36a2fc511601fac', 3, NULL, '/admin/user/me', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:10');
INSERT INTO `utm` VALUES ('169bcac67d4f4c6d8b9bf023567eb423', 3, NULL, '/admin/user/detail/finance/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:30');
INSERT INTO `utm` VALUES ('1769cf5b3e6c45fba1794a4524c2ddb6', 1, NULL, '/me', 'sign=e670d1c59a9ea85e37aba349b48634cd&appId=appidi8thcGWps7Ki5Sh2&t=15762076032071', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:27:45');
INSERT INTO `utm` VALUES ('181a29729e1d40c89ba1b6d6235ac038', 1, NULL, '/admin/user/sendMsg/sms', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/sendMsg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:48');
INSERT INTO `utm` VALUES ('187d782aa9c94f3fa958b58181aeb418', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:23:36');
INSERT INTO `utm` VALUES ('18bdf918b65845bdb5870889e6fbc0a8', NULL, NULL, '/api/user/me', 'sign=ed99af192813161f644a0e4a2a7961b7&appId=appidi8thcGWps7Ki5Sh2&t=1576218998675', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://192.168.43.248:8081/splash', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:36:39');
INSERT INTO `utm` VALUES ('1c7384090a0747adb9d7d6870bf2680c', 1, NULL, '/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:30:50');
INSERT INTO `utm` VALUES ('1d2cb9583ddc47978ff20c4307d2a3f7', 1, NULL, '/admin/article', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:23');
INSERT INTO `utm` VALUES ('1d4313d1034647c7aef8ab7d91f03bf8', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:27:07');
INSERT INTO `utm` VALUES ('1de1b4f8f0d64246b08339cacdac58cf', 1, NULL, '/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:56:38');
INSERT INTO `utm` VALUES ('1deba61af48e43c6ad1705cf57450ff8', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:21:04');
INSERT INTO `utm` VALUES ('1ec75b9387a54a299b268863f049b23a', 1, NULL, '/me', 'sign=e670d1c59a9ea85e37aba349b48634cd&appId=appidi8thcGWps7Ki5Sh2&t=1576207603207', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:27:39');
INSERT INTO `utm` VALUES ('1ee7e675b18043e0937201a394b5b39a', 2, NULL, '/commons/attachment/upload', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:22:27');
INSERT INTO `utm` VALUES ('1f755b80d52d45178d7d32b07763d80d', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:11:27');
INSERT INTO `utm` VALUES ('20e772d36a35405fbf265172e7390917', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:24:26');
INSERT INTO `utm` VALUES ('21e695f6efc94a71b15d5d1bf3f9ec73', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/roleEdit/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:12');
INSERT INTO `utm` VALUES ('22347c16c0774e97baa9f68622cd9666', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:07:30');
INSERT INTO `utm` VALUES ('22876da19ee24ccfb2354f5a9088c8a6', NULL, NULL, '/install/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/install/step3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:30');
INSERT INTO `utm` VALUES ('22bed04b694b4cfaac342547ac385ce3', 4, NULL, '/admin/doLogout', 'csrf_token=53bd65beba694d97ba9700ac2d1b9e2e', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index?date=14d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:56');
INSERT INTO `utm` VALUES ('22c16a90ad034d9db63de0d72c37d280', NULL, NULL, '/install/step2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:23:39');
INSERT INTO `utm` VALUES ('22c43e17148f49fb9b6dfdc1038064cf', NULL, NULL, '/api/user/me', 'sign=e4f35826de308e545809fd78c251e4e2&appId=appidi8thcGWps7Ki5Sh2&t=1576218998681', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://192.168.43.248:8081/splash', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:36:39');
INSERT INTO `utm` VALUES ('236c1d5a349f45eb9a6c75e19758d42a', 4, NULL, '/admin/doLogout', 'csrf_token=de3f0ff076da41fc8b1f4d36d74928d5', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:11:48');
INSERT INTO `utm` VALUES ('23aa41d53c754f76883c7f5b44b0b3c1', 3, NULL, '/admin/user/doDelGroupRolePermission', 'roleId=2&groupId=..._UserController&csrf_token=4fd7108fc40e44f9b94a918cf78205a6', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:07:52');
INSERT INTO `utm` VALUES ('23c599b0cdd54450933e7983f0d414a5', 3, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:05');
INSERT INTO `utm` VALUES ('240cb1c965184ef787753bd9350a4b93', 1, NULL, '/admin/setting/api', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:28:47');
INSERT INTO `utm` VALUES ('2556e74e6f3e4f589a833858c7a7f627', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=action', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:03:40');
INSERT INTO `utm` VALUES ('2662ec4736ca4d5fb5d420845e79ee60', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/permissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:52:24');
INSERT INTO `utm` VALUES ('26ccf9ff225d45e5839b669973ae495f', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:06');
INSERT INTO `utm` VALUES ('26d5905ff05d46168cf91f65a5b379b2', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:17');
INSERT INTO `utm` VALUES ('26f1cb3a2546408dac89bea1a99cfca6', 1, NULL, '/admin/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/setting/connection', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:17:24');
INSERT INTO `utm` VALUES ('27bcef82032c40039394a01305d3e2e9', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:11:04');
INSERT INTO `utm` VALUES ('280c958ef46a48dd9e3ae4522b53c8a0', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:15:26');
INSERT INTO `utm` VALUES ('2892e041245543478264d6b34ab9963d', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:17');
INSERT INTO `utm` VALUES ('298c645bfdb2405bb4a3819ecbd18493', 3, NULL, '/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:18');
INSERT INTO `utm` VALUES ('2a43a561ed4d4a5bbbae3c4707378cb1', 2, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:46');
INSERT INTO `utm` VALUES ('2a884193eb754110bf14d7911517e4b9', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:41:11');
INSERT INTO `utm` VALUES ('2bee3d955f03468da3c3f8a324b945d2', 1, NULL, '/admin/doLogout', 'csrf_token=b86edb11e33b4a68b47bcf65eb0a5974', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:05:06');
INSERT INTO `utm` VALUES ('2c1e039774b244c09e7970a64c2f83f8', 1, NULL, '/admin/user/doAddGroupRolePermission', 'roleId=2&groupId=..._UserController&csrf_token=335dfa3ac3ec40d4a0a26c972041f7db', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:27');
INSERT INTO `utm` VALUES ('2cc58239cb794026afbead6eabd056e6', 1, NULL, '/admin/user/permissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:22');
INSERT INTO `utm` VALUES ('2ddadd7703c8427bbb6ac338d87b634e', 1, NULL, '/admin/doLogout', 'csrf_token=d6b19e675fb048faaf29da25cb667920', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:16:44');
INSERT INTO `utm` VALUES ('2e1adf34e4f94b8a9b425474c0340009', 1, NULL, '/admin/user/doUpdateUserRoles', 'csrf_token=a59927c62f844995ba5b9a0ce01dbca0', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/role/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:31:55');
INSERT INTO `utm` VALUES ('2ecf6cf722c946868a9daa84f80e46e7', 1, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:57:34');
INSERT INTO `utm` VALUES ('2ff955bb8bb847a683f137b0b91af4d5', 1, NULL, '/admin/user/permissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:52:19');
INSERT INTO `utm` VALUES ('300532940d614fd8a05089213b08ef4f', 1, NULL, '/admin/user/doAddGroupRolePermission', 'roleId=2&groupId=..._AdminController&csrf_token=abfcbf8af3e44ab3b4c3c32905701596', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:04:56');
INSERT INTO `utm` VALUES ('301a85cc5ba140b89e6905f4d201f90e', 1, NULL, '/admin/setting/api', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:17:26');
INSERT INTO `utm` VALUES ('3160119daabb48538eb0b4b3774c8e10', NULL, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:55');
INSERT INTO `utm` VALUES ('31823e28806f40d89bc0229f84a987ad', 3, NULL, '/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/tag/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:29');
INSERT INTO `utm` VALUES ('31fb4cfe833144c29c6419b48cfaf11f', 2, NULL, '/me/saveContact', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/proxy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:39:31');
INSERT INTO `utm` VALUES ('32409ce6fa2b4fa491f2f3b22e91abd0', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:28:16');
INSERT INTO `utm` VALUES ('327f7a3485d04278923cc11a964ffb8e', 1, NULL, '/admin/addon/doUninstall', 'id=io.jpress.addon.entre&csrf_token=e1fd00b85da64ee9bfb474bc4edebcc5', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:18:23');
INSERT INTO `utm` VALUES ('329a67ab1aa0481ba6b4c18fd71bf532', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:34');
INSERT INTO `utm` VALUES ('33a8961023cf44e48fffd9bcb317918a', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:37');
INSERT INTO `utm` VALUES ('33d7eb443d194dce978e96db755adca4', 1, NULL, '/admin/addon/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:46:33');
INSERT INTO `utm` VALUES ('34335e3aaa5b40cfa0d4e5c0425c9c07', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:17:51');
INSERT INTO `utm` VALUES ('34d03271363c42f9b56ce013510fa410', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:59:42');
INSERT INTO `utm` VALUES ('35a86cf9ef15414a9a3329beeb8ff7d5', 3, NULL, '/admin/user/detail/member/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/finance/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:48');
INSERT INTO `utm` VALUES ('35c1f3343e9c4314bd130d03548d7977', 2, NULL, '/me/doSmsSend', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:35');
INSERT INTO `utm` VALUES ('36facd9a4618485f9989a127b0d52ec2', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:32');
INSERT INTO `utm` VALUES ('37470762a0b342fea3e4d9f0c56adf77', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:15');
INSERT INTO `utm` VALUES ('37745138263044f093e69bd2fa8fa21a', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:37');
INSERT INTO `utm` VALUES ('379f75e2536e40c2b381067ddd79b7a5', 3, NULL, '/admin/user/detail/tag/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:28');
INSERT INTO `utm` VALUES ('3869e5ae328d45e7b424c90f3bf3e97c', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/role/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:00');
INSERT INTO `utm` VALUES ('3906a42c796b4d079db414fe1a6d3e1c', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:59:43');
INSERT INTO `utm` VALUES ('399367ec5b154cdcbc741593bc3b14b7', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:17:21');
INSERT INTO `utm` VALUES ('3aa17e37eae348aa9b0a264e6f314500', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:49');
INSERT INTO `utm` VALUES ('3c53d0fb786744c3b0a6f7a528158dd2', 3, NULL, '/admin/user/detail/avatar/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/other/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:52');
INSERT INTO `utm` VALUES ('3d32c002a8b944bba9c73bd363401750', 1, NULL, '/admin/user/doAdd', 'csrf_token=3f571dd24cb340c19fe6e64a1212f635', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:17');
INSERT INTO `utm` VALUES ('3df7c839a6914becb7dd07828773d5c0', 1, NULL, '/admin/user/doAddGroupRolePermission', 'roleId=2&groupId=entre&csrf_token=55435073bcfa4fa5873e247096d30913', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:55:00');
INSERT INTO `utm` VALUES ('3ed1d25bddad47ca823cc730cbc3235b', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:53:51');
INSERT INTO `utm` VALUES ('3f007fc2ca914b439a08bda37fc09bc3', 3, NULL, '/admin/user/detail/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:42');
INSERT INTO `utm` VALUES ('3f1bd49de5084ce3af310a8d3d8356ea', 1, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:08:21');
INSERT INTO `utm` VALUES ('3f75cdab9c614c7dad29dc171df0f567', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:51');
INSERT INTO `utm` VALUES ('3f7b0811cc6844599b6c3538b930061d', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:27');
INSERT INTO `utm` VALUES ('408237a614a74845a987382a58d69623', 2, NULL, '/me/getFaceUrl', 'idNo=320829197909280212&realName=%E5%88%98%E6%B4%AA%E4%B9%89&userId=2', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:24:49');
INSERT INTO `utm` VALUES ('40abf26ec725447f8295e2d0af5acdd8', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:17');
INSERT INTO `utm` VALUES ('414d61ad4d434fb9b0ee1f689172d10c', 1, NULL, '/article/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index?date=14d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:43:24');
INSERT INTO `utm` VALUES ('4150aa34bd0148ccae40c3d1bf578bb7', 1, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:51');
INSERT INTO `utm` VALUES ('41555d70680546e7b0897e851466a3d9', 3, NULL, '/commons/captcha', 'd=0.3775904791642153', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:59:01');
INSERT INTO `utm` VALUES ('42225f717ce041b0a18ae9da790b45bf', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:30');
INSERT INTO `utm` VALUES ('4262d60c27ee4c1ba1a4c38eb2106871', 1, NULL, '/admin/user/doDelRolePermission', 'roleId=2&permissionId=268&csrf_token=ec11a57047ed4e48997d28fef56e7ec8', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:12:04');
INSERT INTO `utm` VALUES ('426cd72dd364405fbae721b4d2ebd668', 3, NULL, '/admin/user/detail/pwd/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/communication/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:50');
INSERT INTO `utm` VALUES ('427248041c2e4503b637b5dfe2e510c9', 3, NULL, '/admin/entre/area_manage/doSave', 'csrf_token=d284363c24b744a08059d92c35b08ada', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:24:23');
INSERT INTO `utm` VALUES ('42a60df9fb2c4310a6f547de979fc626', 1, NULL, '/admin/user/sendMsg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/sendMsg/sms', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:51');
INSERT INTO `utm` VALUES ('43e59282bd684053aeadfbeb882137f2', 3, NULL, '/admin/user/detail/avatar/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/other/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:30');
INSERT INTO `utm` VALUES ('44c7d59a7ef647588fe4c676562a50ed', NULL, NULL, '/user/doRegister', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/reg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:38:00');
INSERT INTO `utm` VALUES ('44ff05806d454caab69e5694e26c5ae8', 1, NULL, '/admin/product/tag', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/product/category', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:24:36');
INSERT INTO `utm` VALUES ('4546e6d882cc4db488349080d2089d12', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:52:33');
INSERT INTO `utm` VALUES ('45b2a4476090418d9bd8180dec55ebf9', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:30');
INSERT INTO `utm` VALUES ('45cdf54ac7d04bf482f68b06df5b9828', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:07:02');
INSERT INTO `utm` VALUES ('460f045f26a94f3681a5accee2e3266d', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:24:17');
INSERT INTO `utm` VALUES ('461ad9c5f4ab4d9995eb44dac469faf6', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:08:37');
INSERT INTO `utm` VALUES ('47f757c1d4ef4f808127d6ca7088b1fe', 1, NULL, '/admin/setting/tools', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/setting/connection', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:45:43');
INSERT INTO `utm` VALUES ('48018294713d41f6ae6ab27188f1cfdd', 1, NULL, '/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/permission?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:06');
INSERT INTO `utm` VALUES ('480e50e29d7c4fb3971a5d8a5cce8ee7', 2, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:43');
INSERT INTO `utm` VALUES ('4988085dd69541f5b2892109558f1299', 1, NULL, '/admin/option/doSave', 'csrf_token=23c77fff4b504b5a841025a7fd425107', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/setting/connection', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:41:25');
INSERT INTO `utm` VALUES ('49a0cc5b8e1a4bb09a2f8dc8f5deee58', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/me', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:10');
INSERT INTO `utm` VALUES ('4a820670418e405cad3c88e33c7cc31f', 1, NULL, '/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:18:23');
INSERT INTO `utm` VALUES ('4aa4799c6dbd49c0b131583c65b4444f', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:10:47');
INSERT INTO `utm` VALUES ('4ae18431472c4c1e89cd09f2d52620c8', 2, NULL, '/api/user/me', 'sign=3e1d392f9e1f5757751875b63b74c8d4&appId=appidi8thcGWps7Ki5Sh2&t=1576221580894', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:19:41');
INSERT INTO `utm` VALUES ('4b5f763d42fe482097634bab0a05fa54', 1, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:19');
INSERT INTO `utm` VALUES ('4b6ea67565b14ba8bf382e5fbfaa375c', 2, NULL, '/me/saveContact', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/proxy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:19:41');
INSERT INTO `utm` VALUES ('4c11cca14be6469eb1e51deb2f12aa76', 2, NULL, '/api/user/me', 'sign=652a0592468e3e4712123f2d53d1223c&appId=appidi8thcGWps7Ki5Sh2&t=1576219171299', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:39:32');
INSERT INTO `utm` VALUES ('4c52e16b98bc477b92a8ba632dccab32', 3, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:21:46');
INSERT INTO `utm` VALUES ('4c70b2995f1743d2b56a911314b053ae', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:17:57');
INSERT INTO `utm` VALUES ('4dbe7be2737a42b19d400e7606bce564', 3, NULL, '/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/finance/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:32');
INSERT INTO `utm` VALUES ('4df9fdb687b548c59ee9b86d609dcbcd', 1, NULL, '/admin/user/doAddGroupRolePermission', 'roleId=2&groupId=..._UserController&csrf_token=335dfa3ac3ec40d4a0a26c972041f7db', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:29');
INSERT INTO `utm` VALUES ('4ea29726d5814867843f7621e9eb4ca7', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:52:11');
INSERT INTO `utm` VALUES ('4f081f009e1844ad80e162403a174faf', 1, NULL, '/admin/user/doAddGroupRolePermission', 'roleId=3&groupId=..._AdminController&csrf_token=b3412f8b312b46d8ab137205604e8757', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:30:47');
INSERT INTO `utm` VALUES ('4f6fb7c57c584dd085f7d2cceb876d6c', 3, NULL, '/admin/user/detail/communication/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/member/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:49');
INSERT INTO `utm` VALUES ('50a0fa0bc5b0429aadbd24ca82fd0975', 1, NULL, '/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:31:03');
INSERT INTO `utm` VALUES ('50bab28fad834374b340098fb6cc00a7', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:38');
INSERT INTO `utm` VALUES ('519e2ebb4c65404faa1d59269eb17335', 2, NULL, '/me/doSaveIdSrc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:24:49');
INSERT INTO `utm` VALUES ('51e7863737034b37acf5c04eab37d4d3', 1, NULL, '/install/step2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:22');
INSERT INTO `utm` VALUES ('520612a37e744784ace86cf337690f72', 1, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:45:20');
INSERT INTO `utm` VALUES ('5228e6c563b54697ab719a0a33249353', 3, NULL, '/admin/doLogout', 'csrf_token=d284363c24b744a08059d92c35b08ada', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:24:26');
INSERT INTO `utm` VALUES ('5317d3b578774136856a1e0b586b47c2', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:59:47');
INSERT INTO `utm` VALUES ('5322cff5732b47a38707b73eaa5986fb', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:37');
INSERT INTO `utm` VALUES ('538ab823fceb42eca696348b63a869b6', 1, NULL, '/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:37');
INSERT INTO `utm` VALUES ('53b2dd98c03140ffbc5a24d938ba2aa3', 1, NULL, '/admin/user/sendMsg/wechat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/sendMsg/sms', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:53');
INSERT INTO `utm` VALUES ('545b47d9b2ec4921a4a061ca92817780', 1, NULL, '/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:47:00');
INSERT INTO `utm` VALUES ('547089ec20bc466796d7854be8a50ffc', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:00');
INSERT INTO `utm` VALUES ('54868dc02e794b7b883cd2a4f5b541a3', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:28:13');
INSERT INTO `utm` VALUES ('549b23789a2c49018a779ccc3c89cd9e', 1, NULL, '/admin/product', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:24:32');
INSERT INTO `utm` VALUES ('5542054ac0f943d29da4990d88e93a0d', 2, NULL, '/commons/attachment/upload', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/contract', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:48:25');
INSERT INTO `utm` VALUES ('55e1be552c1d4c2f9ffba518c3bc68e0', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:07:07');
INSERT INTO `utm` VALUES ('5627e42c32dd415183e02a8178e6c00c', 1, NULL, '/admin/user/doAddRolePermission', 'roleId=2&permissionId=299&csrf_token=55435073bcfa4fa5873e247096d30913', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:55:03');
INSERT INTO `utm` VALUES ('563de080d4e34714bce815216cf0e5f7', 2, NULL, '/api/user/me', 'sign=0c8799a0c340c0157815f2f88e1ea9ca&appId=appidi8thcGWps7Ki5Sh2&t=1576222589616', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8081/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:36:30');
INSERT INTO `utm` VALUES ('567410b610e64fe6bbaed6492ed89aa2', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:26');
INSERT INTO `utm` VALUES ('5772f85909b04f5686d5fe0a053cdf07', 2, NULL, '/api/user/me', 'sign=5a70b8a95eb6065954689e804af12b59&appId=appidi8thcGWps7Ki5Sh2&t=1576223269470', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/contract', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:47:50');
INSERT INTO `utm` VALUES ('57f23ec312bf4deabcc31b3dda506d34', 1, NULL, '/admin/addon/doUploadAndInstall', 'csrf_token=4a6b4650b60d4125940b39429ede30ad', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:18:36');
INSERT INTO `utm` VALUES ('5a43ba63b4404a778eda53dab9308739', 1, NULL, '/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:08:30');
INSERT INTO `utm` VALUES ('5ad67725e0274c4ba6ce0d598699c50c', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:55:03');
INSERT INTO `utm` VALUES ('5bb61a41c09049c8b68700d216bc7918', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:22');
INSERT INTO `utm` VALUES ('5c01a4f7bf4a4b6e894be0c9a21ea3bf', 2, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:41');
INSERT INTO `utm` VALUES ('5d15373a626d4ed49498f34adfee283d', 2, NULL, '/me/updateContractPicsList', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/contract', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:49:02');
INSERT INTO `utm` VALUES ('5e0815ec83e84be9971bfd0d3c044444', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:50');
INSERT INTO `utm` VALUES ('5e74891448344555aeea47b421a51a88', 3, NULL, '/admin/user/detail/finance/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:24');
INSERT INTO `utm` VALUES ('5e84819183a94c128e3d72bb47bf89f7', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2?type=action', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:53:57');
INSERT INTO `utm` VALUES ('6050c9d611df4b0da708a75d6b426872', 2, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:41');
INSERT INTO `utm` VALUES ('606b6e7e3c9946efa76d4045be219aed', 1, NULL, '/admin/setting/seo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/setting/tools', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:45:47');
INSERT INTO `utm` VALUES ('607dd8c9ad4c40929c2adc1155a1cbc5', 1, NULL, '/admin/article', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/article', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:39');
INSERT INTO `utm` VALUES ('610889aade92472c835320273bb4537a', 2, NULL, '/api/user/me', 'sign=867a52a79512e4f39ae60eb795772c23&appId=appidi8thcGWps7Ki5Sh2&t=1576223253117', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8081/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:47:33');
INSERT INTO `utm` VALUES ('61a76e5347ca42d098b88176327c0f60', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:00');
INSERT INTO `utm` VALUES ('61b4dae0bdec4a3c96f14dca705256fc', 2, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:58:22');
INSERT INTO `utm` VALUES ('6258a927260841188804270dae707c40', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:27:16');
INSERT INTO `utm` VALUES ('626a8dbfd07a4f01990984d587a7675b', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:16:48');
INSERT INTO `utm` VALUES ('6296ccac84444089a40e04b4934dcbde', 1, NULL, '/admin/entre/area_manage/areaMngers', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:22:01');
INSERT INTO `utm` VALUES ('629faf4b3c45497daf1b92dc35a7a802', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:16:44');
INSERT INTO `utm` VALUES ('62d39831ef3c4fc58484b3bd0221b03a', 1, NULL, '/admin/doLogout', 'csrf_token=9c7b44caf49c4523bc71ce7515b29265', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:12:23');
INSERT INTO `utm` VALUES ('63436fc87fef4757bfb9a81f0dc4016b', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:50');
INSERT INTO `utm` VALUES ('637ace98ab24495fa656a8e264ba6dfd', 2, NULL, '/api/user/me', 'sign=17bef89af3b8c83f470eabc3f9bf88dc&appId=appidi8thcGWps7Ki5Sh2&t=1576223264731', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:47:45');
INSERT INTO `utm` VALUES ('64473e3def364f8e9b72f23675cee6e1', 1, NULL, '/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:14');
INSERT INTO `utm` VALUES ('64c62e5d9f0244a78ea676d61173c124', 3, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:03');
INSERT INTO `utm` VALUES ('65ee182b1486431d947ff6340e7e74f4', 3, NULL, '/admin/entre/area_manage/areaMngers', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:24:20');
INSERT INTO `utm` VALUES ('65f87e6010704f37a889de5e69a6b773', 3, NULL, '/admin/user/detail/tag/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/me', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:22');
INSERT INTO `utm` VALUES ('66d218c8e02d423db280557cd0c5f119', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:25:05');
INSERT INTO `utm` VALUES ('6801e55f76ef42b399ac4ff41d079012', 1, NULL, '/admin/option/doSave', 'csrf_token=1828ce62704e4457a337351e9366848a', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:44:30');
INSERT INTO `utm` VALUES ('68fbf68c1a3a4bbabb227948a1dbf040', 1, NULL, '/admin/option/doSave', 'csrf_token=9c6808a4061540988b7b66b415427612', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/setting/api', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:32:09');
INSERT INTO `utm` VALUES ('69ee5284929e48a49b576877cd037f56', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:01:18');
INSERT INTO `utm` VALUES ('6b5220bff4e74e559d83bb4d4a221eb2', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:10');
INSERT INTO `utm` VALUES ('6ba0a86e72ce48358e980df9589f6786', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:16:30');
INSERT INTO `utm` VALUES ('6c4efd6d8674431eb7e53469cd15841d', 3, NULL, '/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:44');
INSERT INTO `utm` VALUES ('6cc9c1a7a47a44db863e630b8fe6053e', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:11:17');
INSERT INTO `utm` VALUES ('6d2155c69d694ed8b1aa56cfd7fe3300', 1, NULL, '/admin/user/doAddRolePermission', 'roleId=2&permissionId=51&csrf_token=abfcbf8af3e44ab3b4c3c32905701596', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:04:57');
INSERT INTO `utm` VALUES ('6f74c589b50c4926ad37537763bce696', 3, NULL, '/admin/entre/area_manage/doSave', 'csrf_token=9db667f0a0b846b7bcab59ac35208768', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:01:09');
INSERT INTO `utm` VALUES ('700e00014b664f38ba2d189d1973e06c', 1, NULL, '/admin/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:44:04');
INSERT INTO `utm` VALUES ('705fa0499ddd47feb35b2c7209169eea', 3, NULL, '/admin/entre/area_manage/edit/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:24:20');
INSERT INTO `utm` VALUES ('719611ee89fa47aab697fb92033b77d6', 1, NULL, '/admin/user/roleEdit/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:10');
INSERT INTO `utm` VALUES ('71a1e19e4e6a49b5a0f14348048dc3eb', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:11');
INSERT INTO `utm` VALUES ('727f543e9742473a8bc807601dadcd96', 1, NULL, '/admin/user/doDelRolePermission', 'roleId=2&permissionId=270&csrf_token=778df968735d42b3bfe98a469c10c708', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:16:24');
INSERT INTO `utm` VALUES ('72ed682ff39e4f0b9d34e6a69e4d4e89', 1, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:12');
INSERT INTO `utm` VALUES ('74205145eb884edab8ee53521a6d98f4', 3, NULL, '/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/tag/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:23');
INSERT INTO `utm` VALUES ('7433eb9edda14802ad15363589433811', 1, NULL, '/admin/user/doDelGroupRolePermission', 'roleId=2&groupId=..._UserController&csrf_token=ac770e22a95a4a16ae97342cf83333bb', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:11:10');
INSERT INTO `utm` VALUES ('74a73f0456114509a9d737b1865a63ed', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:27:38');
INSERT INTO `utm` VALUES ('752e765edf6a47358b5bc04e4d6e665f', 2, NULL, '/commons/attachment/upload', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:22:13');
INSERT INTO `utm` VALUES ('7565178ceb2f477fac6085bd823abc8d', NULL, NULL, '/admin/entre/area_manage/areaMngers', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:57');
INSERT INTO `utm` VALUES ('766a35f2afda405bb1b73c4fc2a962de', 3, NULL, '/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:45');
INSERT INTO `utm` VALUES ('76735bebe3b847fe88dd3d56db29b83e', 1, NULL, '/me', 'sign=e670d1c59a9ea85e37aba349b48634cd&appId=appidi8thcGWps7Ki5Sh2&t=1576207603207111', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:27:49');
INSERT INTO `utm` VALUES ('7776e156f2f6423cb1ed3b83811cc933', 1, NULL, '/admin/permission', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:07');
INSERT INTO `utm` VALUES ('7812918f360743098f75c9b0f2b949b0', 1, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://localhost:8081/reg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:35:08');
INSERT INTO `utm` VALUES ('786a2ead7537499c8e8cc325f099b1cf', NULL, NULL, '/api/user/me', 'sign=ad9985818c1c6a95b88761782f8f72c8&appId=appidi8thcGWps7Ki5Sh2&t=1576219099686', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:38:20');
INSERT INTO `utm` VALUES ('788811b309d74f5ca8cc85b49db5078c', 3, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:02:35');
INSERT INTO `utm` VALUES ('792f31dc6266448abdecbecdc295920b', 1, NULL, '/api/user/me', 'sign=752ce9474299494b6c8921a5ed076b67&appId=appidi8thcGWps7Ki5Sh2&t=1576207603213', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:32:16');
INSERT INTO `utm` VALUES ('7964284bc9e34167a005e1fcf10e04bb', 1, NULL, '/admin/user/doAddRolePermission', 'roleId=3&permissionId=300&csrf_token=b1761e53d12b40e7bd00365f475210ad', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/3?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:28:55');
INSERT INTO `utm` VALUES ('79d4451a6f4d479a9f216f1c4ae46be2', 3, NULL, '/admin/user/doAddGroupRolePermission', 'roleId=2&groupId=..._UserController&csrf_token=4fd7108fc40e44f9b94a918cf78205a6', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:07:49');
INSERT INTO `utm` VALUES ('79e2e9162f074ac8bbf58ada14532c87', 3, NULL, '/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:24');
INSERT INTO `utm` VALUES ('79e3e6c8b3a84341b507268693eb81fa', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2?type=action', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:56:29');
INSERT INTO `utm` VALUES ('7a1ad8232ef3457bb80bc3baed3c2b75', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/permissions/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:52:29');
INSERT INTO `utm` VALUES ('7a3a95330d164f21a82f8786fb22dc12', 1, NULL, '/admin/doLogout', 'csrf_token=a59927c62f844995ba5b9a0ce01dbca0', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/role/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:00');
INSERT INTO `utm` VALUES ('7aa2fd85c25a4c49ae85f84ca0ef2a4c', 1, NULL, '/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:30:50');
INSERT INTO `utm` VALUES ('7b0a6dc47a414f66a7bfa58923aa29bb', 3, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:53');
INSERT INTO `utm` VALUES ('7b736a2185c94e09a27a22aee4412900', 1, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:21:04');
INSERT INTO `utm` VALUES ('7c293c87d435475399f84efd2cb26427', 1, NULL, '/admin/product/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/product/comment', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:24:39');
INSERT INTO `utm` VALUES ('7c8120a0b4d84d468d7e807478cb314c', 3, NULL, '/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/finance/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:31');
INSERT INTO `utm` VALUES ('7c9c6d4dc84c4a4f9ebd176e13fd4c9c', 3, NULL, '/admin/user/permissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:14');
INSERT INTO `utm` VALUES ('7d73207e4dce442da777ebc91aa73762', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:24');
INSERT INTO `utm` VALUES ('7d7d0bbbf5404365a2308556662626fc', 2, NULL, '/commons/attachment/upload', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/contract', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:48:56');
INSERT INTO `utm` VALUES ('7d93cdaa045e4625a51851a40b590112', 1, NULL, '/admin/user/tag', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/mgroup', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:10:28');
INSERT INTO `utm` VALUES ('7dc11c016e8c4a54a77c771a4757e94e', 2, NULL, '/api/user/me', 'sign=114d7cb5361b456d205dad78bbadc44d&appId=appidi8thcGWps7Ki5Sh2&t=1576221643622', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:20:44');
INSERT INTO `utm` VALUES ('7dc4e1060eff4be2880b13bee5c58580', 1, NULL, '/admin/setting/connection', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:45:40');
INSERT INTO `utm` VALUES ('7ed50f4d5d4645b5be192a6be7d8d5a7', 1, NULL, '/admin/user/roleEdit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:52:36');
INSERT INTO `utm` VALUES ('7f780a22fbeb4aa3bf59a96c39ea6c9a', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:24:32');
INSERT INTO `utm` VALUES ('7ff42c5cdc104939b6c373350770b4a5', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:15:32');
INSERT INTO `utm` VALUES ('801db7c891fc4e859c43a58ea98f2b69', 1, NULL, '/admin/permission', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:04');
INSERT INTO `utm` VALUES ('80dccce8e92d46ccb6dc316bf9b7296a', 1, NULL, '/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:00');
INSERT INTO `utm` VALUES ('815b9605b3b642fda2d0ed513e114013', NULL, NULL, '/admin/logiin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:00');
INSERT INTO `utm` VALUES ('8176df4b05e842ed9cf0660d67c474b8', 2, NULL, '/me/saveContact', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/proxy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:31');
INSERT INTO `utm` VALUES ('817a8a613ccb4750be6d8b5f8f49943e', 1, NULL, '/admin/user/doAdd', 'csrf_token=5bc3af27159b40b78e368e3451430154', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:31:30');
INSERT INTO `utm` VALUES ('84b4ee49102f43ccb37b58ac2d3f1f6a', 1, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:27:34');
INSERT INTO `utm` VALUES ('858e4b79e0954f34b682eaca847d554b', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index?date=yesterday', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:22');
INSERT INTO `utm` VALUES ('86075189c07141c1b4982fe58be53522', 4, NULL, '/admin/doLogout', 'csrf_token=190b57cfc42a4398b1350a39ed9a8b01', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:21:26');
INSERT INTO `utm` VALUES ('872f30f3214c4c9e8c3177a9b7b8fd8b', 1, NULL, '/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/3?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:29:03');
INSERT INTO `utm` VALUES ('87457686191f4ce3b24ad923412595ae', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:05:06');
INSERT INTO `utm` VALUES ('88d526aab5454702a7420f69746b7a9d', 1, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:34');
INSERT INTO `utm` VALUES ('892908f1f9854a8dbb08bb79e70bb262', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:23:59');
INSERT INTO `utm` VALUES ('89a8fc1a24b7475db50fd386ce7a569c', 2, NULL, '/api/user/me', 'sign=af72f7128fe40028829bd468ec442928&appId=appidi8thcGWps7Ki5Sh2&t=1576222216558', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://192.168.43.248:8081/proxy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:17');
INSERT INTO `utm` VALUES ('8a24f99db0284d57b2af5339bab83ea7', 3, NULL, '/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/utm/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:36');
INSERT INTO `utm` VALUES ('8a38e29a16ff401789a302ebf856290b', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:11:59');
INSERT INTO `utm` VALUES ('8aeba963b1aa42609cf61a73424f8d52', 3, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:04');
INSERT INTO `utm` VALUES ('8ba9856c779b43acb489a5eb19b65a79', 1, NULL, '/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:22:01');
INSERT INTO `utm` VALUES ('8bca9f42a2164c588350b24241b011b4', 1, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:15:10');
INSERT INTO `utm` VALUES ('8c4672d339654544af52b21adfe0aecf', 1, NULL, '/admin/article', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/article', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:37');
INSERT INTO `utm` VALUES ('8c76ff6885ed4d9fa2d7043d398097ce', 1, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:59:37');
INSERT INTO `utm` VALUES ('8d0a538bc1ab4e389e95a97dc721bd17', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:21:02');
INSERT INTO `utm` VALUES ('8d12215d968d443abbc3b4f36896f0be', 2, NULL, '/me/doSmsSend', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:42:45');
INSERT INTO `utm` VALUES ('8dbd5df9e21b4f4a8e0d01c5c30f83a3', NULL, NULL, '/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:57');
INSERT INTO `utm` VALUES ('8e4896e906c0427abc01c93e84d0d9b4', NULL, NULL, '/install/gotoStep3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/install/step2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:28');
INSERT INTO `utm` VALUES ('8f7a3c4016da434dada30ebd40ec31e2', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:13');
INSERT INTO `utm` VALUES ('90511c4a3bf0423f9865f86862d55c6b', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:59:45');
INSERT INTO `utm` VALUES ('90a370e3b105432bbdfd210c995b3743', 1, NULL, '/admin/setting/reg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/setting/seo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:45:52');
INSERT INTO `utm` VALUES ('9189352e9cf24825b9826cf0ff11d626', 4, NULL, '/admin/index', 'date=28d', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index?date=7d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:24');
INSERT INTO `utm` VALUES ('924090c3c9e645f0b712a93ac4534999', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:53:44');
INSERT INTO `utm` VALUES ('9283f235debd465ba4b32cc73b1b45b0', 2, NULL, '/me/doSmsSend', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:20:18');
INSERT INTO `utm` VALUES ('938904390fca476b9150a45da8357a9b', 2, NULL, '/me/doSaveIdSrc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:56');
INSERT INTO `utm` VALUES ('9495a4d4362e45e7af97364627310198', 1, NULL, '/api/user/me', 'sign=752ce9474299494b6c8921a5ed076b67&appId=appidi8thcGWps7Ki5Sh2&t=1576207603213', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:33:26');
INSERT INTO `utm` VALUES ('949a4ea451ed45ecbc2775ba5f771cef', 1, NULL, '/admin/user/roleEdit/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:15:28');
INSERT INTO `utm` VALUES ('94a15c6a0b36454e8821832e53e9ac69', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:16');
INSERT INTO `utm` VALUES ('94d86dc9719b4f1aa180978417567da4', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:21:26');
INSERT INTO `utm` VALUES ('95670e13ed154cbbafa5d61705da7be5', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:20:48');
INSERT INTO `utm` VALUES ('95698509e447442b9f74e40588064283', NULL, NULL, '/admin/template', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:41:35');
INSERT INTO `utm` VALUES ('9585158c39974909a859caf31e2cde1c', 1, NULL, '/api/user/me', 'sign=34c1f95be6cf4a52eae3b78d43f94337&appId=appidi8thcGWps7Ki5Sh2&t=1576208084565', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://localhost:8081/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:34:45');
INSERT INTO `utm` VALUES ('967ac47e4b4c4daea4ae02996775b2d3', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:57');
INSERT INTO `utm` VALUES ('96f5b7ca7a23492280db51d2a89f6be6', 1, NULL, '/admin/user/doDelRolePermission', 'roleId=2&permissionId=271&csrf_token=778df968735d42b3bfe98a469c10c708', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:16:19');
INSERT INTO `utm` VALUES ('97727aabb4d04c819b785681b8f069be', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:49');
INSERT INTO `utm` VALUES ('97bafc57a1f841eaa938ce45f55bfcd4', 1, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:44:36');
INSERT INTO `utm` VALUES ('995d043bf29c423fb9e7eb17ea8d5b54', 3, NULL, '/admin/user/detail/communication/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:21');
INSERT INTO `utm` VALUES ('999b45b7d4074b56a9256a2fdd942fdf', 1, NULL, '/install/gotoStep3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/install/step2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:31');
INSERT INTO `utm` VALUES ('9abd7d64b86c4a0dad5527f94cb84659', NULL, NULL, '/api/user/me', 'sign=17fb736674fad7623219674a2532101c&appId=appidi8thcGWps7Ki5Sh2&t=1576216347198', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.1.86', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://192.168.1.86:8081/splash', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 13:52:27');
INSERT INTO `utm` VALUES ('9b599ede16b84dc39c7548dc354acec4', 1, NULL, '/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/setting/api', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:18:15');
INSERT INTO `utm` VALUES ('9b6fbee5408f4750a1b16176ec51ee15', 1, NULL, '/admin/product/comment', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/product/tag', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:24:38');
INSERT INTO `utm` VALUES ('9be9654b9b2a4e1e8045241d09992649', NULL, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:24:19');
INSERT INTO `utm` VALUES ('9d8286f78f294b51a506a834f722dda2', 1, NULL, '/admin/setting/connection', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/setting/api', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:40:09');
INSERT INTO `utm` VALUES ('9d89364f789842f4869cd267e8b105cb', 3, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:39');
INSERT INTO `utm` VALUES ('9e4474e32ee24aeb8c384ba021bd7501', 1, NULL, '/admin/user/mgroup', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/sendMsg/sms', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:10:26');
INSERT INTO `utm` VALUES ('9e51cc5457d249e892667cf8b5f10641', 3, NULL, '/admin/entre/area_manage/areaMngers', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:21:50');
INSERT INTO `utm` VALUES ('9e8cb0b530ee42eaa4974ce97f868b2d', 1, NULL, '/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:46:32');
INSERT INTO `utm` VALUES ('9f2aa594729744ed9a632eedad8c367c', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:08:42');
INSERT INTO `utm` VALUES ('9feb8f9afa834ebca3dc2ef0f7e2c759', 2, NULL, '/api/user/me', 'sign=267b11807f42eef5f233e31b68398f59&appId=appidi8thcGWps7Ki5Sh2&t=1576222185350', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/proxy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:29:46');
INSERT INTO `utm` VALUES ('a0d445af59a4408eb64d9f9d333696f7', 3, NULL, '/admin/user/detail/utm/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/avatar/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:31');
INSERT INTO `utm` VALUES ('a0ddad63309c4d6eb4b4be08c3355410', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:31:00');
INSERT INTO `utm` VALUES ('a0e50a0f97f945c397a56a1eac756fe9', 4, NULL, '/admin/entre/area_manage/audit', 'customerId=2&contactStatus=topay&csrf_token=46581343c362465d97a0203a09b337e7', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:07:30');
INSERT INTO `utm` VALUES ('a1907b8d37a648e98f899da9c3ef82b2', 1, NULL, '/admin/user/sendMsg/sms', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/sendMsg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:52');
INSERT INTO `utm` VALUES ('a22ef8a100894bd7a340badba6962c72', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:33');
INSERT INTO `utm` VALUES ('a3683fdfb4ec4cde81532478c98d5e9c', 3, NULL, '/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:02');
INSERT INTO `utm` VALUES ('a4172a31511247da9f618bccea119e3c', 3, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:12:52');
INSERT INTO `utm` VALUES ('a4e647e83dae48278e97a29fddcaef7f', 2, NULL, '/commons/attachment/upload', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:21:14');
INSERT INTO `utm` VALUES ('a4f09c71b74a458cbe432e0cdf375e6a', 1, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:45:57');
INSERT INTO `utm` VALUES ('a51a8277c3a14f4a8a147ecc5d8d53a3', 1, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:35:57');
INSERT INTO `utm` VALUES ('a563c6470f124f3aa08aa87895910f9b', 1, NULL, '/api/user/me', 'sign=92d78c57216657795695874929ad68b7&appId=appidi8thcGWps7Ki5Sh2&t=1576208073034', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://localhost:8081/splash', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:34:33');
INSERT INTO `utm` VALUES ('a6019043bb03499eb3c904b05c98d7d7', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:25:00');
INSERT INTO `utm` VALUES ('a63d609f2957486da822e07c9c43b88c', 1, NULL, '/admin/doLogout', 'csrf_token=12c3fa5127914d7490e94409a76ceb85', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:49');
INSERT INTO `utm` VALUES ('a6d19d0bba91455cbdfe36889c0a0bb3', NULL, NULL, '/api/user/me', 'sign=c27309406b73fdf525a65e186115faf7&appId=appidi8thcGWps7Ki5Sh2&t=1576216347192', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.1.86', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://192.168.1.86:8081/splash', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 13:52:27');
INSERT INTO `utm` VALUES ('a6f4b5cf46d1487cb6b8e16d3665fd4b', 1, NULL, '/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:18:39');
INSERT INTO `utm` VALUES ('a74d4baa25b44b069e22cc74a3c558fb', 3, NULL, '/admin/user/detail/signature/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/pwd/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:51');
INSERT INTO `utm` VALUES ('a7d6669fa2a049e5b89a4b0e71451cf7', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:10:38');
INSERT INTO `utm` VALUES ('a81faf479fc54789b16547563d6f8691', 1, NULL, '/admin/user/permissions/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:52:26');
INSERT INTO `utm` VALUES ('a83ae44e90ce435693d8820bff23aec6', 4, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:00');
INSERT INTO `utm` VALUES ('a89462d3f9ce4e88973de53f85a6ffe6', 3, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:08:02');
INSERT INTO `utm` VALUES ('a906d017956d4eb79558b26440b3b469', 1, NULL, '/admin/addon/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:18:24');
INSERT INTO `utm` VALUES ('a91746af183e46be991947fd547c9e7f', 1, NULL, '/admin/user/detail/role/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:31:48');
INSERT INTO `utm` VALUES ('a926bdd6e51b40b3bebefee82a85f6d1', 2, NULL, '/me/doSaveIdSrc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:22:29');
INSERT INTO `utm` VALUES ('aad4f80a3a8041ba994fe60c277e322b', 1, NULL, '/admin/addon/doStop', 'id=io.jpress.addon.entre&csrf_token=287cd185fad847b8aec8e0f8b5363197', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:18:20');
INSERT INTO `utm` VALUES ('acf2dc0881ef4f7b8ae66dc135c3a877', 1, NULL, '/admin/user/doRoleSave', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/roleEdit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:53:34');
INSERT INTO `utm` VALUES ('adb74d576a1b49d1a20bdea18960e3cc', 1, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://localhost:8081/reg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:35:12');
INSERT INTO `utm` VALUES ('ade71c00163b4783b64ebd3b126c7012', 1, NULL, '/admin/user/rolePermissions/3', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:28:33');
INSERT INTO `utm` VALUES ('af753598cbf44883973184c9be02e3e6', 1, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:57:48');
INSERT INTO `utm` VALUES ('af844cdb5fb4414dba773169a0a83f1f', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 'Java/1.8.0_231', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:59:43');
INSERT INTO `utm` VALUES ('afde70898e1f43b7a2be2c73efcf5d69', 3, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:05:32');
INSERT INTO `utm` VALUES ('afe8d7196a6a4f96814ec4f1ad383b30', 4, NULL, '/admin/index', 'date=yesterday', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:21');
INSERT INTO `utm` VALUES ('b073c3b6f8b64c2586f2ce55b9062e97', 1, NULL, '/admin/user/doAddGroupRolePermission', 'roleId=2&groupId=user&csrf_token=2d717df7c25649029e5975a416b88679', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:11:56');
INSERT INTO `utm` VALUES ('b11e243508b3468db34f9d3f4d2f6c1d', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:16');
INSERT INTO `utm` VALUES ('b17e68fbdb364b7aa03c8322fdeecd2b', 3, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:14');
INSERT INTO `utm` VALUES ('b193424b5b86409c8ad6a123ddb47a41', 2, NULL, '/api/user/me', 'sign=7883f8fffd5df6cc2ef409ab9ecde811&appId=appidi8thcGWps7Ki5Sh2&t=1576221577569', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/proxy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:19:38');
INSERT INTO `utm` VALUES ('b1c2d69523bb4656bc726ec4b2278b9b', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:14');
INSERT INTO `utm` VALUES ('b24062d3c3d34bee887572b0ee4de46d', 1, NULL, '/admin/doLogout', 'csrf_token=bda3c64669c24ce8a611c96db776440e', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:50');
INSERT INTO `utm` VALUES ('b25166f888fe4cebacd7265481b25882', 1, NULL, '/admin/setting/connection', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/setting/connection', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:41:35');
INSERT INTO `utm` VALUES ('b270259b28fb4e0f9719938539de64e7', 1, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:45:18');
INSERT INTO `utm` VALUES ('b2833709f8864fdc9bfa873689865486', 1, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:43:29');
INSERT INTO `utm` VALUES ('b31d9620a2f84751b5f856c622f60bae', 1, NULL, '/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:39');
INSERT INTO `utm` VALUES ('b372cd2972f6438e86968ca3c46476f6', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:07:20');
INSERT INTO `utm` VALUES ('b44006bfe87f408e9c91dab772cfaf17', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:27:09');
INSERT INTO `utm` VALUES ('b5144e3a02624d07bfde0a2da8fa7599', NULL, NULL, '/admin/option/doSave', 'csrf_token=f1711e30e2e04e908f52fab6360ccdbe', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:27:38');
INSERT INTO `utm` VALUES ('b53c9e8ae5c24f6bbdb1054aca1760e3', 2, NULL, '/commons/attachment/upload', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/contract', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:48:40');
INSERT INTO `utm` VALUES ('b59bf44d96834ebebf1b6e905a17428c', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/roleEdit/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:15:31');
INSERT INTO `utm` VALUES ('b59ebabe66444bc6a34c5244f6f50e88', 1, NULL, '/article/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index?date=14d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:43:26');
INSERT INTO `utm` VALUES ('b6faaa62ce27474596127ff618a77ed6', 1, NULL, '/admin/user/sendMsg/wechat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/sendMsg/sms', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:49');
INSERT INTO `utm` VALUES ('b71422d5d69e43a1b9370a48fa3eeca4', 1, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:31:30');
INSERT INTO `utm` VALUES ('b73fa3705a44470db5e99f2e91bc70ff', NULL, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:41:24');
INSERT INTO `utm` VALUES ('b883a57b972b4926afd839d168239801', 3, NULL, '/admin/user/detail/other/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/signature/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:52');
INSERT INTO `utm` VALUES ('b8b879feb8e24d069c2967a150d3a407', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:11:13');
INSERT INTO `utm` VALUES ('b9db1065e1dc461eafc33f7ce5beebec', NULL, NULL, '/install/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/install/step3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:23:57');
INSERT INTO `utm` VALUES ('bb3cd4b5d28740fea4154cbe17a102ba', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:05:15');
INSERT INTO `utm` VALUES ('bbf1a29e752d4e8289bcc0a2a86efa23', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:21:31');
INSERT INTO `utm` VALUES ('bca91d5b059447dba92f6a11c8d45cf4', 1, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/template', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:44:00');
INSERT INTO `utm` VALUES ('bcad3fe44153461a96cec9d71ed11e55', NULL, NULL, '/install/step2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:20');
INSERT INTO `utm` VALUES ('bcb5bc1b09a94d1693780f03408be0a5', 3, NULL, '/admin/doLogout', 'csrf_token=713e7efd49c64fc6b6e8b5fc55c0cdc9', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:51');
INSERT INTO `utm` VALUES ('bcd09814672742bf8905cd13863a900b', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:56');
INSERT INTO `utm` VALUES ('bd12716d875642f2880c1c8c140ce59c', 1, NULL, '/admin/option/doSave', 'csrf_token=c982dac53b394a5d8962f22567fc2d56', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:45:15');
INSERT INTO `utm` VALUES ('bd9d5029eaa246a4a100ad1ab2784c83', 3, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:05:29');
INSERT INTO `utm` VALUES ('be28cc67df564e148888cf065718f6f4', 3, NULL, '/admin/user/detail/utm/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/avatar/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:53');
INSERT INTO `utm` VALUES ('bf1bd904d61d4d068c4fd5acacbc4111', 1, NULL, '/admin/user/doAddRolePermission', 'roleId=3&permissionId=298&csrf_token=b1761e53d12b40e7bd00365f475210ad', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/3?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:28:49');
INSERT INTO `utm` VALUES ('c0265bbef6fb40629f98363727da4ba3', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/roleEdit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:28:11');
INSERT INTO `utm` VALUES ('c074e68be16545d692dc188e564e85e9', NULL, NULL, '/commons/captcha', 'd=0.49125777199304554', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:24:51');
INSERT INTO `utm` VALUES ('c0e66c3bbaaf4087a223704633437fc1', 1, NULL, '/api/user/me', 'sign=f9a9980126d828b1deb786803bcd6559&appId=appidi8thcGWps7Ki5Sh2&t=1576208084626', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://localhost:8081/proxy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:34:45');
INSERT INTO `utm` VALUES ('c17755c6634d4a5c8007c01e9cd421cc', 4, NULL, '/article/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index?date=14d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:27');
INSERT INTO `utm` VALUES ('c1ac0a84b2db492b930d74912ea4f5c4', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:07:57');
INSERT INTO `utm` VALUES ('c1f0441cda60419a8c684188a2a5bcd8', 3, NULL, '/admin/entre/area_manage/edit/1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:21:50');
INSERT INTO `utm` VALUES ('c216e4ec86dc4f6183648616f005fddd', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:12:39');
INSERT INTO `utm` VALUES ('c243de578d18495f91089530bdced98c', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=action', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:16:07');
INSERT INTO `utm` VALUES ('c3047661706141568827d3742d8f8a06', 1, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:36:01');
INSERT INTO `utm` VALUES ('c31dda7caee043d4a3922ed484eb83fc', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:25:15');
INSERT INTO `utm` VALUES ('c348f9d5b10246d580398a33350ae854', 4, NULL, '/admin/index', 'date=yesterday', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:22');
INSERT INTO `utm` VALUES ('c35d142faa8c4c1b9786243bd57665d3', 3, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:22');
INSERT INTO `utm` VALUES ('c38a96274de348f28a7f28ae61247329', 1, NULL, '/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:47:11');
INSERT INTO `utm` VALUES ('c3e9f81023d24885af9ef336ef12d21a', 3, NULL, '/admin/doLogout', 'csrf_token=b86edb11e33b4a68b47bcf65eb0a5974', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:07:56');
INSERT INTO `utm` VALUES ('c42c243153d6491fb6228fef090970a1', 3, NULL, '/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:22');
INSERT INTO `utm` VALUES ('c4952a43ac514384b6312a45b2d20194', 3, NULL, '/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:16');
INSERT INTO `utm` VALUES ('c4c2a5a519fa4e4d90e2fb0230387f84', 3, NULL, '/admin/user/permissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:04');
INSERT INTO `utm` VALUES ('c50be425afd74252aa4be6e2a78cff7a', 1, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:58');
INSERT INTO `utm` VALUES ('c60c71a07c664677bc2ccfd3d79850e4', 1, NULL, '/admin/user/roleEdit/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:08:38');
INSERT INTO `utm` VALUES ('c64daa7c26e34fcdb1e35dcfac57b8d2', 3, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:07');
INSERT INTO `utm` VALUES ('c69a503968214221aeeedfaf42cc3bcf', 1, NULL, '/install/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/install/step3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:32');
INSERT INTO `utm` VALUES ('c6d06f7f7efb48c39b49efbf828c1fb5', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/tag', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:10:36');
INSERT INTO `utm` VALUES ('c78489f5a8a24a48a78d2ad8b605808e', 3, NULL, '/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:00');
INSERT INTO `utm` VALUES ('c7f639bc746e41a89d814f250a0363c3', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:04');
INSERT INTO `utm` VALUES ('c8204afd9b4e49aa9874d336be482e86', 4, NULL, '/admin/index', 'date=7d', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index?date=yesterday', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:23');
INSERT INTO `utm` VALUES ('c85764890df543e09ff8b80c6af37505', NULL, NULL, '/install/step3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/install/step2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:23:53');
INSERT INTO `utm` VALUES ('c8cbfdd7cbb64e0d8bc4c5f7d733c5b0', 3, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:18');
INSERT INTO `utm` VALUES ('c969620d96b34d84bd95a402c0126001', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:59');
INSERT INTO `utm` VALUES ('c9c16a4f837a435a8fe5afb6cfe8074c', 1, NULL, '/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:28:31');
INSERT INTO `utm` VALUES ('cac1b5c763b04de7be35ac222612e54d', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:59:48');
INSERT INTO `utm` VALUES ('cacc6362a2b04a8fbac8fc1296d4e968', 1, NULL, '/admin/order', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/product/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:24:45');
INSERT INTO `utm` VALUES ('cae592ce24d847c4bdb62b5d637ddb61', 4, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:33:24');
INSERT INTO `utm` VALUES ('cb5a591b9a2a4be499158cf121c03ad7', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:22');
INSERT INTO `utm` VALUES ('cb7744c2954947df856c897e84880aa3', 4, NULL, '/admin/index', 'date=14d', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index?date=28d', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:38:24');
INSERT INTO `utm` VALUES ('ccc82b090f84432088f3366c55e4f32f', 2, NULL, '/api/user/me', 'sign=667ae0cf90a3e2e828a4033d4e5f6e7b&appId=appidi8thcGWps7Ki5Sh2&t=1576222230967', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:31');
INSERT INTO `utm` VALUES ('cd02e6707a6e413faf3addfe6bff64fb', 3, NULL, '/admin/user/detail/tag/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:45');
INSERT INTO `utm` VALUES ('cd5306da59fe431ca433c277aa95884b', 1, NULL, '/admin/user/sendMsg/sms', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/sendMsg/wechat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:10:00');
INSERT INTO `utm` VALUES ('cd9be5ac1cba4f43923abe9cc1a88cbf', 1, NULL, '/admin/user/rolePermissions/2', 'type=action', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:15:57');
INSERT INTO `utm` VALUES ('cdbee4a5985a4d81a91d1e4d5103e950', 1, NULL, '/api/user/me', 'sign=752ce9474299494b6c8921a5ed076b67&appId=appidi8thcGWps7Ki5Sh2&t=1576207603213', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:33:25');
INSERT INTO `utm` VALUES ('ce0d87d931e741748ff92dd003cd119b', 2, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:43');
INSERT INTO `utm` VALUES ('ce8697572ccf45e48796707f644b8beb', 3, NULL, '/admin/user/detail/signature/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/pwd/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:29');
INSERT INTO `utm` VALUES ('cea60363ec204b96a59db4822c3a588b', 3, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:58:45');
INSERT INTO `utm` VALUES ('cf15f721337b45d9b901bd2ee7ea6253', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:27:42');
INSERT INTO `utm` VALUES ('cf3bbc02e56c40b5b83168fc0bb96e69', 2, NULL, '/me/checkBeforeVer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:50');
INSERT INTO `utm` VALUES ('cf500cc5bbe14f75b2f1df8fe42c290f', 1, NULL, '/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:18:20');
INSERT INTO `utm` VALUES ('cf6d2149dfb344338f93fae81559ed01', 3, NULL, '/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:20');
INSERT INTO `utm` VALUES ('cf8a087e30194e069dd238c5428c08e6', 1, NULL, '/admin/user/doDelRolePermission', 'roleId=2&permissionId=269&csrf_token=ec11a57047ed4e48997d28fef56e7ec8', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:12:02');
INSERT INTO `utm` VALUES ('d02dbb0d87f74c3da7581597f2e81d10', 1, NULL, '/admin/setting/api', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:39:58');
INSERT INTO `utm` VALUES ('d0370b9c6f1046d987998b8fb206dd86', 1, NULL, '/admin/user/sendMsg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:44');
INSERT INTO `utm` VALUES ('d0d00e2d8b5345beabe99730b7fda143', 3, NULL, '/admin/user/detail/other/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/signature/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:30');
INSERT INTO `utm` VALUES ('d0faf6a9d66048c99397d6380be0d778', 2, NULL, '/commons/attachment/upload', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/contract', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:48:07');
INSERT INTO `utm` VALUES ('d1b13e069e00466fb9d724af296311a3', NULL, NULL, '/api/user/me', 'sign=dffd98e0f890461c12074b3ef82aa026&appId=appidi8thcGWps7Ki5Sh2&t=1576219099890', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/proxy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:38:20');
INSERT INTO `utm` VALUES ('d35ade9f0c524b4cb30f9015b4572e92', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:12:23');
INSERT INTO `utm` VALUES ('d3b11ebb06764c4585c128700592cb20', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:11:31');
INSERT INTO `utm` VALUES ('d43674dca6ec4bf3a02d69c422662714', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:57:39');
INSERT INTO `utm` VALUES ('d458bcd0dd8349aab312c287400f959c', 3, NULL, '/admin/user/me', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:21');
INSERT INTO `utm` VALUES ('d4a0845e3f1c40f3941565dbc9a8360d', 1, NULL, '/admin/product/category', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/product', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:24:34');
INSERT INTO `utm` VALUES ('d5d1954af8d54f0092087899c96b18f2', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:38');
INSERT INTO `utm` VALUES ('d640963e3cfa4023bf54e6d60f42a51e', 1, NULL, '/admin/permission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/permission?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:08');
INSERT INTO `utm` VALUES ('d71f747b62604817a6d848dd6a084bcb', 1, NULL, '/admin/user/doAddRolePermission', 'roleId=2&permissionId=3&csrf_token=abfcbf8af3e44ab3b4c3c32905701596', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:04:49');
INSERT INTO `utm` VALUES ('d750ab2ca0ea49c3a73eb961aad3d63d', NULL, NULL, '/api/user/me', 'sign=6e83694b5f9e7f257b0ca0f47388d5c0&appId=appidi8thcGWps7Ki5Sh2&t=1576222201147', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:01');
INSERT INTO `utm` VALUES ('d7b4af9e1e764f91b05f274abe553167', 3, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:55');
INSERT INTO `utm` VALUES ('d7d6ee32f959456897b423c22840fc9f', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:59:42');
INSERT INTO `utm` VALUES ('d7dae8b9b85b42768cdd90aeb55fb393', 2, NULL, '/api/user/me', 'sign=3ae8c78562f89cfa298f7865698e8748&appId=appidi8thcGWps7Ki5Sh2&t=1576222250174', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:50');
INSERT INTO `utm` VALUES ('d8921b48e0f54254a6032dbd3711980c', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:32');
INSERT INTO `utm` VALUES ('d9788c8bd24342de9a5698c76c79a4f0', 2, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:46');
INSERT INTO `utm` VALUES ('d99697d4b45146cea20ac7f1b1a28ccb', 3, NULL, '/admin/user/detail/role/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/tag/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:45');
INSERT INTO `utm` VALUES ('da1b1fb32ec24ee2bd443f391d1bc4cf', 1, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:26:16');
INSERT INTO `utm` VALUES ('db547e6a643b43b3951799279f80e08c', 1, NULL, '/admin/addon/doUploadAndInstall', 'csrf_token=9aa2663d6b7246759d8abf64e2ff376d', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:46:57');
INSERT INTO `utm` VALUES ('db5cb7022ae44d90872aa39d6459af80', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/permissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:17');
INSERT INTO `utm` VALUES ('dbc4734105e540c1b6a2b2f6cce9b2a7', 1, NULL, '/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:30:07');
INSERT INTO `utm` VALUES ('dbe7723a11504480ba28e77147c07f79', 2, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:43');
INSERT INTO `utm` VALUES ('dc6fab4be6fb4e41afc821d676ab626a', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:17:55');
INSERT INTO `utm` VALUES ('dc88dc408a58405887b75be8f3b4471b', 3, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:08:10');
INSERT INTO `utm` VALUES ('dce035363c1f44cd882ce4625de20fff', 3, NULL, '/admin/user/detail/member/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/finance/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:27');
INSERT INTO `utm` VALUES ('dd2f41b59e044d3bb492c7315585a6fb', 1, NULL, '/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon/install', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:30:52');
INSERT INTO `utm` VALUES ('dd4f59d7b2d24e2882b8b2fe1d60d0eb', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:48');
INSERT INTO `utm` VALUES ('dd9cf6513f37466daea54c2c4f3787ec', 1, NULL, '/admin/user/doRoleSave', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/roleEdit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:28:11');
INSERT INTO `utm` VALUES ('de292dc2aed6499899d233cd2f0f7023', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:31');
INSERT INTO `utm` VALUES ('df78e25bbc4349848903c2a0bef071aa', 3, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:05:36');
INSERT INTO `utm` VALUES ('dfdc1ef77bbf4801a9d5023e9f44be59', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:12:19');
INSERT INTO `utm` VALUES ('e03590631e3544d3878291594a6e91c8', 2, NULL, '/api/user/me', 'sign=594466f6a17e841b0a4ad44e01058c6e&appId=appidi8thcGWps7Ki5Sh2&t=1576223341667', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/viewContract', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:49:02');
INSERT INTO `utm` VALUES ('e25d6716b4814b9ead789ef5913c2f68', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:35');
INSERT INTO `utm` VALUES ('e2aac8dcd718491bb450f97641bf39c2', 1, NULL, '/admin/user/doUpdateUserRoles', 'csrf_token=bda3c64669c24ce8a611c96db776440e', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:44');
INSERT INTO `utm` VALUES ('e2b1748269a54db39c9ac41814979a78', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:59:45');
INSERT INTO `utm` VALUES ('e303af143981475e935f1f93997790d1', 3, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:01:35');
INSERT INTO `utm` VALUES ('e36b28aa4dae49a2898bbcfb0a37252a', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:11');
INSERT INTO `utm` VALUES ('e3dc673696fa46d8b1852a3a9dd138ac', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:22:05');
INSERT INTO `utm` VALUES ('e4091c1a17054a459c9836a96e3d276a', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:58:14');
INSERT INTO `utm` VALUES ('e46cef30347b485e9fdd0656de7858f4', 2, NULL, '/api/user/me', 'sign=b0baca326400c5608889ebb631124646&appId=appidi8thcGWps7Ki5Sh2&t=1576221577346', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:19:38');
INSERT INTO `utm` VALUES ('e4c1f73f0b6f423e9af4d0d1aa6d8015', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:17:25');
INSERT INTO `utm` VALUES ('e574e165ebd64f7b8d9f431818a67e57', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:34');
INSERT INTO `utm` VALUES ('e5811a288d8b4e44a9ba7b318f5f5a41', 1, NULL, '/admin/user/permissions/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:31:35');
INSERT INTO `utm` VALUES ('e59804e663ee4a47a8a7aa62dc0f2e96', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:04:59');
INSERT INTO `utm` VALUES ('e5c29cfe32124e6eaf7e3368295c02c3', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:23:33');
INSERT INTO `utm` VALUES ('e5eb5e102c274dde8de9f622c36394ab', 2, NULL, '/me/getFaceUrl', 'idNo=320829197909280212&realName=%E5%88%98%E6%B4%AA%E4%B9%89&userId=2', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/ver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:56');
INSERT INTO `utm` VALUES ('e619e2bd29744e239da3b3f6e9c7e530', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:36:43');
INSERT INTO `utm` VALUES ('e65b2eacd0ec42eaaa9c1581a43dbd30', 1, NULL, '/admin/user/rolePermissions/2', 'type=action', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:02:06');
INSERT INTO `utm` VALUES ('e67b1c75ed0942d986a303c46334191c', 3, NULL, '/admin/user/detail/finance/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/role/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:47');
INSERT INTO `utm` VALUES ('e6de5e5f1b4248c79f4c8fb10998b399', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/role/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:50');
INSERT INTO `utm` VALUES ('e793aba3c12f4443bf894193d06bc983', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:59:40');
INSERT INTO `utm` VALUES ('e7cdf22deb7943e9b5177be56557d216', 2, NULL, '/api/user/me', 'sign=50edb058405bba1e2b35ccb327495d1f&appId=appidi8thcGWps7Ki5Sh2&t=1576222229225', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/proxy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:30');
INSERT INTO `utm` VALUES ('e7d024ad79fb4914975dd50f0175dbcd', NULL, NULL, '/admin/entre/area_manage/doSave', 'csrf_token=9db667f0a0b846b7bcab59ac35208768', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 19:59:12');
INSERT INTO `utm` VALUES ('e7e2454a304142bca223ad7dba6de19d', 1, NULL, '/admin/user/rolePermissions/2', 'type=action', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:53:54');
INSERT INTO `utm` VALUES ('e8420b30183b4af2b6c3a9c53934148d', 1, NULL, '/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:57:31');
INSERT INTO `utm` VALUES ('e9824bdbe5e64bea931869f29b1d0382', 1, NULL, '/admin/user/rolePermissions/2', 'type=action', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2?type=menu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:55:57');
INSERT INTO `utm` VALUES ('e98f243fb925466aaf6111aab64ba4dd', 2, NULL, '/entre/verCallback', 'orderNo=21576222255790&signature=DAD2B9BE1529FC99999BF765000026E038788527&code=0&newSignature=9F3DC88D9206D800932DA734C65A39BC7F003D98&h5faceId=1876b4342a4922f858b6e5f0f5f396c1&liveRate=100', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:32:01');
INSERT INTO `utm` VALUES ('e9ce85bb3cb24ef4bfc182af80b961ae', 3, NULL, '/admin/doLogout', 'csrf_token=510e261544b9408bbdd12373fc3b3d83', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:27:09');
INSERT INTO `utm` VALUES ('ebbf4eaea8df4923bd6bfd7c57c2bfe4', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/reg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:37:10');
INSERT INTO `utm` VALUES ('ebcb0e5de946419fb1552a66b258a467', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/article', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:46');
INSERT INTO `utm` VALUES ('eccdc6c2ef654fb5ad6c5c4e96db0f98', 3, NULL, '/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:12:57');
INSERT INTO `utm` VALUES ('ed1db352aa924092b2a488ffe82d52a9', 1, NULL, '/admin/user/detail/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:31:45');
INSERT INTO `utm` VALUES ('ed23bfb4a0fe4b139f708a305a00aa5f', 3, NULL, '/admin/doLogout', 'csrf_token=89415946888040dab2acba7a01a01374', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:33');
INSERT INTO `utm` VALUES ('edb8988b069643fbbeb2e83105587ed1', 1, NULL, '/me', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:26:21');
INSERT INTO `utm` VALUES ('ee27b4263d7c442391f6cf8051edd408', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:25:18');
INSERT INTO `utm` VALUES ('ef0a703854304c29a69133071bf3b4f9', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:53:53');
INSERT INTO `utm` VALUES ('ef8d96e459b34b57aa2d83e355cfff1f', 1, NULL, '/admin/setting/connection', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/setting/reg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:45:53');
INSERT INTO `utm` VALUES ('ef9992999e2a4f3abe8f75fa96fddd31', 1, NULL, '/api/user/me', 'sign=6d310916cd61d65cbb8852dc5112208f&appId=appidi8thcGWps7Ki5Sh2&t=1576208073039', NULL, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://localhost:8081/splash', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:34:33');
INSERT INTO `utm` VALUES ('f00f249ecf7b43d2aa71a457f1213901', 3, NULL, '/admin/user/detail/pwd/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/communication/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:29');
INSERT INTO `utm` VALUES ('f14a99699886468fa04c58e257be005c', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:11:48');
INSERT INTO `utm` VALUES ('f183bda462c94353aa3ab096ab02bbb9', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/detail/utm/4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:12:58');
INSERT INTO `utm` VALUES ('f2ce6b2df81f4bc6a27dd82a78b2af71', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/roleEdit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:53:34');
INSERT INTO `utm` VALUES ('f3cac4e6d2484538ab182522e13dfa95', 1, NULL, '/admin/user/rolePermissions/2', 'type=menu', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:54:26');
INSERT INTO `utm` VALUES ('f4cb06b548724e2cac555ac074414e1d', 1, NULL, '/admin/user/sendMsg/sms', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/sendMsg/wechat', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:50');
INSERT INTO `utm` VALUES ('f4f4e52c6a8b4e97b7873abf53cd04cd', 3, NULL, '/admin/user/detail/communication/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/member/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:28');
INSERT INTO `utm` VALUES ('f54c1da4c35347d8b926705ba61074f6', 1, NULL, '/admin/user/roleEdit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:27:44');
INSERT INTO `utm` VALUES ('f693d6d8363149a1be2439706001f420', 4, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:39:04');
INSERT INTO `utm` VALUES ('f706a35bddfd48e8b2b37741e212bff6', 2, NULL, '/api/user/me', 'sign=b9fc2d4b032504ace2bd84ca1af9772b&appId=appidi8thcGWps7Ki5Sh2&t=1576222216495', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1', 'http://192.168.43.248:8081/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:30:17');
INSERT INTO `utm` VALUES ('f7250ec0b2de47fc8a075cabb4458fc7', 2, NULL, '/me/doSmsSend', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 14:42:36');
INSERT INTO `utm` VALUES ('f7a69ce36def4fd380911769c550953d', 4, NULL, '/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:17:58');
INSERT INTO `utm` VALUES ('f825be9618fd4131811413f90aa8a5df', 1, NULL, '/admin/addon/readme', 'id=io.jpress.addon.entre', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:47:02');
INSERT INTO `utm` VALUES ('f84eafe3b85544a8ba8feb188679a8ef', NULL, NULL, '/admin/setting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/addon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:27:19');
INSERT INTO `utm` VALUES ('fa6e5a6a5ebc407aa2cbe197bf6cbadd', 3, NULL, '/admin/user/detail/finance/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:24');
INSERT INTO `utm` VALUES ('fa979cbead5d427d959576c15e254dcb', 2, NULL, '/ver_rst', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:35:43');
INSERT INTO `utm` VALUES ('faafaf60a67947bb967166fe44843f6d', NULL, NULL, '/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:06:34');
INSERT INTO `utm` VALUES ('fb3aeb1c499b46639d47b132b7de742d', 4, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:32:43');
INSERT INTO `utm` VALUES ('fb67abceb1b440ad8709cb43284a0d70', 2, NULL, '/me/checkBeforeVer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.1', 'Mozilla/5.0 (Linux; Android 9; CLT-AL00 Build/HUAWEICLT-AL00; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126 MQQBrowser/6.2 TBS/45016 Mobile Safari/537.36 MMWEBID/2063 MicroMessenger/7.0.9.1560(0x27000935) Process/tools NetType/4G Language/zh_CN ABI/arm64', 'http://192.168.43.248:8081/info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:20:44');
INSERT INTO `utm` VALUES ('fbacfaeffe8f4a23ac94a1c3b8d1469a', NULL, NULL, '/commons/captcha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 20:17:31');
INSERT INTO `utm` VALUES ('fc1d56b6cab644c3a6d99882bdcc624e', 3, NULL, '/admin/user/detail/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/detail/communication/3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:14:23');
INSERT INTO `utm` VALUES ('fc2071ba502442078077171b98a48070', 1, NULL, '/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/login', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 15:59:09');
INSERT INTO `utm` VALUES ('fc902fd828f74d2da9b6b515dedf7006', 1, NULL, '/admin/user/doAddRolePermission', 'roleId=2&permissionId=52&csrf_token=abfcbf8af3e44ab3b4c3c32905701596', NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:04:58');
INSERT INTO `utm` VALUES ('fd02d11e5c5d464bbdc8db01ca27e842', 1, NULL, '/install/step3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/install/step2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 10:20:31');
INSERT INTO `utm` VALUES ('fe0792fab38549908bde17842041671e', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/roleEdit/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:08:40');
INSERT INTO `utm` VALUES ('fead33782cca4d3fadb6022245243883', 3, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/entre/area_manage/customer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:05:37');
INSERT INTO `utm` VALUES ('feb675c89f6b42c08af5fe4a81ee65f3', 3, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:13:14');
INSERT INTO `utm` VALUES ('ff45d80602a44c21afcd8932f5838acb', 1, NULL, '/api/user/me', 'sign=752ce9474299494b6c8921a5ed076b67&appId=appidi8thcGWps7Ki5Sh2&t=1576207603213', NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 11:28:30');
INSERT INTO `utm` VALUES ('ff48fc3e614b47be8400b363d367859c', 1, NULL, '/admin/user/role', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '192.168.43.248', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://192.168.43.248:8080/admin/user/rolePermissions/2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 16:09:08');
INSERT INTO `utm` VALUES ('ff4be8cf35704f54919d3708bd29a64d', 1, NULL, '/admin/entre/area_manage', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'http://localhost:8080/admin/index', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-13 09:59:41');
COMMIT;

-- ----------------------------
-- Table structure for wechat_menu
-- ----------------------------
DROP TABLE IF EXISTS `wechat_menu`;
CREATE TABLE `wechat_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL COMMENT '父级ID',
  `text` varchar(512) DEFAULT NULL COMMENT '文本内容',
  `keyword` varchar(128) DEFAULT NULL COMMENT '关键字',
  `type` varchar(32) DEFAULT '' COMMENT '菜单类型',
  `order_number` int(11) DEFAULT '0' COMMENT '排序字段',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  `modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信公众号菜单表';

-- ----------------------------
-- Table structure for wechat_reply
-- ----------------------------
DROP TABLE IF EXISTS `wechat_reply`;
CREATE TABLE `wechat_reply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(128) DEFAULT NULL COMMENT '关键字',
  `content` text COMMENT '回复内容',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  `modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyword` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户自定义关键字回复表';

SET FOREIGN_KEY_CHECKS = 1;
