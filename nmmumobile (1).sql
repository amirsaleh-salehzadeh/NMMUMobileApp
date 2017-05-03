-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 16, 2017 at 11:22 PM
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
(3, 'Rhodes'),
(4, 'amirtest');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `country_code` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `country_code`, `country_name`) VALUES
(1, 'AF', 'Afghanistan'),
(2, 'AL', 'Albania'),
(3, 'DZ', 'Algeria'),
(4, 'DS', 'American Samoa'),
(5, 'AD', 'Andorra'),
(6, 'AO', 'Angola'),
(7, 'AI', 'Anguilla'),
(8, 'AQ', 'Antarctica'),
(9, 'AG', 'Antigua and Barbuda'),
(10, 'AR', 'Argentina'),
(11, 'AM', 'Armenia'),
(12, 'AW', 'Aruba'),
(13, 'AU', 'Australia'),
(14, 'AT', 'Austria'),
(15, 'AZ', 'Azerbaijan'),
(16, 'BS', 'Bahamas'),
(17, 'BH', 'Bahrain'),
(18, 'BD', 'Bangladesh'),
(19, 'BB', 'Barbados'),
(20, 'BY', 'Belarus'),
(21, 'BE', 'Belgium'),
(22, 'BZ', 'Belize'),
(23, 'BJ', 'Benin'),
(24, 'BM', 'Bermuda'),
(25, 'BT', 'Bhutan'),
(26, 'BO', 'Bolivia'),
(27, 'BA', 'Bosnia and Herzegovina'),
(28, 'BW', 'Botswana'),
(29, 'BV', 'Bouvet Island'),
(30, 'BR', 'Brazil'),
(31, 'IO', 'British Indian Ocean Territory'),
(32, 'BN', 'Brunei Darussalam'),
(33, 'BG', 'Bulgaria'),
(34, 'BF', 'Burkina Faso'),
(35, 'BI', 'Burundi'),
(36, 'KH', 'Cambodia'),
(37, 'CM', 'Cameroon'),
(38, 'CA', 'Canada'),
(39, 'CV', 'Cape Verde'),
(40, 'KY', 'Cayman Islands'),
(41, 'CF', 'Central African Republic'),
(42, 'TD', 'Chad'),
(43, 'CL', 'Chile'),
(44, 'CN', 'China'),
(45, 'CX', 'Christmas Island'),
(46, 'CC', 'Cocos (Keeling) Islands'),
(47, 'CO', 'Colombia'),
(48, 'KM', 'Comoros'),
(49, 'CG', 'Congo'),
(50, 'CK', 'Cook Islands'),
(51, 'CR', 'Costa Rica'),
(52, 'HR', 'Croatia (Hrvatska)'),
(53, 'CU', 'Cuba'),
(54, 'CY', 'Cyprus'),
(55, 'CZ', 'Czech Republic'),
(56, 'DK', 'Denmark'),
(57, 'DJ', 'Djibouti'),
(58, 'DM', 'Dominica'),
(59, 'DO', 'Dominican Republic'),
(60, 'TP', 'East Timor'),
(61, 'EC', 'Ecuador'),
(62, 'EG', 'Egypt'),
(63, 'SV', 'El Salvador'),
(64, 'GQ', 'Equatorial Guinea'),
(65, 'ER', 'Eritrea'),
(66, 'EE', 'Estonia'),
(67, 'ET', 'Ethiopia'),
(68, 'FK', 'Falkland Islands (Malvinas)'),
(69, 'FO', 'Faroe Islands'),
(70, 'FJ', 'Fiji'),
(71, 'FI', 'Finland'),
(72, 'FR', 'France'),
(73, 'FX', 'France, Metropolitan'),
(74, 'GF', 'French Guiana'),
(75, 'PF', 'French Polynesia'),
(76, 'TF', 'French Southern Territories'),
(77, 'GA', 'Gabon'),
(78, 'GM', 'Gambia'),
(79, 'GE', 'Georgia'),
(80, 'DE', 'Germany'),
(81, 'GH', 'Ghana'),
(82, 'GI', 'Gibraltar'),
(83, 'GK', 'Guernsey'),
(84, 'GR', 'Greece'),
(85, 'GL', 'Greenland'),
(86, 'GD', 'Grenada'),
(87, 'GP', 'Guadeloupe'),
(88, 'GU', 'Guam'),
(89, 'GT', 'Guatemala'),
(90, 'GN', 'Guinea'),
(91, 'GW', 'Guinea-Bissau'),
(92, 'GY', 'Guyana'),
(93, 'HT', 'Haiti'),
(94, 'HM', 'Heard and Mc Donald Islands'),
(95, 'HN', 'Honduras'),
(96, 'HK', 'Hong Kong'),
(97, 'HU', 'Hungary'),
(98, 'IS', 'Iceland'),
(99, 'IN', 'India'),
(100, 'IM', 'Isle of Man'),
(101, 'ID', 'Indonesia'),
(102, 'IR', 'Iran (Islamic Republic of)'),
(103, 'IQ', 'Iraq'),
(104, 'IE', 'Ireland'),
(105, 'IL', 'Israel'),
(106, 'IT', 'Italy'),
(107, 'CI', 'Ivory Coast'),
(108, 'JE', 'Jersey'),
(109, 'JM', 'Jamaica'),
(110, 'JP', 'Japan'),
(111, 'JO', 'Jordan'),
(112, 'KZ', 'Kazakhstan'),
(113, 'KE', 'Kenya'),
(114, 'KI', 'Kiribati'),
(115, 'KP', 'Korea, Democratic People\'s Republic of'),
(116, 'KR', 'Korea, Republic of'),
(117, 'XK', 'Kosovo'),
(118, 'KW', 'Kuwait'),
(119, 'KG', 'Kyrgyzstan'),
(120, 'LA', 'Lao People\'s Democratic Republic'),
(121, 'LV', 'Latvia'),
(122, 'LB', 'Lebanon'),
(123, 'LS', 'Lesotho'),
(124, 'LR', 'Liberia'),
(125, 'LY', 'Libyan Arab Jamahiriya'),
(126, 'LI', 'Liechtenstein'),
(127, 'LT', 'Lithuania'),
(128, 'LU', 'Luxembourg'),
(129, 'MO', 'Macau'),
(130, 'MK', 'Macedonia'),
(131, 'MG', 'Madagascar'),
(132, 'MW', 'Malawi'),
(133, 'MY', 'Malaysia'),
(134, 'MV', 'Maldives'),
(135, 'ML', 'Mali'),
(136, 'MT', 'Malta'),
(137, 'MH', 'Marshall Islands'),
(138, 'MQ', 'Martinique'),
(139, 'MR', 'Mauritania'),
(140, 'MU', 'Mauritius'),
(141, 'TY', 'Mayotte'),
(142, 'MX', 'Mexico'),
(143, 'FM', 'Micronesia, Federated States of'),
(144, 'MD', 'Moldova, Republic of'),
(145, 'MC', 'Monaco'),
(146, 'MN', 'Mongolia'),
(147, 'ME', 'Montenegro'),
(148, 'MS', 'Montserrat'),
(149, 'MA', 'Morocco'),
(150, 'MZ', 'Mozambique'),
(151, 'MM', 'Myanmar'),
(152, 'NA', 'Namibia'),
(153, 'NR', 'Nauru'),
(154, 'NP', 'Nepal'),
(155, 'NL', 'Netherlands'),
(156, 'AN', 'Netherlands Antilles'),
(157, 'NC', 'New Caledonia'),
(158, 'NZ', 'New Zealand'),
(159, 'NI', 'Nicaragua'),
(160, 'NE', 'Niger'),
(161, 'NG', 'Nigeria'),
(162, 'NU', 'Niue'),
(163, 'NF', 'Norfolk Island'),
(164, 'MP', 'Northern Mariana Islands'),
(165, 'NO', 'Norway'),
(166, 'OM', 'Oman'),
(167, 'PK', 'Pakistan'),
(168, 'PW', 'Palau'),
(169, 'PS', 'Palestine'),
(170, 'PA', 'Panama'),
(171, 'PG', 'Papua New Guinea'),
(172, 'PY', 'Paraguay'),
(173, 'PE', 'Peru'),
(174, 'PH', 'Philippines'),
(175, 'PN', 'Pitcairn'),
(176, 'PL', 'Poland'),
(177, 'PT', 'Portugal'),
(178, 'PR', 'Puerto Rico'),
(179, 'QA', 'Qatar'),
(180, 'RE', 'Reunion'),
(181, 'RO', 'Romania'),
(182, 'RU', 'Russian Federation'),
(183, 'RW', 'Rwanda'),
(184, 'KN', 'Saint Kitts and Nevis'),
(185, 'LC', 'Saint Lucia'),
(186, 'VC', 'Saint Vincent and the Grenadines'),
(187, 'WS', 'Samoa'),
(188, 'SM', 'San Marino'),
(189, 'ST', 'Sao Tome and Principe'),
(190, 'SA', 'Saudi Arabia'),
(191, 'SN', 'Senegal'),
(192, 'RS', 'Serbia'),
(193, 'SC', 'Seychelles'),
(194, 'SL', 'Sierra Leone'),
(195, 'SG', 'Singapore'),
(196, 'SK', 'Slovakia'),
(197, 'SI', 'Slovenia'),
(198, 'SB', 'Solomon Islands'),
(199, 'SO', 'Somalia'),
(200, 'ZA', 'South Africa'),
(201, 'GS', 'South Georgia South Sandwich Islands'),
(202, 'ES', 'Spain'),
(203, 'LK', 'Sri Lanka'),
(204, 'SH', 'St. Helena'),
(205, 'PM', 'St. Pierre and Miquelon'),
(206, 'SD', 'Sudan'),
(207, 'SR', 'Suriname'),
(208, 'SJ', 'Svalbard and Jan Mayen Islands'),
(209, 'SZ', 'Swaziland'),
(210, 'SE', 'Sweden'),
(211, 'CH', 'Switzerland'),
(212, 'SY', 'Syrian Arab Republic'),
(213, 'TW', 'Taiwan'),
(214, 'TJ', 'Tajikistan'),
(215, 'TZ', 'Tanzania, United Republic of'),
(216, 'TH', 'Thailand'),
(217, 'TG', 'Togo'),
(218, 'TK', 'Tokelau'),
(219, 'TO', 'Tonga'),
(220, 'TT', 'Trinidad and Tobago'),
(221, 'TN', 'Tunisia'),
(222, 'TR', 'Turkey'),
(223, 'TM', 'Turkmenistan'),
(224, 'TC', 'Turks and Caicos Islands'),
(225, 'TV', 'Tuvalu'),
(226, 'UG', 'Uganda'),
(227, 'UA', 'Ukraine'),
(228, 'AE', 'United Arab Emirates'),
(229, 'GB', 'United Kingdom'),
(230, 'US', 'United States'),
(231, 'UM', 'United States minor outlying islands'),
(232, 'UY', 'Uruguay'),
(233, 'UZ', 'Uzbekistan'),
(234, 'VU', 'Vanuatu'),
(235, 'VA', 'Vatican City State'),
(236, 'VE', 'Venezuela'),
(237, 'VN', 'Vietnam'),
(238, 'VG', 'Virgin Islands (British)'),
(239, 'VI', 'Virgin Islands (U.S.)'),
(240, 'WF', 'Wallis and Futuna Islands'),
(241, 'EH', 'Western Sahara'),
(242, 'YE', 'Yemen'),
(243, 'ZR', 'Zaire'),
(244, 'ZM', 'Zambia'),
(245, 'ZW', 'Zimbabwe');

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
  `location_id` bigint(255) NOT NULL,
  `gps` varchar(200) NOT NULL,
  `location_name` varchar(2000) NOT NULL,
  `user_id` bigint(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`country`, `state`, `address`, `post_box`, `tel`, `fax`, `email`, `street`, `area`, `cell`, `location_id`, `gps`, `location_name`, `user_id`) VALUES
(5, 'state5', 'address5', 'pob5', 'tel5', 'fax5', 'email5', 'street5', 'area5', 'cell5', 3, 'gps5', 'NAME5', 5),
(6, 'state6', 'address6', 'pob6', 'tel6', 'fax6', 'email6', 'street6', 'area6', 'cell6', 4, 'gps6', 'NAME6', 6),
(7, 'state7', 'address7', 'pob7', 'tel7', 'fax7', 'email7', 'street7', 'area7', 'cell7', 5, 'gps7', 'NAME7', 7),
(8, 'state8', 'address8', 'pob8', 'tel8', 'fax8', 'email8', 'street8', 'area8', 'cell8', 6, 'gps8', 'NAME8', 8),
(9, 'state9', 'address9', 'pob9', 'tel9', 'fax9', 'email9', 'street9', 'area9', 'cell9', 7, 'gps9', 'NAME9', 9),
(10, 'state10', 'address10', 'pob10', 'tel10', 'fax10', 'email10', 'street10', 'area10', 'cell10', 8, 'gps10', 'NAME10', 10),
(11, 'state11', 'address11', 'pob11', 'tel11', 'fax11', 'email11', 'street11', 'area11', 'cell11', 9, 'gps11', 'NAME11', 11),
(12, 'state12', 'address12', 'pob12', 'tel12', 'fax12', 'email12', 'street12', 'area12', 'cell12', 10, 'gps12', 'NAME12', 12),
(13, 'state13', 'address13', 'pob13', 'tel13', 'fax13', 'email13', 'street13', 'area13', 'cell13', 11, 'gps13', 'NAME13', 13),
(3, 'state3', 'address3', 'pob3', 'tel3', 'fax3', 'email3', 'street3', 'area3', 'cell3', 34, 'gps3', 'NAME3', 5),
(4, 'state4', 'address4', 'pob4', 'tel4', 'fax4', 'email4', 'street4', 'area4', 'cell4', 35, 'gps4', 'NAME4', 5),
(5, 'state5', 'address5', 'pob5', 'tel5', 'fax5', 'email5', 'street5', 'area5', 'cell5', 36, 'gps5', 'NAME5', 5),
(6, 'state6', 'address6', 'pob6', 'tel6', 'fax6', 'email6', 'street6', 'area6', 'cell6', 37, 'gps6', 'NAME6', 5),
(7, 'state7', 'address7', 'pob7', 'tel7', 'fax7', 'email7', 'street7', 'area7', 'cell7', 38, 'gps7', 'NAME7', 5),
(8, 'state8', 'address8', 'pob8', 'tel8', 'fax8', 'email8', 'street8', 'area8', 'cell8', 39, 'gps8', 'NAME8', 5),
(9, 'state9', 'address9', 'pob9', 'tel9', 'fax9', 'email9', 'street9', 'area9', 'cell9', 40, 'gps9', 'NAME9', 5),
(10, 'state10', 'address10', 'pob10', 'tel10', 'fax10', 'email10', 'street10', 'area10', 'cell10', 41, 'gps10', 'NAME10', 5),
(11, 'state11', 'address11', 'pob11', 'tel11', 'fax11', 'email11', 'street11', 'area11', 'cell11', 42, 'gps11', 'NAME11', 5),
(12, 'state12', 'address12', 'pob12', 'tel12', 'fax12', 'email12', 'street12', 'area12', 'cell12', 43, 'gps12', 'NAME12', 5),
(13, 'state13', 'address13', 'pob13', 'tel13', 'fax13', 'email13', 'street13', 'area13', 'cell13', 44, 'gps13', 'NAME13', 5);

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
(502, 'roleeddde3', 'commeneeet3', 3),
(503, 'roleeddde4', 'commeneeet4', 3),
(504, 'roleeddde5', 'commeneeet5', 3),
(505, 'roleeddde6', 'commeneeet6', 3),
(506, 'roleeddde7', 'commeneeet7', 3),
(507, 'roleeddde8', 'commeneeet8', 3),
(508, 'roleeddde9', 'commeneeet9', 3),
(516, 'roleeddde17', 'commeneeet17', 3),
(521, 'roleeddde22', 'commeneeet22', 3),
(525, 'roleeddde26', 'commeneeet26', 3),
(526, 'roleeddde27', 'commeneeet27', 3),
(527, 'roleeddde28', 'commeneeet28', 3),
(529, 'roleeddde30', 'commeneeet30', 3),
(531, 'roleeddde32', 'commeneeet32', 3),
(532, 'roleeddde33', 'commeneeet33', 3),
(533, 'roleeddde34', 'commeneeet34', 3),
(534, 'roleeddde35', 'commeneeet35', 3),
(535, 'roleeddde36', 'commeneeet36', 3),
(536, 'roleeddde37', 'commeneeet37', 3),
(537, 'roleeddde38', 'commeneeet38', 3),
(538, 'roleeddde39', 'commeneeet39', 3),
(539, 'roleeddde40', 'commeneeet40', 3),
(540, 'roleeddde41', 'commeneeet41', 3),
(541, 'roleeddde42', 'commeneeet42', 3),
(542, 'roleeddde43', 'commeneeet43', 3),
(543, 'roleeddde44', 'commeneeet44', 3),
(544, 'roleeddde45', 'commeneeet45', 3),
(545, 'roleeddde46', 'commeneeet46', 3),
(546, 'roleeddde47', 'commeneeet47', 3),
(547, 'roleeddde48', 'commeneeet48', 3),
(548, 'roleeddde49', 'commeneeet49', 3),
(549, 'roleeddde50', 'commeneeet50', 3),
(550, 'roleeddde51', 'commeneeet51', 3),
(551, 'roleeddde52', 'commeneeet52', 3),
(552, 'roleeddde53', 'commeneeet53', 3),
(553, 'roleeddde54', 'commeneeet54', 3),
(554, 'roleeddde55', 'commeneeet55', 3),
(555, 'roleeddde56', 'commeneeet56', 3),
(556, 'roleeddde57', 'commeneeet57', 3),
(557, 'roleeddde58', 'commeneeet58', 3),
(558, 'roleeddde59', 'commeneeet59', 3),
(559, 'roleeddde60', 'commeneeet60', 3),
(560, 'roleeddde61', 'commeneeet61', 3),
(561, 'roleeddde62', 'commeneeet62', 3),
(562, 'roleeddde63', 'commeneeet63', 3),
(563, 'roleeddde64', 'commeneeet64', 3),
(564, 'roleeddde65', 'commeneeet65', 3),
(565, 'roleeddde66', 'commeneeet66', 3),
(566, 'roleeddde67', 'commeneeet67', 3),
(567, 'roleeddde68', 'commeneeet68', 3),
(568, 'roleeddde69', 'commeneeet69', 3),
(569, 'roleeddde70', 'commeneeet70', 3),
(570, 'roleeddde71', 'commeneeet71', 3),
(571, 'roleeddde72', 'commeneeet72', 3),
(572, 'roleeddde73', 'commeneeet73', 3),
(573, 'roleeddde74', 'commeneeet74', 3),
(574, 'roleeddde75', 'commeneeet75', 3);

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
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `version`
--

CREATE TABLE `version` (
  `version_id` int(11) NOT NULL,
  `version` text NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Explanation` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `version`
--

INSERT INTO `version` (`version_id`, `version`, `date`, `Explanation`) VALUES
(1, '0.0.0.0', '2017-04-15 11:54:08', 'Setup'),
(2, '0.0.0.0', '2017-04-15 11:54:14', 'Setup');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `user_id_2` (`user_id`);

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
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_role_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `version`
--
ALTER TABLE `version`
  ADD PRIMARY KEY (`version_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;
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
  MODIFY `location_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
--
-- AUTO_INCREMENT for table `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `log_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=575;
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
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `user_role_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `version`
--
ALTER TABLE `version`
  MODIFY `version_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
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
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

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
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
