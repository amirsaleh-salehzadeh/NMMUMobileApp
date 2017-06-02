-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2017 at 01:29 AM
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
(200, 'N/A', '', 5, '-34.00875776159067, 25.66948721958215', 'NMMU-Embizweni-Enterance-Southern-Yard', 'admin', 1),
(200, 'N/A', '', 7, '-34.00903749550676, 25.670152120292187', 'NMMU-Main-Building-Enterance-Eastern', 'admin', 1),
(200, 'N/A', '', 8, '-34.00902415501305, 25.669626407325268', 'NMMU-Main-Building-Enterance-Western', 'admin', 1),
(200, 'N/A', '', 9, '-34.00873775078342, 25.669789519160986', 'NMMU-Embizweni-Enterance-Southern-Main-Building', 'admin', 1),
(200, 'N/A', '', 10, '-34.00844161807753, 25.66979270428419', 'NMMU-Embizweni-Enterance-Northern', 'admin', 1),
(200, 'N/A', '', 11, '-34.00853944898714, 25.66758792847395', 'NMMU-Rendezvous-Enterance', 'admin', 1),
(200, 'N/A', '', 12, '-34.00860170496184, 25.6693259999156', 'NMMU-Embizweni-Enterance-Western', 'admin', 1),
(200, 'N/A', '', 13, '-34.00913532572986, 25.66755037754774', 'NMMU-South-Campus-Library-Enterance', 'admin', 1),
(200, 'N/A', '', 14, '-34.00867086327199, 25.668703224509954', 'NMMU-South-Campus-Yard-Education-Old-Mutual-Lecture-Halls', 'admin', 1),
(200, 'N/A', '', 15, '-34.00865951404033, 25.668017081916332', 'NMMU-Education-Dept-Enterance', 'admin', 1),
(200, 'N/A', '', 16, '-34.00928401863886, 25.668035354465246', 'NMMU-Library-Yard-to-Southern-Stairways', 'admin', 1),
(200, 'N/A', '', 17, '-34.00930917363629, 25.668445732444525', 'NMMU-Kral-Yard-Stairways', 'admin', 1),
(200, 'N/A', '', 18, '-34.0087625211049, 25.668048388324678', 'NMMU-Southern--Education-to-Yard-Stairways-Kral', 'admin', 1),
(200, 'N/A', '', 19, '-34.009296596138526, 25.669494476169348', 'NMMU-Main-Building-Western-to-Yard-Stairways', 'admin', 1),
(200, 'N/A', '', 20, '-34.00901674633096, 25.66946228966117', 'NMMU-Main-Building-Western-to-UniWay-Stairways', 'admin', 1),
(200, 'N/A', '', 21, '-34.0095315091883, 25.669491793960333', 'NMMU-Music-Dept-Main-Building-Passage', 'admin', 1),
(200, 'N/A', '', 22, '-34.009491547144826, 25.67046007141471', 'NMMU-Buidling-35-Enterance-Western', 'admin', 1),
(200, 'N/A', '', 23, '-34.00873689560114, 25.67065855488181', 'NMMU-Beyers-Naude-Garden-of-Contemplation-1', 'admin', 1),
(200, 'N/A', '', 24, '-34.00874003999646, 25.67093750461936', 'NMMU-Beyers-Naude-Garden-of-Contemplation-2', 'admin', 1),
(200, 'N/A', '', 25, '-34.00891927033874, 25.67115208134055', 'NMMU-Beyers-Naude-Garden-of-Contemplation-3', 'admin', 1),
(200, 'N/A', '', 26, '-34.00902303510083, 25.67116281017661', 'NMMU-Beyers-Naude-Garden-of-Contemplation-4', 'admin', 1),
(200, 'N/A', '', 27, '-34.009144636270776, 25.671141352504492', 'NMMU-Beyers-Naude-Garden-of-Contemplation-5', 'admin', 1),
(200, 'N/A', '', 28, '-34.00931546238451, 25.67095359787345', 'NMMU-Beyers-Naude-Garden-of-Contemplation-6', 'admin', 1),
(200, 'N/A', '', 29, '-34.00932489550589, 25.67069074138999', 'NMMU-Beyers-Naude-Garden-of-Contemplation-7', 'admin', 1),
(200, 'N/A', '', 30, '-34.00914193206817, 25.670490078628063', 'NMMU-Beyers-Naude-Garden-of-Contemplation-8', 'admin', 1),
(200, 'N/A', '', 31, '-34.00874573921275, 25.670490078628063', 'NMMU-Beyers-Naude-Garden-of-Contemplation-9', 'admin', 1),
(200, 'N/A', '', 32, '-34.00889725961534, 25.670494940131903', 'NMMU-Beyers-Naude-Garden-of-Contemplation-10', 'admin', 1),
(200, 'N/A', '', 33, '-34.00901345482388, 25.670465869404666', 'NMMU-Beyers-Naude-Garden-of-Contemplation-11', 'admin', 1),
(200, 'N/A', '', 34, '-34.0091267997361, 25.67166170105338', 'NMMU-123-Western-North-Entrance', 'admin', 1),
(200, 'N/A', '', 35, '-34.00907904443675, 25.67209403961897', 'NMMU-123-Eastern-North-Entrance', 'admin', 1),
(200, 'N/A', '', 36, '-34.009456959095715, 25.67159464582801', 'NMMU-123-Western-South-Entrance', 'admin', 1),
(200, 'N/A', '', 37, '-34.00941922666243, 25.67208817228675', 'NMMU-123-Eastern-South-Entrance', 'admin', 1),
(200, 'N/A', '', 38, '-34.009598455571144, 25.67134788259864', 'NMMU-123-Southern-Parking-1', 'admin', 1),
(200, 'N/A', '', 39, '-34.01006696444029, 25.672058667987585', 'NMMU-123-Southern-Parking-2', 'admin', 1),
(200, 'N/A', '', 40, '-34.00985884777432, 25.6725500151515', 'NMMU-123-Southern-Parking-3', 'admin', 1),
(200, 'N/A', '', 41, '-34.01003493140783, 25.67253928631544', 'NMMU-123-Southern-Parking-4', 'admin', 1),
(200, 'N/A', '', 42, '-34.009638742718934, 25.67230325192213', 'NMMU-123-Southern-Parking-5', 'admin', 1),
(200, 'N/A', '', 43, '-34.010236169399, 25.67206721752882', 'NMMU-123-Southern-Parking-6', 'admin', 1),
(200, 'N/A', '', 44, '-34.009795960673834, 25.671391300857067', 'NMMU-123-Southern-Parking-7', 'admin', 1),
(200, 'N/A', '', 45, '-34.00964876537226, 25.67083289846778', 'NMMU-Building-35-Western-Entrance', 'admin', 1),
(200, 'N/A', '', 46, '-34.0099657557382, 25.6708387658', 'NMMU-Building-35-Southern-Entrance', 'admin', 1),
(200, 'N/A', '', 47, '-34.008292945114505, 25.670463256537914', 'NMMU-Embizweni-Parking-1', 'admin', 1),
(200, 'N/A', '', 48, '-34.008299233937954, 25.671192817389965', 'NMMU-Embizweni-Parking-2', 'admin', 1),
(200, 'N/A', '', 49, '-34.00710808316081, 25.66959908232093', 'NMMU-Embizweni-Parking-Main-Entrance', 'admin', 1),
(200, 'N/A', '', 50, '-34.00728043846486, 25.669894628226757', 'NMMU-Embizweni-Parking-Main-Entrance-1', 'admin', 1),
(200, 'N/A', '', 52, '-34.00831810040553, 25.67005556076765', 'NMMU-Embizweni-Parking-Main-Entrance-3', 'admin', 1),
(200, 'N/A', '', 53, '-34.01019214862917, 25.677726678550243', 'NMMU-South-Junction-Sport-Center', 'admin', 1),
(200, 'N/A', '', 54, '-34.01060720069491, 25.67876737564802', 'NMMU-Indoor-Sport-Center', 'admin', 1),
(200, 'N/A', '', 55, '-34.01019843731197, 25.67356925457716', 'NMMU-Melodi-Clubhouse-Pool-Parking-1', 'admin', 1),
(200, 'N/A', '', 56, '-34.010154416522575, 25.6760261580348', 'NMMU-Melodi-Clubhouse-Pool-Parking-2', 'admin', 1),
(200, 'N/A', '', 57, '-34.01006008618281, 25.672877244651318', 'NMMU-Melodi-Clubhouse-Pool-Parking-3', 'admin', 1),
(200, 'N/A', '', 58, '-34.00944438161981, 25.67770203575492', 'NMMU-Stadium-Western-Entrance', 'admin', 1),
(200, 'N/A', '', 59, '-34.009380317683224, 25.67107278402318', 'NMMU-Beyers-Naude-Garden-of-Contemplation-12', 'admin', 1),
(200, 'N/A', '', 60, '-34.00901345482388, 25.67170245794', 'NMMU-123-Northern-Enterance-1', 'admin', 1),
(200, 'N/A', '', 61, '-34.0090223484877, 25.672692487411496', 'NMMU-123-Northern-Enterance-2', 'admin', 1),
(200, 'N/A', '', 62, '-34.00953812307504, 25.672727040946484', 'NMMU-Beyers-Naude-Garden-of-Contemplation-13', 'admin', 1),
(200, 'N/A', '', 63, '-34.009277729888346, 25.66872736439109', 'NMMU-South-Campus-Yard-Math-Dep-1', 'admin', 1),
(200, 'N/A', '', 64, '-34.009274585512934, 25.669306721538305', 'NMMU-South-Campus-Yard-Math-Dep-2', 'admin', 1),
(200, 'N/A', '', 65, '-34.00913308849782, 25.668078269809484', 'NMMU-Kral-Enterance-', 'admin', 1),
(200, 'N/A', '', 66, '-34.00869287405407, 25.667914655059576', 'NMMU-Passage-Rend-Library', 'admin', 1),
(200, 'N/A', '', 67, '-34.00762632718727, 25.669240169227123', 'NMMU-Main-Road-Turn-Before-Bridge', 'admin', 1);

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
(1, 'Entrance'),
(2, 'Public'),
(3, 'Private'),
(4, 'ATM');

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
(1, 21, 22, 89.36098971735035, 2),
(3, 22, 46, 63.236290846817155, 2),
(4, 46, 39, 113.0049137141721, 2),
(5, 46, 41, 156.9322618191283, 2),
(6, 39, 43, 18.831229090202893, 2),
(7, 57, 55, 65.61412608212675, 2),
(8, 19, 21, 26.12230930946624, 2),
(9, 20, 19, 31.25898593880043, 2),
(10, 40, 57, 37.55615648902325, 1),
(11, 41, 57, 31.27625144055088, 1),
(12, 48, 34, 101.66519235895984, 1),
(13, 24, 25, 28.07810796282274, 2),
(14, 23, 24, 25.714649446101852, 2),
(15, 42, 40, 33.411802194352845, 2),
(16, 44, 40, 107.03212587473882, 2),
(17, 40, 39, 50.859225020367816, 2),
(18, 39, 41, 44.4434122525298, 2),
(19, 44, 39, 68.49840649087285, 2),
(20, 42, 39, 52.68336314855371, 2),
(21, 38, 39, 83.7037637055711, 2),
(22, 38, 42, 88.17439995339619, 2),
(23, 25, 26, 11.580418148132102, 2),
(24, 27, 26, 13.665324052796553, 2),
(25, 28, 27, 25.696609801728243, 2),
(26, 29, 28, 24.251400330621372, 2),
(27, 30, 29, 27.495572199397216, 2),
(29, 23, 32, 23.354047764712146, 2),
(30, 31, 23, 15.56045029027685, 2),
(31, 47, 31, 50.40907167755311, 2),
(32, 52, 47, 37.68362153052118, 2),
(33, 48, 47, 67.25146746491964, 2),
(34, 20, 5, 28.889324890731814, 2),
(35, 33, 32, 13.19525834836775, 2),
(36, 33, 30, 14.459246889832123, 2),
(37, 45, 38, 47.7968199905992, 1),
(38, 44, 45, 54.010027506382784, 1),
(39, 45, 59, 37.14746482271875, 1),
(40, 28, 59, 13.141451213335234, 2),
(41, 59, 38, 35.090253886330245, 2),
(42, 42, 37, 31.4456225030892, 2),
(47, 10, 52, 27.851045637641217, 2),
(48, 32, 31, 16.854258134126482, 2),
(49, 64, 19, 17.47843111757976, 6),
(50, 63, 64, 53.40321815880098, 2),
(51, 63, 14, 67.51716393173815, 2),
(52, 16, 17, 37.92973590301242, 6),
(53, 13, 16, 47.66230872257001, 2),
(54, 11, 16, 92.4956236920768, 2),
(55, 65, 17, 39.12285006130842, 2),
(56, 18, 65, 41.29716682389163, 2),
(57, 15, 18, 11.811778681481686, 6),
(58, 66, 16, 66.6671474149608, 2),
(59, 14, 66, 72.72785832509582, 2),
(60, 11, 66, 34.61256645168396, 2),
(63, 60, 26, 49.7534296818243, 2),
(64, 38, 36, 27.656750922138063, 2),
(65, 61, 60, 91.26130937245016, 2),
(66, 62, 61, 57.439886226325015, 2),
(67, 42, 62, 40.633210969874035, 2),
(68, 40, 62, 39.218596522031916, 1),
(69, 8, 7, 48.48027684968997, 3),
(70, 9, 8, 35.217311067194146, 3),
(71, 10, 9, 32.929763307049214, 3),
(73, 9, 7, 47.201471945016934, 3),
(74, 46, 44, 54.31639387571198, 2),
(75, 22, 45, 38.556142781030374, 3),
(76, 7, 33, 29.04, 2),
(77, 48, 24, 54.372226135149205, 2),
(78, 50, 52, 116.33241160071555, 2),
(79, 49, 50, 33.308463052177935, 2),
(80, 67, 49, 66.44759544943848, 2),
(81, 67, 49, 66.44759544943848, 2),
(82, 17, 63, 26.193736603151706, 6),
(84, 8, 20, 15.14995731453395, 2),
(85, 12, 67, 108.74523500901024, 2),
(86, 55, 56, 226.51484244801856, 2),
(87, 56, 53, 156.79946214924334, 2),
(88, 53, 54, 106.44962066472026, 2),
(89, 58, 53, 83.17891731310061, 2),
(90, 34, 35, 40.20299471340968, 2),
(91, 45, 46, 35.25186919527855, 3),
(92, 37, 36, 45.683644188398006, 3),
(93, 35, 37, 37.830403581144964, 3),
(94, 34, 36, 37.22870565007115, 3),
(95, 61, 35, 55.52097658338235, 2),
(96, 5, 10, 45.04, 3),
(97, 5, 9, 27.95, 3),
(98, 60, 34, 13.15, 2);

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
(7, 'Underground-1');

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
('c4ca4238a0b923820dcc509a6f75849b', '05/30/2017 21:23:54', NULL, 1, 'admin', 1, 'amirsaleh', 'salehzadeh', 1, 1, '1985-04-22', 1);

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
  MODIFY `location_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;
--
-- AUTO_INCREMENT for table `location_type`
--
ALTER TABLE `location_type`
  MODIFY `location_type_id` int(22) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `log_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `paths`
--
ALTER TABLE `paths`
  MODIFY `path_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;
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
