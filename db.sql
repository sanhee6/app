/*
SQLyog Ultimate v11.3 (64 bit)
MySQL - 5.7.32-log : Database - springboot0b6e5
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`springboot0b6e5` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `springboot0b6e5`;

/*Table structure for table `banjifenlei` */

DROP TABLE IF EXISTS `banjifenlei`;

CREATE TABLE `banjifenlei` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `leixing` varchar(200) DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COMMENT='班级分类';

/*Data for the table `banjifenlei` */

insert  into `banjifenlei`(`id`,`addtime`,`leixing`) values (121,'2021-05-25 13:37:13','类型1');
insert  into `banjifenlei`(`id`,`addtime`,`leixing`) values (122,'2021-05-25 13:37:13','类型2');
insert  into `banjifenlei`(`id`,`addtime`,`leixing`) values (123,'2021-05-25 13:37:13','类型3');
insert  into `banjifenlei`(`id`,`addtime`,`leixing`) values (124,'2021-05-25 13:37:13','类型4');
insert  into `banjifenlei`(`id`,`addtime`,`leixing`) values (125,'2021-05-25 13:37:13','类型5');
insert  into `banjifenlei`(`id`,`addtime`,`leixing`) values (126,'2021-05-25 13:37:13','类型6');

/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='配置文件';

/*Data for the table `config` */

insert  into `config`(`id`,`name`,`value`) values (1,'picture1','http://localhost:8080/springboot0b6e5/upload/picture1.jpg');
insert  into `config`(`id`,`name`,`value`) values (2,'picture2','http://localhost:8080/springboot0b6e5/upload/picture2.jpg');
insert  into `config`(`id`,`name`,`value`) values (3,'picture3','http://localhost:8080/springboot0b6e5/upload/picture3.jpg');

/*Table structure for table `discusszaixiankecheng` */

DROP TABLE IF EXISTS `discusszaixiankecheng`;

CREATE TABLE `discusszaixiankecheng` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint(20) NOT NULL COMMENT '关联表id',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `nickname` varchar(200) DEFAULT NULL COMMENT '用户名',
  `content` longtext NOT NULL COMMENT '评论内容',
  `reply` longtext COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8 COMMENT='在线课程评论表';

/*Data for the table `discusszaixiankecheng` */

insert  into `discusszaixiankecheng`(`id`,`addtime`,`refid`,`userid`,`nickname`,`content`,`reply`) values (171,'2021-05-25 13:37:13',1,1,'用户名1','评论内容1','回复内容1');
insert  into `discusszaixiankecheng`(`id`,`addtime`,`refid`,`userid`,`nickname`,`content`,`reply`) values (172,'2021-05-25 13:37:13',2,2,'用户名2','评论内容2','回复内容2');
insert  into `discusszaixiankecheng`(`id`,`addtime`,`refid`,`userid`,`nickname`,`content`,`reply`) values (173,'2021-05-25 13:37:13',3,3,'用户名3','评论内容3','回复内容3');
insert  into `discusszaixiankecheng`(`id`,`addtime`,`refid`,`userid`,`nickname`,`content`,`reply`) values (174,'2021-05-25 13:37:13',4,4,'用户名4','评论内容4','回复内容4');
insert  into `discusszaixiankecheng`(`id`,`addtime`,`refid`,`userid`,`nickname`,`content`,`reply`) values (175,'2021-05-25 13:37:13',5,5,'用户名5','评论内容5','回复内容5');
insert  into `discusszaixiankecheng`(`id`,`addtime`,`refid`,`userid`,`nickname`,`content`,`reply`) values (176,'2021-05-25 13:37:13',6,6,'用户名6','评论内容6','回复内容6');

/*Table structure for table `forum` */

DROP TABLE IF EXISTS `forum`;

CREATE TABLE `forum` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) DEFAULT NULL COMMENT '帖子标题',
  `content` longtext NOT NULL COMMENT '帖子内容',
  `parentid` bigint(20) DEFAULT NULL COMMENT '父节点id',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(200) DEFAULT NULL COMMENT '用户名',
  `isdone` varchar(200) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8 COMMENT='在线交流';

/*Data for the table `forum` */

insert  into `forum`(`id`,`addtime`,`title`,`content`,`parentid`,`userid`,`username`,`isdone`) values (141,'2021-05-25 13:37:13','帖子标题1','帖子内容1',1,1,'用户名1','开放');
insert  into `forum`(`id`,`addtime`,`title`,`content`,`parentid`,`userid`,`username`,`isdone`) values (142,'2021-05-25 13:37:13','帖子标题2','帖子内容2',2,2,'用户名2','开放');
insert  into `forum`(`id`,`addtime`,`title`,`content`,`parentid`,`userid`,`username`,`isdone`) values (143,'2021-05-25 13:37:13','帖子标题3','帖子内容3',3,3,'用户名3','开放');
insert  into `forum`(`id`,`addtime`,`title`,`content`,`parentid`,`userid`,`username`,`isdone`) values (144,'2021-05-25 13:37:13','帖子标题4','帖子内容4',4,4,'用户名4','开放');
insert  into `forum`(`id`,`addtime`,`title`,`content`,`parentid`,`userid`,`username`,`isdone`) values (145,'2021-05-25 13:37:13','帖子标题5','帖子内容5',5,5,'用户名5','开放');
insert  into `forum`(`id`,`addtime`,`title`,`content`,`parentid`,`userid`,`username`,`isdone`) values (146,'2021-05-25 13:37:13','帖子标题6','帖子内容6',6,6,'用户名6','开放');

/*Table structure for table `jiaoshiyonghu` */

DROP TABLE IF EXISTS `jiaoshiyonghu`;

CREATE TABLE `jiaoshiyonghu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `jiaoshigonghao` varchar(200) NOT NULL COMMENT '教师工号',
  `mima` varchar(200) NOT NULL COMMENT '密码',
  `jiaoshixingming` varchar(200) NOT NULL COMMENT '教师姓名',
  `xingbie` varchar(200) DEFAULT NULL COMMENT '性别',
  `suojiaobanji` varchar(200) DEFAULT NULL COMMENT '所教班级',
  `suojiaokemu` varchar(200) DEFAULT NULL COMMENT '所教科目',
  `lianxidianhua` varchar(200) DEFAULT NULL COMMENT '联系电话',
  `shenfenzheng` varchar(200) DEFAULT NULL COMMENT '身份证',
  PRIMARY KEY (`id`),
  UNIQUE KEY `jiaoshigonghao` (`jiaoshigonghao`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='教师用户';

/*Data for the table `jiaoshiyonghu` */

insert  into `jiaoshiyonghu`(`id`,`addtime`,`jiaoshigonghao`,`mima`,`jiaoshixingming`,`xingbie`,`suojiaobanji`,`suojiaokemu`,`lianxidianhua`,`shenfenzheng`) values (21,'2021-05-25 13:37:13','教师用户1','123456','教师姓名1','男','所教班级1','所教科目1','13823888881','440300199101010001');
insert  into `jiaoshiyonghu`(`id`,`addtime`,`jiaoshigonghao`,`mima`,`jiaoshixingming`,`xingbie`,`suojiaobanji`,`suojiaokemu`,`lianxidianhua`,`shenfenzheng`) values (22,'2021-05-25 13:37:13','教师用户2','123456','教师姓名2','男','所教班级2','所教科目2','13823888882','440300199202020002');
insert  into `jiaoshiyonghu`(`id`,`addtime`,`jiaoshigonghao`,`mima`,`jiaoshixingming`,`xingbie`,`suojiaobanji`,`suojiaokemu`,`lianxidianhua`,`shenfenzheng`) values (23,'2021-05-25 13:37:13','教师用户3','123456','教师姓名3','男','所教班级3','所教科目3','13823888883','440300199303030003');
insert  into `jiaoshiyonghu`(`id`,`addtime`,`jiaoshigonghao`,`mima`,`jiaoshixingming`,`xingbie`,`suojiaobanji`,`suojiaokemu`,`lianxidianhua`,`shenfenzheng`) values (24,'2021-05-25 13:37:13','教师用户4','123456','教师姓名4','男','所教班级4','所教科目4','13823888884','440300199404040004');
insert  into `jiaoshiyonghu`(`id`,`addtime`,`jiaoshigonghao`,`mima`,`jiaoshixingming`,`xingbie`,`suojiaobanji`,`suojiaokemu`,`lianxidianhua`,`shenfenzheng`) values (25,'2021-05-25 13:37:13','教师用户5','123456','教师姓名5','男','所教班级5','所教科目5','13823888885','440300199505050005');
insert  into `jiaoshiyonghu`(`id`,`addtime`,`jiaoshigonghao`,`mima`,`jiaoshixingming`,`xingbie`,`suojiaobanji`,`suojiaokemu`,`lianxidianhua`,`shenfenzheng`) values (26,'2021-05-25 13:37:13','教师用户6','123456','教师姓名6','男','所教班级6','所教科目6','13823888886','440300199606060006');

/*Table structure for table `jiaoxuejihua` */

DROP TABLE IF EXISTS `jiaoxuejihua`;

CREATE TABLE `jiaoxuejihua` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengmingcheng` varchar(200) DEFAULT NULL COMMENT '课程名称',
  `kemuleixing` varchar(200) DEFAULT NULL COMMENT '科目类型',
  `jiaoxueneirong` longtext COMMENT '教学内容',
  `jiaoxuemubiao` longtext COMMENT '教学目标',
  `jiaoxuezhongdian` longtext COMMENT '教学重点',
  `kechenganpai` longtext COMMENT '课程安排',
  `jiaoshigonghao` varchar(200) DEFAULT NULL COMMENT '教师工号',
  `jiaoshixingming` varchar(200) DEFAULT NULL COMMENT '教师姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='教学计划';

/*Data for the table `jiaoxuejihua` */

insert  into `jiaoxuejihua`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`jiaoxueneirong`,`jiaoxuemubiao`,`jiaoxuezhongdian`,`kechenganpai`,`jiaoshigonghao`,`jiaoshixingming`) values (71,'2021-05-25 13:37:13','课程名称1','科目类型1','教学内容1','教学目标1','教学重点1','课程安排1','教师工号1','教师姓名1');
insert  into `jiaoxuejihua`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`jiaoxueneirong`,`jiaoxuemubiao`,`jiaoxuezhongdian`,`kechenganpai`,`jiaoshigonghao`,`jiaoshixingming`) values (72,'2021-05-25 13:37:13','课程名称2','科目类型2','教学内容2','教学目标2','教学重点2','课程安排2','教师工号2','教师姓名2');
insert  into `jiaoxuejihua`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`jiaoxueneirong`,`jiaoxuemubiao`,`jiaoxuezhongdian`,`kechenganpai`,`jiaoshigonghao`,`jiaoshixingming`) values (73,'2021-05-25 13:37:13','课程名称3','科目类型3','教学内容3','教学目标3','教学重点3','课程安排3','教师工号3','教师姓名3');
insert  into `jiaoxuejihua`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`jiaoxueneirong`,`jiaoxuemubiao`,`jiaoxuezhongdian`,`kechenganpai`,`jiaoshigonghao`,`jiaoshixingming`) values (74,'2021-05-25 13:37:13','课程名称4','科目类型4','教学内容4','教学目标4','教学重点4','课程安排4','教师工号4','教师姓名4');
insert  into `jiaoxuejihua`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`jiaoxueneirong`,`jiaoxuemubiao`,`jiaoxuezhongdian`,`kechenganpai`,`jiaoshigonghao`,`jiaoshixingming`) values (75,'2021-05-25 13:37:13','课程名称5','科目类型5','教学内容5','教学目标5','教学重点5','课程安排5','教师工号5','教师姓名5');
insert  into `jiaoxuejihua`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`jiaoxueneirong`,`jiaoxuemubiao`,`jiaoxuezhongdian`,`kechenganpai`,`jiaoshigonghao`,`jiaoshixingming`) values (76,'2021-05-25 13:37:13','课程名称6','科目类型6','教学内容6','教学目标6','教学重点6','课程安排6','教师工号6','教师姓名6');

/*Table structure for table `kaoshidagang` */

DROP TABLE IF EXISTS `kaoshidagang`;

CREATE TABLE `kaoshidagang` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengmingcheng` varchar(200) DEFAULT NULL COMMENT '课程名称',
  `kemuleixing` varchar(200) DEFAULT NULL COMMENT '科目类型',
  `kaodianneirong` longtext COMMENT '考点内容',
  `zhuyishixiang` longtext COMMENT '注意事项',
  `kaodianfenxi` longtext COMMENT '考点分析',
  `kechengtupian` varchar(200) DEFAULT NULL COMMENT '课程图片',
  `jiaoshigonghao` varchar(200) DEFAULT NULL COMMENT '教师工号',
  `jiaoshixingming` varchar(200) DEFAULT NULL COMMENT '教师姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8 COMMENT='考试大纲';

/*Data for the table `kaoshidagang` */

insert  into `kaoshidagang`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kaodianneirong`,`zhuyishixiang`,`kaodianfenxi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (81,'2021-05-25 13:37:13','课程名称1','科目类型1','考点内容1','注意事项1','考点分析1','http://localhost:8080/springboot0b6e5/upload/kaoshidagang_kechengtupian1.jpg','教师工号1','教师姓名1');
insert  into `kaoshidagang`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kaodianneirong`,`zhuyishixiang`,`kaodianfenxi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (82,'2021-05-25 13:37:13','课程名称2','科目类型2','考点内容2','注意事项2','考点分析2','http://localhost:8080/springboot0b6e5/upload/kaoshidagang_kechengtupian2.jpg','教师工号2','教师姓名2');
insert  into `kaoshidagang`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kaodianneirong`,`zhuyishixiang`,`kaodianfenxi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (83,'2021-05-25 13:37:13','课程名称3','科目类型3','考点内容3','注意事项3','考点分析3','http://localhost:8080/springboot0b6e5/upload/kaoshidagang_kechengtupian3.jpg','教师工号3','教师姓名3');
insert  into `kaoshidagang`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kaodianneirong`,`zhuyishixiang`,`kaodianfenxi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (84,'2021-05-25 13:37:13','课程名称4','科目类型4','考点内容4','注意事项4','考点分析4','http://localhost:8080/springboot0b6e5/upload/kaoshidagang_kechengtupian4.jpg','教师工号4','教师姓名4');
insert  into `kaoshidagang`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kaodianneirong`,`zhuyishixiang`,`kaodianfenxi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (85,'2021-05-25 13:37:13','课程名称5','科目类型5','考点内容5','注意事项5','考点分析5','http://localhost:8080/springboot0b6e5/upload/kaoshidagang_kechengtupian5.jpg','教师工号5','教师姓名5');
insert  into `kaoshidagang`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kaodianneirong`,`zhuyishixiang`,`kaodianfenxi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (86,'2021-05-25 13:37:13','课程名称6','科目类型6','考点内容6','注意事项6','考点分析6','http://localhost:8080/springboot0b6e5/upload/kaoshidagang_kechengtupian6.jpg','教师工号6','教师姓名6');

/*Table structure for table `kejianxinxi` */

DROP TABLE IF EXISTS `kejianxinxi`;

CREATE TABLE `kejianxinxi` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengmingcheng` varchar(200) DEFAULT NULL COMMENT '课程名称',
  `kemuleixing` varchar(200) DEFAULT NULL COMMENT '科目类型',
  `kejianmingcheng` varchar(200) DEFAULT NULL COMMENT '课件名称',
  `kejianneirong` longtext COMMENT '课件内容',
  `kejianwenjian` varchar(200) DEFAULT NULL COMMENT '课件文件',
  `shangchuanriqi` date DEFAULT NULL COMMENT '上传日期',
  `kechengtupian` varchar(200) DEFAULT NULL COMMENT '课程图片',
  `jiaoshigonghao` varchar(200) DEFAULT NULL COMMENT '教师工号',
  `jiaoshixingming` varchar(200) DEFAULT NULL COMMENT '教师姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='课件信息';

/*Data for the table `kejianxinxi` */

insert  into `kejianxinxi`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kejianmingcheng`,`kejianneirong`,`kejianwenjian`,`shangchuanriqi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (51,'2021-05-25 13:37:13','课程名称1','科目类型1','课件名称1','课件内容1','','2021-05-25','http://localhost:8080/springboot0b6e5/upload/kejianxinxi_kechengtupian1.jpg','教师工号1','教师姓名1');
insert  into `kejianxinxi`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kejianmingcheng`,`kejianneirong`,`kejianwenjian`,`shangchuanriqi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (52,'2021-05-25 13:37:13','课程名称2','科目类型2','课件名称2','课件内容2','','2021-05-25','http://localhost:8080/springboot0b6e5/upload/kejianxinxi_kechengtupian2.jpg','教师工号2','教师姓名2');
insert  into `kejianxinxi`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kejianmingcheng`,`kejianneirong`,`kejianwenjian`,`shangchuanriqi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (53,'2021-05-25 13:37:13','课程名称3','科目类型3','课件名称3','课件内容3','','2021-05-25','http://localhost:8080/springboot0b6e5/upload/kejianxinxi_kechengtupian3.jpg','教师工号3','教师姓名3');
insert  into `kejianxinxi`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kejianmingcheng`,`kejianneirong`,`kejianwenjian`,`shangchuanriqi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (54,'2021-05-25 13:37:13','课程名称4','科目类型4','课件名称4','课件内容4','','2021-05-25','http://localhost:8080/springboot0b6e5/upload/kejianxinxi_kechengtupian4.jpg','教师工号4','教师姓名4');
insert  into `kejianxinxi`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kejianmingcheng`,`kejianneirong`,`kejianwenjian`,`shangchuanriqi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (55,'2021-05-25 13:37:13','课程名称5','科目类型5','课件名称5','课件内容5','','2021-05-25','http://localhost:8080/springboot0b6e5/upload/kejianxinxi_kechengtupian5.jpg','教师工号5','教师姓名5');
insert  into `kejianxinxi`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kejianmingcheng`,`kejianneirong`,`kejianwenjian`,`shangchuanriqi`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`) values (56,'2021-05-25 13:37:13','课程名称6','科目类型6','课件名称6','课件内容6','','2021-05-25','http://localhost:8080/springboot0b6e5/upload/kejianxinxi_kechengtupian6.jpg','教师工号6','教师姓名6');

/*Table structure for table `kemuleixing` */

DROP TABLE IF EXISTS `kemuleixing`;

CREATE TABLE `kemuleixing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `leixing` varchar(200) DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COMMENT='科目类型';

/*Data for the table `kemuleixing` */

insert  into `kemuleixing`(`id`,`addtime`,`leixing`) values (111,'2021-05-25 13:37:13','类型1');
insert  into `kemuleixing`(`id`,`addtime`,`leixing`) values (112,'2021-05-25 13:37:13','类型2');
insert  into `kemuleixing`(`id`,`addtime`,`leixing`) values (113,'2021-05-25 13:37:13','类型3');
insert  into `kemuleixing`(`id`,`addtime`,`leixing`) values (114,'2021-05-25 13:37:13','类型4');
insert  into `kemuleixing`(`id`,`addtime`,`leixing`) values (115,'2021-05-25 13:37:13','类型5');
insert  into `kemuleixing`(`id`,`addtime`,`leixing`) values (116,'2021-05-25 13:37:13','类型6');

/*Table structure for table `news` */

DROP TABLE IF EXISTS `news`;

CREATE TABLE `news` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `introduction` longtext COMMENT '简介',
  `picture` varchar(200) NOT NULL COMMENT '图片',
  `content` longtext NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8 COMMENT='校园资讯';

/*Data for the table `news` */

insert  into `news`(`id`,`addtime`,`title`,`introduction`,`picture`,`content`) values (161,'2021-05-25 13:37:13','标题1','简介1','http://localhost:8080/springboot0b6e5/upload/news_picture1.jpg','内容1');
insert  into `news`(`id`,`addtime`,`title`,`introduction`,`picture`,`content`) values (162,'2021-05-25 13:37:13','标题2','简介2','http://localhost:8080/springboot0b6e5/upload/news_picture2.jpg','内容2');
insert  into `news`(`id`,`addtime`,`title`,`introduction`,`picture`,`content`) values (163,'2021-05-25 13:37:13','标题3','简介3','http://localhost:8080/springboot0b6e5/upload/news_picture3.jpg','内容3');
insert  into `news`(`id`,`addtime`,`title`,`introduction`,`picture`,`content`) values (164,'2021-05-25 13:37:13','标题4','简介4','http://localhost:8080/springboot0b6e5/upload/news_picture4.jpg','内容4');
insert  into `news`(`id`,`addtime`,`title`,`introduction`,`picture`,`content`) values (165,'2021-05-25 13:37:13','标题5','简介5','http://localhost:8080/springboot0b6e5/upload/news_picture5.jpg','内容5');
insert  into `news`(`id`,`addtime`,`title`,`introduction`,`picture`,`content`) values (166,'2021-05-25 13:37:13','标题6','简介6','http://localhost:8080/springboot0b6e5/upload/news_picture6.jpg','内容6');

/*Table structure for table `storeup` */

DROP TABLE IF EXISTS `storeup`;

CREATE TABLE `storeup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `refid` bigint(20) DEFAULT NULL COMMENT '收藏id',
  `tablename` varchar(200) DEFAULT NULL COMMENT '表名',
  `name` varchar(200) NOT NULL COMMENT '收藏名称',
  `picture` varchar(200) NOT NULL COMMENT '收藏图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏表';

/*Data for the table `storeup` */

/*Table structure for table `tiwenjieda` */

DROP TABLE IF EXISTS `tiwenjieda`;

CREATE TABLE `tiwenjieda` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengmingcheng` varchar(200) DEFAULT NULL COMMENT '课程名称',
  `kemuleixing` varchar(200) DEFAULT NULL COMMENT '科目类型',
  `tiwenneirong` longtext COMMENT '提问内容',
  `tiwenjieda` longtext COMMENT '提问解答',
  `jiedariqi` date DEFAULT NULL COMMENT '解答日期',
  `xuehao` varchar(200) DEFAULT NULL COMMENT '学号',
  `jiaoshigonghao` varchar(200) DEFAULT NULL COMMENT '教师工号',
  `jiaoshixingming` varchar(200) DEFAULT NULL COMMENT '教师姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COMMENT='提问解答';

/*Data for the table `tiwenjieda` */

insert  into `tiwenjieda`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenjieda`,`jiedariqi`,`xuehao`,`jiaoshigonghao`,`jiaoshixingming`) values (101,'2021-05-25 13:37:13','课程名称1','科目类型1','提问内容1','提问解答1','2021-05-25','学号1','教师工号1','教师姓名1');
insert  into `tiwenjieda`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenjieda`,`jiedariqi`,`xuehao`,`jiaoshigonghao`,`jiaoshixingming`) values (102,'2021-05-25 13:37:13','课程名称2','科目类型2','提问内容2','提问解答2','2021-05-25','学号2','教师工号2','教师姓名2');
insert  into `tiwenjieda`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenjieda`,`jiedariqi`,`xuehao`,`jiaoshigonghao`,`jiaoshixingming`) values (103,'2021-05-25 13:37:13','课程名称3','科目类型3','提问内容3','提问解答3','2021-05-25','学号3','教师工号3','教师姓名3');
insert  into `tiwenjieda`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenjieda`,`jiedariqi`,`xuehao`,`jiaoshigonghao`,`jiaoshixingming`) values (104,'2021-05-25 13:37:13','课程名称4','科目类型4','提问内容4','提问解答4','2021-05-25','学号4','教师工号4','教师姓名4');
insert  into `tiwenjieda`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenjieda`,`jiedariqi`,`xuehao`,`jiaoshigonghao`,`jiaoshixingming`) values (105,'2021-05-25 13:37:13','课程名称5','科目类型5','提问内容5','提问解答5','2021-05-25','学号5','教师工号5','教师姓名5');
insert  into `tiwenjieda`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenjieda`,`jiedariqi`,`xuehao`,`jiaoshigonghao`,`jiaoshixingming`) values (106,'2021-05-25 13:37:13','课程名称6','科目类型6','提问内容6','提问解答6','2021-05-25','学号6','教师工号6','教师姓名6');

/*Table structure for table `token` */

DROP TABLE IF EXISTS `token`;

CREATE TABLE `token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='token表';

/*Data for the table `token` */

insert  into `token`(`id`,`userid`,`username`,`tablename`,`role`,`token`,`addtime`,`expiratedtime`) values (1,1621921122178,'1','xueshengyonghu','学生用户','zd6r8i35q0pjspan8tekkls7k90zweh3','2021-05-25 13:38:46','2021-05-25 14:38:47');

/*Table structure for table `tongzhigonggao` */

DROP TABLE IF EXISTS `tongzhigonggao`;

CREATE TABLE `tongzhigonggao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gonggaobiaoti` varchar(200) DEFAULT NULL COMMENT '公告标题',
  `gonggaoleixing` varchar(200) DEFAULT NULL COMMENT '公告类型',
  `gonggaoneirong` longtext COMMENT '公告内容',
  `fabushijian` date DEFAULT NULL COMMENT '发布时间',
  `faburen` varchar(200) DEFAULT NULL COMMENT '发布人',
  `fengmian` varchar(200) DEFAULT NULL COMMENT '封面',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COMMENT='通知公告';

/*Data for the table `tongzhigonggao` */

insert  into `tongzhigonggao`(`id`,`addtime`,`gonggaobiaoti`,`gonggaoleixing`,`gonggaoneirong`,`fabushijian`,`faburen`,`fengmian`) values (131,'2021-05-25 13:37:13','公告标题1','公告类型1','公告内容1','2021-05-25','发布人1','http://localhost:8080/springboot0b6e5/upload/tongzhigonggao_fengmian1.jpg');
insert  into `tongzhigonggao`(`id`,`addtime`,`gonggaobiaoti`,`gonggaoleixing`,`gonggaoneirong`,`fabushijian`,`faburen`,`fengmian`) values (132,'2021-05-25 13:37:13','公告标题2','公告类型2','公告内容2','2021-05-25','发布人2','http://localhost:8080/springboot0b6e5/upload/tongzhigonggao_fengmian2.jpg');
insert  into `tongzhigonggao`(`id`,`addtime`,`gonggaobiaoti`,`gonggaoleixing`,`gonggaoneirong`,`fabushijian`,`faburen`,`fengmian`) values (133,'2021-05-25 13:37:13','公告标题3','公告类型3','公告内容3','2021-05-25','发布人3','http://localhost:8080/springboot0b6e5/upload/tongzhigonggao_fengmian3.jpg');
insert  into `tongzhigonggao`(`id`,`addtime`,`gonggaobiaoti`,`gonggaoleixing`,`gonggaoneirong`,`fabushijian`,`faburen`,`fengmian`) values (134,'2021-05-25 13:37:13','公告标题4','公告类型4','公告内容4','2021-05-25','发布人4','http://localhost:8080/springboot0b6e5/upload/tongzhigonggao_fengmian4.jpg');
insert  into `tongzhigonggao`(`id`,`addtime`,`gonggaobiaoti`,`gonggaoleixing`,`gonggaoneirong`,`fabushijian`,`faburen`,`fengmian`) values (135,'2021-05-25 13:37:13','公告标题5','公告类型5','公告内容5','2021-05-25','发布人5','http://localhost:8080/springboot0b6e5/upload/tongzhigonggao_fengmian5.jpg');
insert  into `tongzhigonggao`(`id`,`addtime`,`gonggaobiaoti`,`gonggaoleixing`,`gonggaoneirong`,`fabushijian`,`faburen`,`fengmian`) values (136,'2021-05-25 13:37:13','公告标题6','公告类型6','公告内容6','2021-05-25','发布人6','http://localhost:8080/springboot0b6e5/upload/tongzhigonggao_fengmian6.jpg');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `role` varchar(100) DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`password`,`role`,`addtime`) values (1,'abo','abo','管理员','2021-05-25 13:37:13');

/*Table structure for table `wodekecheng` */

DROP TABLE IF EXISTS `wodekecheng`;

CREATE TABLE `wodekecheng` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengmingcheng` varchar(200) DEFAULT NULL COMMENT '课程名称',
  `kemuleixing` varchar(200) DEFAULT NULL COMMENT '科目类型',
  `kechengjianjie` longtext COMMENT '课程简介',
  `jiaoshixingming` varchar(200) DEFAULT NULL COMMENT '教师姓名',
  `kaikeshijian` date DEFAULT NULL COMMENT '开课时间',
  `jiekeshijian` date DEFAULT NULL COMMENT '结课时间',
  `beizhu` varchar(200) DEFAULT NULL COMMENT '备注',
  `xuehao` varchar(200) DEFAULT NULL COMMENT '学号',
  `xueshengxingming` varchar(200) DEFAULT NULL COMMENT '学生姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='我的课程';

/*Data for the table `wodekecheng` */

insert  into `wodekecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`jiaoshixingming`,`kaikeshijian`,`jiekeshijian`,`beizhu`,`xuehao`,`xueshengxingming`) values (41,'2021-05-25 13:37:13','课程名称1','科目类型1','课程简介1','教师姓名1','2021-05-25','2021-05-25','备注1','学号1','学生姓名1');
insert  into `wodekecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`jiaoshixingming`,`kaikeshijian`,`jiekeshijian`,`beizhu`,`xuehao`,`xueshengxingming`) values (42,'2021-05-25 13:37:13','课程名称2','科目类型2','课程简介2','教师姓名2','2021-05-25','2021-05-25','备注2','学号2','学生姓名2');
insert  into `wodekecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`jiaoshixingming`,`kaikeshijian`,`jiekeshijian`,`beizhu`,`xuehao`,`xueshengxingming`) values (43,'2021-05-25 13:37:13','课程名称3','科目类型3','课程简介3','教师姓名3','2021-05-25','2021-05-25','备注3','学号3','学生姓名3');
insert  into `wodekecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`jiaoshixingming`,`kaikeshijian`,`jiekeshijian`,`beizhu`,`xuehao`,`xueshengxingming`) values (44,'2021-05-25 13:37:13','课程名称4','科目类型4','课程简介4','教师姓名4','2021-05-25','2021-05-25','备注4','学号4','学生姓名4');
insert  into `wodekecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`jiaoshixingming`,`kaikeshijian`,`jiekeshijian`,`beizhu`,`xuehao`,`xueshengxingming`) values (45,'2021-05-25 13:37:13','课程名称5','科目类型5','课程简介5','教师姓名5','2021-05-25','2021-05-25','备注5','学号5','学生姓名5');
insert  into `wodekecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`jiaoshixingming`,`kaikeshijian`,`jiekeshijian`,`beizhu`,`xuehao`,`xueshengxingming`) values (46,'2021-05-25 13:37:13','课程名称6','科目类型6','课程简介6','教师姓名6','2021-05-25','2021-05-25','备注6','学号6','学生姓名6');

/*Table structure for table `xueshengtiwen` */

DROP TABLE IF EXISTS `xueshengtiwen`;

CREATE TABLE `xueshengtiwen` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengmingcheng` varchar(200) DEFAULT NULL COMMENT '课程名称',
  `kemuleixing` varchar(200) DEFAULT NULL COMMENT '科目类型',
  `tiwenneirong` longtext COMMENT '提问内容',
  `tiwenriqi` date DEFAULT NULL COMMENT '提问日期',
  `jiaoshigonghao` varchar(200) DEFAULT NULL COMMENT '教师工号',
  `xuehao` varchar(200) DEFAULT NULL COMMENT '学号',
  `xueshengxingming` varchar(200) DEFAULT NULL COMMENT '学生姓名',
  `sfsh` varchar(200) DEFAULT '否' COMMENT '是否审核',
  `shhf` longtext COMMENT '审核回复',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='学生提问';

/*Data for the table `xueshengtiwen` */

insert  into `xueshengtiwen`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenriqi`,`jiaoshigonghao`,`xuehao`,`xueshengxingming`,`sfsh`,`shhf`) values (91,'2021-05-25 13:37:13','课程名称1','科目类型1','提问内容1','2021-05-25','教师工号1','学号1','学生姓名1','是','');
insert  into `xueshengtiwen`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenriqi`,`jiaoshigonghao`,`xuehao`,`xueshengxingming`,`sfsh`,`shhf`) values (92,'2021-05-25 13:37:13','课程名称2','科目类型2','提问内容2','2021-05-25','教师工号2','学号2','学生姓名2','是','');
insert  into `xueshengtiwen`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenriqi`,`jiaoshigonghao`,`xuehao`,`xueshengxingming`,`sfsh`,`shhf`) values (93,'2021-05-25 13:37:13','课程名称3','科目类型3','提问内容3','2021-05-25','教师工号3','学号3','学生姓名3','是','');
insert  into `xueshengtiwen`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenriqi`,`jiaoshigonghao`,`xuehao`,`xueshengxingming`,`sfsh`,`shhf`) values (94,'2021-05-25 13:37:13','课程名称4','科目类型4','提问内容4','2021-05-25','教师工号4','学号4','学生姓名4','是','');
insert  into `xueshengtiwen`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenriqi`,`jiaoshigonghao`,`xuehao`,`xueshengxingming`,`sfsh`,`shhf`) values (95,'2021-05-25 13:37:13','课程名称5','科目类型5','提问内容5','2021-05-25','教师工号5','学号5','学生姓名5','是','');
insert  into `xueshengtiwen`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`tiwenneirong`,`tiwenriqi`,`jiaoshigonghao`,`xuehao`,`xueshengxingming`,`sfsh`,`shhf`) values (96,'2021-05-25 13:37:13','课程名称6','科目类型6','提问内容6','2021-05-25','教师工号6','学号6','学生姓名6','是','');

/*Table structure for table `xueshengyonghu` */

DROP TABLE IF EXISTS `xueshengyonghu`;

CREATE TABLE `xueshengyonghu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xuehao` varchar(200) NOT NULL COMMENT '学号',
  `mima` varchar(200) NOT NULL COMMENT '密码',
  `xueshengxingming` varchar(200) NOT NULL COMMENT '学生姓名',
  `xingbie` varchar(200) DEFAULT NULL COMMENT '性别',
  `banji` varchar(200) DEFAULT NULL COMMENT '班级',
  `shouji` varchar(200) DEFAULT NULL COMMENT '手机',
  `shenfenzheng` varchar(200) DEFAULT NULL COMMENT '身份证',
  PRIMARY KEY (`id`),
  UNIQUE KEY `xuehao` (`xuehao`)
) ENGINE=InnoDB AUTO_INCREMENT=1621921122179 DEFAULT CHARSET=utf8 COMMENT='学生用户';

/*Data for the table `xueshengyonghu` */

insert  into `xueshengyonghu`(`id`,`addtime`,`xuehao`,`mima`,`xueshengxingming`,`xingbie`,`banji`,`shouji`,`shenfenzheng`) values (11,'2021-05-25 13:37:13','学生用户1','123456','学生姓名1','男','班级1','13823888881','440300199101010001');
insert  into `xueshengyonghu`(`id`,`addtime`,`xuehao`,`mima`,`xueshengxingming`,`xingbie`,`banji`,`shouji`,`shenfenzheng`) values (12,'2021-05-25 13:37:13','学生用户2','123456','学生姓名2','男','班级2','13823888882','440300199202020002');
insert  into `xueshengyonghu`(`id`,`addtime`,`xuehao`,`mima`,`xueshengxingming`,`xingbie`,`banji`,`shouji`,`shenfenzheng`) values (13,'2021-05-25 13:37:13','学生用户3','123456','学生姓名3','男','班级3','13823888883','440300199303030003');
insert  into `xueshengyonghu`(`id`,`addtime`,`xuehao`,`mima`,`xueshengxingming`,`xingbie`,`banji`,`shouji`,`shenfenzheng`) values (14,'2021-05-25 13:37:13','学生用户4','123456','学生姓名4','男','班级4','13823888884','440300199404040004');
insert  into `xueshengyonghu`(`id`,`addtime`,`xuehao`,`mima`,`xueshengxingming`,`xingbie`,`banji`,`shouji`,`shenfenzheng`) values (15,'2021-05-25 13:37:13','学生用户5','123456','学生姓名5','男','班级5','13823888885','440300199505050005');
insert  into `xueshengyonghu`(`id`,`addtime`,`xuehao`,`mima`,`xueshengxingming`,`xingbie`,`banji`,`shouji`,`shenfenzheng`) values (16,'2021-05-25 13:37:13','学生用户6','123456','学生姓名6','男','班级6','13823888886','440300199606060006');
insert  into `xueshengyonghu`(`id`,`addtime`,`xuehao`,`mima`,`xueshengxingming`,`xingbie`,`banji`,`shouji`,`shenfenzheng`) values (1621921122178,'2021-05-25 13:38:42','1','1','1',NULL,NULL,NULL,NULL);

/*Table structure for table `zaixiankecheng` */

DROP TABLE IF EXISTS `zaixiankecheng`;

CREATE TABLE `zaixiankecheng` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengmingcheng` varchar(200) DEFAULT NULL COMMENT '课程名称',
  `kemuleixing` varchar(200) DEFAULT NULL COMMENT '科目类型',
  `kechengjianjie` longtext COMMENT '课程简介',
  `kechengneirong` longtext COMMENT '课程内容',
  `kechengshipin` varchar(200) DEFAULT NULL COMMENT '课程视频',
  `kaikeshijian` date DEFAULT NULL COMMENT '开课时间',
  `jiekeshijian` date DEFAULT NULL COMMENT '结课时间',
  `kechengtupian` varchar(200) DEFAULT NULL COMMENT '课程图片',
  `jiaoshigonghao` varchar(200) DEFAULT NULL COMMENT '教师工号',
  `jiaoshixingming` varchar(200) DEFAULT NULL COMMENT '教师姓名',
  `userid` bigint(20) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='在线课程';

/*Data for the table `zaixiankecheng` */

insert  into `zaixiankecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`kechengneirong`,`kechengshipin`,`kaikeshijian`,`jiekeshijian`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`,`userid`) values (31,'2021-05-25 13:37:13','课程名称1','科目类型1','课程简介1','课程内容1','','2021-05-25','2021-05-25','http://localhost:8080/springboot0b6e5/upload/zaixiankecheng_kechengtupian1.jpg','教师工号1','教师姓名1',1);
insert  into `zaixiankecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`kechengneirong`,`kechengshipin`,`kaikeshijian`,`jiekeshijian`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`,`userid`) values (32,'2021-05-25 13:37:13','课程名称2','科目类型2','课程简介2','课程内容2','','2021-05-25','2021-05-25','http://localhost:8080/springboot0b6e5/upload/zaixiankecheng_kechengtupian2.jpg','教师工号2','教师姓名2',2);
insert  into `zaixiankecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`kechengneirong`,`kechengshipin`,`kaikeshijian`,`jiekeshijian`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`,`userid`) values (33,'2021-05-25 13:37:13','课程名称3','科目类型3','课程简介3','课程内容3','','2021-05-25','2021-05-25','http://localhost:8080/springboot0b6e5/upload/zaixiankecheng_kechengtupian3.jpg','教师工号3','教师姓名3',3);
insert  into `zaixiankecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`kechengneirong`,`kechengshipin`,`kaikeshijian`,`jiekeshijian`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`,`userid`) values (34,'2021-05-25 13:37:13','课程名称4','科目类型4','课程简介4','课程内容4','','2021-05-25','2021-05-25','http://localhost:8080/springboot0b6e5/upload/zaixiankecheng_kechengtupian4.jpg','教师工号4','教师姓名4',4);
insert  into `zaixiankecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`kechengneirong`,`kechengshipin`,`kaikeshijian`,`jiekeshijian`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`,`userid`) values (35,'2021-05-25 13:37:13','课程名称5','科目类型5','课程简介5','课程内容5','','2021-05-25','2021-05-25','http://localhost:8080/springboot0b6e5/upload/zaixiankecheng_kechengtupian5.jpg','教师工号5','教师姓名5',5);
insert  into `zaixiankecheng`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`kechengjianjie`,`kechengneirong`,`kechengshipin`,`kaikeshijian`,`jiekeshijian`,`kechengtupian`,`jiaoshigonghao`,`jiaoshixingming`,`userid`) values (36,'2021-05-25 13:37:13','课程名称6','科目类型6','课程简介6','课程内容6','','2021-05-25','2021-05-25','http://localhost:8080/springboot0b6e5/upload/zaixiankecheng_kechengtupian6.jpg','教师工号6','教师姓名6',6);

/*Table structure for table `zhishiyaodian` */

DROP TABLE IF EXISTS `zhishiyaodian`;

CREATE TABLE `zhishiyaodian` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengmingcheng` varchar(200) DEFAULT NULL COMMENT '课程名称',
  `kemuleixing` varchar(200) DEFAULT NULL COMMENT '科目类型',
  `zhishidianmingcheng` varchar(200) DEFAULT NULL COMMENT '知识点名称',
  `zhishidianneirong` longtext COMMENT '知识点内容',
  `zhishidianjiexi` longtext COMMENT '知识点解析',
  `kechengtupian` varchar(200) DEFAULT NULL COMMENT '课程图片',
  `faburiqi` date DEFAULT NULL COMMENT '发布日期',
  `jiaoshigonghao` varchar(200) DEFAULT NULL COMMENT '教师工号',
  `jiaoshixingming` varchar(200) DEFAULT NULL COMMENT '教师姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='知识要点';

/*Data for the table `zhishiyaodian` */

insert  into `zhishiyaodian`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`zhishidianmingcheng`,`zhishidianneirong`,`zhishidianjiexi`,`kechengtupian`,`faburiqi`,`jiaoshigonghao`,`jiaoshixingming`) values (61,'2021-05-25 13:37:13','课程名称1','科目类型1','知识点名称1','知识点内容1','知识点解析1','http://localhost:8080/springboot0b6e5/upload/zhishiyaodian_kechengtupian1.jpg','2021-05-25','教师工号1','教师姓名1');
insert  into `zhishiyaodian`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`zhishidianmingcheng`,`zhishidianneirong`,`zhishidianjiexi`,`kechengtupian`,`faburiqi`,`jiaoshigonghao`,`jiaoshixingming`) values (62,'2021-05-25 13:37:13','课程名称2','科目类型2','知识点名称2','知识点内容2','知识点解析2','http://localhost:8080/springboot0b6e5/upload/zhishiyaodian_kechengtupian2.jpg','2021-05-25','教师工号2','教师姓名2');
insert  into `zhishiyaodian`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`zhishidianmingcheng`,`zhishidianneirong`,`zhishidianjiexi`,`kechengtupian`,`faburiqi`,`jiaoshigonghao`,`jiaoshixingming`) values (63,'2021-05-25 13:37:13','课程名称3','科目类型3','知识点名称3','知识点内容3','知识点解析3','http://localhost:8080/springboot0b6e5/upload/zhishiyaodian_kechengtupian3.jpg','2021-05-25','教师工号3','教师姓名3');
insert  into `zhishiyaodian`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`zhishidianmingcheng`,`zhishidianneirong`,`zhishidianjiexi`,`kechengtupian`,`faburiqi`,`jiaoshigonghao`,`jiaoshixingming`) values (64,'2021-05-25 13:37:13','课程名称4','科目类型4','知识点名称4','知识点内容4','知识点解析4','http://localhost:8080/springboot0b6e5/upload/zhishiyaodian_kechengtupian4.jpg','2021-05-25','教师工号4','教师姓名4');
insert  into `zhishiyaodian`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`zhishidianmingcheng`,`zhishidianneirong`,`zhishidianjiexi`,`kechengtupian`,`faburiqi`,`jiaoshigonghao`,`jiaoshixingming`) values (65,'2021-05-25 13:37:13','课程名称5','科目类型5','知识点名称5','知识点内容5','知识点解析5','http://localhost:8080/springboot0b6e5/upload/zhishiyaodian_kechengtupian5.jpg','2021-05-25','教师工号5','教师姓名5');
insert  into `zhishiyaodian`(`id`,`addtime`,`kechengmingcheng`,`kemuleixing`,`zhishidianmingcheng`,`zhishidianneirong`,`zhishidianjiexi`,`kechengtupian`,`faburiqi`,`jiaoshigonghao`,`jiaoshixingming`) values (66,'2021-05-25 13:37:13','课程名称6','科目类型6','知识点名称6','知识点内容6','知识点解析6','http://localhost:8080/springboot0b6e5/upload/zhishiyaodian_kechengtupian6.jpg','2021-05-25','教师工号6','教师姓名6');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
