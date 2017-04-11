-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2017 at 08:46 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nmmumobile`
--

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `client_name` varchar(10000) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`client_id`, `client_name`) VALUES
(1, 'NMMU'),
(2, 'UCT'),
(3, 'Rhodes');

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `device_id` int(11) NOT NULL,
  `device_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ethnics`
--

CREATE TABLE `ethnics` (
  `ethnic_id` int(11) NOT NULL,
  `ethnic` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ethnics`
--

INSERT INTO `ethnics` (`ethnic_id`, `ethnic`) VALUES
(1, 'Asian'),
(2, 'African');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL,
  `group_name` varchar(10000) CHARACTER SET latin1 NOT NULL,
  `comment` varchar(10000) CHARACTER SET latin1 NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`group_id`, `group_name`, `comment`, `client_id`) VALUES
(2, 'grouf2', 'commeneeet2', 1),
(3, 'grouf3', 'commeneeet3', 1),
(4, 'grouf4', 'commeneeet4', 1),
(5, 'grouf5', 'commeneeet5', 1),
(6, 'grouf6', 'commeneeet6', 1),
(7, 'grouf7', 'commeneeet7', 1),
(8, 'grouf8', 'commeneeet8', 1),
(9, 'grouf9', 'commeneeet9', 1),
(10, 'group9', 'comment9', 1),
(11, 'group0', 'comment0', 2),
(12, 'group1', 'comment1', 2),
(13, 'group2', 'comment2', 2),
(14, 'group3', 'comment3', 2),
(15, 'group4', 'comment4', 2),
(16, 'group5', 'comment5', 2),
(17, 'group6', 'comment6', 2),
(18, 'group7', 'comment7', 2),
(19, 'group8', 'comment8', 2),
(20, 'group9', 'comment9', 2),
(21, 'grou0', 'comment0', 1),
(22, 'grou1', 'comment1', 1),
(23, 'grou2', 'comment2', 1),
(24, 'grou3', 'comment3', 1),
(25, 'grou4', 'comment4', 1),
(26, 'grou5', 'comment5', 1),
(27, 'grou6', 'comment6', 1),
(28, 'grou7', 'comment7', 1),
(29, 'grou8', 'comment8', 1),
(30, 'grou9', 'comment9', 1),
(32, 'grou0', 'commeneeet0', 2),
(33, 'grouf0', 'commeneeet0', 1);

-- --------------------------------------------------------

--
-- Table structure for table `group_roles`
--

CREATE TABLE `group_roles` (
  `role_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `role_group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `country` int(11) NOT NULL,
  `state` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `address` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `post_box` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `tel` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `fax` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `email` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `street` varchar(200) CHARACTER SET latin1 NOT NULL,
  `area` varchar(200) CHARACTER SET latin1 NOT NULL,
  `cell` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `location_id` bigint(20) NOT NULL,
  `gps` varchar(200) NOT NULL,
  `location_name` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `log_activities`
--

CREATE TABLE `log_activities` (
  `user_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `activity` text NOT NULL,
  `log_id` bigint(255) NOT NULL,
  `parameters` varchar(20000) NOT NULL,
  `device_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(10000) CHARACTER SET latin1 NOT NULL,
  `comment` varchar(10000) CHARACTER SET latin1 NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `comment`, `client_id`) VALUES
(410, 'role101', 'comment101', 1),
(411, 'role102', 'comment102', 1),
(412, 'role103', 'comment103', 1),
(413, 'role104', 'comment104', 1),
(414, 'role105', 'comment105', 1),
(415, 'role106', 'comment106', 1),
(416, 'role107', 'comment107', 1),
(417, 'role108', 'comment108', 1),
(418, 'role109', 'comment109', 1),
(419, 'role110', 'comment110', 1),
(420, 'role111', 'comment111', 1),
(421, 'role112', 'comment112', 1),
(422, 'role113', 'comment113', 1),
(423, 'role114', 'comment114', 1),
(424, 'role115', 'comment115', 1),
(425, 'role116', 'comment116', 1),
(426, 'role117', 'comment117', 1),
(427, 'role118', 'comment118', 1),
(428, 'role119', 'comment119', 1),
(429, 'role120', 'comment120', 1),
(430, 'role121', 'comment121', 1),
(431, 'role122', 'comment122', 1),
(432, 'role123', 'comment123', 1),
(433, 'role124', 'comment124', 1),
(434, 'role125', 'comment125', 1),
(435, 'role126', 'comment126', 1),
(436, 'role127', 'comment127', 1),
(437, 'role128', 'comment128', 1),
(438, 'role129', 'comment129', 1),
(439, 'role130', 'comment130', 1),
(440, 'role131', 'comment131', 1),
(441, 'role132', 'comment132', 1),
(442, 'role133', 'comment133', 1),
(443, 'role134', 'comment134', 1),
(444, 'role135', 'comment135', 1),
(445, 'role136', 'comment136', 1),
(446, 'role137', 'comment137', 1),
(447, 'role138', 'comment138', 1),
(448, 'role139', 'comment139', 1),
(449, 'role140', 'comment140', 1),
(450, 'role141', 'comment141', 1),
(451, 'role142', 'comment142', 1),
(452, 'role143', 'comment143', 1),
(453, 'role144', 'comment144', 1),
(454, 'role145', 'comment145', 1),
(455, 'role146', 'comment146', 1),
(456, 'role147', 'comment147', 1),
(457, 'role148', 'comment148', 1),
(458, 'role149', 'comment149', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_settings`
--

CREATE TABLE `sensor_settings` (
  `sensor_setting_id` bigint(20) NOT NULL,
  `accelerometer` double NOT NULL DEFAULT '1',
  `gyroscope` double NOT NULL DEFAULT '1',
  `gps` varchar(200) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `start_time` varchar(200) NOT NULL,
  `end_time` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `titles`
--

CREATE TABLE `titles` (
  `title_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `titles`
--

INSERT INTO `titles` (`title_id`, `title`) VALUES
(1, 'Mr'),
(2, 'Mrs');

-- --------------------------------------------------------

--
-- Table structure for table `track_user`
--

CREATE TABLE `track_user` (
  `user_id` bigint(20) NOT NULL,
  `accelerometer` varchar(200) NOT NULL,
  `gyroscope` varchar(200) NOT NULL,
  `gps` varchar(200) NOT NULL,
  `user_track_id` bigint(255) NOT NULL,
  `date_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `password` varchar(500) CHARACTER SET latin1 DEFAULT NULL,
  `registeration_date` varchar(100) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `user_id` bigint(11) NOT NULL,
  `username` varchar(10000) CHARACTER SET latin1 NOT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `surname` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `ethnic` int(11) NOT NULL,
  `date_of_birth` varchar(100) NOT NULL,
  `title` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`password`, `registeration_date`, `creator_id`, `active`, `user_id`, `username`, `client_id`, `name`, `surname`, `gender`, `ethnic`, `date_of_birth`, `title`) VALUES
('pass', 'today', NULL, 1, 3, 'userName', 1, 'name', 'surname', 1, 1, 'dob', 1),
('pass5', 'today', NULL, 1, 5, 'userNamezzzz5', 1, 'namezzzz5', 'surnamezzz', 1, 2, 'dob', 2),
('pass6', 'today', NULL, 1, 6, 'userNamezzzz6', 1, 'namezzzz6', 'surnamezzz', 1, 2, 'dob', 2),
('pass7', 'today', NULL, 1, 7, 'userNamezzzz7', 1, 'namezzzz7', 'surnamezzz', 1, 2, 'dob', 2),
('pass8', 'today', NULL, 1, 8, 'userNamezzzz8', 1, 'namezzzz8', 'surnamezzz', 1, 2, 'dob', 2),
('pass9', 'today', NULL, 1, 9, 'userNamezzzz9', 1, 'namezzzz9', 'surnamezzz', 1, 2, 'dob', 2),
('pass6', 'today', NULL, 1, 10, 'userName6', 1, 'name6', 'surname', 1, 2, 'dob', 2),
('pass7', 'today', NULL, 1, 11, 'userName7', 1, 'name7', 'surname', 1, 2, 'dob', 2),
('pass8', 'today', NULL, 1, 12, 'userName8', 1, 'name8', 'surname', 1, 2, 'dob', 2),
('pass9', 'today', NULL, 1, 13, 'userName9', 1, 'name9', 'surname', 1, 2, 'dob', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_device`
--

CREATE TABLE `user_device` (
  `user_device_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `user_id` bigint(11) NOT NULL,
  `mac_address` varchar(400) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `user_group_id` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `user_location`
--

CREATE TABLE `user_location` (
  `user_id` bigint(20) NOT NULL,
  `location_id` bigint(20) NOT NULL,
  `user_location_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`device_id`);

--
-- Indexes for table `ethnics`
--
ALTER TABLE `ethnics`
  ADD PRIMARY KEY (`ethnic_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `group_roles`
--
ALTER TABLE `group_roles`
  ADD PRIMARY KEY (`role_group_id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `log_activities`
--
ALTER TABLE `log_activities`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `device_id` (`device_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_id` (`role_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `sensor_settings`
--
ALTER TABLE `sensor_settings`
  ADD PRIMARY KEY (`sensor_setting_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `titles`
--
ALTER TABLE `titles`
  ADD PRIMARY KEY (`title_id`);

--
-- Indexes for table `track_user`
--
ALTER TABLE `track_user`
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `user_device`
--
ALTER TABLE `user_device`
  ADD PRIMARY KEY (`user_device_id`),
  ADD KEY `device_id` (`device_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`user_group_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `user_location`
--
ALTER TABLE `user_location`
  ADD PRIMARY KEY (`user_location_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `address_id` (`location_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_role_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `ethnics`
--
ALTER TABLE `ethnics`
  MODIFY `ethnic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `group_roles`
--
ALTER TABLE `group_roles`
  MODIFY `role_group_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `log_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=459;
--
-- AUTO_INCREMENT for table `sensor_settings`
--
ALTER TABLE `sensor_settings`
  MODIFY `sensor_setting_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `titles`
--
ALTER TABLE `titles`
  MODIFY `title_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `user_group_id` bigint(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_location`
--
ALTER TABLE `user_location`
  MODIFY `user_location_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `user_role_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`);

--
-- Constraints for table `group_roles`
--
ALTER TABLE `group_roles`
  ADD CONSTRAINT `group_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  ADD CONSTRAINT `group_roles_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `user_location` (`location_id`);

--
-- Constraints for table `log_activities`
--
ALTER TABLE `log_activities`
  ADD CONSTRAINT `log_activities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `log_activities_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`);

--
-- Constraints for table `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `roles_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`);

--
-- Constraints for table `sensor_settings`
--
ALTER TABLE `sensor_settings`
  ADD CONSTRAINT `sensor_settings_ibfk_1` FOREIGN KEY (`sensor_setting_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `track_user`
--
ALTER TABLE `track_user`
  ADD CONSTRAINT `track_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`);

--
-- Constraints for table `user_device`
--
ALTER TABLE `user_device`
  ADD CONSTRAINT `user_device_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`),
  ADD CONSTRAINT `user_device_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD CONSTRAINT `user_groups_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_groups_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_location`
--
ALTER TABLE `user_location`
  ADD CONSTRAINT `user_location_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
