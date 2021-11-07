-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.27 - MySQL Community Server - GPL
-- 服务器操作系统:                      Linux
-- HeidiSQL 版本:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 farm 的数据库结构
CREATE DATABASE IF NOT EXISTS `farm` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `farm`;

-- 导出  表 farm.LandLevelStatic 结构
CREATE TABLE IF NOT EXISTS `LandLevelStatic` (
  `id` int DEFAULT NULL COMMENT '土地id',
  `reward` varchar(50) DEFAULT NULL COMMENT '奖励',
  `cost` varchar(50) DEFAULT NULL COMMENT '消耗',
  `gain` int DEFAULT NULL COMMENT '额外收益'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='土地静态配置表';

-- 数据导出被取消选择。

-- 导出  表 farm.PlantStatic 结构
CREATE TABLE IF NOT EXISTS `PlantStatic` (
  `id` int DEFAULT NULL COMMENT '植物id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='种子静态表';

-- 数据导出被取消选择。

-- 导出  表 farm.User 结构
CREATE TABLE IF NOT EXISTS `User` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gold` int unsigned NOT NULL COMMENT '金币',
  `diamond` int unsigned NOT NULL COMMENT '钻石',
  `uid` int unsigned NOT NULL COMMENT '用户id',
  `nickname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `addTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb3 COMMENT='用户表';

-- 数据导出被取消选择。

-- 导出  表 farm.UserLand 结构
CREATE TABLE IF NOT EXISTS `UserLand` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL COMMENT '用户id',
  `level` int NOT NULL COMMENT '等级',
  `productId` int DEFAULT NULL COMMENT '产品id',
  `matureTime` datetime DEFAULT NULL COMMENT '成熟时间',
  `landId` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- 数据导出被取消选择。

-- 导出  表 farm.UserSeeds 结构
CREATE TABLE IF NOT EXISTS `UserSeeds` (
  `plantId` int DEFAULT NULL,
  `uid` int DEFAULT NULL,
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='用户解锁的种子列表';

-- 数据导出被取消选择。

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
