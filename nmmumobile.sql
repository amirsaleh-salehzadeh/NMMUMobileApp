-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 06, 2017 at 11:11 AM
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
-- Table structure for table `calendar_date`
--

CREATE TABLE `calendar_date` (
  `date_id` int(11) NOT NULL,
  `day_date` varchar(10) NOT NULL
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
(1, 'System Admin'),
(2, 'UCT'),
(3, 'Rhodes'),
(4, 'NMMU');

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
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` bigint(255) NOT NULL,
  `event_title` varchar(10000) NOT NULL,
  `description` text NOT NULL,
  `start_time` int(11) NOT NULL,
  `end_time` varchar(8) NOT NULL,
  `status` int(11) NOT NULL,
  `creator_username` varchar(22) NOT NULL,
  `price` int(11) NOT NULL,
  `venue_id` bigint(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `events_attendance`
--

CREATE TABLE `events_attendance` (
  `events_id` bigint(255) NOT NULL,
  `username` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `events_categories`
--

CREATE TABLE `events_categories` (
  `event_id` bigint(255) NOT NULL,
  `category_id` bigint(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `events_category`
--

CREATE TABLE `events_category` (
  `category_id` bigint(255) NOT NULL,
  `title` varchar(100) NOT NULL,
  `parent_id` bigint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `events_hash_tag`
--

CREATE TABLE `events_hash_tag` (
  `event_id` bigint(255) NOT NULL,
  `event_hash_tag_id` bigint(255) NOT NULL,
  `hash_tag_id` bigint(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(1, 'Developer', 'IT Team > developers', 1);

-- --------------------------------------------------------

--
-- Table structure for table `group_roles`
--

CREATE TABLE `group_roles` (
  `role_name` varchar(22) NOT NULL,
  `group_id` int(11) NOT NULL,
  `role_group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `group_roles`
--

INSERT INTO `group_roles` (`role_name`, `group_id`, `role_group_id`) VALUES
('AcitvateUser', 1, 1),
('EditUser', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `hash_tag`
--

CREATE TABLE `hash_tag` (
  `hash_tag_id` bigint(255) NOT NULL,
  `hash_tag` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `country` int(11) NOT NULL,
  `address` varchar(2000) NOT NULL,
  `post_box` varchar(2000) CHARACTER SET latin1 NOT NULL,
  `location_id` bigint(255) NOT NULL,
  `gps` varchar(200) NOT NULL,
  `location_name` varchar(2000) NOT NULL,
  `username` varchar(22) NOT NULL,
  `location_type` int(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`country`, `address`, `post_box`, `location_id`, `gps`, `location_name`, `username`, `location_type`) VALUES
(200, 'N/A', '', 1, '-33.99835602238611, 25.670130662620068', 'University Way, Northern Enterance', 'admin', 1),
(200, 'N/A', '', 2, '-34.000013894781844, 25.669821705669165', 'University Way, Square', 'admin', 1),
(200, 'N/A', '', 3, '-34.000651680582685, 25.669873170554638', 'North Campus, Bus Stop', 'admin', 3),
(200, 'N/A', '', 4, '-34.0004856012282, 25.669853892177343', 'University Way', 'admin', 1),
(200, 'N/A', '', 5, '-34.00048245652722, 25.66965540871024', 'University Way', 'admin', 1),
(200, 'N/A', '', 6, '-34.001032777424264, 25.66994508728385', 'North Campus', 'admin', 1),
(200, 'N/A', '', 7, '-34.00246045044264, 25.66993435844779', 'North Campus', 'admin', 1),
(200, 'N/A', '', 8, '-34.002724598766854, 25.669894125312567', 'North Campus', 'admin', 1),
(200, 'N/A', '', 9, '-34.002730888002645, 25.66967686638236', 'North Campus', 'admin', 1),
(200, 'N/A', '', 10, '-34.003350375447084, 25.669722463935614', 'North Campus, Bus Stop', 'admin', 3),
(200, 'N/A', '', 11, '-34.00335911951666, 25.669464971870184', 'North Campus, ABSA Bank', 'admin', 7),
(200, 'N/A', '', 12, '-34.003825207941986, 25.6697197817266', 'North Campus', 'admin', 1),
(200, 'N/A', '', 13, '-34.005004416231465, 25.669888760894537', 'South Campus', 'admin', 1),
(200, 'N/A', '', 14, '-34.00501699436495, 25.66977074369788', 'South Campus', 'admin', 1),
(200, 'N/A', '', 15, '-34.00510189671737, 25.669741239398718', 'South Campus', 'admin', 1),
(200, 'N/A', '', 16, '-34.00506730688033, 25.6696661375463', 'South Campus', 'admin', 1),
(200, 'N/A', '', 17, '-34.00485033394487, 25.669738557189703', 'South Campus', 'admin', 1),
(200, 'N/A', '', 18, '-34.00538804846523, 25.669891443103552', 'South Campus', 'admin', 1),
(200, 'N/A', '', 19, '-34.005410060098185, 25.669757332652807', 'South Campus', 'admin', 1),
(200, 'N/A', '', 20, '-34.005661621212745, 25.669735874980688', 'South Campus', 'admin', 1),
(200, 'N/A', '', 21, '-34.005658476703424, 25.669625904411077', 'South Campus', 'admin', 1),
(200, 'N/A', '', 22, '-34.00596349356661, 25.66960444673896', 'South Campus', 'admin', 1),
(200, 'N/A', '', 23, '-34.00624020894837, 25.669937040656805', 'South Campus', 'admin', 10),
(200, 'N/A', '', 24, '-34.005255978547574, 25.66978683695197', 'South Campus', 'admin', 10),
(200, 'N/A', '', 25, '-34.00666156927518, 25.669886078685522', 'South Campus', 'admin', 1),
(200, 'N/A', '', 26, '-34.00659867980688, 25.669615175575018', 'South Campus', 'admin', 1),
(200, 'N/A', '', 27, '-34.00703576064852, 25.669684913009405', 'South Campus', 'admin', 1),
(200, 'N/A', '', 28, '-34.00718983897008, 25.66955080255866', 'South Campus', 'admin', 1),
(200, 'N/A', '', 29, '-34.0073093280882, 25.66982438787818', 'South Campus', 'admin', 1),
(200, 'N/A', '', 30, '-34.00760805014798, 25.66891511902213', 'South Campus', 'admin', 1),
(200, 'N/A', '', 31, '-34.007661505563604, 25.669247712939978', 'South Campus', 'admin', 1),
(200, 'N/A', '', 32, '-34.00832812321473, 25.669261123985052', 'South Campus', 'admin', 1),
(200, 'N/A', '', 33, '-34.00833441203558, 25.668850746005774', 'South Campus', 'admin', 1),
(200, 'N/A', '', 34, '-34.008308629004055, 25.669616188938676', 'South Campus', 'admin', 1),
(200, 'N/A', '', 35, '-34.008424247520736, 25.669790676891466', 'South Campus', 'admin', 1),
(200, 'N/A', '', 36, '-34.0082330321965, 25.668842372799986', 'South Campus', 'admin', 1),
(200, 'N/A', '', 37, '-34.008313075873, 25.67008654776805', 'South Campus', 'admin', 1),
(200, 'N/A', '', 38, '-34.008339757081714, 25.670496215135586', 'South Campus', 'admin', 1),
(200, 'N/A', '', 39, '-34.00829751183069, 25.67095898753223', 'South Campus', 'admin', 1),
(200, 'N/A', '', 40, '-34.00829528839585, 25.671220719461417', 'South Campus', 'admin', 1),
(200, 'N/A', '', 41, '-34.00852622084773, 25.671296920627356', 'South Campus', 'admin', 1),
(200, 'N/A', '', 42, '-34.008343845265976, 25.671629514545202', 'South Campus', 'admin', 1),
(200, 'N/A', '', 43, '-34.00902303510083, 25.67157855257392', 'South Campus', 'admin', 1),
(200, 'N/A', '', 44, '-34.00902303510083, 25.67216595634818', 'South Campus', 'admin', 1),
(200, 'N/A', '', 45, '-34.00901674633096, 25.67260315641761', 'South Campus', 'admin', 1),
(200, 'N/A', '', 46, '-34.009123655355104, 25.672742631286383', 'South Campus', 'admin', 1),
(200, 'N/A', '', 47, '-34.00951041334746, 25.672737266868353', 'South Campus', 'admin', 1),
(200, 'N/A', '', 48, '-34.00960788866113, 25.672632660716772', 'South Campus', 'admin', 1),
(200, 'N/A', '', 49, '-34.009598455571144, 25.672305431216955', 'South Campus', 'admin', 1),
(200, 'N/A', '', 50, '-34.00942551540247, 25.672085490077734', 'South Campus', 'admin', 1),
(200, 'N/A', '', 51, '-34.00946639220142, 25.671691205352545', 'South Campus', 'admin', 1),
(200, 'N/A', '', 52, '-34.00960474429791, 25.671538319438696', 'South Campus', 'admin', 1),
(200, 'N/A', '', 53, '-34.00961103302421, 25.67134251818061', 'South Campus', 'admin', 1),
(200, 'N/A', '', 54, '-34.010044954014354, 25.672053303569555', 'South Campus', 'admin', 1),
(200, 'N/A', '', 55, '-34.00986887040166, 25.67254414781928', 'South Campus', 'admin', 1),
(200, 'N/A', '', 56, '-34.00988144781466, 25.672635342925787', 'South Campus', 'admin', 1),
(200, 'N/A', '', 57, '-34.00996948965364, 25.672871377319098', 'South Campus', 'admin', 1),
(200, 'N/A', '', 58, '-34.01011412961945, 25.672863330692053', 'South Campus', 'admin', 1),
(200, 'N/A', '', 59, '-34.010035520972956, 25.67253878340125', 'South Campus', 'admin', 1),
(200, 'N/A', '', 60, '-34.01021474858081, 25.67205598577857', 'South Campus', 'admin', 1),
(200, 'N/A', '', 61, '-34.010211604240084, 25.672879423946142', 'South Campus', 'admin', 1),
(200, 'N/A', '', 62, '-34.0102556249998, 25.672495868057013', 'South Campus', 'admin', 1),
(200, 'N/A', '', 63, '-34.01023990330252, 25.672249104827642', 'South Campus', 'admin', 1),
(200, 'N/A', '', 64, '-34.01021474858081, 25.672729220241308', 'South Campus', 'admin', 1),
(200, 'N/A', '', 65, '-34.01018959385164, 25.67355265840888', 'South Campus', 'admin', 1),
(200, 'N/A', '', 66, '-34.00984057121554, 25.673466827720404', 'South Campus', 'admin', 1),
(200, 'N/A', '', 67, '-34.009482114041916, 25.673386361449957', 'South Campus', 'admin', 1),
(200, 'N/A', '', 68, '-34.00959216684392, 25.67343195900321', 'South Campus', 'admin', 1),
(200, 'N/A', '', 69, '-34.01013182574312, 25.674748923629522', 'South Campus', 'admin', 1),
(200, 'N/A', '', 70, '-34.01013555046302, 25.67604225128889', 'South Campus', 'admin', 1),
(200, 'N/A', '', 71, '-34.010177016484285, 25.677704717963934', 'South Campus', 'admin', 1),
(200, 'N/A', '', 72, '-34.01017387214214, 25.677243378013372', 'South Campus', 'admin', 1),
(200, 'N/A', '', 73, '-34.01016129477245, 25.676613058894873', 'South Campus', 'admin', 1),
(200, 'N/A', '', 74, '-34.01060779025607, 25.67856838926673', 'South Campus', 'admin', 1),
(200, 'N/A', '', 75, '-34.01062351188523, 25.679059233516455', 'South Campus', 'admin', 1),
(200, 'N/A', '', 76, '-34.0101833051682, 25.679115559905767', 'South Campus', 'admin', 1),
(200, 'N/A', '', 77, '-34.00947896967404, 25.677814688533545', 'South Campus', 'admin', 1),
(200, 'N/A', '', 78, '-34.00941922666243, 25.677530374377966', 'South Campus', 'admin', 1),
(200, 'N/A', '', 79, '-34.00794764868695, 25.677602794021368', 'South Campus', 'admin', 1),
(200, 'N/A', '', 80, '-34.006840804004256, 25.67763766273856', 'South Campus', 'admin', 1),
(200, 'N/A', '', 81, '-34.00601380552126, 25.677179004997015', 'South Campus', 'admin', 1),
(200, 'N/A', '', 82, '-34.00571448825847, 25.677217058837414', 'South Campus', 'admin', 1),
(200, 'N/A', '', 83, '-34.00534402518215, 25.677010025829077', 'South Campus', 'admin', 1),
(200, 'N/A', '', 84, '-34.00465851683014, 25.676285829395056', 'South Campus', 'admin', 1),
(200, 'N/A', '', 85, '-34.00410507485778, 25.676081981509924', 'South Campus', 'admin', 1),
(200, 'N/A', '', 86, '-34.0037717501116, 25.67528000101447', 'South Campus', 'admin', 1),
(200, 'N/A', '', 87, '-34.00450128936384, 25.675505306571722', 'South Campus', 'admin', 1),
(200, 'N/A', '', 88, '-34.00468052865221, 25.67391475662589', 'South Campus', 'admin', 1),
(200, 'N/A', '', 89, '-34.00399815951566, 25.67439755424857', 'South Campus', 'admin', 1),
(200, 'N/A', '', 90, '-34.00274346647288, 25.673735048621893', 'South Campus', 'admin', 1),
(200, 'N/A', '', 91, '-34.00570564433119, 25.67381551489234', 'South Campus', 'admin', 1),
(200, 'N/A', '', 92, '-34.00590374808174, 25.673110093921423', 'South Campus', 'admin', 1),
(200, 'N/A', '', 93, '-34.00599808303864, 25.67303767427802', 'South Campus', 'admin', 1),
(200, 'N/A', '', 94, '-34.00652635686079, 25.67306449636817', 'South Campus', 'admin', 1),
(200, 'N/A', '', 95, '-34.00723700574731, 25.67265948280692', 'South Campus', 'admin', 1),
(200, 'N/A', '', 96, '-34.00777784958721, 25.67265411838889', 'South Campus', 'admin', 1),
(200, 'N/A', '', 97, '-34.008126880701674, 25.67270239815116', 'South Campus', 'admin', 1),
(200, 'N/A', '', 98, '-34.00778099401808, 25.67315300926566', 'South Campus', 'admin', 1),
(200, 'N/A', '', 99, '-34.00834698967586, 25.672337617725134', 'South Campus', 'admin', 1),
(200, 'N/A', '', 100, '-34.008406733441845, 25.672683622688055', 'South Campus', 'admin', 1),
(200, 'N/A', '', 101, '-34.00901674633096, 25.671170856803656', 'South Campus', 'admin', 1),
(200, 'N/A', '', 102, '-34.00888153766656, 25.671125259250402', 'South Campus', 'admin', 1),
(200, 'N/A', '', 103, '-34.00874003999646, 25.670961644500494', 'South Campus', 'admin', 1),
(200, 'N/A', '', 104, '-34.00873060681011, 25.670688059180975', 'South Campus', 'admin', 1),
(200, 'N/A', '', 105, '-34.00888782644641, 25.670484211295843', 'South Campus', 'admin', 1),
(200, 'N/A', '', 106, '-34.008727462414406, 25.670492257922888', 'South Campus', 'admin', 1),
(200, 'N/A', '', 107, '-34.00903246825474, 25.670484211295843', 'South Campus', 'admin', 1),
(200, 'N/A', '', 108, '-34.00914881040003, 25.670492257922888', 'South Campus', 'admin', 1),
(200, 'N/A', '', 109, '-34.009318606758406, 25.670956280082464', 'South Campus', 'admin', 1),
(200, 'N/A', '', 110, '-34.01022732594261, 25.671734120696783', 'South Campus', 'admin', 1),
(200, 'N/A', '', 111, '-34.01022103726196, 25.67135324701667', 'South Campus', 'admin', 1),
(200, 'N/A', '', 112, '-34.01022103726196, 25.67103674635291', 'South Campus', 'admin', 1),
(200, 'N/A', '', 113, '-34.01023990330252, 25.67064782604575', 'South Campus', 'admin', 1),
(200, 'N/A', '', 114, '-34.01023047028275, 25.6702964566648', 'South Campus', 'admin', 1),
(200, 'N/A', '', 115, '-34.01016443911503, 25.66996654495597', 'South Campus', 'admin', 1),
(200, 'N/A', '', 116, '-34.010177016484285, 25.669743921607733', 'South Campus', 'admin', 1),
(200, 'N/A', '', 117, '-34.009906602635105, 25.66969832405448', 'South Campus', 'admin', 1),
(200, 'N/A', '', 118, '-34.00970536386288, 25.66943546757102', 'South Campus', 'admin', 1),
(200, 'N/A', '', 119, '-34.01018016082629, 25.669497158378363', 'South Campus', 'admin', 1),
(200, 'N/A', '', 120, '-34.010148717400874, 25.669253077358007', 'South Campus', 'admin', 1),
(200, 'N/A', '', 121, '-34.00965505409529, 25.669274535030127', 'South Campus', 'admin', 1),
(200, 'N/A', '', 122, '-34.01016129477245, 25.66871663555503', 'South Campus', 'admin', 1),
(200, 'N/A', '', 123, '-34.00928716301396, 25.669497158378363', 'South Campus', 'admin', 1),
(200, 'N/A', '', 124, '-34.00877148394355, 25.669494476169348', 'South Campus', 'admin', 1),
(200, 'N/A', '', 125, '-34.009015678239926, 25.67013965279716', 'South Campus', 'admin', 1),
(200, 'N/A', '', 126, '-34.00932695591127, 25.67062139127563', 'South Campus', 'admin', 1),
(200, 'N/A', '', 127, '-34.00966491323392, 25.670780706363075', 'South Campus', 'admin', 1),
(200, 'N/A', '', 128, '-34.00988502945099, 25.67080725887763', 'South Campus', 'admin', 1),
(200, 'N/A', '', 129, '-34.009896146416516, 25.671391414197956', 'South Campus', 'admin', 1),
(200, 'N/A', '', 130, '-34.00926247705876, 25.671376241332496', 'South Campus', 'admin', 1),
(200, 'N/A', '', 131, '-34.00915130650843, 25.673405612088345', 'South Campus', 'admin', 1),
(200, 'N/A', '', 132, '-34.008991220660256, 25.673906316648527', 'South Campus', 'admin', 1),
(200, 'N/A', '', 133, '-34.00889561369031, 25.673401818871866', 'South Campus', 'admin', 1),
(200, 'N/A', '', 134, '-34.00876220843609, 25.67414149606327', 'South Campus', 'admin', 1),
(200, 'N/A', '', 135, '-34.00885114529552, 25.67476737676361', 'South Campus', 'admin', 1),
(200, 'N/A', '', 136, '-34.00875553816788, 25.674315984016175', 'South Campus', 'admin', 1),
(200, 'N/A', '', 137, '-34.00934029635741, 25.674281845068776', 'South Campus', 'admin', 1),
(200, 'N/A', '', 138, '-34.00916020015781, 25.673974594543097', 'South Campus', 'admin', 1),
(200, 'N/A', '', 139, '-34.009611551640816, 25.673640791502976', 'South Campus', 'admin', 1),
(200, 'N/A', '', 140, '-34.00934474317232, 25.674054252086876', 'South Campus', 'admin', 1),
(200, 'N/A', '', 141, '-34.00950482835401, 25.673822865888496', 'South Campus', 'admin', 1),
(200, 'N/A', '', 142, '-34.00961822184179, 25.67384941840305', 'South Campus', 'admin', 1),
(200, 'N/A', '', 143, '-34.00959154103476, 25.67426667220343', 'South Campus', 'admin', 1),
(200, 'N/A', '', 144, '-34.009173540630144, 25.67459288881082', 'South Campus', 'admin', 1),
(200, 'N/A', '', 145, '-34.008848921875185, 25.675173250914895', 'South Campus', 'admin', 1),
(200, 'N/A', '', 146, '-34.00885336871582, 25.67493807150015', 'South Campus', 'admin', 1),
(200, 'N/A', '', 147, '-34.00922023226678, 25.67499876296199', 'South Campus', 'admin', 1),
(200, 'N/A', '', 148, '-34.009364753836536, 25.67523014916037', 'South Campus', 'admin', 1),
(200, 'N/A', '', 149, '-34.00891340104171, 25.675507053955016', 'South Campus', 'admin', 1),
(200, 'N/A', '', 150, '-34.00908460410837, 25.675643609744156', 'South Campus', 'admin', 1),
(200, 'N/A', '', 151, '-34.00904680605841, 25.676167073602755', 'South Campus', 'admin', 1),
(200, 'N/A', '', 152, '-34.008935635225704, 25.67617086681912', 'South Campus', 'admin', 1),
(200, 'N/A', '', 153, '-34.00919132792332, 25.676167073602755', 'South Campus', 'admin', 1),
(200, 'N/A', '', 154, '-34.009129072380894, 25.676288456526436', 'South Campus', 'admin', 1),
(200, 'N/A', '', 155, '-34.00898455041003, 25.67626949044461', 'South Campus', 'admin', 1),
(200, 'N/A', '', 156, '-34.00898010357626, 25.676633639215652', 'South Campus', 'admin', 1),
(200, 'N/A', '', 157, '-34.009137966032604, 25.676633639215652', 'South Campus', 'admin', 1),
(200, 'N/A', '', 158, '-34.008833357931096, 25.676762608572176', 'South Campus', 'admin', 1),
(200, 'N/A', '', 159, '-34.00883113451028, 25.67695606260679', 'South Campus', 'admin', 1),
(200, 'N/A', '', 160, '-34.00886670923635, 25.677001581203285', 'South Campus', 'admin', 1),
(200, 'N/A', '', 161, '-34.00891340104171, 25.677054686232395', 'South Campus', 'admin', 1),
(200, 'N/A', '', 162, '-34.00918465768881, 25.67705847944876', 'South Campus', 'admin', 1),
(200, 'N/A', '', 163, '-34.009278040924194, 25.676732262841256', 'South Campus', 'admin', 1),
(200, 'N/A', '', 164, '-34.009302498421256, 25.676899164361316', 'South Campus', 'admin', 1),
(200, 'N/A', '', 165, '-34.009244689780495, 25.676971235472365', 'South Campus', 'admin', 1),
(200, 'N/A', '', 166, '-34.008835581351846, 25.67737710962342', 'South Campus', 'admin', 1),
(200, 'N/A', '', 167, '-34.00935141339425, 25.67714193020879', 'South Campus', 'admin', 1),
(200, 'N/A', '', 168, '-34.00939365812097, 25.671106922970466', 'South Campus', 'admin', 1),
(200, 'N/A', '', 169, '-34.009784976695784, 25.671376241332496', 'South Campus', 'admin', 1),
(200, 'N/A', '', 170, '-34.009530458683216, 25.670483205467463', 'South Campus', 'admin', 1),
(200, 'N/A', '', 171, '-34.009329219019556, 25.66929766908288', 'South Campus', 'admin', 1),
(200, 'N/A', '', 172, '-34.00931664152473, 25.668702218681574', 'South Campus', 'admin', 1),
(200, 'N/A', '', 173, '-34.009558757972655, 25.66871026530862', 'South Campus', 'admin', 1),
(200, 'N/A', '', 174, '-34.0095650467024, 25.667913649231195', 'South Campus', 'admin', 1),
(200, 'N/A', '', 175, '-34.009247465269965, 25.66829452291131', 'South Campus', 'admin', 1),
(200, 'N/A', '', 176, '-34.00933550776625, 25.668004844337702', 'South Campus', 'admin', 1),
(200, 'N/A', '', 177, '-34.009165711441675, 25.66807458177209', 'South Campus', 'admin', 1),
(200, 'N/A', '', 178, '-34.00909339068177, 25.667556915432215', 'South Campus', 'admin', 1),
(200, 'N/A', '', 179, '-34.008561988426656, 25.667626652866602', 'South Campus', 'admin', 1),
(200, 'N/A', '', 180, '-34.008351313239274, 25.6673021055758', 'South Campus', 'admin', 1),
(200, 'N/A', '', 181, '-34.008244403242834, 25.66765883937478', 'South Campus', 'admin', 1),
(200, 'N/A', '', 182, '-34.0080620270558, 25.66744426265359', 'South Campus', 'admin', 1),
(200, 'N/A', '', 183, '-34.00761866262286, 25.666931960731745', 'South Campus', 'admin', 1),
(200, 'N/A', '', 184, '-34.008024294002716, 25.666948053985834', 'South Campus', 'admin', 1),
(200, 'N/A', '', 185, '-34.007901661464295, 25.666948053985834', 'South Campus', 'admin', 1),
(200, 'N/A', '', 186, '-34.007885939331175, 25.667272601276636', 'South Campus', 'admin', 1),
(200, 'N/A', '', 187, '-34.00744257397889, 25.666931960731745', 'South Campus', 'admin', 1),
(200, 'N/A', '', 188, '-34.007052662110716, 25.666548404842615', 'South Campus', 'admin', 1),
(200, 'N/A', '', 189, '-34.00866143007791, 25.667893197387457', 'South Campus', 'admin', 1),
(200, 'N/A', '', 190, '-34.00867086327199, 25.668703224509954', 'South Campus', 'admin', 1),
(200, 'N/A', '', 191, '-34.0086732714835, 25.669381823390722', 'South Campus', 'admin', 1),
(200, 'N/A', '', 192, '-34.00855987673387, 25.669400598853827', 'South Campus', 'admin', 1),
(200, 'N/A', '', 193, '-34.00855987673387, 25.669789519160986', 'South Campus', 'admin', 1),
(200, 'N/A', '', 194, '-34.009015678239926, 25.669558849185705', 'South Campus', 'admin', 1),
(200, 'N/A', '', 195, '-34.00901366326914, 25.669880462810397', 'South Campus', 'admin', 1),
(200, 'N/A', '', 196, '-34.008339757081714, 25.66819628700614', 'South Campus', 'admin', 1),
(200, 'N/A', '', 197, '-34.00863992010227, 25.66819628700614', 'South Campus', 'admin', 1),
(200, 'N/A', '', 198, '-34.00915509916009, 25.671149399131536', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 199, '-34.00851364323398, 25.670446660369635', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 200, '-34.00837843376848, 25.670304503291845', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 201, '-34.00583004882377, 25.67001599818468', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 202, '-34.00580430320124, 25.673103723675013', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 203, '-34.00586719325781, 25.67255923524499', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 204, '-34.008299823515145, 25.667657162994146', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 205, '-34.00899788001863, 25.66945692524314', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 206, '-34.00899473563282, 25.673378314822912', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 207, '-34.00934251976489, 25.67335250705912', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 208, '-34.008966763073545, 25.672874561797016', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 209, '-34.00870217600331, 25.6730945683463', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 210, '-34.0087132931237, 25.67341319852096', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 211, '-34.00867994175818, 25.67383424553759', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 212, '-34.008862262396406, 25.673959421677637', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 213, '-34.00948704112651, 25.669502392447725', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 214, '-34.008464269278285, 25.66867167806356', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 215, '-34.008479833290025, 25.66800786519957', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 216, '-34.00814854156725, 25.668030624497646', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 217, '-34.008159658760114, 25.668618573034337', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 218, '-34.0089915912469, 25.677618887275457', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 219, '-34.00866882463343, 25.66973051056266', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 220, '-34.00865346910248, 25.66985229961574', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 221, '-34.00855897346626, 25.669828159734607', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 222, '-34.00856564374992, 25.669366819784045', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 223, '-34.00869237903977, 25.66935340873897', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 224, '-34.008996536015516, 25.669251359067857', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 225, '-34.009887736520454, 25.667305290699005', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 226, '-34.00981227202, 25.6677183508873', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 227, '-34.009400360439535, 25.66769689321518', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 228, '-34.0086575772284, 25.669323652982712', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 229, '-34.00866841208385, 25.669342763721943', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 230, '-34.001958818473454, 25.673224925994873', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 231, '-34.00096742700432, 25.673235654830933', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 232, '-34.00057429157478, 25.673954486846924', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 233, '-33.998836825616316, 25.672935247421265', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 234, '-33.9994328078023, 25.67328929901123', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 235, '-34.00063718550403, 25.673230290412903', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 236, '-34.00032900480569, 25.67319005727768', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 237, '-33.9996466498454, 25.6727796792984', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 238, '-33.99887304225828, 25.67227005958557', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 239, '-33.99866548780457, 25.670435428619385', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 240, '-33.99935271838969, 25.673493146896362', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 241, '-34.00593588093821, 25.6670880317688', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 242, '-34.00709928851076, 25.66706657409668', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 243, '-34.005917013941406, 25.66658914089203', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 244, '-34.005898146940396, 25.665763020515442', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 245, '-34.0070741328587, 25.665741562843323', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 246, '-34.007772199437724, 25.66616803407669', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 247, '-34.00803004239861, 25.66632628440857', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 248, '-34.008070919869276, 25.665902495384216', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 249, '-34.008070919869276, 25.665749609470367', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 250, '-34.008891583742994, 25.666248583302718', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 251, '-34.00922509597746, 25.666237203653623', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 252, '-34.009349606875865, 25.666381345875607', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 253, '-34.00934293665379, 25.666571006693857', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 254, '-34.008787082973356, 25.666407898390162', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 255, '-34.00876929559549, 25.666544454179302', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 256, '-34.008907233225074, 25.66667228937149', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 257, '-34.009246826568464, 25.66666692495346', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 258, '-34.00955811927353, 25.666345059871674', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 259, '-34.0109887932934, 25.66640406847', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 260, '-34.01055173279836, 25.666371881961823', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 261, '-34.010796990043815, 25.666374564170837', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 262, '-34.01003606140763, 25.666363835334778', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 263, '-34.00990399871849, 25.66634774208069', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 264, '-34.01039766057677, 25.666358470916748', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 265, '-34.01080013436289, 25.66626727581024', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 266, '-34.01058317607454, 25.666251182556152', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 267, '-34.010180701260076, 25.66618949174881', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 268, '-34.010124103086305, 25.66556990146637', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 269, '-34.00969961558039, 25.66542237997055', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 270, '-34.01003920575488, 25.665473341941833', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 271, '-34.00994801963768, 25.6654492020607', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 272, '-34.00985997777647, 25.665435791015625', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 273, '-34.009611573461626, 25.66614121198654', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 274, '-34.00978451325133, 25.66615730524063', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 275, '-34.00994801963768, 25.666165351867676', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 276, '-34.01011781439797, 25.66617339849472', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 277, '-34.00872705055816, 25.666969294412297', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 278, '-34.00872482713456, 25.667507931136242', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 279, '-34.00863811356874, 25.666973087628662', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 280, '-34.00877818928488, 25.666654457453888', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 281, '-33.99840240728222, 25.653101108036935', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 282, '-33.998390507044654, 25.653019573073834', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 283, '-33.99837688691668, 25.652913961093873', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 284, '-33.99831502301717, 25.653107268735766', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 285, '-33.99832073861101, 25.65313122002408', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 286, '-33.998342975568185, 25.65305745927617', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 287, '-33.99829850164801, 25.65303499577567', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 288, '-33.99833630448165, 25.65298068104312', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 289, '-33.99826208860853, 25.65293977735564', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 290, '-33.99813834322458, 25.65310580190271', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 291, '-33.99818787267056, 25.65314697800204', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 292, '-33.998196489505645, 25.653086963575333', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 293, '-33.9981597984599, 25.653073887806386', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 294, '-33.998196489505645, 25.653017226140946', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 295, '-33.998186482858365, 25.65296659944579', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 296, '-33.99824207532828, 25.65305008320138', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 297, '-33.99823457034695, 25.653090986888856', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 298, '-33.99824402106406, 25.653088975232095', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 299, '-33.99827598671705, 25.65312049118802', 'NMMU-Path-Definition-Enterance-', 'test', 1),
(200, 'N/A', '', 300, '-34.011051777770135, 25.66681981086731', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 301, '-34.01101090173437, 25.667238235473633', 'NMMU-Path-Definition-Enterance-', 'admin', 1),
(200, 'N/A', '', 302, '-34.01102033466745, 25.667868554592133', 'NMMU-Path-Definition-Enterance-', 'admin', 2),
(200, 'N/A', '', 303, '-34.01102853935317, 25.668762736022472', 'NMMU-Path-Definition-Enterance-', 'admin', 2);

-- --------------------------------------------------------

--
-- Table structure for table `location_type`
--

CREATE TABLE `location_type` (
  `location_type_id` int(22) NOT NULL,
  `location_type` varchar(66) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location_type`
--

INSERT INTO `location_type` (`location_type_id`, `location_type`) VALUES
(1, 'Entrance Gate'),
(2, 'Intersection'),
(3, 'Bus Stop'),
(4, 'Building'),
(5, 'Room'),
(6, 'ATM'),
(7, 'Bank'),
(8, 'Library'),
(9, 'Cafe'),
(10, 'Security'),
(11, 'Staircase');

-- --------------------------------------------------------

--
-- Table structure for table `log_activities`
--

CREATE TABLE `log_activities` (
  `username` varchar(22) NOT NULL,
  `date` date NOT NULL,
  `activity` text NOT NULL,
  `log_id` bigint(255) NOT NULL,
  `parameters` varchar(20000) NOT NULL,
  `device_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `paths`
--

CREATE TABLE `paths` (
  `path_id` bigint(255) NOT NULL,
  `destination_location_id` bigint(255) NOT NULL,
  `departure_location_id` bigint(255) NOT NULL,
  `distance` double DEFAULT NULL,
  `path_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `paths`
--

INSERT INTO `paths` (`path_id`, `destination_location_id`, `departure_location_id`, `distance`, `path_type`) VALUES
(1, 104, 103, 25.24, 2),
(2, 103, 102, 21.79, 2),
(3, 102, 101, 15.61, 2),
(6, 130, 198, 24.08, 2),
(7, 109, 198, 25.44, 2),
(8, 168, 109, 16.2, 2),
(9, 53, 168, 32.49, 2),
(10, 52, 53, 18.06, 2),
(11, 51, 52, 20.86, 2),
(12, 49, 52, 70.71, 2),
(13, 169, 53, 19.59, 2),
(14, 129, 169, 12.44, 2),
(15, 129, 169, 12.44, 2),
(16, 54, 169, 68.78, 2),
(17, 54, 129, 63.21, 2),
(18, 59, 54, 44.76, 2),
(19, 55, 54, 49.3, 2),
(20, 55, 59, 18.54, 2),
(21, 49, 59, 53.15, 2),
(22, 169, 59, 110.72, 2),
(23, 129, 59, 106.89, 2),
(24, 54, 60, 18.88, 2),
(25, 128, 129, 53.86, 2),
(26, 126, 109, 30.88, 2),
(27, 108, 126, 23.11, 2),
(28, 107, 108, 12.96, 2),
(29, 105, 107, 16.08, 2),
(30, 104, 105, 25.66, 2),
(31, 106, 104, 18.05, 2),
(32, 106, 105, 17.85, 2),
(33, 38, 106, 43.11, 2),
(34, 39, 38, 42.91, 2),
(35, 40, 39, 24.13, 2),
(36, 37, 38, 37.88, 2),
(37, 200, 199, 19.94, 2),
(38, 199, 38, 19.87, 2),
(39, 106, 199, 24.14, 2),
(40, 37, 200, 21.36, 2),
(41, 38, 200, 18.19, 2),
(42, 106, 39, 64.32, 2),
(43, 125, 106, 45.64, 2),
(44, 125, 107, 31.81, 2),
(45, 35, 37, 29.94, 2),
(46, 34, 37, 43.36, 2),
(47, 34, 35, 20.59, 2),
(48, 32, 34, 32.8, 2),
(49, 33, 32, 37.83, 2),
(50, 36, 33, 11.3, 2),
(51, 30, 36, 69.82, 2),
(52, 31, 32, 74.13, 2),
(53, 28, 31, 59.42, 2),
(54, 29, 28, 28.5, 2),
(55, 27, 28, 21.13, 2),
(56, 26, 30, 129.46, 2),
(57, 25, 27, 45.55, 2),
(58, 25, 26, 25.93, 2),
(59, 35, 29, 124.01, 2),
(60, 34, 29, 112.76, 2),
(61, 37, 29, 114.2, 2),
(62, 23, 25, 47.09, 2),
(63, 22, 26, 70.64, 2),
(64, 21, 22, 33.97, 2),
(65, 18, 23, 94.85, 2),
(66, 20, 21, 10.14, 2),
(67, 20, 19, 28.04, 2),
(68, 18, 19, 12.6, 2),
(69, 24, 19, 17.35, 2),
(70, 15, 24, 17.64, 2),
(71, 16, 15, 7.92, 2),
(72, 14, 15, 9.82, 2),
(73, 13, 14, 10.97, 2),
(74, 13, 18, 42.66, 2),
(75, 17, 16, 25.03, 2),
(76, 12, 17, 114, 2),
(77, 8, 13, 253.5, 2),
(78, 9, 10, 69.01, 2),
(79, 12, 10, 52.8, 2),
(80, 11, 10, 23.76, 2),
(81, 8, 9, 20.04, 2),
(82, 7, 8, 29.61, 2),
(83, 6, 7, 158.75, 2),
(84, 5, 9, 250.02, 2),
(85, 3, 6, 42.89, 2),
(86, 4, 3, 18.55, 2),
(87, 2, 4, 52.54, 2),
(88, 4, 5, 18.3, 2),
(89, 1, 2, 186.53, 2),
(90, 201, 18, 50.47, 2),
(91, 23, 201, 46.18, 2),
(92, 92, 202, 11.07, 2),
(93, 91, 202, 66.52, 2),
(94, 201, 202, 284.64, 2),
(95, 93, 92, 12.43, 2),
(96, 94, 93, 58.79, 2),
(97, 95, 94, 87.4, 2),
(98, 96, 95, 60.14, 2),
(99, 98, 96, 45.99, 2),
(100, 88, 91, 114.35, 2),
(101, 89, 88, 87.96, 2),
(102, 89, 90, 152.3, 2),
(103, 81, 91, 311.93, 2),
(104, 80, 81, 101.21, 2),
(105, 79, 80, 123.12, 2),
(106, 78, 79, 163.77, 2),
(107, 77, 78, 27.04, 2),
(108, 77, 71, 78.28, 2),
(109, 78, 71, 85.78, 2),
(110, 74, 75, 45.28, 2),
(111, 71, 74, 92.91, 2),
(112, 76, 75, 49.22, 2),
(113, 72, 71, 42.52, 2),
(114, 73, 72, 58.12, 2),
(115, 70, 73, 52.69, 2),
(116, 69, 70, 119.21, 2),
(117, 65, 69, 110.45, 2),
(118, 61, 65, 62.1, 2),
(119, 64, 61, 13.85, 2),
(120, 62, 64, 21.98, 2),
(121, 63, 62, 22.81, 2),
(122, 60, 63, 18.02, 2),
(123, 110, 60, 29.7, 2),
(124, 111, 110, 35.11, 2),
(125, 112, 111, 29.17, 2),
(126, 113, 112, 35.91, 2),
(127, 114, 113, 32.4, 2),
(128, 115, 114, 31.28, 2),
(129, 116, 115, 20.57, 2),
(130, 117, 116, 30.36, 2),
(131, 119, 116, 22.75, 2),
(132, 118, 119, 53.1, 2),
(133, 118, 117, 32.98, 2),
(134, 120, 119, 22.77, 2),
(135, 121, 120, 54.93, 2),
(136, 122, 120, 49.47, 2),
(137, 178, 176, 49.29, 2),
(138, 189, 176, 75.66, 2),
(139, 179, 176, 92.81, 2),
(140, 179, 178, 59.44, 2),
(141, 189, 178, 57.17, 2),
(142, 179, 189, 26.94, 2),
(143, 174, 176, 26.87, 2),
(144, 189, 174, 100.5, 2),
(145, 178, 174, 61.9, 2),
(146, 179, 174, 114.63, 2),
(147, 204, 179, 29.29, 2),
(148, 180, 204, 33.22, 2),
(149, 204, 189, 45.72, 2),
(150, 176, 204, 119.54, 2),
(151, 185, 184, 13.64, 2),
(152, 183, 185, 31.5, 2),
(153, 182, 186, 25.17, 2),
(154, 183, 186, 43.23, 2),
(155, 187, 183, 19.58, 2),
(156, 188, 187, 55.94, 2),
(157, 172, 190, 71.81, 2),
(158, 171, 172, 54.9, 2),
(159, 205, 123, 32.38, 2),
(160, 124, 205, 25.41, 2),
(161, 194, 205, 9.6, 2),
(162, 124, 194, 27.79, 2),
(163, 123, 194, 30.72, 2),
(164, 124, 123, 57.34, 2),
(165, 43, 101, 37.59, 2),
(166, 44, 43, 54.14, 2),
(167, 45, 44, 40.3, 2),
(168, 46, 45, 17.51, 2),
(169, 47, 46, 43.01, 2),
(170, 48, 47, 14.51, 2),
(171, 49, 48, 30.18, 2),
(172, 50, 49, 27.94, 2),
(173, 131, 46, 61.19, 2),
(174, 68, 47, 64.67, 2),
(175, 68, 66, 27.81, 2),
(176, 67, 68, 12.94, 2),
(177, 139, 68, 19.37, 2),
(178, 142, 139, 19.24, 2),
(179, 141, 142, 12.84, 2),
(180, 140, 141, 27.78, 2),
(181, 143, 142, 38.57, 2),
(182, 137, 143, 27.97, 2),
(183, 137, 140, 20.98, 2),
(184, 136, 137, 65.1, 2),
(185, 134, 136, 16.1, 2),
(186, 132, 134, 33.44, 2),
(187, 138, 132, 19.82, 2),
(188, 140, 138, 21.79, 2),
(189, 206, 131, 17.59, 2),
(190, 133, 206, 11.23, 2),
(191, 206, 45, 71.49, 2),
(192, 132, 206, 48.67, 2),
(193, 144, 137, 34.14, 2),
(194, 135, 136, 42.94, 2),
(195, 135, 144, 39.29, 2),
(196, 146, 135, 15.74, 2),
(197, 147, 146, 41.18, 2),
(198, 145, 146, 21.68, 2),
(199, 149, 145, 31.59, 2),
(200, 150, 149, 22.82, 2),
(201, 148, 147, 26.7, 2),
(202, 148, 150, 49.22, 2),
(203, 151, 150, 48.43, 2),
(204, 153, 151, 16.07, 2),
(205, 152, 151, 12.37, 2),
(206, 155, 151, 11.71, 2),
(207, 154, 151, 14.45, 2),
(208, 155, 154, 16.16, 2),
(209, 157, 154, 31.83, 2),
(210, 156, 155, 33.57, 2),
(211, 158, 156, 20.19, 2),
(212, 159, 158, 17.83, 2),
(213, 160, 159, 5.77, 2),
(214, 161, 160, 7.14, 2),
(215, 162, 161, 30.16, 2),
(216, 165, 162, 10.45, 2),
(217, 164, 165, 9.24, 2),
(218, 163, 164, 15.62, 2),
(219, 157, 163, 18.03, 2),
(220, 156, 157, 17.55, 2),
(221, 167, 165, 19.71, 2),
(222, 166, 160, 34.79, 2),
(223, 131, 138, 52.46, 2),
(224, 131, 207, 21.82, 2),
(225, 132, 212, 15.15, 2),
(226, 212, 211, 23.33, 2),
(227, 212, 134, 20.14, 2),
(228, 210, 211, 38.99, 2),
(229, 209, 210, 29.4, 2),
(230, 208, 209, 35.73, 2),
(231, 206, 208, 46.54, 2),
(232, 45, 208, 25.63, 2),
(233, 32, 121, 147.55, 2),
(234, 175, 172, 38.36, 2),
(235, 173, 172, 26.93, 2),
(236, 173, 174, 73.43, 2),
(237, 170, 213, 90.53, 2),
(238, 123, 213, 22.23, 2),
(239, 173, 213, 73.45, 2),
(240, 197, 189, 28.04, 2),
(241, 190, 197, 46.85, 2),
(242, 97, 96, 39.06, 1),
(243, 99, 97, 41.59, 1),
(244, 100, 97, 31.17, 1),
(245, 99, 100, 32.58, 1),
(246, 42, 99, 65.27, 1),
(247, 45, 100, 68.23, 1),
(248, 40, 42, 38.07, 1),
(249, 41, 42, 36.76, 1),
(250, 43, 41, 61.04, 1),
(251, 40, 41, 26.62, 1),
(252, 82, 81, 33.47, 1),
(253, 83, 82, 45.4, 1),
(254, 84, 83, 101.32, 1),
(255, 85, 84, 64.34, 1),
(256, 87, 84, 74.04, 1),
(257, 88, 87, 147.96, 1),
(258, 86, 85, 82.7, 1),
(259, 89, 86, 85.15, 1),
(260, 90, 88, 216.03, 1),
(261, 95, 203, 152.6, 1),
(262, 92, 203, 50.94, 2),
(263, 201, 203, 234.47, 2),
(264, 127, 168, 42.59, 1),
(265, 127, 53, 52.13, 1),
(266, 127, 169, 56.49, 1),
(267, 51, 130, 36.84, 2),
(268, 43, 130, 32.51, 2),
(269, 103, 41, 38.99, 1),
(270, 198, 101, 15.51, 2),
(271, 216, 217, 54.21, 2),
(272, 214, 217, 34.22, 2),
(273, 215, 214, 61.21, 2),
(274, 204, 181, 6.16, 2),
(275, 195, 125, 23.89, 3),
(276, 194, 195, 29.65, 3),
(277, 193, 35, 15.08, 3),
(278, 192, 193, 35.85, 3),
(279, 124, 192, 25.07, 3),
(280, 195, 193, 51.15, 3),
(281, 125, 106, 45.64, 2),
(282, 98, 79, 410.58, 2),
(283, 218, 166, 28.24, 1),
(284, 78, 167, 36.59, 1),
(285, 218, 78, 48.25, 2),
(286, 79, 218, 116.09, 2),
(287, 219, 193, 15.28, 6),
(288, 220, 219, 13.36, 6),
(289, 221, 220, 12.74, 6),
(290, 222, 221, 42.53, 4),
(291, 223, 222, 14.15, 4),
(292, 190, 223, 59.98, 4),
(293, 171, 123, 20.97, 6),
(294, 176, 175, 30.44, 6),
(295, 177, 175, 24.22, 6),
(296, 205, 224, 20.95, 6),
(297, 32, 224, 74.33, 2),
(298, 121, 224, 73.26, 2),
(299, 214, 36, 32.14, 6),
(300, 215, 216, 36.9, 3),
(301, 189, 215, 22.79, 3),
(302, 179, 215, 36.31, 2),
(303, 197, 215, 24.87, 3),
(304, 182, 181, 30.33, 6),
(305, 226, 225, 38.99, 2),
(306, 227, 226, 45.85, 2),
(307, 178, 227, 36.49, 2),
(308, 174, 227, 27.1, 2),
(309, 176, 227, 29.29, 2),
(310, 189, 227, 84.13, 2),
(311, 179, 227, 93.45, 2),
(312, 229, 191, 5.640000000000001, 6),
(313, 223, 229, 2.84, 4),
(314, 228, 191, 5.64, 2),
(315, 32, 228, 37.08, 2),
(316, 228, 224, 38.28, 2),
(317, 230, 90, 99.11, 2),
(318, 231, 230, 110.24, 2),
(319, 232, 231, 79.39, 2),
(320, 234, 232, 140.96, 2),
(321, 233, 234, 73.87, 2),
(322, 1, 233, 264.01, 2),
(323, 237, 238, 98.01, 2),
(324, 237, 234, 52.65, 2),
(325, 239, 238, 170.69, 2),
(326, 235, 231, 36.72, 2),
(327, 236, 235, 34.47, 2),
(328, 237, 236, 84.78, 2),
(329, 286, 282, 6.33, 2),
(330, 288, 282, 7.01, 2),
(331, 287, 282, 10.33, 2),
(332, 287, 286, 5.36, 2),
(333, 287, 288, 6.54, 2),
(334, 289, 288, 9.07, 2),
(335, 289, 283, 12.98, 2),
(336, 295, 289, 8.76, 2),
(337, 294, 295, 4.8, 2),
(338, 293, 294, 6.63, 2),
(339, 293, 295, 10.33, 2),
(340, 293, 292, 4.25, 2),
(341, 290, 292, 6.69, 2),
(342, 293, 290, 3.79, 2),
(343, 291, 290, 6.69, 2),
(345, 285, 291, 14.85, 2),
(346, 285, 291, 14.85, 2),
(347, 281, 285, 9.5, 2),
(348, 286, 281, 7.74, 2),
(349, 284, 281, 9.73, 2),
(350, 284, 286, 5.54, 2),
(351, 285, 284, 2.3, 2),
(352, 296, 287, 6.43, 3),
(353, 292, 296, 6.1, 3),
(354, 294, 296, 5.9, 3),
(355, 297, 296, 3.86, 3),
(356, 298, 296, 3.59, 3),
(357, 298, 297, 1.07, 3),
(358, 299, 298, 4.59, 3),
(359, 246, 247, 32.17, 2),
(360, 248, 246, 41.26, 2),
(361, 245, 246, 87.01, 2),
(362, 188, 245, 74.41, 2),
(363, 243, 188, 126.33, 2),
(364, 241, 242, 129.38, 2),
(365, 301, 302, 58.11, 2),
(366, 300, 301, 38.83, 2),
(367, 259, 300, 38.95, 2),
(368, 261, 259, 21.5, 2),
(369, 265, 261, 9.9, 2),
(370, 266, 265, 24.17, 2),
(371, 260, 261, 27.27, 2),
(372, 267, 266, 45.11, 2),
(373, 264, 260, 17.18, 2),
(374, 267, 259, 92.01, 1),
(375, 276, 267, 7.15, 2),
(376, 268, 276, 55.63, 2),
(377, 266, 260, 11.66, 2),
(378, 262, 264, 40.21, 2),
(379, 263, 262, 14.76, 2),
(380, 258, 263, 38.46, 2),
(381, 252, 258, 23.43, 2),
(382, 270, 268, 12.97, 2),
(383, 271, 270, 10.38, 2),
(384, 272, 271, 9.87, 2),
(385, 269, 272, 17.87, 2),
(386, 273, 269, 66.98, 2),
(387, 274, 272, 67.03, 2),
(388, 275, 271, 66.01, 2),
(389, 276, 270, 65.12, 2),
(390, 275, 276, 18.89, 2),
(391, 274, 275, 18.2, 2),
(392, 273, 274, 19.29, 2),
(393, 269, 267, 88.66, 1);

-- --------------------------------------------------------

--
-- Table structure for table `path_type`
--

CREATE TABLE `path_type` (
  `path_type_id` int(255) NOT NULL,
  `path_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `path_type`
--

INSERT INTO `path_type` (`path_type_id`, `path_type`) VALUES
(1, 'Dirt Road'),
(2, 'Outdoor, Ground Level'),
(3, 'Indoor, Ground Level'),
(4, 'Indoor, Level 1'),
(5, 'Indoor, Level 2'),
(6, 'Stairway'),
(7, 'Indoor, -1');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_name` varchar(22) NOT NULL DEFAULT 'NULL_VAL',
  `comment` varchar(10000) CHARACTER SET latin1 NOT NULL,
  `client_id` int(11) NOT NULL,
  `category_role` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_name`, `comment`, `client_id`, `category_role`) VALUES
('AcitvateUser', 'Can activate/deactivate a user', 1, 'User Management'),
('EditUser', 'Can edit a user', 1, 'User Management'),
('ViewAllRoles', 'Can view all roles', 1, 'Security Management');

-- --------------------------------------------------------

--
-- Table structure for table `sensor_settings`
--

CREATE TABLE `sensor_settings` (
  `sensor_setting_id` bigint(255) NOT NULL,
  `accelerometer` double NOT NULL DEFAULT '1',
  `gyroscope` double NOT NULL DEFAULT '1',
  `gps` varchar(200) NOT NULL,
  `username` varchar(22) NOT NULL,
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
  `username` varchar(22) NOT NULL,
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
  `creator_username` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `username` varchar(22) NOT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(2000) NOT NULL,
  `surname` varchar(2000) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `ethnic` int(11) NOT NULL,
  `date_of_birth` varchar(100) NOT NULL,
  `title` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`password`, `registeration_date`, `creator_username`, `active`, `username`, `client_id`, `name`, `surname`, `gender`, `ethnic`, `date_of_birth`, `title`) VALUES
('c4ca4238a0b923820dcc509a6f75849b', '05/30/2017 21:23:54', NULL, 1, 'admin', 1, 'amirsaleh', 'salehzadeh', 1, 1, '1985-04-22', 1),
('c4ca4238a0b923820dcc509a6f75849b', '06/04/2017 22:29:34', NULL, 1, 'NMMU', 1, 'NMMU', 'NMMU', 1, 1, '2017-06-09', 1),
('c4ca4238a0b923820dcc509a6f75849b', '06/04/2017 22:31:49', NULL, 1, 'test', 1, 'test', 'test', 1, 1, '2017-06-13', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_device`
--

CREATE TABLE `user_device` (
  `user_device_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `username` varchar(22) NOT NULL,
  `mac_address` varchar(400) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `username` varchar(22) NOT NULL,
  `group_id` int(11) NOT NULL,
  `user_group_id` bigint(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `username` varchar(22) NOT NULL,
  `role_name` varchar(22) NOT NULL,
  `user_role_id` bigint(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`username`, `role_name`, `user_role_id`) VALUES
('admin', 'AcitvateUser', 4),
('admin', 'EditUser', 5),
('admin', 'ViewAllRoles', 6);

-- --------------------------------------------------------

--
-- Table structure for table `venue`
--

CREATE TABLE `venue` (
  `location_id` bigint(255) NOT NULL,
  `venue_id` bigint(255) NOT NULL,
  `title` varchar(3000) NOT NULL,
  `capacity` int(11) NOT NULL,
  `creator_username` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Indexes for table `calendar_date`
--
ALTER TABLE `calendar_date`
  ADD PRIMARY KEY (`date_id`);

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
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `creator_username` (`creator_username`),
  ADD KEY `start_time` (`start_time`),
  ADD KEY `venue_id` (`venue_id`);

--
-- Indexes for table `events_attendance`
--
ALTER TABLE `events_attendance`
  ADD KEY `username` (`username`),
  ADD KEY `events_id` (`events_id`);

--
-- Indexes for table `events_categories`
--
ALTER TABLE `events_categories`
  ADD KEY `event_id` (`event_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `events_category`
--
ALTER TABLE `events_category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `events_hash_tag`
--
ALTER TABLE `events_hash_tag`
  ADD PRIMARY KEY (`event_hash_tag_id`),
  ADD KEY `hash_tag_id` (`hash_tag_id`),
  ADD KEY `event_id` (`event_id`);

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
  ADD KEY `role_id` (`role_name`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `hash_tag`
--
ALTER TABLE `hash_tag`
  ADD PRIMARY KEY (`hash_tag_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `username` (`username`),
  ADD KEY `country` (`country`),
  ADD KEY `location_type` (`location_type`);

--
-- Indexes for table `location_type`
--
ALTER TABLE `location_type`
  ADD PRIMARY KEY (`location_type_id`);

--
-- Indexes for table `log_activities`
--
ALTER TABLE `log_activities`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `uusername` (`username`),
  ADD KEY `device_id` (`device_id`);

--
-- Indexes for table `paths`
--
ALTER TABLE `paths`
  ADD PRIMARY KEY (`path_id`),
  ADD KEY `destination_location_id` (`destination_location_id`),
  ADD KEY `departure_location_id` (`departure_location_id`),
  ADD KEY `path_type` (`path_type`);

--
-- Indexes for table `path_type`
--
ALTER TABLE `path_type`
  ADD PRIMARY KEY (`path_type_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_name`),
  ADD UNIQUE KEY `role_name_2` (`role_name`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `role_name` (`role_name`);

--
-- Indexes for table `sensor_settings`
--
ALTER TABLE `sensor_settings`
  ADD PRIMARY KEY (`sensor_setting_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `titles`
--
ALTER TABLE `titles`
  ADD PRIMARY KEY (`title_id`);

--
-- Indexes for table `track_user`
--
ALTER TABLE `track_user`
  ADD KEY `username` (`username`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `ethnic` (`ethnic`),
  ADD KEY `title` (`title`);

--
-- Indexes for table `user_device`
--
ALTER TABLE `user_device`
  ADD PRIMARY KEY (`user_device_id`),
  ADD KEY `device_id` (`device_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`user_group_id`),
  ADD KEY `username` (`username`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_role_id`),
  ADD UNIQUE KEY `user_role_id` (`user_role_id`),
  ADD KEY `username` (`username`),
  ADD KEY `role_name` (`role_name`),
  ADD KEY `user_role_id_2` (`user_role_id`);

--
-- Indexes for table `venue`
--
ALTER TABLE `venue`
  ADD PRIMARY KEY (`venue_id`),
  ADD KEY `creator_username` (`creator_username`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `version`
--
ALTER TABLE `version`
  ADD PRIMARY KEY (`version_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calendar_date`
--
ALTER TABLE `calendar_date`
  MODIFY `date_id` int(11) NOT NULL AUTO_INCREMENT;
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
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `events_category`
--
ALTER TABLE `events_category`
  MODIFY `category_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `events_hash_tag`
--
ALTER TABLE `events_hash_tag`
  MODIFY `event_hash_tag_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `group_roles`
--
ALTER TABLE `group_roles`
  MODIFY `role_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;
--
-- AUTO_INCREMENT for table `location_type`
--
ALTER TABLE `location_type`
  MODIFY `location_type_id` int(22) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `log_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `paths`
--
ALTER TABLE `paths`
  MODIFY `path_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=394;
--
-- AUTO_INCREMENT for table `path_type`
--
ALTER TABLE `path_type`
  MODIFY `path_type_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `sensor_settings`
--
ALTER TABLE `sensor_settings`
  MODIFY `sensor_setting_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `titles`
--
ALTER TABLE `titles`
  MODIFY `title_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `user_group_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `user_role_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `version`
--
ALTER TABLE `version`
  MODIFY `version_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`venue_id`),
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`start_time`) REFERENCES `calendar_date` (`date_id`),
  ADD CONSTRAINT `events_ibfk_3` FOREIGN KEY (`creator_username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `events_attendance`
--
ALTER TABLE `events_attendance`
  ADD CONSTRAINT `events_attendance_ibfk_1` FOREIGN KEY (`events_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `events_attendance_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`username`);

--
-- Constraints for table `events_categories`
--
ALTER TABLE `events_categories`
  ADD CONSTRAINT `events_categories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `events_category` (`category_id`),
  ADD CONSTRAINT `events_categories_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

--
-- Constraints for table `events_category`
--
ALTER TABLE `events_category`
  ADD CONSTRAINT `events_category_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `events_category` (`category_id`);

--
-- Constraints for table `events_hash_tag`
--
ALTER TABLE `events_hash_tag`
  ADD CONSTRAINT `events_hash_tag_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `events_hash_tag_ibfk_2` FOREIGN KEY (`hash_tag_id`) REFERENCES `hash_tag` (`hash_tag_id`);

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`);

--
-- Constraints for table `group_roles`
--
ALTER TABLE `group_roles`
  ADD CONSTRAINT `group_roles_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_roles_ibfk_4` FOREIGN KEY (`role_name`) REFERENCES `roles` (`role_name`);

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  ADD CONSTRAINT `location_ibfk_2` FOREIGN KEY (`country`) REFERENCES `countries` (`id`),
  ADD CONSTRAINT `location_ibfk_3` FOREIGN KEY (`location_type`) REFERENCES `location_type` (`location_type_id`);

--
-- Constraints for table `log_activities`
--
ALTER TABLE `log_activities`
  ADD CONSTRAINT `log_activities_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  ADD CONSTRAINT `log_activities_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`);

--
-- Constraints for table `paths`
--
ALTER TABLE `paths`
  ADD CONSTRAINT `paths_ibfk_1` FOREIGN KEY (`destination_location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `paths_ibfk_2` FOREIGN KEY (`departure_location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `paths_ibfk_3` FOREIGN KEY (`path_type`) REFERENCES `path_type` (`path_type_id`);

--
-- Constraints for table `sensor_settings`
--
ALTER TABLE `sensor_settings`
  ADD CONSTRAINT `sensor_settings_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`);

--
-- Constraints for table `track_user`
--
ALTER TABLE `track_user`
  ADD CONSTRAINT `track_user_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`title`) REFERENCES `titles` (`title_id`),
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`ethnic`) REFERENCES `ethnics` (`ethnic_id`);

--
-- Constraints for table `user_device`
--
ALTER TABLE `user_device`
  ADD CONSTRAINT `user_device_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`device_id`),
  ADD CONSTRAINT `user_device_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`username`);

--
-- Constraints for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD CONSTRAINT `user_groups_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  ADD CONSTRAINT `user_groups_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_name`) REFERENCES `roles` (`role_name`);

--
-- Constraints for table `venue`
--
ALTER TABLE `venue`
  ADD CONSTRAINT `venue_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `venue_ibfk_2` FOREIGN KEY (`creator_username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
