-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 09, 2017 at 11:52 AM
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
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `country` int(11) NOT NULL,
  `state` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `address1` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `post_box` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `tel1` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `tel2` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `tel3` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `tel4` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `fax1` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `fax2` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `fax3` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `email1` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `email2` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `email3` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `email4` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `street` varchar(200) CHARACTER SET latin1 NOT NULL,
  `area` varchar(200) CHARACTER SET latin1 NOT NULL,
  `cell1` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `cell2` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `cell3` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `cell4` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `address2` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `address_id` bigint(20) NOT NULL,
  `gps` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(1, 'NMMU');

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
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `group_id` int(11) NOT NULL,
  `group_name` varchar(10000) CHARACTER SET latin1 NOT NULL,
  `group_description` varchar(10000) CHARACTER SET latin1 NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(1, 'admin', 'administrator', 1),
(5, 'developerss', 'comment', 1),
(6, 'Test', 'comm', 1),
(7, 'role19', 'comment19', 1),
(8, 'role0', 'comment0', 1),
(9, 'role1', 'comment1', 1),
(10, 'role2', 'comment2', 1),
(11, 'role3', 'comment3', 1),
(12, 'role4', 'comment4', 1),
(13, 'role5', 'comment5', 1),
(14, 'role6', 'comment6', 1),
(15, 'role7', 'comment7', 1),
(16, 'role8', 'comment8', 1),
(17, 'role9', 'comment9', 1),
(18, 'role10', 'comment10', 1),
(19, 'role11', 'comment11', 1),
(20, 'role12', 'comment12', 1),
(21, 'role13', 'comment13', 1),
(22, 'role14', 'comment14', 1),
(23, 'role15', 'comment15', 1),
(24, 'role16', 'comment16', 1),
(25, 'role17', 'comment17', 1),
(26, 'role18', 'comment18', 1),
(27, 'role19', 'comment19', 1),
(28, 'role40', 'comment40', 1),
(29, 'role41', 'comment41', 1),
(30, 'role42', 'comment42', 1),
(31, 'role43', 'comment43', 1),
(32, 'role44', 'comment44', 1),
(33, 'role45', 'comment45', 1),
(34, 'role46', 'comment46', 1),
(35, 'role47', 'comment47', 1),
(36, 'role48', 'comment48', 1),
(37, 'role49', 'comment49', 1),
(38, 'role50', 'comment50', 1),
(39, 'role51', 'comment51', 1),
(40, 'role52', 'comment52', 1),
(41, 'role53', 'comment53', 1),
(42, 'role54', 'comment54', 1),
(43, 'role55', 'comment55', 1),
(44, 'role56', 'comment56', 1),
(45, 'role57', 'comment57', 1),
(46, 'role58', 'comment58', 1),
(47, 'role59', 'comment59', 1),
(48, 'role60', 'comment60', 1),
(49, 'role61', 'comment61', 1),
(50, 'role62', 'comment62', 1),
(51, 'role63', 'comment63', 1),
(52, 'role64', 'comment64', 1),
(53, 'role65', 'comment65', 1),
(54, 'role66', 'comment66', 1),
(55, 'role67', 'comment67', 1),
(56, 'role68', 'comment68', 1),
(57, 'role69', 'comment69', 1),
(58, 'role70', 'comment70', 1),
(59, 'role71', 'comment71', 1),
(60, 'role72', 'comment72', 1),
(61, 'role73', 'comment73', 1),
(62, 'role74', 'comment74', 1),
(63, 'role75', 'comment75', 1),
(64, 'role76', 'comment76', 1),
(65, 'role77', 'comment77', 1),
(66, 'role78', 'comment78', 1),
(67, 'role79', 'comment79', 1),
(68, 'role80', 'comment80', 1),
(69, 'role81', 'comment81', 1),
(70, 'role82', 'comment82', 1),
(71, 'role83', 'comment83', 1),
(72, 'role84', 'comment84', 1),
(73, 'role85', 'comment85', 1),
(74, 'role86', 'comment86', 1),
(75, 'role87', 'comment87', 1),
(76, 'role88', 'comment88', 1),
(77, 'role89', 'comment89', 1),
(78, 'role90', 'comment90', 1),
(79, 'role91', 'comment91', 1),
(80, 'role92', 'comment92', 1),
(81, 'role93', 'comment93', 1),
(82, 'role94', 'comment94', 1),
(83, 'role95', 'comment95', 1),
(84, 'role96', 'comment96', 1),
(85, 'role97', 'comment97', 1),
(86, 'role98', 'comment98', 1),
(87, 'role99', 'comment99', 1),
(88, 'role100', 'comment100', 1),
(89, 'role101', 'comment101', 1),
(90, 'role102', 'comment102', 1),
(91, 'role103', 'comment103', 1),
(92, 'role104', 'comment104', 1),
(93, 'role105', 'comment105', 1),
(94, 'role106', 'comment106', 1),
(95, 'role107', 'comment107', 1),
(96, 'role108', 'comment108', 1),
(97, 'role109', 'comment109', 1),
(98, 'role110', 'comment110', 1),
(99, 'role111', 'comment111', 1),
(100, 'role112', 'comment112', 1),
(101, 'role113', 'comment113', 1),
(102, 'role114', 'comment114', 1),
(103, 'role115', 'comment115', 1),
(104, 'role116', 'comment116', 1),
(105, 'role117', 'comment117', 1),
(106, 'role118', 'comment118', 1),
(107, 'role119', 'comment119', 1),
(108, 'role120', 'comment120', 1),
(109, 'role121', 'comment121', 1),
(110, 'role122', 'comment122', 1),
(111, 'role123', 'comment123', 1),
(112, 'role124', 'comment124', 1),
(113, 'role125', 'comment125', 1),
(114, 'role126', 'comment126', 1),
(115, 'role127', 'comment127', 1),
(116, 'role128', 'comment128', 1),
(117, 'role129', 'comment129', 1),
(118, 'role130', 'comment130', 1),
(119, 'role131', 'comment131', 1),
(120, 'role132', 'comment132', 1),
(121, 'role133', 'comment133', 1),
(122, 'role134', 'comment134', 1),
(123, 'role135', 'comment135', 1),
(124, 'role136', 'comment136', 1),
(125, 'role137', 'comment137', 1),
(126, 'role138', 'comment138', 1),
(127, 'role139', 'comment139', 1),
(128, 'role140', 'comment140', 1),
(129, 'role141', 'comment141', 1),
(130, 'role142', 'comment142', 1),
(131, 'role143', 'comment143', 1),
(132, 'role144', 'comment144', 1),
(133, 'role145', 'comment145', 1),
(134, 'role146', 'comment146', 1),
(135, 'role147', 'comment147', 1),
(136, 'role148', 'comment148', 1),
(137, 'role149', 'comment149', 1),
(138, 'role150', 'comment150', 1),
(139, 'role151', 'comment151', 1),
(140, 'role152', 'comment152', 1),
(141, 'role153', 'comment153', 1),
(142, 'role154', 'comment154', 1),
(143, 'role155', 'comment155', 1),
(144, 'role156', 'comment156', 1),
(145, 'role157', 'comment157', 1),
(146, 'role158', 'comment158', 1),
(147, 'role159', 'comment159', 1),
(148, 'role160', 'comment160', 1),
(149, 'role161', 'comment161', 1),
(150, 'role162', 'comment162', 1),
(151, 'role163', 'comment163', 1),
(152, 'role164', 'comment164', 1),
(153, 'role165', 'comment165', 1),
(154, 'role166', 'comment166', 1),
(155, 'role167', 'comment167', 1),
(156, 'role168', 'comment168', 1),
(157, 'role169', 'comment169', 1),
(158, 'role170', 'comment170', 1),
(159, 'role171', 'comment171', 1),
(160, 'role172', 'comment172', 1),
(161, 'role173', 'comment173', 1),
(162, 'role174', 'comment174', 1),
(163, 'role175', 'comment175', 1),
(164, 'role176', 'comment176', 1),
(165, 'role177', 'comment177', 1),
(166, 'role178', 'comment178', 1),
(167, 'role179', 'comment179', 1),
(168, 'role200', 'comment200', 1),
(169, 'role201', 'comment201', 1),
(170, 'role202', 'comment202', 1),
(171, 'role203', 'comment203', 1),
(172, 'role204', 'comment204', 1),
(173, 'role205', 'comment205', 1),
(174, 'role206', 'comment206', 1),
(175, 'role207', 'comment207', 1),
(176, 'role208', 'comment208', 1),
(177, 'role209', 'comment209', 1),
(178, 'role210', 'comment210', 1),
(179, 'role211', 'comment211', 1),
(180, 'role212', 'comment212', 1),
(181, 'role213', 'comment213', 1),
(182, 'role214', 'comment214', 1),
(183, 'role215', 'comment215', 1),
(184, 'role216', 'comment216', 1),
(185, 'role217', 'comment217', 1),
(186, 'role218', 'comment218', 1),
(187, 'role219', 'comment219', 1),
(188, 'role220', 'comment220', 1),
(189, 'role221', 'comment221', 1),
(190, 'role222', 'comment222', 1),
(191, 'role223', 'comment223', 1),
(192, 'role224', 'comment224', 1),
(193, 'role225', 'comment225', 1),
(194, 'role226', 'comment226', 1),
(195, 'role227', 'comment227', 1),
(196, 'role228', 'comment228', 1),
(197, 'role229', 'comment229', 1),
(198, 'role230', 'comment230', 1),
(199, 'role231', 'comment231', 1),
(200, 'role232', 'comment232', 1),
(201, 'role233', 'comment233', 1),
(202, 'role234', 'comment234', 1),
(203, 'role235', 'comment235', 1),
(204, 'role236', 'comment236', 1),
(205, 'role237', 'comment237', 1),
(206, 'role238', 'comment238', 1),
(207, 'role239', 'comment239', 1),
(208, 'role240', 'comment240', 1),
(209, 'role241', 'comment241', 1),
(210, 'role242', 'comment242', 1),
(211, 'role243', 'comment243', 1),
(212, 'role244', 'comment244', 1),
(213, 'role245', 'comment245', 1),
(214, 'role246', 'comment246', 1),
(215, 'role247', 'comment247', 1),
(216, 'role248', 'comment248', 1),
(217, 'role249', 'comment249', 1),
(218, 'role250', 'comment250', 1),
(219, 'role251', 'comment251', 1),
(220, 'role252', 'comment252', 1),
(221, 'role253', 'comment253', 1),
(222, 'role254', 'comment254', 1),
(223, 'role255', 'comment255', 1),
(224, 'role256', 'comment256', 1),
(225, 'role257', 'comment257', 1),
(226, 'role258', 'comment258', 1),
(227, 'role259', 'comment259', 1),
(228, 'role260', 'comment260', 1),
(229, 'role261', 'comment261', 1),
(230, 'role262', 'comment262', 1),
(231, 'role263', 'comment263', 1),
(232, 'role264', 'comment264', 1),
(233, 'role265', 'comment265', 1),
(234, 'role266', 'comment266', 1),
(235, 'role267', 'comment267', 1),
(236, 'role268', 'comment268', 1),
(237, 'role269', 'comment269', 1),
(238, 'role270', 'comment270', 1),
(239, 'role271', 'comment271', 1),
(240, 'role272', 'comment272', 1),
(241, 'role273', 'comment273', 1),
(242, 'role274', 'comment274', 1),
(243, 'role275', 'comment275', 1),
(244, 'role276', 'comment276', 1),
(245, 'role277', 'comment277', 1),
(246, 'role278', 'comment278', 1),
(247, 'role279', 'comment279', 1),
(248, 'role280', 'comment280', 1),
(249, 'role281', 'comment281', 1),
(250, 'role282', 'comment282', 1),
(251, 'role283', 'comment283', 1),
(252, 'role284', 'comment284', 1),
(253, 'role285', 'comment285', 1),
(254, 'role286', 'comment286', 1),
(255, 'role287', 'comment287', 1),
(256, 'role288', 'comment288', 1),
(257, 'role289', 'comment289', 1),
(258, 'role290', 'comment290', 1),
(259, 'role291', 'comment291', 1),
(260, 'role292', 'comment292', 1),
(261, 'role293', 'comment293', 1),
(262, 'role294', 'comment294', 1),
(263, 'role295', 'comment295', 1),
(264, 'role296', 'comment296', 1),
(265, 'role297', 'comment297', 1),
(266, 'role298', 'comment298', 1),
(267, 'role299', 'comment299', 1),
(268, 'role300', 'comment300', 1),
(269, 'role301', 'comment301', 1),
(270, 'role302', 'comment302', 1),
(271, 'role303', 'comment303', 1),
(272, 'role304', 'comment304', 1),
(273, 'role305', 'comment305', 1),
(274, 'role306', 'comment306', 1),
(275, 'role307', 'comment307', 1),
(276, 'role308', 'comment308', 1),
(277, 'role309', 'comment309', 1),
(278, 'role310', 'comment310', 1),
(279, 'role311', 'comment311', 1),
(280, 'role312', 'comment312', 1),
(281, 'role313', 'comment313', 1),
(282, 'role314', 'comment314', 1),
(283, 'role315', 'comment315', 1),
(284, 'role316', 'comment316', 1),
(285, 'role317', 'comment317', 1),
(286, 'role318', 'comment318', 1),
(287, 'role319', 'comment319', 1),
(288, 'role320', 'comment320', 1),
(289, 'role321', 'comment321', 1),
(290, 'role322', 'comment322', 1),
(291, 'role323', 'comment323', 1),
(292, 'role324', 'comment324', 1),
(293, 'role325', 'comment325', 1),
(294, 'role326', 'comment326', 1),
(295, 'role327', 'comment327', 1),
(296, 'role328', 'comment328', 1),
(297, 'role329', 'comment329', 1),
(298, 'role330', 'comment330', 1),
(299, 'role331', 'comment331', 1),
(300, 'role332', 'comment332', 1),
(301, 'role333', 'comment333', 1),
(302, 'role334', 'comment334', 1),
(303, 'role335', 'comment335', 1),
(304, 'role336', 'comment336', 1),
(305, 'role337', 'comment337', 1),
(306, 'role338', 'comment338', 1),
(307, 'role339', 'comment339', 1),
(308, 'role340', 'comment340', 1),
(309, 'role341', 'comment341', 1),
(310, 'role342', 'comment342', 1),
(311, 'role343', 'comment343', 1),
(312, 'role344', 'comment344', 1),
(313, 'role345', 'comment345', 1),
(314, 'role346', 'comment346', 1),
(315, 'role347', 'comment347', 1),
(316, 'role348', 'comment348', 1);

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
  `registeration_date` date DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `user_id` bigint(11) NOT NULL,
  `username` varchar(10000) CHARACTER SET latin1 NOT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `surname` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `race` int(11) NOT NULL,
  `date_of_birth` date NOT NULL,
  `title` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `user_address`
--

CREATE TABLE `user_address` (
  `user_id` bigint(20) NOT NULL,
  `address_id` bigint(20) NOT NULL,
  `user_address_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

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
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`);

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
-- Indexes for table `user_address`
--
ALTER TABLE `user_address`
  ADD PRIMARY KEY (`user_address_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `address_id` (`address_id`);

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
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `group_roles`
--
ALTER TABLE `group_roles`
  MODIFY `role_group_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `log_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=317;
--
-- AUTO_INCREMENT for table `sensor_settings`
--
ALTER TABLE `sensor_settings`
  MODIFY `sensor_setting_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_address`
--
ALTER TABLE `user_address`
  MODIFY `user_address_id` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `user_group_id` bigint(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `user_role_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `user_address` (`address_id`);

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`);

--
-- Constraints for table `group_roles`
--
ALTER TABLE `group_roles`
  ADD CONSTRAINT `group_roles_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`),
  ADD CONSTRAINT `group_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

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
-- Constraints for table `user_address`
--
ALTER TABLE `user_address`
  ADD CONSTRAINT `user_address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

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
  ADD CONSTRAINT `user_groups_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`),
  ADD CONSTRAINT `user_groups_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
