/*
创建数据库和表
*/
CREATE DATABASE `cj`;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `acomment`
-- ----------------------------
DROP TABLE IF EXISTS `acomment`;
CREATE TABLE `acomment` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `activityID` int(11) NOT NULL,
  `reviewerID` int(11) NOT NULL,
  `comment_floor` int(11) NOT NULL,
  `comment_time` datetime NOT NULL,
  `comment_content` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `comment_status` tinyint(1) DEFAULT '0',
  `reviewer_nickname` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `reviewer_head_portrait` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`commentID`),
  KEY `index_comment_floor` (`comment_floor`) USING BTREE,
  KEY `index_comment_id` (`activityID`) USING BTREE,
  KEY `index_comment_reviewerID` (`reviewerID`) USING BTREE,
  CONSTRAINT `fk_comment_reviewerID` FOREIGN KEY (`reviewerID`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=702 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `activity`
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `activityID` int(11) NOT NULL AUTO_INCREMENT,
  `activity_type` enum('全部','运动','旅行','学习','艺术','聚餐','聚会','游戏','其他','其它','公益') CHARACTER SET utf8 NOT NULL,
  `activity_content` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `invited_object_sex` enum('男','女') COLLATE utf8mb4_bin DEFAULT NULL,
  `activity_explain` text COLLATE utf8mb4_bin,
  `expected_number` int(11) DEFAULT '0',
  `create_time` datetime NOT NULL,
  `activity_time` datetime NOT NULL,
  `activity_past_time` datetime NOT NULL,
  `activity_longitude` decimal(11,6) NOT NULL,
  `activity_latitude` decimal(11,6) NOT NULL,
  `activity_place` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `activity_picture` text CHARACTER SET utf8,
  `landmark` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `accept_necessary` varchar(255) COLLATE utf8mb4_bin DEFAULT 'true',
  `group_chat_id` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `activity_category` varchar(255) COLLATE utf8mb4_bin DEFAULT 'normal',
  `act_invited_status` enum('not_start','under_way','ended') COLLATE utf8mb4_bin DEFAULT 'under_way',
  `city` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT 'hangzhou',
  `is_hot` enum('yes','no') CHARACTER SET utf8 NOT NULL DEFAULT 'no',
  `activity_views` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`activityID`),
  KEY `index_activity_coordinate` (`activity_longitude`,`activity_latitude`) USING BTREE,
  KEY `index_activity_create_time` (`create_time`) USING BTREE,
  KEY `index_activity_userID` (`userID`) USING BTREE,
  KEY `fk_activity_city` (`city`),
  CONSTRAINT `fk_activity_city` FOREIGN KEY (`city`) REFERENCES `city` (`id`),
  CONSTRAINT `fk_act_user_id` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `activity_expire`
-- ----------------------------
DROP TABLE IF EXISTS `activity_expire`;
CREATE TABLE `activity_expire` (
  `activityID` int(11) NOT NULL,
  `activity_type` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `activity_content` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `invited_object_sex` enum('男','女') COLLATE utf8mb4_bin DEFAULT NULL,
  `activity_explain` text COLLATE utf8mb4_bin,
  `expected_number` int(11) DEFAULT '1',
  `create_time` datetime NOT NULL,
  `activity_time` datetime NOT NULL,
  `activity_past_time` datetime NOT NULL,
  `activity_longitude` decimal(11,8) NOT NULL,
  `activity_latitude` decimal(11,8) NOT NULL,
  `activity_place` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `activity_picture` text CHARACTER SET utf8,
  `landmark` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `accept_necessary` varchar(255) COLLATE utf8mb4_bin DEFAULT 'true',
  `group_chat_id` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `activity_category` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT 'normal',
  `act_invited_status` enum('not_start','under_way','ended') COLLATE utf8mb4_bin NOT NULL DEFAULT 'under_way',
  `city` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT 'hangzhou',
  `is_hot` enum('yes','no') CHARACTER SET utf8 NOT NULL DEFAULT 'no',
  `activity_delete_status` tinyint(4) DEFAULT '0' COMMENT '0：未被解散\n1：被解散的活动',
  `activity_views` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`activityID`),
  KEY `index_activity_coordinate` (`activity_longitude`,`activity_latitude`) USING BTREE,
  KEY `index_activity_create_time` (`create_time`) USING BTREE,
  KEY `index_activity_userID` (`userID`) USING BTREE,
  CONSTRAINT `fk_act_expire_user_id` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `apraise`
-- ----------------------------
DROP TABLE IF EXISTS `apraise`;
CREATE TABLE `apraise` (
  `praise_user_id` int(11) NOT NULL,
  `praise_activity_id` int(11) NOT NULL,
  `praise_time` datetime NOT NULL,
  PRIMARY KEY (`praise_user_id`,`praise_activity_id`),
  KEY `fk_praise_activity_id` (`praise_activity_id`),
  CONSTRAINT `fk_praise_activity_id` FOREIGN KEY (`praise_activity_id`) REFERENCES `activity_expire` (`activityID`) ON DELETE CASCADE,
  CONSTRAINT `fk_praise_user_id` FOREIGN KEY (`praise_user_id`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `areport`
-- ----------------------------
DROP TABLE IF EXISTS `areport`;
CREATE TABLE `areport` (
  `uid` int(11) NOT NULL,
  `to_actid` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `reason` tinyint(2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`,`to_actid`),
  KEY `index_report_activityID` (`to_actid`) USING BTREE,
  KEY `index_report_reporterID` (`uid`) USING BTREE,
  CONSTRAINT `fk_areport_actid` FOREIGN KEY (`to_actid`) REFERENCES `activity_expire` (`activityID`) ON DELETE CASCADE,
  CONSTRAINT `fk_areport_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `attention`
-- ----------------------------
DROP TABLE IF EXISTS `attention`;
CREATE TABLE `attention` (
  `att_from_uid` int(11) NOT NULL,
  `att_to_uid` int(11) NOT NULL,
  `att_time` datetime NOT NULL,
  `att_dynamic_post_id` varchar(255) DEFAULT NULL COMMENT '关注的人新发起的帖子id(最新的在前面)\n[231,546]',
  `att_dynamic_act_id` varchar(255) DEFAULT NULL COMMENT '关注的人新发起的活动id(最新的在前面)\n[231,546]',
  PRIMARY KEY (`att_from_uid`,`att_to_uid`),
  KEY `fk_att_to_uid` (`att_to_uid`),
  KEY `index_att_user_id` (`att_from_uid`) USING BTREE,
  CONSTRAINT `fk_att_from_uid` FOREIGN KEY (`att_from_uid`) REFERENCES `user` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `fk_att_to_uid` FOREIGN KEY (`att_to_uid`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `city`
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `id` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `level` enum('province','city','district') NOT NULL,
  `parent` varchar(100) DEFAULT NULL COMMENT '为省级的时该字段为null',
  `is_hot` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_city_id` (`id`) USING BTREE,
  KEY `fk_city_parent` (`parent`),
  CONSTRAINT `fk_city_parent` FOREIGN KEY (`parent`) REFERENCES `city` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `config`
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `city` varchar(255) NOT NULL,
  `business_pictures` text,
  `business_title` varchar(255) DEFAULT NULL,
  `business_link` text,
  `business_target` text,
  `stick_activity` varchar(255) DEFAULT NULL,
  `no_thirdpart_version` varchar(32) DEFAULT NULL,
  `white_list` text,
  PRIMARY KEY (`city`),
  CONSTRAINT `fk_config_city` FOREIGN KEY (`city`) REFERENCES `city` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `credit_records`
-- ----------------------------
DROP TABLE IF EXISTS `credit_records`;
CREATE TABLE `credit_records` (
  `credits_id` int(11) NOT NULL AUTO_INCREMENT,
  `credits_event` varchar(255) NOT NULL,
  `credits_time` datetime NOT NULL,
  `credits_change` int(11) NOT NULL,
  `credits_total_now` int(11) NOT NULL COMMENT '包括本次积分变化',
  `credits_user_id` int(11) NOT NULL,
  PRIMARY KEY (`credits_id`),
  KEY `index_credits_user_id` (`credits_user_id`) USING BTREE,
  CONSTRAINT `fk_credits_user_id` FOREIGN KEY (`credits_user_id`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3841 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `feedback`
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `feedback_info` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `feedback_mailbox` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `feedback_time` datetime DEFAULT NULL,
  `feedback_imgs` text COLLATE utf8mb4_bin,
  `feedback_phone` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否处理的状态',
  PRIMARY KEY (`feedback_id`),
  KEY `fk_feedback_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_feedback_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `interest`
-- ----------------------------
DROP TABLE IF EXISTS `interest`;
CREATE TABLE `interest` (
  `i_user_id` int(11) NOT NULL,
  `i_act_id` int(11) NOT NULL,
  `i_has_joined` enum('yes','no') NOT NULL DEFAULT 'no',
  `i_time` datetime NOT NULL,
  PRIMARY KEY (`i_user_id`,`i_act_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `chattingID` int(11) NOT NULL AUTO_INCREMENT,
  `senderID` int(11) NOT NULL,
  `receiverID` int(11) NOT NULL,
  `chatting_send_time` datetime NOT NULL,
  `chatting_status` tinyint(1) DEFAULT '0',
  `chatting_content` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `chatting_contentType` tinyint(1) DEFAULT '0' COMMENT '默认0 为文本',
  PRIMARY KEY (`chattingID`),
  KEY `index_chat_receiverID` (`receiverID`) USING BTREE,
  KEY `index_chat_time` (`chatting_send_time`) USING BTREE,
  KEY `index_chat_user` (`senderID`,`receiverID`) USING BTREE,
  CONSTRAINT `fk_chat_receiverID` FOREIGN KEY (`receiverID`) REFERENCES `user` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `fk_chat_senderID` FOREIGN KEY (`senderID`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `push_setting`
-- ----------------------------
DROP TABLE IF EXISTS `push_setting`;
CREATE TABLE `push_setting` (
  `uid` int(11) NOT NULL COMMENT '用户id',
  `subs_sex` varchar(255) DEFAULT NULL COMMENT '订阅性别',
  `subs_distance` decimal(10,4) DEFAULT NULL COMMENT '订阅距离',
  `subs_act_type` varchar(256) DEFAULT NULL COMMENT '订阅活动类型',
  `subs_push_frequency` decimal(8,4) NOT NULL DEFAULT '48.0000' COMMENT '订阅推送频率：多少小时推送一次',
  `subs_last_push_time` datetime NOT NULL DEFAULT '2014-01-01 00:00:00' COMMENT '最后推送时间',
  `switch_subs_activity` enum('on','off') NOT NULL DEFAULT 'on' COMMENT '活动订阅开关',
  `switch_during_sound_off` enum('on','off') NOT NULL DEFAULT 'on' COMMENT '静音时段开关',
  `switch_new_act_of_atten_user` enum('on','off') NOT NULL DEFAULT 'on' COMMENT '用户关注的人创建新活动开关',
  `switch_act_interested` enum('on','off') NOT NULL DEFAULT 'on' COMMENT '活动被感兴趣开关',
  `switch_act_posted` enum('on','off') NOT NULL DEFAULT 'on' COMMENT '活动被晒图开关',
  `switch_new_comment` enum('on','off') NOT NULL DEFAULT 'on' COMMENT '活动/晒图新评论开关',
  `switch_new_comment_reply` enum('on','off') NOT NULL DEFAULT 'on' COMMENT '新评论回复开关',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `index_push_setting_userID` (`uid`) USING BTREE,
  CONSTRAINT `fk_push_setting_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `ublack`
-- ----------------------------
DROP TABLE IF EXISTS `ublack`;
CREATE TABLE `ublack` (
  `uid` int(11) NOT NULL,
  `to_uid` int(11) NOT NULL,
  `black_time` datetime NOT NULL,
  PRIMARY KEY (`uid`,`to_uid`),
  UNIQUE KEY `index_blacklist_id` (`uid`,`to_uid`) USING BTREE,
  KEY `index_blacklist_pulled_black_userID` (`to_uid`) USING BTREE,
  CONSTRAINT `fk_blacklist_pulled_black_userID` FOREIGN KEY (`to_uid`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_blacklist_userID` FOREIGN KEY (`uid`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `ureport`
-- ----------------------------
DROP TABLE IF EXISTS `ureport`;
CREATE TABLE `ureport` (
  `uid` int(11) NOT NULL,
  `to_uid` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `reason` tinyint(4) NOT NULL COMMENT '1:垃圾广告\n2:色情相关\n3:欺诈骗钱\n4:骚扰信息',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`,`to_uid`),
  CONSTRAINT `fk_ureport_to_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `fk_ureport_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `qq_number` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `wechat_number` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `weibo_number` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `user_register_time` datetime NOT NULL,
  `birthday` date DEFAULT NULL,
  `sex` enum('男','女') COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `nickname` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `voice` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `photo` mediumtext COLLATE utf8mb4_bin,
  `hometown` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '家乡',
  `school` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '学校',
  `company` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '公司',
  `profession` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '职业',
  `trade` tinyint(2) NOT NULL DEFAULT '0' COMMENT '行业\n0：无\n1：计算机/互联网/通信/电子\n2：会计/金融/银行/保险\n3：商业/服务业/个体经营\n4：贸易/消费/运营\n5：生产/工艺/制造\n6：医疗/护理/制药\n7：文化/广告/媒体\n8：娱乐/艺术/表演\n9：公务员/事业单位\n10：房地产/建筑\n11：律师/法务\n12：教育/培训\n13：学生\n14：其他',
  `location` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `head_portrait` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `user_credits` int(11) NOT NULL DEFAULT '0',
  `activity_types` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '偏爱的活动类型',
  `hobbies_book` text CHARACTER SET utf8,
  `hobbies_music` text CHARACTER SET utf8,
  `hobbies_movie` text CHARACTER SET utf8,
  `interest_hobbies` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `usually_appear_area` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `personal_sign` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `history_act_visible` enum('visible','invisible') CHARACTER SET utf8 NOT NULL DEFAULT 'visible',
  `user_missed_num` int(11) NOT NULL DEFAULT '0',
  `user_status` enum('online','offline') CHARACTER SET utf8 NOT NULL DEFAULT 'online',
  `user_state` tinyint(1) NOT NULL DEFAULT '0',
  `current_version` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `longitude` double(8,4) DEFAULT NULL,
  `latitude` double(8,4) DEFAULT NULL,
  `login_token` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `device_type` smallint(2) DEFAULT NULL,
  `push_device_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8 DEFAULT 'hangzhou',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `index_user_userID` (`userID`) USING BTREE,
  UNIQUE KEY `index_user_phone_number` (`phone_number`) USING BTREE,
  UNIQUE KEY `index_user_qq_number` (`qq_number`) USING BTREE,
  UNIQUE KEY `index_user_weibo_number` (`weibo_number`) USING BTREE,
  UNIQUE KEY `index_user_wechat_number` (`wechat_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

-- ----------------------------
--  Table structure for `version`
-- ----------------------------
DROP TABLE IF EXISTS `version`;
CREATE TABLE `version` (
  `id` int(11) NOT NULL,
  `ios_current_version` varchar(255) NOT NULL,
  `android_current_version` varchar(255) NOT NULL,
  `ios_download_url` varchar(255) NOT NULL,
  `android_download_url` varchar(255) NOT NULL,
  `ios_version_explain` varchar(255) NOT NULL,
  `android_version_explain` varchar(255) NOT NULL,
  `ios_min_available_version` varchar(255) NOT NULL,
  `android_min_available_version` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  View definition for `view_activity`
-- ----------------------------
DROP VIEW IF EXISTS `view_activity`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_activity` AS select `activity`.`activityID` AS `activityID`,`activity`.`activity_type` AS `activity_type`,`activity`.`activity_content` AS `activity_content`,`activity`.`invited_object_sex` AS `invited_object_sex`,`activity`.`activity_explain` AS `activity_explain`,`activity`.`expected_number` AS `expected_number`,`activity`.`activity_time` AS `activity_time`,`activity`.`activity_longitude` AS `activity_longitude`,`activity`.`activity_latitude` AS `activity_latitude`,`activity`.`activity_place` AS `activity_place`,`activity`.`activity_past_time` AS `activity_past_time`,`activity`.`activity_picture` AS `activity_picture`,`activity`.`landmark` AS `landmark`,`activity`.`accept_necessary` AS `accept_necessary`,`activity`.`group_chat_id` AS `group_chat_id`,`activity`.`activity_category` AS `activity_category`,`activity`.`create_time` AS `create_time`,`activity`.`city` AS `city`,`activity`.`act_invited_status` AS `act_invited_status`,`activity`.`is_hot` AS `is_hot`,`activity`.`activity_views` AS `activity_views`,(select count(`interest`.`i_user_id`) from `interest` where (`interest`.`i_act_id` = `activity`.`activityID`)) AS `interested_number`,(select count(`acomment`.`activityID`) from `acomment` where (`acomment`.`activityID` = `activity`.`activityID`)) AS `comment_number`,(select count(`areport`.`to_actid`) from `areport` where (`areport`.`to_actid` = `activity`.`activityID`)) AS `report_number`,(select count(`apraise`.`praise_activity_id`) from `apraise` where (`apraise`.`praise_activity_id` = `activity`.`activityID`)) AS `activity_praise_number`,`activity`.`userID` AS `userID`,(select `user`.`nickname` from `user` where (`user`.`userID` = `activity`.`userID`)) AS `nickname`,(select `user`.`sex` from `user` where (`user`.`userID` = `activity`.`userID`)) AS `sex`,(select `user`.`head_portrait` from `user` where (`user`.`userID` = `activity`.`userID`)) AS `head_portrait`,(select `user`.`user_credits` from `user` where (`user`.`userID` = `activity`.`userID`)) AS `user_credits`,(select `user`.`birthday` from `user` where (`user`.`userID` = `activity`.`userID`)) AS `birthday` from `activity`;

-- ----------------------------
--  View definition for `view_activity_expire`
-- ----------------------------
DROP VIEW IF EXISTS `view_activity_expire`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_activity_expire` AS select `activity_expire`.`activityID` AS `activityID`,`activity_expire`.`activity_type` AS `activity_type`,`activity_expire`.`activity_content` AS `activity_content`,`activity_expire`.`invited_object_sex` AS `invited_object_sex`,`activity_expire`.`activity_explain` AS `activity_explain`,`activity_expire`.`expected_number` AS `expected_number`,`activity_expire`.`activity_time` AS `activity_time`,`activity_expire`.`activity_longitude` AS `activity_longitude`,`activity_expire`.`activity_latitude` AS `activity_latitude`,`activity_expire`.`activity_place` AS `activity_place`,`activity_expire`.`activity_past_time` AS `activity_past_time`,`activity_expire`.`activity_picture` AS `activity_picture`,`activity_expire`.`landmark` AS `landmark`,`activity_expire`.`accept_necessary` AS `accept_necessary`,`activity_expire`.`group_chat_id` AS `group_chat_id`,`activity_expire`.`activity_category` AS `activity_category`,`activity_expire`.`create_time` AS `create_time`,`activity_expire`.`city` AS `city`,`activity_expire`.`is_hot` AS `is_hot`,`activity_expire`.`act_invited_status` AS `act_invited_status`,`activity_expire`.`activity_delete_status` AS `activity_delete_status`,`activity_expire`.`activity_views` AS `activity_views`,(select count(`interest`.`i_user_id`) from `interest` where (`interest`.`i_act_id` = `activity_expire`.`activityID`)) AS `interested_number`,(select count(`acomment`.`activityID`) from `acomment` where ((`acomment`.`activityID` = `activity_expire`.`activityID`) and (`acomment`.`comment_status` = 0))) AS `comment_number`,(select count(`areport`.`to_actid`) from `areport` where (`areport`.`to_actid` = `activity_expire`.`activityID`)) AS `report_number`,(select count(`apraise`.`praise_activity_id`) from `apraise` where (`apraise`.`praise_activity_id` = `activity_expire`.`activityID`)) AS `activity_praise_number`,`activity_expire`.`userID` AS `userID`,(select `user`.`nickname` from `user` where (`user`.`userID` = `activity_expire`.`userID`)) AS `nickname`,(select `user`.`sex` from `user` where (`user`.`userID` = `activity_expire`.`userID`)) AS `sex`,(select `user`.`head_portrait` from `user` where (`user`.`userID` = `activity_expire`.`userID`)) AS `head_portrait`,(select `user`.`user_credits` from `user` where (`user`.`userID` = `activity_expire`.`userID`)) AS `user_credits`,(select `user`.`birthday` from `user` where (`user`.`userID` = `activity_expire`.`userID`)) AS `birthday` from `activity_expire`;

-- ----------------------------
--  View definition for `view_user`
-- ----------------------------
DROP VIEW IF EXISTS `view_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_user` AS select `user`.`userID` AS `userID`,`user`.`phone_number` AS `phone_number`,`user`.`qq_number` AS `qq_number`,`user`.`wechat_number` AS `wechat_number`,`user`.`weibo_number` AS `weibo_number`,`user`.`user_register_time` AS `user_register_time`,`user`.`birthday` AS `birthday`,`user`.`sex` AS `sex`,`user`.`password` AS `password`,`user`.`nickname` AS `nickname`,`user`.`job` AS `job`,`user`.`voice` AS `voice`,`user`.`photo` AS `photo`,`user`.`company` AS `company`,`user`.`hometown` AS `hometown`,`user`.`school` AS `school`,`user`.`profession` AS `profession`,`user`.`trade` AS `trade`,`user`.`activity_types` AS `activity_types`,`user`.`location` AS `location`,`user`.`head_portrait` AS `head_portrait`,`user`.`user_credits` AS `user_credits`,`user`.`interest_hobbies` AS `interest_hobbies`,`user`.`hobbies_book` AS `hobbies_book`,`user`.`hobbies_music` AS `hobbies_music`,`user`.`hobbies_movie` AS `hobbies_movie`,`user`.`usually_appear_area` AS `usually_appear_area`,`user`.`personal_sign` AS `personal_sign`,`user`.`history_act_visible` AS `history_act_visible`,`user`.`user_missed_num` AS `user_missed_num`,`user`.`user_status` AS `user_status`,`user`.`user_state` AS `user_state`,`user`.`current_version` AS `current_version`,`user`.`longitude` AS `longitude`,`user`.`latitude` AS `latitude`,`user`.`login_token` AS `login_token`,`user`.`device_type` AS `device_type`,(select count(`interest`.`i_user_id`) from `interest` where ((`interest`.`i_user_id` = `user`.`userID`) and (`interest`.`i_has_joined` = 'yes'))) AS `n_participant_act`,(select count(`activity_expire`.`userID`) from `activity_expire` where ((`activity_expire`.`userID` = `user`.`userID`) and (`activity_expire`.`activity_delete_status` = 0))) AS `n_publish_act`,0 AS `n_reported` from `user`;

-- ----------------------------
--  Event definition for `expire_activity_delete`
-- ----------------------------
DROP EVENT IF EXISTS `expire_activity_delete`;
CREATE DEFINER=`root`@`localhost` EVENT `expire_activity_delete` ON SCHEDULE EVERY 1 HOUR STARTS '2014-09-05 00:00:00' ON COMPLETION PRESERVE ENABLE DO begin
	DELETE FROM `activity` WHERE  activity_past_time < SYSDATE();
end;
