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
DROP DATABASE IF EXISTS `farm`;
CREATE DATABASE IF NOT EXISTS `farm` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `farm`;

-- 导出  表 farm.LandLevelStatic 结构
DROP TABLE IF EXISTS `LandLevelStatic`;
CREATE TABLE IF NOT EXISTS `LandLevelStatic` (
  `id` int DEFAULT NULL COMMENT '土地id',
  `reward` varchar(50) DEFAULT NULL COMMENT '奖励',
  `cost` varchar(50) DEFAULT NULL COMMENT '消耗',
  `gain` int DEFAULT NULL COMMENT '额外收益'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='土地静态配置表';

-- 正在导出表  farm.LandLevelStatic 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `LandLevelStatic` DISABLE KEYS */;
/*!40000 ALTER TABLE `LandLevelStatic` ENABLE KEYS */;

-- 导出  表 farm.PlantStatic 结构
DROP TABLE IF EXISTS `PlantStatic`;
CREATE TABLE IF NOT EXISTS `PlantStatic` (
  `id` int DEFAULT NULL COMMENT '植物id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='种子静态表';

-- 正在导出表  farm.PlantStatic 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `PlantStatic` DISABLE KEYS */;
REPLACE INTO `PlantStatic` (`id`) VALUES
	(1002),
	(1003),
	(1004),
	(1001);
/*!40000 ALTER TABLE `PlantStatic` ENABLE KEYS */;

-- 导出  表 farm.User 结构
DROP TABLE IF EXISTS `User`;
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

-- 正在导出表  farm.User 的数据：~22 rows (大约)
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
REPLACE INTO `User` (`id`, `gold`, `diamond`, `uid`, `nickname`, `addTime`) VALUES
	(101, 99, 999, 999, 'asda', '2021-11-06 20:03:58'),
	(102, 0, 0, 0, 'game', '2021-11-06 20:03:57'),
	(103, 0, 0, 1000, 'game', '2021-11-06 20:03:53'),
	(104, 0, 0, 1000, 'game', '2021-11-06 20:03:56'),
	(105, 0, 0, 0, 'game', '2021-11-06 20:03:53'),
	(106, 0, 0, 0, 'game', '2021-11-06 20:03:51'),
	(107, 0, 0, 1001, 'game', '2021-11-06 20:03:52'),
	(108, 0, 0, 1002, 'game', '2021-11-06 20:03:50'),
	(109, 0, 0, 1003, 'game', '2021-11-06 20:03:50'),
	(110, 0, 0, 1004, 'game', '2021-11-06 20:03:49'),
	(111, 999, 999, 1005, 'game', '2021-11-06 20:03:47'),
	(112, 999, 999, 1006, 'game', '2021-11-06 20:03:46'),
	(114, 999, 999, 1008, 'game', '2021-11-06 01:11:11'),
	(115, 999, 999, 1009, 'game', '2021-11-06 12:16:13'),
	(116, 999, 999, 1010, 'game', '2021-11-06 12:16:13'),
	(117, 999, 999, 1011, 'game', '2021-11-06 12:27:36'),
	(118, 999, 999, 1012, 'game', '2021-11-06 12:27:36'),
	(119, 999, 999, 1013, 'game', '2021-11-06 12:33:04'),
	(120, 999, 999, 1014, 'game', '2021-11-06 12:33:04'),
	(121, 999, 999, 1015, 'game', '2021-11-06 13:36:15'),
	(122, 999, 999, 10134, 'game', '2021-11-07 02:23:52'),
	(123, 999, 999, 1018, 'game', '2021-11-07 12:46:04');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;

-- 导出  表 farm.UserLand 结构
DROP TABLE IF EXISTS `UserLand`;
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

-- 正在导出表  farm.UserLand 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `UserLand` DISABLE KEYS */;
REPLACE INTO `UserLand` (`id`, `uid`, `level`, `productId`, `matureTime`, `landId`) VALUES
	(8, 1014, 1, 22, '2021-11-07 20:51:25', 4),
	(9, 1013, 1, 99, '2021-11-07 21:38:03', 4);
/*!40000 ALTER TABLE `UserLand` ENABLE KEYS */;

-- 导出  表 farm.UserSeeds 结构
DROP TABLE IF EXISTS `UserSeeds`;
CREATE TABLE IF NOT EXISTS `UserSeeds` (
  `plantId` int DEFAULT NULL,
  `uid` int DEFAULT NULL,
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='用户解锁的种子列表';

-- 正在导出表  farm.UserSeeds 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `UserSeeds` DISABLE KEYS */;
REPLACE INTO `UserSeeds` (`plantId`, `uid`) VALUES
	(1002, 1013);
/*!40000 ALTER TABLE `UserSeeds` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
