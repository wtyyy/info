CREATE TABLE `courses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT 'default',
  `teacher` varchar(45) NOT NULL DEFAULT 'bin xu',
  `day` int(11) NOT NULL DEFAULT '0',
  `block` int(11) NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `startTime` date NOT NULL,
  `endTime` date NOT NULL,
  `capacity` int(11) unsigned NOT NULL DEFAULT '100',
  `selectStartTime` date NOT NULL,
  `selectEndTime` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

CREATE TABLE `discussion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `topic` varchar(45) NOT NULL DEFAULT '无标题',
  `content` varchar(20000) NOT NULL,
  `appendixURL` varchar(100) DEFAULT NULL,
  `userid` int(10) unsigned NOT NULL,
  `discussType` enum('T','R') DEFAULT 'R',
  `pros` int(10) unsigned NOT NULL DEFAULT '0',
  `cons` int(10) unsigned NOT NULL DEFAULT '0',
  `postDate` datetime NOT NULL,
  `belongs` int(10) unsigned DEFAULT '0',
  `zone` enum('cs','food','other','music') DEFAULT 'other',
  `lastReplyTime` datetime DEFAULT NULL,
  `lastReplyName` varchar(45) DEFAULT '0',
  `lastReplyId` int(11) DEFAULT NULL,
  `userName` varchar(45) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

CREATE TABLE `discussReply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(20000) COLLATE utf8_bin NOT NULL,
  `appendixURL` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `userid` int(10) unsigned NOT NULL,
  `discussType` enum('T','R') COLLATE utf8_bin DEFAULT 'R',
  `pros` int(10) unsigned NOT NULL DEFAULT '0',
  `cons` int(10) unsigned NOT NULL DEFAULT '0',
  `postDate` datetime NOT NULL,
  `belongs` int(10) unsigned DEFAULT '0',
  `zone` enum('cs','food','music','other') COLLATE utf8_bin DEFAULT 'other',
  `userName` varchar(45) COLLATE utf8_bin DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `content` longblob NOT NULL,
  `uploaderId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

CREATE TABLE `Forbidden` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `professorInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `detail` varchar(13900) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8;

CREATE TABLE `publicInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `text` text NOT NULL,
  `type` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

CREATE TABLE `slideInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` text NOT NULL,
  `href` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `studentChooseCourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentId` int(11) DEFAULT NULL,
  `courseId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;

CREATE TABLE `studentChooseCourseHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentId` int(11) NOT NULL,
  `courseId` int(11) NOT NULL,
  `operation` enum('select','deselect') NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;

CREATE TABLE `teachInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `dateBorn` date DEFAULT NULL,
  `tel` varchar(45) DEFAULT NULL,
  `emergencyContactName` varchar(45) DEFAULT NULL,
  `emergencyContactTel` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `qq` varchar(45) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT '0',
  `privilege` enum('student','admin') NOT NULL DEFAULT 'student',
  `validated` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;



INSERT INTO `wtyInfo`.`users`
(`id`,
`email`,
`password`,
`name`,
`gender`,
`dateBorn`,
`tel`,
`emergencyContactName`,
`emergencyContactTel`,
`address`,
`qq`,
`blocked`,
`privilege`,
`validated`)
VALUES
(0,
'admin@admin.com',
'admin',
'admin',
'male',
'2014-01-01',
'13012345678',
'TianyiWang',
'110',
'Tsinghua univ.',
'',
0,
'student',
'1');
