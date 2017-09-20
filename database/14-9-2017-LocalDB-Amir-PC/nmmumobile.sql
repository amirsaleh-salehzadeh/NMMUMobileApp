-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 14, 2017 at 12:41 PM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nmmumobile`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSPLocationTypeChildren` (IN `p_cat_id` INT UNSIGNED)  begin

declare v_done tinyint unsigned default 0;
declare v_depth int unsigned default 0;

create temporary table hier(
 parent_id int unsigned, 
 id int unsigned, 
 depth int unsigned default 0
)engine = memory;

insert into hier select parent_id, location_type_id, v_depth from location_type where location_type_id = p_cat_id;



create temporary table tmp engine = memory select * from hier;
while not v_done do
    if exists( select 1 from location_type p inner join hier on p.parent_id = hier.id and hier.depth = v_depth) then
        insert into hier 
            select p.parent_id, p.location_type_id, v_depth + 1 from location_type p 
            inner join tmp on p.parent_id = tmp.id and tmp.depth = v_depth;
			set v_depth = v_depth + 1;          
		truncate table tmp;
        insert into tmp select * from hier where depth = v_depth;
else
set v_done = 1;
    end if;
    end while;
select 
 p.location_type_id,
 p.location_type as location_type,
 b.location_type_id as parent_id,
 b.location_type as parent_location_name,
 hier.depth
from 
 hier
inner join location_type p on hier.id = p.location_type_id
left outer join location_type b on hier.parent_id = b.location_type_id group by hier.depth, p.location_type
order by
 hier.depth, hier.id;

drop temporary table if exists hier;
drop temporary table if exists tmp;

end$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetFnLocationAncestors` (`l_id` BIGINT) RETURNS VARCHAR(1024) CHARSET utf8 BEGIN
    DECLARE rv VARCHAR(1024);
    DECLARE cm CHAR(1);
    DECLARE ch BIGINT;

    SET rv = '';
    SET cm = '';
    SET ch = l_id;
    WHILE ch > 0 DO
        SELECT IFNULL(`parent_id`,0) INTO ch FROM
        (SELECT `parent_id` FROM location WHERE location_id = ch) A;
        IF ch > 0 THEN
            SET rv = CONCAT(rv,cm,ch);
            SET cm = ',';
        END IF;
    END WHILE;
    RETURN rv;

END$$

DELIMITER ;

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
(115, 'KP', 'Korea, Democratic People''s Republic of'),
(116, 'KR', 'Korea, Republic of'),
(117, 'XK', 'Kosovo'),
(118, 'KW', 'Kuwait'),
(119, 'KG', 'Kyrgyzstan'),
(120, 'LA', 'Lao People''s Democratic Republic'),
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

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`device_id`, `device_description`) VALUES
(0, '1,2,3,6,asdfadfs');

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
  `address` varchar(2000) DEFAULT NULL,
  `post_box` varchar(2000) DEFAULT NULL,
  `location_id` bigint(255) NOT NULL,
  `gps` varchar(200) NOT NULL,
  `location_name` varchar(2000) NOT NULL,
  `username` varchar(22) NOT NULL,
  `location_type` int(22) NOT NULL,
  `parent_id` bigint(254) DEFAULT NULL,
  `description` text,
  `boundary` text,
  `plan` text,
  `icon` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`country`, `address`, `post_box`, `location_id`, `gps`, `location_name`, `username`, `location_type`, `parent_id`, `description`, `boundary`, `plan`, `icon`) VALUES
(200, NULL, NULL, 360, '-34.01303096346168,25.670464006290445', 'Nelson Mandela University', 'NMMU', 1, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 361, '-33.988012,25.657674', 'Second Avenue', 'NMMU', 2, 360, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 367, '-33.872440,25.552591', 'Missionvale', 'NMMU', 2, 360, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 368, '-33.965241,25.617134', 'Bird Street', 'NMMU', 2, 360, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 369, '-34.0081858,25.6646675', 'South', 'NMMU', 2, 360, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 370, '-33.971628,22.534518', 'George', 'NMMU', 2, 360, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 371, '-34.0009942,25.6692978', 'North', 'NMMU', 2, 360, NULL, NULL, NULL, NULL),
(200, '', NULL, 374, '-34.00900192085222,25.66980879753828', '1 Main', 'NMMU', 3, 0, '1 Offices all', '', '', ''),
(200, NULL, NULL, 375, '-34.0088089002989,25.669789519160986', '2', 'NMMU', 3, 369, 'Council Chamber', NULL, NULL, NULL),
(200, NULL, NULL, 376, '-34.0092735941058,25.669800247997046', '3', 'NMMU', 3, 369, 'Auditorium', NULL, NULL, NULL),
(200, NULL, NULL, 377, '-34.008591004719435,25.66909432411194', '4', 'NMMU', 3, 369, 'Old Mutual Lecture Halls', NULL, NULL, NULL),
(200, NULL, NULL, 378, '-34.00954929640648,25.669075548648834', '5', 'NMMU', 3, 369, 'Sanlam Lecture Halls', NULL, NULL, NULL),
(200, NULL, NULL, 380, '-34.008498732443286,25.66828429698944', '6', 'NMMU', 3, 369, 'Education, Writing Centre', NULL, NULL, NULL),
(200, NULL, NULL, 381, '-34.00958806697072,25.668291673064232', '7', 'NMMU', 3, 369, 'Mathematics & Applied Mathematics', NULL, NULL, NULL),
(200, NULL, NULL, 382, '-34.0090206020396,25.667463541030884', '8', 'NMMU', 3, 369, 'Library and School of Architecture', NULL, NULL, NULL),
(200, NULL, NULL, 383, '-34.008573217300516,25.669794380664825', '9 Embizweni ', 'NMMU', 3, 369, 'Computing Science Department', NULL, NULL, 'data:image/jpeg;base64,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'),
(200, '', NULL, 384, '-34.00959779434966,25.66957712173462', '10', 'NMMU', 3, 0, 'Music Department test', '', '', ''),
(200, '', NULL, 385, '-34.00832551320831,25.668307095766068', '11', 'NMMU', 3, 0, 'Education Department test', '', '', 'data:image/png;base64,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');
INSERT INTO `location` (`country`, `address`, `post_box`, `location_id`, `gps`, `location_name`, `username`, `location_type`, `parent_id`, `description`, `boundary`, `plan`, `icon`) VALUES
(200, NULL, NULL, 386, '-34.00834218896232,25.66698208451271', '12', 'NMMU', 3, 369, 'Biological Sciences', NULL, NULL, 'data:image/png;base64,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'),
(200, NULL, NULL, 387, '-34.00965560275004,25.667254328727722', '13', 'NMMU', 3, 369, 'Physics and Chemistry', NULL, NULL, NULL),
(200, '', NULL, 388, '-34.011745439130685,25.661766529083252', '15', 'NMMU', 3, 360, 'Technical Services', 'undefined', '', 'undefined'),
(200, NULL, NULL, 389, '-34.00853192007832,25.67406814545393', '17', 'NMMU', 3, 369, 'Unitas Main Block', NULL, NULL, NULL),
(200, NULL, NULL, 390, '-34.00875576197144,25.67341536283493', '58', 'NMMU', 3, 369, 'Unitas Annex', NULL, NULL, NULL),
(200, NULL, NULL, 391, '-34.00872431801857,25.674973726272583', '18', 'NMMU', 3, 369, 'Veritas Main Block', NULL, NULL, NULL),
(200, NULL, NULL, 392, '-34.00941293792194,25.673401951789856', '60', 'NMMU', 3, 369, 'Xanadu Annex', NULL, NULL, NULL),
(200, NULL, NULL, 393, '-34.00969907514357,25.674096643924713', '19 Xanadu Main Block', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 394, '-34.00937206109728,25.675223171710968', '20 Melodi Main Block', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 395, '-34.010814725967,25.678476691246033', '24 Indoor Sport Centre and Sport Offices', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 396, '-34.00960101036646,25.670601725578308', '35 Universet Lecture Halls', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 397, '-34.00920564113309,25.67826747894287', '36 Stadium and Clubhouse', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 398, '-34.00841931107145,25.674992501735687', '27 Study Centre (Veritas)', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 400, '-34.00917966462464,25.676202178001404', '59 Veritas Annex', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 401, '-34.00917966462464,25.676202178001404', '50 Melodi Annex', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 402, '-34.00882179423462,25.6761834025383', '59 Veritas Annex', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 403, '-34.0062553417948,25.675698928534985', '125', 'NMMU', 3, 369, 'Human Movement Science', NULL, NULL, 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/7AARRHVja3kAAQAEAAAAZAAA/+EDh2h0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8APD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4NCjx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTM4IDc5LjE1OTgyNCwgMjAxNi8wOS8xNC0wMTowOTowMSAgICAgICAgIj4NCgk8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPg0KCQk8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOjlkNTIxY2NkLTI1ZmMtN2Y0Mi04MGY1LTgxN2U0NGM2YWUwZiIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozRUJGOTc5NkQ5NjcxMUU2ODUwNUUyMDI5RkM5QzI1RSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozRUJGOTc5NUQ5NjcxMUU2ODUwNUUyMDI5RkM5QzI1RSIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBJbkRlc2lnbiBDQyAyMDE3IChXaW5kb3dzKSI+DQoJCQk8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDoxMTU0MkFBNEQ5NjUxMUU2QkU5RkQ5RTFDQjExOUMxNSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDoxMTU0MkFBNUQ5NjUxMUU2QkU5RkQ5RTFDQjExOUMxNSIvPg0KCQk8L3JkZjpEZXNjcmlwdGlvbj4NCgk8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'),
(200, NULL, NULL, 404, '-34.01082474848148,25.679216980934143', '126', 'NMMU', 3, 369, 'Dietetics (Sport Center)', NULL, NULL, 'data:image/png;base64,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'),
(200, NULL, NULL, 405, '-34.00625593138617,25.675319731235504', '126', 'NMMU', 3, 369, 'Dietetics', NULL, NULL, 'data:image/png;base64,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'),
(200, NULL, NULL, 406, '-34.00706091631194,25.67507565021515', '51 Unitas/Veritas Clubhouse and Pool', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 407, '-34.01065809945916,25.675089061260223', '53 Xanadu/Melodi Clubhouse ', 'NMMU', 3, 369, NULL, NULL, NULL, NULL);
INSERT INTO `location` (`country`, `address`, `post_box`, `location_id`, `gps`, `location_name`, `username`, `location_type`, `parent_id`, `description`, `boundary`, `plan`, `icon`) VALUES
(200, NULL, NULL, 408, '-34.009280284693304,25.671851634979248', '123', 'NMMU', 3, 369, 'Lecture Theater', NULL, NULL, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAABRBElEQVR42ux9B3wU1d72M7M92Wx67wlJCCW0UEQQBAFFRVTAggWxi12uXntDESuIBbBTFAWxIigoUpQWINQQSnqvW7K9zHfOzOxmd7MpoL7vvd/L+THsZnZ2duY8z/n3c4bBufZ/ujH/2xdwrv3vtnME+C9vC2aEMXYXg6fWtnJ3jdMwS37Tc2fy/XME+C9sxW9kMPWtNkZf1zL9YKVNvnQf1qZFSZ0DUpSOxb9oXWdyrnME+C9rZYuzmZpGk8JYUvXJoBGR11qa9Zj5sT1/azlOx4dJzCMz5bav95l7LAXOEeC/qJ18sxfTqLUp9SUVn4+clD41qO8o2EoL8cKbhxe/8gfeJIe0jumtNG49bnH09JznCPBf0opey2SaCPjG8koefFXKIDhrayBJjsS+letPjXgfM8hhdVFqRtvUxpl7et5zBPgvaBT8Rq1VaSqv8gGfNklyKpq3fYdL37bM3FeLPWRXw4U58rYtxbYe2QLnCPAf3o69nslsOaANG6hoXtf/wvSxqpTBBPxq8glLNqLqVcHktRGPzz/42Vu7eDVQkx4l0ZU2Oe09Of85AvwHt2Ov92IXrKmKvWeAZV2/CTkj5LH94KypBsuK4HPkleHAxGuwa/nGU6M/wI3kg6rwILa51eTqkRo4R4D/0HaUgP/G2qqcB/Mt3/WaNDBLpk6Dq6EeDEMg4wj4Igk4joEkMRENv32DcYvs1xxvwn7yQcPoLFnb9pP2btXAOQL8B7Zjb2RJigorx/WLsaxMmzw6hnWGwtXaLIDlHv1UBfDOHvkvRAO7oQR3zyt+b/khLCE7a1MiJLqKlu7VwDkC/Ac1IvKZghIrW19cef81oySvJVx8icTZZANMBjA88LSJoh9uKUAFAgc2NgibPvjl4OQVuJPsqsqKlTafrHdYuvvNcwT4D2lFb2axW/a3hGZwzcuGjgifFjp8ApzVDWDshABU7HtGfTvw/HuyjygCSFKTUPnNF/b8hbii2Yxi8kHj8HSpcXepo0s1cI4A/wGteGGOZO0vFcMuzzCvyrywT7oioT+clVUEHHdAz2v0s+0k4MR9LLEDEB4JY8kuzHq99plvi7GOfFA7IEmqP1jl6DIodI4A/4uN6HqmRWtV7N1d8fT086WPxY4bJ4FF4afvaRNHP/+WjHfRDmC97QBWAoTa8c6rOzY89DOeITurMqIlrSWNTmtX13COAP9Lbfm9yWxDRdP54xLN7/Yakdw/qPcIXuTDYffV9z4gC+Ke9dvHv6N2QEI4jnzxbcPAtzGN7KogW9PAJImpsMrZaW7gHAH+h1vxohz2t33Nka6mpvlTR8pnxYy9UAKbEq6mRsHF89H3QDvwwnvWzwB0HysQIAlNW9bg0rets/bVYRf5oG5UL1nbjlN2Z2fXc44A/0OtaGEO+8POZoWjsenOaYPxdPLovAhZfC6cVbVk1DvEUd8F8J0YgOIf4KFUh8CuL8YdLxQvXnkYH5GdNUnhjLaqlevUHTxHgH+4Fb2Zw+wpsUjaahuuHJNoXpA8ID49uP954FrMcOl14qinR7YDz3mBzHZiAHr2edsG5FxsBIsv3968Y+bXmEv2VmXGSJtPN3TuDp4jwD/UiGXPLtzQxPZTm64cGWt+Jjk3vF9Y/vngLDK4GusFUe+O6sFXrLNdgIxOJIXwMVUDkTjx5RptnzcxFYId0DgoSWI80Ikd0C0BPrktkjFZXJizsvWMSo3+r7aihb2JqG9SHC1quvaRC/BwQhYFnox4VzBcdUIGzw0828HYCwC8D8iBgfexA2Li0fLn15iy0Hzbrmr8AcEOMHRmB3RKgLX3RCkiGMuDn25rO7n8MDZMHRLMpUbLHVHBrPPpr5vPkcGrFb2Zzew5bWFNBnOktqpx9tQBuC8+Ny5B3XcQQIFvqANDwfX09pkC382x7vc0HhCkhsNQjNufL3pHtAOqk8JYbZXWFdAOCEiAXx9PZI8cbZx94yT1B04Hh1NHWvfe9i3uPdqIE+nRUsttY0NtT65pPqPas/8fW/Gi3uzC9Y2SXLXpvEyl+Y6+6ZgW3b+XQpHWDzBxcLU08ccxnv/OfnTz+HrbAQhAAlYgARvBYeVbm7fO+gaPQYgHNJc0OgPaAQEJMPP8EPn0JMP7l9x63mxIwsE5W1G9ZY/5k+3O5+ftwMfkENOtYzTWSLXE+er6/1uqoYiAvuekiSk91ZiqsJuvubwvboxNC8kNzcsDG5IArrUNnEEndK43sHzrAmTRveM6s/LJ/u5tA+E9E63B4dVfNw58G9Mh2gF5CazxUI2rA1YdCPDDw/HM4181q1ZdadudO31CP0dZPRhVEKTJcdDu2orNO1rXP74Z/yrTomZ83yDzyGyl48VvWv6/lQaHXs9mZDKWWbS+kR0Ux8b8Wdh4xf3nY0ZsrHRsRL8syBMzAGcQuIZ6MlAcHTN2AioI6N51agAy8ESBvSDiGMazr12bBLAD4hLQsGklRr/puPZUCwrJB/Uj0qSGXWWODnZABwKsfzSRvfP96ojtc1CXeOnlEkdZhXAY+XFpaipsDSdx8rejNf/eiAd+Po3fiUowXpgbZPt4m77TYMN/Uzv4WjYjkTDMnlNmOtLZ7CBjf12LefLUPEyOjpKMiMhNgzy5F+kPDTidHlybob0jO4xOYWS7fXnvURrQAHQDzEoBTSgYpZzsI93qspLNKeyXKMl7KZEyBnBmo6he/OyA0HCYSrdj1oLqeeuOYw35oCYhDLoaLTrYAR0I8NI10dKDhxpHv3NH6G+hfUbAyRchQLwRcuERUWDURKZs3er8fJtt6YvbMN9gg+7ui8KscaES+7P/RQbigQW9iJRmqaRmFhOXjb5vqWrKC5Zi5C1DcEFcBEaHxgXHhGZnQBqdRL4RDE7vFvGBRyHH+QHLitE71psYvsDTkc3QWH5UDAHYDBgaYKwshammAQadw2yywVynQ0t0CEJDlFCHRatUIZkZkCf15t1KTtvCXw0HIYrISGSAvBlPv7Dz6/k7sIDsrEqLZFvKml0d8gIdCDDjPI08yKi/a/Hj2Ytkyli42trEWxX1E9UxMjmRBokwFe3BsZ2Vxx/diAe3V6AgM0ZqmtBfbVvyq/YvSYP1/4pn5FKW/WybnqH4kBFJseFcLk/PcS4i6+6aECHYRaQDJeTSJOQYr1vj/+DJS/57d2MTQxu9GfqvtdWoYs2WXIUU2QPjMPiCDAwI12BQSLRKE5yUBEV8AhmBYeBsEjLStaSjzV4d1i62fUU53dUDa90NPD2fXAkmNgqcsQq6gwdQcUqn/f4wDu2rwbF9tThRbQBlmxPtSkGSF4uka/pgzOX9MTJzeIZKmXsBXLVNYJ0O960D4Sw2f7j+0KRPMYfsqQgLYppigmE+0cj5DNAOBLh2ZKhySpzunavvPu9WZ51FgF4EnvUSYZS1krh4coY21P2+zbl2p/OTV3ZgXoMJrZcMUFvG9wtyzF3VcMa2wfK7oplgu3lkhqLtlWAVUqnZYrKi0mZHGxkJLb+eQlVdG6xOF6qJtOOId1sp3gjnczfke1IWBEVIJQwS+0UjND8ZsZogpAQpkaJSIUEVGQJlVBQUsTEEiBAyashmZ3ix7hbtPF08PSXo2K5FOQB/yz7A5xwZ8WxcHFymSjTt2o0Nu62HVxzEr1vKcJQcYBE3G9kcfaMRSUlKtpyRGciJC0dCsEamlKmJbRYcBHUsURe5E+AiYoJpaRR+LjEaJauXG7NexRXkrzKyNQwghuDBGpcPJj4E+Py+eOb6xbVBBXfjl7wZF410VLfwh3TGalqPBpmCSIMEWE/tx+mdp2qW7sSL7xVgba84mfnyQSG2pAip45FVDT1WC8tujZTs3tf8/PvP5TzJRKUT7juFjQ4C4soycMFls8LRZiJX4IRd2yZ2rrfQodcogVStImpTRl6DwChU5LtEzEqJDpUoyKYCzBaiR8nINhnJvbg83eGtzzk/a5ztLBzbmfvm/zkdncEhYMJl0P6xCT9t0x9/60+s21+HU+QAo7iZzk9G4oVpuOjKPIxOSJBlhKQnIyghGZwsjPQ50cEcsQdoyZ+DqHUy8jli3/HFI+77iI1H0+bluHiRfdaBer5cvG5EukS/q9TpI519CPDlA4nsNYuqg0/ORXnq1MvDneXV5Ho7E2ecxy6gZ5HwtgED7d4dOHZIt/ulrXj6l9MoyIqTWaYM0dhTIqTOB1bUd0uEMb3lsiSZ7dJFt4V9o+k7HK76WoGEHsOYjEgJuXm5nDd+GIUy8O3QjqYdQglPxAdcDs/3vY9p/yuwWGe9dfeZAi/aA97+OxMdD5e5BCc27DI+uR6rvyvGTnIIFTeGCCVsl2ZhzF3n4cpemcp+4X37kH4ltocsgnxKeMFLJa7jffrfA90XEgpT2TbcPL/qJY8hGAptjc7XEPQhwLpHkiTvr6vq9els2fHoCybDWVXVMTctdg7nNnAYr5FCxJokPpHozXo07dyN7YXWbxfvwYIdFTieHS+3Ts3X2NOipc57Pq7rlAjD0mXyPaX20KKHcThr2qWxzrIq8R79RpF4+Zz/rTCCTdDhFpnO/W8OZyHWOw3Hen2PFc4vfI28j4mHrWovfvn2ZPm9P2JZpZ730XWxQbDfPBCX3zIC1yYPSI5QZQ8goMcSJWAVLXyi21li2FE7pI0QgXO25xL8DU830YghyDE1ePDpPavf2cvPF6hKiWBbKlp8DUEfAlw9PEQmNxoufufu6O/VvfLham5s7/xOgA8oEeQKSBKIAdlagoZdB5x/HnV88/EBvEvcxsKcBLn16uFh9sxYmfPWJdUdiDA4RSrbX+EIfW0CFtz34ODZrJncuE285gA+r4/xxXQjfgNZ6557ObOATUcVIdyKh3w+3yH7YuJgLd+NL1afPvrQBizT29CgkEB/dz4uums0bk4dnh0hzxpGpGgcOOJqc6ZGmKsrYWtpJR4gEe8SCRSREVClZIAJSQWaiAvK94uXihYxEkhA/oXa8fXijbtmfIl/QTQEtSbO1CkBpo/QyNVm/YPvPNNngYSJEhjnzbKALk2AIIdoaLJE77JxUXDpytBUUIiDx62/fLofH355FJt7Jypsfcg27bww5/WLKjyGydxLNJLXN+hDxqVh5Bd3q9ZHXjQVrvJycFaz3yV7jaxurO1A+vxMCeOx3D2hWOFaWPflEGvec7xVjLq61ScRx05bFdYv31ty89dYRMCvH5+OpHkTMaf/iIR01aBxYIKj4SzdhdbCAzhx2lLxwxEcLm7Cqdo2NBrtsBCyyBNDED8pC0OvGC4ZGj9+goSxh4lqgQkgochrpBIHVq2pGbKYnzBSRraG3jGM8XhDuyfgQ4BrRoaqhofoFt47d+Qdzka7mLTy7zD/BERH3ekxlBhRRMuURDXEwGWshu5QIapO6U6u2odP1hVhdYkWTVOHhdnjw6SO5AjWSYfLE6sbqWKP2HYrfujdJ2RgSEYyZOEx7Va6gdy00QBf8eFrrfvk1r31eWf2TKeSwlff8p/QgEyIhhhzQcQAa+M3p56MVDN5T+wTWUwyMTbJ9dbVCn0WH4IjK9fpL/kY8/VW1Dw7FlffNF45JfKCC8FG94WrZh/vSX272/nnJwewnrh/VDVQn84mvjq8LlY+KBY5y6/Fk31mXhnKNHnXfHrhQcGLjUbVuo+cmfMxhdiLp8kHdQMTGUNhNedq7zWxfXZPHHPze3VBf96Bb/OvHXeRs66tXbx0KiI7AT7QyOGVM7ERYuPIqxGWsqNoOlpiO1LK/bjyINYQ9bC51QLzJYNCHBsOGIi5DjrpLYpIgvOTQzFycg4GDEhB7/AYVVBwYixUcQng5AQAlmwucrjZSnx14hmYTR6wfEQy2kOp3v/7GIYBbAeWGpxBwcImJUe7iA42t8JUXQVjRQ0qah31+8tR8WcFyqxOGMmVyK7sh8EXXRCeqxlxGQ+dfu+PmL249ePDDSj+4ErcPWJiRpoiZyz/E6YDG7H9t5rTj27E0sONPPBUfFBxZxI3qz8ByKa+LAsXrnggfF7o0KuIOqhvlzbeuYTIGLTuXI0pb7TN+aMS28je2pwYRlfcwDl875K0lfcmMje8U60++iD2Z181uZezuqnbZEag+EBA/9fjLbRb84wmHEyoCpyxFm3FhAynG1v3l2LDd8fx/dZybK828H4dQRdEziGU3jTZVEPikZoZjsze0cgcnYH0lCgkhIbJghRRRD/GREGmCQUnkZOfkgkuHzWe6Hsb7VcJf12c2zugUoN6EbyoI8YxUVn8K82c0uQZZyOEMsDS1AhLQxP09W320kZU/34SpUfqcYK4bifLdaApP7u4uTtW+uQoTH/0pujp6sGjsOXdb6pf+R3fLJmO29MuHadgpQlEghA3cMtaLFpn+OGlbVjr4EBHHJXnWvHVDT49r0vcaKfKxL6IqH4KBfFTZwH1zRDFtG9+Qa0hnsDvuOnlypeJJ7CW7KyO16C1Vt/uCXgI8OUDScQFrAop+zeaEy+/SuKsrPYyAP8i8DSTxfiJXE5UD/QzGgIlOHCGGrSdOIbW8kZTeR12fbYfWwgRDmwqQRU5UiGyX+b/mhGOyJxIpBA3Ki4lDHG5MYhIDEd4VAjCNUpoZEQqy0OUhNDC7co0QZ73Nr1Z9J2F98RjtOtMMNTr0VzZQgZQOepazKgl11FDRHONk+NHqBtwm9dmj1NDQQQn9eOllKw778KHAwcoU7/bZDk9eog8LW7i5RKmlfA6Kgza7V/j+c8Nqxftxo8i4DToQpHUU/CD5bCGB7OOyBCpKzFC6tIEyRAbJmO/LzBISxusQS+MwQP3Xx/9jGbgVPKt+vbqIra9fyGVEe+3FLf9u+CzTw/iPfJBZXI401LZynk8AQ8Bnrk6Wrr3YGPOx7cojkSNvhTOmpoO7teZAY/OLWxvS1oMiQr+PRmhYRFgVGS/pRH2hiroT5ehtd7cVFSLfd8fQ2GjCUd2VqGk2cyPNqk4rGVer+593hvbPwbRLt6FAZMUgkh3eUaTGXqrg1oW4IjR1WLn+PO6R5wYgeL3uUe4QwRbOjIJOVkRGDi5DwYmRyFXoZSElFY79436ALMoOZ+5AHPvn4Tr7IwcMZOmg6nX8raDpXovFn1w6vfHf+VT661kq6eXQsFXK2BKi5TaEyJkzl+OtC/18syMJLa21c7GuLSDxydZn80bFDw5Ysw0otW1HXHwuMvkfZAO78z/9Zf7N+AFsrMiLZJtKmtunznsIcBVwzQyuUk/4d27I9eHZI8kLmCTXw6guzj3GQLvJpDbX3afF166OkhNXB4NGCnR7+YW2JtrYaqsgKFOZ2vREzFcjaItpThltKG8So+SP6vQ4JHz7nBg+3vG69V74wJsbvD5Vzqy8+OJhFGh17BE5IzIQN+4SCZHnRApUadnEVUWD0YeQahnx+GPPjs9YBGupN99fiwee3Km/EZmMAG/rpXP6HFxITjw2drm0UvwpNmBOnIcrROj163tlyg1J4TL7G7gX7o+iQlTy9ni0tYgXUPrtAdGYnZiinxU5HnngQ3JBhobvbKIAbChuzRObP7guyMTP8G95K9ysjUSiWkqaRWg8hBg2vBQeZBZd/M7/0pbpgzPhou6F38X8J2VNLvdyUC17u4CCS/DjFURkyCYkEJBBrlDR1S0Hk4t1c8NsDS3wqy12Axm1GiNaKjTo/6XYtQQ3aolYttscaCZvFJRzZARb9ZZoSWulSJUiQj3+YNliJcwUEkZhE3IQkJCOGKiNEjVqJlYZWQoMTzjII8h+lsVTcyKSKKhXbw3AoeQq+HUBnz22k+bZn+Lp6kY3347Phg569LhjJYT0rmqYNj1x/HgS8e+fn8fviLHVIsEaBmWITemRCuca3cbuAU3JjONeicbZG7pEyOxzLlsAK6Lyk3SBGUPJHKF/H4LIZPD5jWEOwtWCa7g4VWf1w9YiBvgcQVhON7gR4DpI0KVGovuyXdfHPQUYyOGFPkBAY8uMlvdBYb8L+xMgO9QISvqNfHMQhiX5iLkvIXOKMirhHziJNLNbuSNOIa8t7cZCVFMRL+TV362tJN8ZIfTauONXFmISugGIqblocFg5cFkXwg4KdkvJbYCjbtLQwSwqSFJcwceB9TLe1AGwda4C7c9d2zZysP4gor20sexM/XqG1WoExM0EbHQ7luHyQsMz++qwm4I1Tr1ecly/YgcjT0mTA6tycUmQDvuomTLo6lp8osi8vMhicwSTEKD1jMY2pNTfsD7pKNJD8VGovrrZc7kebhMJEBdXjxjOFTLOf0JoDovVLfo3kdH3e5qcokuXQBWiSf3BIZ6FEwRL6zbuHog4LsgiycaKNTWs24wgPZrpQSh3+FzBmINPs2XU3uDdhDvHYj7vXMHgVqAGn4PsYnL1bLtY+pyPUFU0e5LeiF25b0hn4cPJ9qguUH4jUhCgD1rccmrbY/vruZzAJQATc9dk2iuaHZwcZx28BWZ1gUZOSEXRgwfCUaZwo92Ohg7xvyF3+/SHqP9GRWN5s2fYNzr1lnEzdxHJU5mJDGtmgWPhT/rx3fFM7OX1AZtuQWrRt104RVcoyheOgOe/rCkh8GULmvZ2/d5vIUzAt4/uNOJ6vGOBXinf5hO/P8uxaof8O7XKDVOffGBKftV3Eo7edYATFryTO8n5GF9idQQYxPEprFpj+LxBcc+f2s3v5AD9W5arspB7wdH4qmcbPllUeePBhOcQWjRRCSWU4Shaync1b1z4VHQ7/0C017XPbq5FJvIB9UxwdA2GAVXkL/VT+ckMrPerVbvuwc/582YdJ6r0eibA/CKnfckIthT4L3FF9uJROgYvz/zqF6HEHBX9kxn0gte+wKRNMSINW9+W3jNV3iR7Kz79lo8O+XeSROhZX37JC4Cld9+bnnrZ9cKrQXNd4/EmPR0+Xl0xLNhOWAaGvn0rsDFziSl3yDrJvVsKvkVN7xU/so3YiyA2KEtdQbeHhIIsPzeJPamd6pCih5CYdZVl6U5iWvBMO03z3UJvKiXvUYR4xlZXQPP9pAsPuTrIXicF3jdpnS7kl7eXkrAa+V49eIwHMQdT+z7kvjbK8gHDcVz8VPWdTOjOGr9A+2/Q1QSExVM3Owj/F5JVAqf+WN8DLseSB//geKVkPKxmci12Zr3YfYzR99bdQSfUamTGIrmah0fZBIIsPK+JMkNi6vUpx9FZerUaSHO6noaBA5s2Xv57fz/UqJjFQpiLMk8opQfcTabUEYVIF/9TwHvndZle6J6vEfwWagtzygjYrb1j09x+au6p6n+H5eG0NVzVGuixs4E01jb0U2jTa4Q+tBua++egMDD7/q8rhds4Hvi/I6VVeKOh3Z89cEBLCI7K5LD0Fyp5cPNAoqf358suf7typDKJ9Eaf9m1cFbVCMT3qzblzS0pATuSuEAyop8szXAZtUSvtcLRRiOZTv6UrEwJmUYDeXgEOGU4saLDiBVLblTX2n6znc6GbRe57cB3DZ7HfugpeIGA949U9rAOgJKdiaT6fynV/7dB0P8T33+6zxPKqP7kvtsCA+tOMnnsDf/R6w5Z0H2MH7BAtyT2HhjKRrz+wuafH92El8jOcuL6NuksvF8h/MKUfI3U1KzPWnGr7Fj0hVeBq6trZ60beFrGFBkCl7YM2oMHUVtp1B+sRMmWEpTprWgim9ZdtEPcdIVGjjBibSaM6YXMrEQmJSIrRaLM7AdGEgNXYwMY6hcHqMJhewge53XDZwS8d4lXV/aMWEzqNTyFT/328bmNID1Wvfbd/hu/5ju47rvr8MzlcyZOYgwKr0MDFKl4vzJdgHymwHvbLOT+OJUWn77207bZ3/Irh1DPoyGRmAbVBpGGU4dqZDatvt8nt6v2R46YQgCq85SCcYwEbGIc7I1FqPljv33VLuzadAq7tlfiBLzi4BBCpO7qVXeUjfpa0nAFQiZmYsRtw3DRoDx1RtjIceRoDbjWFq9U9pkB31GNdDcS3Po8AFn8gaFg0JVV7AaymYgbZhbiC2RjHWTgUBfaIVr2cilsQRGY/VzZZ0TH0tKrhpOPYlPmxQNCmeKD7aemSSmaRuZf3Ykqoj5lwUKtv5S8ytXCe/9r8Qfen8Q+doDXPneXqC3YvGzdkYkf4wGIwaCUUBgrdCIBrhwaKpebdBPfnxP+gyZ3PD+nTagGloJNJvpt63p8sdmw/5Xt+LqmjY9b8+nKYQkIi1AhSCWDjHYZI4RO+dZkRuPpVhiq9LyooUkbOhwUF6Uj//kJmDVoXK94Ra8LyHhp4Fe7FC62E/B6Yg90EVRqDz55d6j4SsG1ECLa9eJrG80KkdO3106y3oPXr3FpOWg+VIYLXrM+XNSEw5N7IW7lfeoVYRkxYKpK4AlQ+FZjd94YqUAKmQag6lNOXhWRQiGr+7rd6qrTGIyXOqFv1U789sHqovEf8gQopQRID4ehtNVNgGGhCoVJd8mS++O+UWeMhIvqapq6TYlD3Ya1rhe+sX1TrkND70gkjcpAQlYMEog2iJdrlJCqFIS0NKUq8cqw24ldYCR9a4PJ6DQ0G1B9qAqnt5Xh9MkWFBXWou3VSbjj5qviRgcPvpxozdr2C/a6oR67bwFXzvA+zj2qibCyNBH6ks3awtswtFgUXmfzgO4tGDpFn/zLHYiCNYV1w97Fg2RP7WMjcc28J7LvkTZWkt/wN4L9f8X9J9vxc/+v0SpmZQSgiiFbFCFGuBcBxC9w3pVB7gsk/UhMsMMrVtBw8M0iAep7RcBwqgUu/meuGh6qCDbpZr43N+UjZfxgcG16sAmJaN3zA0qOaE3RkZCFp0TLgtPSwarJD0vUfJgUDo4XZ4ySFkxIBbHpsgkXplTzBiNnMQKtteBMzbA11cFYXoa6KnPzhiMoHBCLrFGT01OUaUQSaFt8a+87VOQCHdSCf1DGe6TTk1FwLcSvNhKbxkwkjU0XCMMzA937SxIJuNQcPPvSsV9e3ManWxv+vBPvjbh2wEBe/AfE3u9H2M5OHmi3d3WSlM9JIDiB9H08kRghvnaEt9oMl+HYqk+a+r2Bm0QC1GVHwnCimZfalABhyhCz9vb3n8p+W6bOAichop+th5W4MIqkbPIDcaQT7eD0ejGeTk5PXB+oHERdVKDt1EmYG1vRquNaCAl52amUIUitkQYHxccgODMHTEgyIQhN+jv46U+cthLao4cJLjokXEqkgI50pjhnoVt7oAPwXkYUFeHGaqKgaoSR7t8YX2l8xqB7iXQuNhltRNdNf6Xp1Z9PY0uyBtbdcyWb4s7LlTCnj5wl2AEuKCAn/CSFlAzK4CQgJEUgBtrJwIWrcGzlMkoAtwSoy46C/kSTSIArCQE0Zu0d7z/dd5EsOANseiaRAs3gDFZwuhZP5/ICRhEENjoYpqM7ULKvonXVXuwsqMH+PdU4bXTwxRLuNCpSQ6EZEo/cMWnIv2wgzksYkquU9zqPCCCiYmgRRgQRZyCWiI7oyqghYHnvAz0D3n1FNKavIeKRMfCgM9Rwc5e8MW4XUSIUuDbWgDO2tev0rtZH8el0piMutGN7D0Tpz4XWnFdwOxGGVTf0x/lLH018UaVwgGlp8DMeegB2Z0B3SVJv1ecmA82akgEXksarDC5Cjeq17zqTX+SmigSozYmCrthNgKnDwlRhVu297z/d71VpcDo4q5XvRJ+pztQdJKKe1dhR/uNP1gUbXd9/dAC/OoVSJmroUfDd9WvuaTZ0owUaiuggRDwwHNfOHi+7JPbiqyRoprNZRGmiJoZOBDF06EMQxH1dG3gQ1E24FJy9Aa37DqKqrE13uBrlu8pRa3MIJIzXIGhAAqJ7xyM1Jk6pCe2VAGmEhs/oMVWn+dW5fIjgP8o7YwYvdEh/5AzAh28W7r7je7xGR9WX0/HE9HvyJjMnjwRAswdgsz2UCF01zvOf0Ihq4LJHoG7Tz0h4jpviIUA0tMWNIgGuIASItmlfWLogf67TEin46D6hWyHiJUmMwOk1X1iv/gQLDzegCOAnLtLoDi1pop6Bu4rVfQWsmwAQ6vtCJmfh/HevYZ9MufoGBVOrFzwAb/3WFfB0ZFPxbieSIjEWhqJTKC9swe4KHFx3HAWNRjQU1qGcjEazFxH5m+hPDNfhiRh081Bc0Cc3ODmsXxoYWm9feUokQmeg+xttoldCpJfZLsOseVXL1hThe5UUzUfn4re0iweqBP3PdnqKvwQ21+FNF6cQXfmMPqjbfpgS4AqRADUhMugMdjj4Xs9OUASNibW+sOS14Y8420LFebVeMXuqAiKiYDyxBXe9VbPyiyN8Vokq2AaRALQOzj36nQnEHtGTv9psnliATCQBLWYMu38YZs67I/Z+db/LgBavgkbPjflZ9tTn1p4kNCsj4p6M4L5DyPcahTAqQ2074nEYLLDq2tDW0GarbkHlpmIcPVSLgm0V2N9o4qUT676OManoe+tgTL10VNCQsPxcXlwz9ZXCb3nCtt6A+3Uw7dRe/VC17ag97xXXPVorSq/ORfYnD0e/p45WkXNVwUe/nA3Y/iO5w9d6KBl8CUBVAPVNa0Pk0BpsIgFIC7p9ENoJwE+5ag+2CMuPxaLq2+XO3gtwn9nBz8illSy00kGfmyC3hKsljnC11LV+v8Fz1VOGBDO0sJ4WORyvsUsb9NQKhEYhQeyhh7Ax69obI9Bg6Kjn3VE46rJpiwm9aju/P2r/KUmnK4PABYfwKVfqktK8vrG8Fi2lTfYDp7Fr9WFs+OUU/mix8uqBxiWCCBEGzpuEu/LHJSUp4ojffvKQmInz6lyffuY8L1xWHr54/+DBmWswj+ypW3YZHrn1obypbOlxwfvwsS+6AKuzEc2eAciBT9h+re0EuFIkQI2aEKDNiwDBhADPCwQI440X7/AqTwBizZeuWW7t/RruICKW1pbRcqamob2CjUN7qZ1SCcPRedgyCZ1LIFQTOl0c7ORgBwGDgA6d2SldtqmJqoKI3Xfj+6E3Te8HraM9Vu4Gnor5VtKRVjF3EMBY88Q6yO9x8alEtoQKZVfu/D+t54+MJVATA7GhEsbTlagratB9VYBvPz6AL0638upLKWMR8uI43Hn75KBLw4fngSkuJJLF6heB80KFjqiwKFicctz8YtUHbvF/6GFsyJw8MJQ5ccjPPw+ED+dzym5J0hXAHXZ1sFYJAXIJAY4QAri6JwBnDEfHYALDL0duKd+OD1aUb/3xBJYXNaGgxsCTwDo1BwkEc6nnN8nhRxuIldnM17i7xuWF8TKlrN6M0/U2+ZgUDF01Cz8mTL1dwde0uyc6UuBbjvKRuEDA+7hv1J2LJj5wbBL0R06g9rS27WQdKur00KoVkKdGIpKYLElhKREyTWYisRnSiJXSBkd1NZoKTzs37nNumL8NS0628tcYdOtATH7pWsX9MWPzWebIHkES+MyL9OpQj/h3zhHFf9ZH94W/p0km91lb4eWPB0CICXBjgVqnDkQAonTFHUrYdEKAHYQAz/aEAKaI9lCj97QvfvGhWDiaDqPtxAkyOA3gxMUnpcEKsFLfq3BY7HBZiV9oQ4PNDp3VhkbeIJAgNCpa0jd6/GVgTERcO6w9Bt6Hk1FxcCg02PvDiaYXfuNnFtHFkDyLKtCjyOiWTshAn0lZGHVFPjs6IT9TJk2I54s4nTot6nYW2ZZvd33+9i6srCdmxvX9MGHhTcq5USMHSJijexFYjxMqZw/E54v3HbxhLZ/8qf3gcjwy+4H+U9nyYnEtAy9gvAxcKjlo6hhSYaww7rUaGEbMgjKCFGuqJV6t3pft3bbOA0heBPDYAN0QoH2SgU+Wju6jkyDVRNcqZO2iTqylY1ixPJ/OO6B1ArTTaPjVRXChASQ+CEREsoJImRYigduINd98SAjJ9gR475vqm4+C1QUtF32IeXqbUFMvbu5YhLcBqowhbuj9ght6WezoPJZp0/GLKdnqGlG8vazu5U1Y+OUx7H9yNG5+fHbszKAYDZjq017XJIr/iFgYicl748s1731bjA1U/B+eiw0Zk/NDmeIDflJD7EO6khixT6z1TUQsVuF0tb36eA1q9hNhRF1WhRTssBTEZMcjIS1BkRCWkwh5LCFKmx5MTalQp+hvnHZo/pKqvbOoCijacKi172vcLSIBaoKJF2C0dyDACIEA3qM+kFsWoMYu8Jz8AIWMlM20apcCT0f+mQDvvkG1BhZ5OGY9X/45AW0jvCZWdEYAiG7o4Dj0e2cq/p1/aU6ClHoXVNTHpaBlzxF8ttH4/cvbsXzldMyfeOuQLPb0USEu4RVipb5/6cZCa//XXHebHKi4pi8GfvBQzOu89d9Q3T546OExibwdojt8EgcKWqs/3YvtP59CAZE2lPHuLKr3tC9JWhgix6Zi6C3DMD5vcERKaP8sYgg3gamrgCfi2QMeeHcml94bR3863NT/de5WkQC1MWroGtq8CHDbIDyzZH7+o4SuYoCm61KqDmnZzkK3nnn4EPx47Qli4B0TjbUzAN6bACGhsCkj8ND80i/f24fVEAxSSgJ9mArWECXrsjtdIJ4ha7TxtombBHTCaSidQrZiGhZMuCanj9RKRpmuGVxmP9gam7Ftffmprw5iw6u3aO4Ly4oX4gTunDWN/af3waJXC3c8tJGvrqn7agaennbvkInMycPifEOIQaKBsNY2oODX8obnfsHaX0tBxAMfNKMusxkd4ybuoJncTdgp2Rj9yBjMGHJBYmpQZgoYSkg69bzbCKPvx9QLOPTDwYaBb/IE4ANBaeHQlbWKgSD6YzcPwB1Lnu7/lkyTLZRKdxGSFbjQw+oZVhziJiLuG/e359G97qHHwHvH4fsPR/2WAufCDc4VSwvwPjHGqPOtm9hXagsLYpxf7RWemTciQ8JqTRxb1eqStlnbYxGRSiRtmI1Phlw3LJ6l7h8hPRefApc8CMc2HtPJWU6VfflAOXPisPibBNSEdOjKm3D1q63zfyvDH8kamP98WLohcUw/OXPqCNyhaa7PEGj3HcGSdbrtL27Fl8RtpvP+qHTyn/jpX0PhHTOhEktN7Jjwu4fiyocvls1MHj9IwbTWgWmq81VNXRKAnJpIgF+/OHT8og+4RyDUA9Qmh0JfqWuPBAaFWrS3L32mz0J5aB9xgYOOiw74FnP2MFlDQ7ZNxD5rcwda/gLw3l8ktggdZZayKlQVVum+K8SaLaVY+dMpHIgPY+3xoXDkZ0idy7a0P0M3L0kiKWtyKvQWXhJEXJCKMWvnqJZGDe4FpuSYcGpNGA907eZ9SBibJ4w6UazT2P/+rwoa8xcLqd85+bjo9X+lPqFgrbwU4Ud+78FoLijCC6t06xbvwXoRdKqeWkUS8OAzIvicmDehg1oqFEdLCHXdE195tUW20IGxyFs8FU8Mv6x3klQpAVNxqnt1IH7IZeZiw6eFhy/9lF87mE8GJYTAQLw4kQBD+VzAHUufzVkoC80TEid+FTPt9kBniZkAoVsjGZQN+4Tp1n8H8F435alGjk3kk0oukwXao6WorjAfW1WAL747ji+LW1B3frbUFhvCOMNUjPPjHTZu6kAZu/O0XV5v4CVB9K+zsfzCmwbl8/67ONJddE5ir/7g9C1gq0sFI5fss4fE4uEXi9e9sxcraSfuvAtLh1+f3585IVT+cKnZMJTW49mPmr5duBvfQZjtW4/2Wb9mCSOIfYJ8p0voRajAEtpSiUWJQKcu8VKLqK7ENy8hKufKxOFBKTGEnMe6TxTxkcAcfLzw4PbbvuW9Fr4eIFYNQ32bWA9ACaAyaS9f+lDil+qcceRStZ3n5ruqvHHvo4A3EDfK6F4f/+8E3sum8D6pIkgICCkVcDTr0HikwnnwhGP94p1YtOE09iVFMLbze8nsMRrWpVYyWL3bqihtdIXfMgAPfzC/9yOShgoxtCwacXIFXANGAkS3s1pqI/RBzZ/HnSNesT5c1YZiYqiFrrk/+MvIvHQwxP3jNBFwBEXgoyVF++/+Ee9CCJPXia86mYTofI4oGhd6vHZivIZhLA7IWk2cR3XJWcTMG4+H7pkZd0VQdroQuHIrkID9ST4kXsC/Hj/ww+s78TbEkrBIFQzNZnEYTRkapiQEmLzsweiv1b0v4QnAib3c/TJpflk6WnhRv0dYYOEvAx8gJs/6f+aXDqX4hRA3MzaZ91C0B0+g6Jhx11s78NrXRfgtNZKxZcdJ7SoFw3y/36YmBJhLCPB4OwG8roWSIFgNli7/ktEPny3at3/2N3iVfFj75kTMeeCRPjPYhipeZXK5g3H0mz36se+4nmm28J1M2U9Hv1YphcnhIv6GqzuLLXDLimEl1a0uucnuWTAj+rUJeOzumXFTg9ITfdRUhyaTwxGVhFsfO7Zy+SF+OjqN4jZoFDDqrSIBLhsSquB0umHL7wneFnb+THBN9Xw4t8d63g1I82HBygd8wD974Fk/nP3Csj6Hen9HfC+VgUvuBY4AqT1wAseOGHa9uxOLVx/lXUdqfCl234Wfh84cOpA5fqD9nH7ShUoWfVUrrnu1+S0iTbYQA7J1z0PMhvTJQ9V0BHIx8TC1cbjj5Yrlnx/h9b5n1q9KBqPZji4f3tiTlhPDMm1Wl6xa50OCx++eGX8lrw7Kijt2NL1+dSjMnAo3PFO6aN1x/oGS/BRxwKss/NLBoQqXTtd/+d2qvZGjryVAtvRsdoobXWrZ1+0SAjo9HfVnBXyAYAfr95nPqURXUyonRMgER171RaWoP91aXdGI3SFKpPQ7Lz4/ODYEDNX1TAD3imo4Ytjt+WJP/Yh3eSu69sb+GL3k8eTnVMEMb5FTY7Rwzd7moW9zjxLdTq1d6pE0qBXEE7Xx6ZCzGvn+beogKWOwMrJfj9lVbhJ8MhWvXXtDxliFWuYbhhZB4KLioa9twxUvNTy5tRy/k70VEUEEYZPXxJDJgzXyn/brw6qfRn38lXcSMOu90OsCeNrMjdQcEqx95myBh9/vdAM8G0ASeN10+24/9UCDW3E0caQW5vTTkCwR30zFyQCRNtGAotFCNhgPvFTy1dL9fMyhbtfd+HDY9cP68MYfnfMfEoOHXjj+7buCcUgjNjXE2GuRS4g57fh7wHe3f10WzNQSl3blH2ZKgnCFBHHfXI8PL7oxr5+0rUX0Rtq7lErAxv2nkD/PfFulHkREoypUiRadhQ+YCYdePChEtvGAIaz0cZxOnXZLCBq0XhND/IsyvN7THD118byx6U7cd4hrBzLuugO+k9He6QW4i07ckUy/j33Cvd77CQGyBqB00wHr8NcdDzWZUTIpA7GfP6D5LDw3CUzlad7yr997CqNeNT9yuhVHRALUB8thMNr+uujf/Xw4Ef0cmttcjN7EMYUVduZ4tYvZfNRGPQSqDsJTQ5HzzSz2owEzhsWwVBWIC0jyAbv0HJz+5ZAp62UnLQgtowRQy9HaZvOaHDohTy3ddKgttOgR7MuZcW0qWqztnRUIePqeWvmGcs+oP2s9/3cAHzB3znm9sOjUq/AH3ePtgF81zBmTgvnzD//29BZ+Onfdmhl46qq7Bk5k+ZIyG58Z/PWz/acnfMQ9BUG/VhGLv1nKwHw2o//465F0ZXzmrZ9MEroUclO1JZeM8jQJi1i66jldEoOHluGNynoCZPUflahPUGPAt3MUbyVOyJfznoF4DzQPsH3V/pIxS7mHIVYDqSQ0M+81PfytWYmShz6tDi2Yg58Gz7xyOHQsAs9Hg5Dcqd3B6/tuR32PgXfv/zuBZwN81V/E+5/e15DkevVBHXH9xr1hfup4Ew71CoNr61z5j/Gj+kmYkqO8kelMyMQjTxz8ftEe/gldZbSDidWvI+5bp0/r9G8n34xg39xgYq/MQcLKrZaxV/XF+VkJ7HkhIWx2cLRaoQhV8yubydRKYSEteqVOJ2x6E6xNBhjqWl1HS+yFLTpOcckl0X01vZJ415Q/Lr03Fr68f8vDP+N1kQB1McHQNxjRvkLI6zfFS+Yurw3ZeCM+mXD7xVP5NG0gX19Cp0SdIhw/zq9T+/cB7w/IWQLPee3vzrj0HBPIs+B4+8CVnIVPFxUeuPU73vWre2kcZv1rbp+bpfpGMCYDuMg44kxbMW1e7SubSvArRBcrMojsNnXt7594I5JduMHIZgTZcx1tzmmX5jGXR8cpB2kyE6CMCRX6j+ZOLCYwZqMQnKOFKu58A51mplSCCwoRimEIGdtOV0LX7EDiiEzwgS2FEnZNLGb/+9iKlYf5aeuUoPVhSrRpLcL18QR45foY9t+fN6ifG4NXnnl+zN2wxvjNliVN5oLFXgH9sROIGZgBpmh/4OBDZ3r+fwL4Ho/2ToxI76KP1Cy0HqvExJd1z++rw774YBh2PCj5If3iwWo+8UOPSslCQ8FJ9H7WcqvWys+VrFBJ0USsbHO1vqP4L3o1gpHLGHbTPmNkXYXl+qsHM7fGpWv6hfZJg5Rf+MohZP4MWj+fPtDEUr/T0zB0XDIPOlMuuOKUoNQDmPJi/TPbKviVQnkXMFgGE53m4TnbvBmRzFNfNQffMgD3Lnmu33xZ+EBiHYuGBD2CundNO/mAQuH3JxwDr8iWSvUNYDwRQ3Q/6jsN4HiD8ncC39Vo76RilxXPyUrgSsvFjx/sO3nFKjxH9tTNPQ+T5z2S/ohcYgfT2iR0ONGvh78vbB7whusuiAZWnAatdXr4LMl+ZH44c6DCyVaUGbNDGecDlw+Vz4oZmKpQxETwD6tgGmvElUzdkHRRANKBwAFu3T2xNy0Hlb8fsfd50Xqr0QFisaNSo0Cz3grPMwS9fynoun64atnDCSuCcy8VwsFUxrdVg6vfyVeqML3zsOyNQ4fG5CIr54qhKr5q5p8w8DoFvivDrrMYQjfA+7uUtOOSMqE9XYerFjS//nsZdkQo0frHvey6nKuGR/IGljs5lJmLnz89UHTJx9zjEA2s1AhGV97S/rTuvS+GSw6eNGckuSzP9O8bfF1MfqZEoiIeXH2Fb9WPP+hdAd2j8nGaA+iN35fvKxn3Afcv8fqqg2TQmuzwrErh+VXiCqoYg2Hw8juVOyLH3SaUXbdVgav7oz0wlt0PG5cfKVm5D3vemxN2rSYtVjA2/AMoZ2vgdQt8D/V7d1FDz2/4/75g99CK3/VLdp28fAW/umbtXUMw+s1/pTyrDJa0p2LpbRIX66O3Cnfc/h1ehrgE2/R8uX5Ngc254NpgRq93qGNd1qeuPF/1QNzIHIWEuAdMZamgy727v1Owu0v1drGDGIuu+HQ88UzhTwv+4Oct0uurJRJATyRAx8WiiSuoIK5gWMWTqEiafpecKyV6joLvHVToPQAnfzpozHkNj628GndcMzsnT2JoBqNt8lIF7Jnr+W5F/dkA39VoD9Cx7rBvciZ0JfW4cn4TP/qpTt99H7u631X5ScypwyL4ootMRth9c/d//85evCN2cMOcccq2FjOHnCD7hTPy8HH6hdnJiohQPmYA9zMPWP+gUxdgdwVyh6+0G7F04oqhiRioL1TN9zZQQ4kBqLOg43LxF/YNkm05ago7/CD+6HvV+Czm6K8dKlNp0KPpUBnOf9X2qMEK/cbZmN9/en44S9OS/M0xnYv7swJe3P8/ALywTAwj6P5lBVT3e0b/a/clPhscpRTW++HvkeP1rIu4gLfPPfjlx4VYJnZw4w1DpY4RUY4XZkwMfSTqvH6CqKczn316u7NrCbCjM5C7arx66oPSjQesefNtdxD9T58VUCGXoFniF5/wXNKtY0OkH/1u0GyahVXjb8q7mCk+1JEA4dEwO+W48cXqt9cdx5YhcUhde5t0QerFgxX8pAqbNXAptfeKFd4d/08A352Y9wbdDby70wjBW4+U4+o3te7R37zrXvbz/tPyk/mMmzvvSr+vVMGmisTNT5xYsvooHyKu7BUO24ppWDngorQxyiSiHkuKhCpfJsA1dAD8LMH26TOvPUQ9rVxYsP8mYdmaMgj6v9Vb//sQ4LmrNOxz6/Qhswfg8Q/m5zzGVouTJz1JQaEgkcvsi+dfOLzh+a1YTPZapuRgxHsz5fMSJuSzfEbNE4ZEN6P+HwKeDbDfo546CRfzfr8cLuLWffN+QfG01fxsn9oHh2Psyw8kP6XUyHzLsPjl11T80jCEAO8TAnyZFALtF9cxHwyfmjtUKuHA1HlPNfMHnPO5xJ6BzSGgmeD+rlcGk9OEw2hmMfv5Ujpv8RsI0qlOTfR/mxWBHxv32OQgZsFPpuDr+2H60rnxHwcHucDQdei9LXx68txB2LX6QPnI93EHhDIn5uY8XPL8VOmTKROHyFBWDMak78j6rgy8fwJ4N7DeefJApHNfAhGZjXuKMfn1theI378/UoXWHdTyv/q8SJ7YDOsLoIpKAEKAx08sIdLw6w03M6+Ont5nkNRlFcnCdAH42YDN9kwgiFXApZsOWvu/ZKWVy1T8UzY2quUwtdnQ+YMj06MZVZiE67XxAdmh6EGZYMqO+06R4juqHxp2H8eQBY5rqg188IMqf9XYNIxeOoN5KePigSGStlbfEcB1Ajz/8g8AL3aESxUMhnQGfYwM638v7t/mwQyCMzIBS946tOfen7CQ7Kyd2R+DFt8e+iY/eZQWhnrbN2KewBYUiRv/XbwsPxEJ99/d6zK5khV8ek89ZU8A/wtg+3QEPDEM6sa+s6Bg5/0/4Q0Io786WI4Wow1dPzt4XK5M8VuRPaz4XziUdXFeDK/X/RY5pGvPWlxK3DKv8rUvjwqrYkMobAzNDEe/pVfixfMnJGcqEuPAlBa1r5PTI1fx7wGef0lIBadUo+LXQ1AlxiAmK1JI+3p/hxWO57LzUPnLfvvYt2xPler4R7dSFI0LL8ZTt10Xf2NQegK5l+Nij4npcEIAK5EAS94r/n3mxZqxkfk5wv12W63rD3hPwOa62OU7qLiEFLSeqMPU+Y3ztlfgD5EAdSEKGAzWjtlJHwKMypLIdpx0hv56C7648OYBFzHHD3q5Pe5OZ/gOW/Ne4e5rvuJXnaKmMa0uoenJcFqz9u9RuOPOCfJr4kbmsozLIayW5fDOjQQa9X8T8MEagLhy5pIK/LqxujxOjcgh1w1Rs1WlQrTNO0zNEzoaNpccz79xcuP8HfgUQjEHreWj0bKgNyZi3p0zE2cE0QTL6WPt6kQZxBOgaONxZ951wyQsJRc/nzBQGPxMAOcC/BngCwGzm4KN9tuHOysu+tD1b/FeaHq6SRT/HZjkc7VPT1FJXvzeHDJrIB5e9kLW07KWGj4Z4RsMID+S1R8Vvx2y57/OXdFk4dUArXql7HJXqkTmxaL/o6Nw+yWjQ4aG5WUI6wfXVvBJlA6/ftYRQ6/7IeKe+vAuownlO4qtb220/+wi+C64N+GK4IQwMDVlHdQZv4QMIXPh6l3aC993Pa6z8dEy2mm0ZIpayzTfTkuvnrnzutir1L3TwZw66rkoru9QvlRMEy4VSrJ8Fmk6C8ADgc128x2vXXQmkqHWgJnzKt/98SR+FsGvVcmgNftZ/wEJ8NAEJfPWJkvw1Bxc+PF9Yd+HpYaLHed1NXTURMbCYpfg1peqXvtCWIC4LlTFtDmJ3dhm5SgJNCIRIoYlYsB9wzHzonzFoMh+qRJpuIbPMzDNRHAYAkwG9V9ZI1Ctn9exXFQs/yAGl8GAun0lzq93mAsWbMe35KYlm+5XPJ02aZBCmLLtHXxxh3wzoCupw+1vNX64toivE6wWCdAaEcw4Wox8NS69j5jn6EOaro28IWxQrlCE6eyi1qP74ojAgPcU7EA5E1q8Quyz3z/+s2rcMtfj4r1QAtDgj0ln8bX+AxKANmIHqPacskcfmoujaRMGqAU7wC+gw0cFB2P7ioLiMR/wS49VaZRMa0Y0a2tqc7FVrZx7Lh4lAs1thhEVnDq5FybOGIwRWemqFE2vRMgjQwSXioZGTW1gjPr2tfU9V+d1iTQXHhQCLjRCmKQqlcJYUoPaolrzFzuduwkZfz3ehEoZC9v6Wcy88TcNyWBrS0U7xA28eCPEj3fFpWLdkn3F01fzvjLV+7y1TDrMoJQxLpmUkVS1ujz1d/cPw41PzAi5L2bUAJYjIp+1eF1r17nxHgLeDdiduYEU/IQ0aE9UY8YrjYs2l2KLCH5NEH0ISQDjr1MCnN9LIv/jlDNs0yx8Pn7WwPF8QMjHr2c9QZOWoxW4epHxzq3l+I0ybXiG1Nioc7hsTrD1esjsLs+kTLVIBjrLJbhvNFIHxmLIxGz0HZzOZMXEKMKVUeFQxmggD1GBE/WZZwFRNxEcDliaDTDVtqCxtq1ta5GraP1x7NtcgoNmh2fWjYmI7NvvvT11mkKjErwRb5fMbfj16o/KzYX2SxZbXjzWhIMi+HUSBlp3LV9CGMMQIkhLGnkSUCJHT8nGpIXXKp5NnUinadWD0TZ3vhjkGQPeDdiBcgaiR+KMTsIXiwuO3LiWewXC6OfJHKaCUWsOPPoDEuCxyUrJgp8smlkDMGfJMxkvKujyqUY/v56KYpkcrtTe+Oq9A39etxZzKNvSolhtWZOL1zURpO9ddEVAO2RWBz/XTSWSgW7B4ivdp0zSIKJPFNKig5EYrkTkgEREELeF8IFRU0++ppXT6S2wFlajiT7Dr0yH6gN1vKimzLaIG514ab5zMC586WbNqxH5fSDk7f2CUlR6xSbDQmTi0wvLfnhjJz6HIPb5FU80RFzqvcRlWiTLUElwst7pVm1ROZEYtOJ6dv6gS/vESQhb+Ipid296g95TwAOC3cNMIE/mvij7aZ9tzFvmJyv1OC6CX0tGv66r0R+QAHePVbDv/24NGpqA/j/ep/gzOr+X6N74B1jAj6LGvcW4arH5lj8qsZV24PhcmfHXIrsn2ECsT/qMRgkxyKTECqXz3dyzXxXiq/s93WTwffYf63WNtEfcz/FzP7SR3hwd9fxM21EpyFwxS/5t6uShKmG2rrOD/UJVh4v4yVs+3VM16WPuOSfnGS31xG7Qd2Ys9YqVSE/V82scUSkWGRuM1Fcn4ekrpyQO541DagTSiSVdztxlu9jdw+SQz6k5IXl1ogpzFtZ98vkRbED7nITmrnR/pwSgbVSWVLnjpCOi4F78NnjaoByPEeUdxnVPn0rOxoZPDuy/bAVmU9blJkh0RTXOgKwLkYO1OgUyOFyeadvuiZDuv6U9JICbBPxK5blRiFl7E/tz76uGJaH6tKCfO0QjOd6Dqfn9oPPShaaXDzbwU7bp6K+RStCqJKLfP1Lm3QalSIkkcCjarLxKo2vpRD9yHm588PLgWxLG5skYfYsQBfT07N8AONfJHxSOuBRYdWa8+/6JP+f+IhStQhT9hMyGzsjcLQHy06SygjJH6BOj8NRzj/V+QNZSJRhS/tE8sepEf6oGD7zf+sxnh3hx2nhBjsy4rdjeJfOI5KQnYonnQIUdJYXPkz69wPcmgDcJ3BuXFYGQtTOZrX2n5vVmaRSS18sdw9C0ZMqiNeGFt8t/euUPvobfPVqaiMpp60kZd98ECUtnGJNj3TN0IofEYcjrU9jHhk9MT1UmxYmpX68Kn54CHgjsQPkC2u8EfCcRtOs+OlR8/Rq8TiRZrXg/9VIWWoUUFqOtU7OxawLcSdTA0t+t6jGpyP9qTtCv0YMzhEhYoFAqFQa5Q3Di2936S5a6ri7V4Vichmkdmyu3rN5t7fYCvC5EiBcS28/J+T7dU8LwhOGUcuL1hbBccqSEiyavsWEsU1RiCX1pPNYPnJI7QsrZ2uPwXsDz60bTBa1jU/DzRwUVl6/gXiC/4bb6edFP+tRm6WEZd3Ysy5KBJ63Xu9zTtyOI5xEz9zzMuuti1YyEUblS+lA1fqaO9wOgOgW8h8khd7ArMR3W1jZsXHOi5OY13Jt6m6DzIcxFbCGGn7krw69bAtCWGMaoqrVc5K67sH7YdYPzfHxpn1U/CBtDwuAMi8MvKw8XTPsct5idqMtPl+pz4iT2VTt7ToIzac9ODWILTphjn70A6wZe0WcEneTD1JT7qar2jqT2StlPe60XLba9WKLlw710tNSKot/clegP1FIjCFdZRkKMXmoXUJVAvYSIzDDkPDced15yYeSI8EHZYBw2XyLAKx7R0+SQ5zlDSnApvdB27BRWrK0pmLsRHxFvhQLvnoncEqKAyWDteUl6pwQYnMrK9pe7Qu8bijmv/ivtOQWMYPhn/gSo+KHRwaQMWJr0WLayZt2DG0Fr0FqmDZUbNSrW8fE2y99KgvdvUbOb9pkyn78Q63Mm9c5qT796J2F88/zaonLc+07Tp8RQogEft7ikot/4V2bwEGkgqWzh5GY7HwCj0oAPgI1MRP7j45kbRwyN6B85IEMwDmnFr77Vt9uZTiDwDnoRj4uKfBfRl9U7iuyvfWf87p29/CRUWmlCRz2NXLYSD8Zoc8DeU0nWJQFmjVKwn+6wqlNDkb71fsmelIvocimHfMPC3vF7cRqV8fhpLFvT8vkjm/AE2au9caTCRMS2462fzX8LCV69Vi1JZc2TBqcwn6RNzIuRmPXthlcgGyU6ni9RWLb0xO77N/C1cfRgfvImL/pdpMOcPe+wQC05nCouRlbZ4vKsiQyBCGHDiDd102BMvXy4amRUvxSpKi5CqO2nK4DR8m9bJ16aQsGvOUDXQ4LVjsb9J/HTNt2hF37jviRqtgxCEo4CT1cf0YYQi99BwD/T2UhdLkBHxLiyoNQR8dEULLz5gQHTJbRIxLvqx1Po4xVbz8ojJDiFj79uWfPEr/i30Y7me8YrzSmREvu/vzKedUcXvx7JfLfbrFToTc9dM0H9SMz5eRIQkc8v9xaosoiCHxQCZ1Qifl9eUD1lOTfPa4nbOpmED/hYjWco+rtqaZGspFbnonEPz6pkEFSDJiYIsRdlYPQ1A5iRA7IVvcOSImVBiZH8bB8xjSNqV0GFOU0WtFU0or60pe2HAmvhF4fw+/5avrSbBrx0aF92xkBcbbOdgG89i/UHuiTAxH4y6S9H7JqxqRj55b3BP0QPyhBqBHwCHV7lXmIBBnW1rJV1+HNzZeGc73Dv8WYc7xXHmp68Qm27Zam+R8aJux1/LYrZW2Jjm2tMF1yY6ny31/DEXFV6snAd/BJunZR7UbGZkYtjX+82XrbU/lKZjg+Q8OBDmLdvIm7SGV1LT1p0MA1hMhK9hfMmAg18qUVCBKtl0AxNRFZiCLIyIhHXK5oJS4iQhNIrbzG4zFUtLv3BGtSWa3F6RyVOE4OVj3BCCHZpRQJQIhjJfVgJ+M6znYLeJQGuGiJn/jxlD6rTcZHrrsFnV9yTP5YtPea1jKqHBb6JG35FrTS4ZCrU7jhiW7HVvuSDfXiXiK766cMV1rwUqT0vRea64g1twIs+MD+CUckY5u2NRjZDZR88NMr5dJ+8kMsihvYFY9SJK3sHqjGAJyZPJ21Sf3/me21vb63ALhF43uVTE4Om7QwMpbNp4Sreo5EQ41JG9DKNc6jQHg11v6cEoZ+JK2y2115ByK66Yx1mtC8xxz+fgdy5VSmFjUi1vyTBul2DtH+SRH64ykmlwAVrH9J8HdE/VUx9Bsra+elfunJ3ShZsDU2oLSg1fF/gWLejAl9vLsGfrRZYbxqldDAM56Kl+FTykVeGPqwyhrUlw+y89OpBzA2JGeqhEYOzBf+Qn5HrP+r9Ssr4iti+0B48iYeXNK369CB+gmAo8UYfDZCcicv3VxuNhNLnbxG1LyXq0B30UoivbvD9CUBBdYoksHpvpJ+sxC12uDg4nX/DwhPdEoBIAXbdPhtlbdTX1+CTqXcNHstWnfKZgx7I+Gp/ng+ENXKj4uGyWmE4WQVdjdbUrHUdbDFwFV8W8gYNd3E2IpMimMRwDdsvNFqREkazhTGRfBEHb+Hb3VPV/HL6/gWRadkwltVhwbKqn+dt5wNTFHw68htIx+mVsr9X759JU0n5YULJILG5PNFOqdh5EvgGvTwkoGkwctsOcv1O4ghQE/JvI29PViFG30SJ/Gi1M5RYtMO/uS/ou/jz+7B8rL0T48s3NeoGis5sl/GLPNOUrrD+LXUexLyCG1h+4VRy39pmwUp2ZwL9lj7pUGghunsmYji9+2n5H49t5qdrU/+YjvwG4u/rCAAWg/Xv1/tn2fG8UKOvZCQHjHqKEQ0X1x4F/Seuo/s2ZaCc/b5QkAKvTcDL99/f+zqZVStODu1qUaCOQaMOP8ug4z73n50ZeAHKuulCTla9GSs+O1V49/d4l3SqZ+STrTVIBrPpHzD6/ttbjwhAW+94ifx4rVMTF4y0n+9gf+w/Y0Qsv0aOe3l0f+D5ly6mifl7EJ5DuigdZwMTgi6Hbm1sxopPefDfI+BT0D3gB8th+juWa/n/sfWYABf3k7MFZTZVUxvCJ2Vi8oo5mqVR+cQ4o2vkdjXq3fu6mh/osz8QyAGKSN1xB6LzTeW1WLW6svCeHz3gU4ufSoBWWgxpc8Jh+4vBnv9fW48JQNuITKl012kHv8TqK+PxzP13pN/Az5pxV924wT/TUd9VwWdAySIuypzZB/ojp/Duqrrfn/yNXwGDFqe6V+dsJe6eyW4/uwDJ/5V2RgS4IFvGHK6yK1pN0CgliF83E5+Nn5k3QGZqFWYId8gTBCr17m7UdyLuPZKF6HsVMUeSe6Hhz8POV1Zrf/Bal5eCT8Oj2nPg96ydEQFou6iPjN0sLFQYHq9G5rc3MysGXz0oWaJrAON5yqgX+Gc0W7gTcc+/CKuV0IUPXcGhKNlYaL7vC+unP5dgJ9oXZebj4n8lNPp/rZ0xAWgbnCqV7i938Euup4ai95c3MMuGTBuUJDG0CI9MZToR+Wc06v2mb0mlvL631jZix/qS6ju/di0t0YI+zcGdEaMk0AVT8M/p/B63syLAkFQJw4GRiSSIpCT4/Drm3WFTclP4Ikk6E8jj1Z7lqPc8noYWcSbxM34a/jzqXPqjfuuLW/EVMfYo4HRzP7xSr5LB4nDAaf+blmb9v9DOigC05adJmRN1Drnewic5IiJVSHnrErx45eVx5wXnpAOEBPzyZu6f6emodweNKPARsfwzd4wny/HnlqrKJ39yrSqoBX2yg/shDJQAWgmDNpkEVovjnJ9/pu2sCUAbUQXsyXqHzCCSgGzR9w3DDQ9Mkt+cNjoniA0ixlptOSFCW4CfYj2TTHwuh0YLo+P5BzRYqhpw9I/yprc2OzZ8foRf6Nj92BUKPD/qyVlMChlsZvv/Tnj3v739JQLQ1j9JwpY2OmVtVuGBTGSLTNGg112ECDeOUUyKHZQu5aeD2ez8/ALG1CZM0uRDwCz/gAdOJS52KCF+PTlOe7wSBwtbKz/807Xly6P4g4h7d/qTgu9+/k5bkAxWhwv2c/r+7NtfJgBtObEs4yI2gTh5wlMWlRKC1CtycfH0Iex52amKdFVsBJRRIZCHBvPf4+ijZQ0mvpTM3EAsukpr9Xf7nYd/L0PB3hrewKM5cKpHvHPgbYQ2FiUZ9edCu3+9/S0EoC0lnBZCsJIK37IojbiFRKsQNTgBWREqxKlliHL/tt6G5hYzmg7UoqLJzIPszn9T8OlU4jbx1UgEhEXKwuZy8Y9eOTfq/4b2txHA3VLCGdZg9Tznxl0A4Z4K5p4F5M5/u4MG3pM9zF6be9aPlQBvp2nRM3nmzrnWffvbCeBucSGQELvAezqYuwjCe+qXu7mLH9wkoMl/G8vA7lX8cA74f6D9YwRwt2AZWALg/xsTaCvY738Yix9gJQCsFPjHBI1wYMT/g0b6aFFPQ0DzBIDFPuSFD8inNvxHwqOAToDeCWAUDDIwmgBGOBhNACMcAAA/J+m72PvFtgAAAABJRU5ErkJggg=='),
(200, NULL, NULL, 409, '-34.00865423340499,25.666015148162842', '127 Life Sciences', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 410, '-34.001980915503246,25.673776636064076', '201 Lebombo Residence', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 411, '-34.00297263539996,25.67442598729076', '251 Letaba Residence', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 412, '-34.00238124509304,25.673847198486328', '252 Campus Health Services', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 413, '-34.00238124509304,25.67308008670807', '229 Technical Services', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 414, '-34.002548499975305,25.672715306282043', '230 Tennis Clubhouse', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 415, '-34.0026774294835,25.67192405462265', '212 Heinz Betz Centre ', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 416, '-34.00252625170009,25.670394524931908', '288 Engineering Building II', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 417, '-34.00226233866034,25.670757293701172', '276 Engineering Building', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 418, '-34.001888126255295,25.670886039733887', '286 Bitumen Building', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 419, '-34.001903849498774,25.671516358852386', '205 Laboratories', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 420, '-34.00172774900558,25.672430992126465', '219 Student Services Centre', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 421, '-34.00187240300892,25.672782361507416', '225 EBEIT Lab ', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 422, '-34.00140070426386,25.672752857208252', '215 Food Court (cafeteria)  and Muslim Prayer Room', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 423, '-34.001152275205044,25.67281723022461', '217 Goldfields Auditorium', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 424, '-34.0012812068326,25.673605799674988', '235 Conference Centre', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 425, '-34.00081579418204,25.672414898872375', '222 D Block (main entrance, cashiers, ABSA Alumni Centre, Student Counselling)', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 426, '-34.00041641777999,25.67230761051178', '209 Human Resources and Contact Centre', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 427, '-34.00045100951113,25.672776997089386', '260 Main Administration Building', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 428, '-34.00086751555975,25.67138761281967', '202 Science and Health Sciences', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 429, '-34.000551639921646,25.67107915878296', '207 Lecture Halls (N1 and N2)', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 430, '-34.000123959853624,25.67104160785675', '208 Art', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 431, '-34.00041956248341,25.67045420408249', '206 Nursing', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 432, '-34.000752900385045,25.670330822467804', '226 Goldfields Computer Centre (writing centre, Offices etc.)', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 433, '-34.00115651173071,25.67130446434021', '203 Engineering', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 434, '-34.00148246556736,25.671301782131195', '204 Built Environment ', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 435, '-34.001513322577296,25.670397877693176', '261 MTLC Building (eNtsa, library, CTLM, Senate Hall, lecture halls)', 'NMMU', 3, 371, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 486, '-34.00857585762075,25.669504702091217', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 487, '-34.00900942488215,25.669448375701904', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 488, '-34.00928290463156,25.669485926628113', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 489, '-34.009024988793975,25.670110881328583', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 490, '-34.00890270083858,25.67014843225479', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 491, '-34.00872705055816,25.670373737812042', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 492, '-34.00873363228519,25.670492835013192', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 493, '-34.00873149740518,25.67091554403305', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 494, '-34.008913775311264,25.67115420493451', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 495, '-34.00902367661416,25.671166308590614', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 496, '-34.0090315715349,25.671566018041403', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 497, '-34.00915172339827,25.671164989471436', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 498, '-34.009309517503326,25.670947824171208', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 499, '-34.00932292598442,25.670698285102844', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 500, '-34.00913509341085,25.670490353948026', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 501, '-34.008884496593794,25.67049012053758', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 502, '-34.0087292739817,25.67067950963974', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 503, '-34.0092695812717,25.668736269215742', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 504, '-34.00861394498071,25.668721510730165', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 505, '-34.00860238006387,25.668055046393192', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 506, '-34.00930347445785,25.668209195137024', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 507, '-34.0092662545686,25.66801759492455', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 508, '-34.00852874873689,25.66748068202287', 'Randevous', 'NMMU', 3, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 509, '-34.00852874873689,25.66748068202287', 'Ground', 'NMMU', 4, 508, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 510, '-34.00852874873689,25.66748068202287', 'Entrance', 'NMMU', 10, 509, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 511, '-34.00903169598392,25.67215994706521', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 512, '-34.00902054196231,25.672650933265686', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 513, '-34.009011648298305,25.673876702785492', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 514, '-34.008877654575194,25.673978456300233', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 515, '-34.00220615062431,25.673414292400253', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 516, '-34.00220350390403,25.673722807447234', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 517, '-34.00197096900792,25.67370512215848', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 518, '-34.003879289502876,25.674314160161316', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 519, '-34.0046714291231,25.67383646965027', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 520, '-34.00588991468845,25.673954486846924', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 521, '-34.00587284783834,25.673069212887754', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 522, '-34.00584573257521,25.672543952079195', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 523, '-34.005892138186276,25.669963359832764', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 524, '-34.00669051360126,25.669886114143537', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 525, '-34.00708526651283,25.66956639289856', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 526, '-34.00766937045138,25.669255256652832', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 527, '-34.008344816323714,25.66927134990692', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 528, '-34.00907211569606,25.669297628225877', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 529, '-34.00961162259228,25.66928207874298', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 530, '-34.010023533147944,25.669290125370026', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 531, '-34.0101501773359,25.66926954807286', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 532, '-34.01017743683605,25.669511289252682', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 533, '-34.01016234471633,25.669741871305064', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 534, '-34.010186900485714,25.669956798441035', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 535, '-34.01023396097791,25.670756034100236', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 536, '-34.01023420418654,25.67205011844635', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 537, '-34.01022162682577,25.672846734523773', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 538, '-34.01022162682577,25.673498511314392', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 539, '-34.0101901834157,25.67414492368698', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 540, '-34.01018082864328,25.674374191874335', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 541, '-34.010183871657965,25.67456195079967', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 542, '-34.0101901834157,25.67479133605957', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 543, '-34.01013672959185,25.67603051662445', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 544, '-34.01017760604844,25.677672028541565', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 545, '-34.010174461706306,25.67796438932419', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 546, '-34.010451163366525,25.67856788635254', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 547, '-34.010570647895584,25.679190158843994', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 548, '-34.009470938086466,25.677814452851067', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 549, '-34.00943631971511,25.677672028541565', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 550, '-34.009010446114154,25.672848234459366', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 551, '-34.009011648298305,25.673380494117737', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 552, '-34.00866924152564,25.67258656024933', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 553, '-34.00838194897147,25.6726505428137', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 554, '-34.00811567977452,25.672681404918876', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 555, '-34.00789548607108,25.672613382339478', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 556, '-34.0072350413487,25.67263381083285', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 557, '-34.00649915091532,25.6730318069458', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 558, '-34.002991401432865,25.67377209663391', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 559, '-34.005828969246224,25.675287635454424', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 560, '-34.0058288696351,25.67570596933365', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 561, '-34.00580253441773,25.67596019245684', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 562, '-34.00597351665372,25.67727506160736', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 563, '-34.006539524358274,25.677720308303833', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 564, '-34.00688541609845,25.677736401557922', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 565, '-34.00780052238581,25.677720685093163', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 566, '-34.00869814604682,25.673114245656166', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 567, '-34.00866479467536,25.673573224836446', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 568, '-34.00867705194378,25.673996165973904', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 569, '-34.008755955059655,25.674161173373136', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 570, '-34.00875959348421,25.67427704196143', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 571, '-34.008820251658115,25.674740127567816', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 572, '-34.00884534261898,25.674945549005997', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 573, '-34.00920625408842,25.67497662658809', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 574, '-34.00917961194731,25.673993168928405', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 575, '-34.00933464796371,25.674268305301666', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 576, '-34.00933613071415,25.67444919718946', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 577, '-34.009182955017295,25.674603476120865', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 578, '-34.009511002916234,25.67383110523224', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 579, '-34.00968708727107,25.673828423023224', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 580, '-34.00945922078351,25.67365649342537', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 581, '-34.009467404347234,25.673392507774793', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 582, '-34.009754266034776,25.674348771572113', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 583, '-34.00963619585926,25.67345896848599', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 584, '-34.0095474898923,25.67320907606529', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 585, '-34.00958282105776,25.67287745184194', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 586, '-34.00951423916178,25.672735133789956', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 587, '-34.00909613806879,25.672753890101376', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 588, '-34.00959411410598,25.672624203525743', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 589, '-34.00960522932485,25.672300978981184', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 590, '-34.009603074926325,25.67154049873352', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 591, '-34.009603074926325,25.67135140299797', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 592, '-34.00996634530381,25.670703356154263', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 593, '-34.00995435746904,25.670918226242065', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 594, '-34.00991976960845,25.671382248401642', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 595, '-34.010047898721844,25.672045986318835', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 596, '-34.010027743385315,25.67252218723297', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 597, '-34.00987768182205,25.672519526643782', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 598, '-34.00971202148745,25.6723290681839', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 599, '-34.00973199574528,25.671391755518243', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 600, '-34.009472388833714,25.670526822732427', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 601, '-34.009445008437254,25.669479309806434', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 602, '-34.008591004719435,25.66909432411194', 'Ground', 'NMMU', 4, 377, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 603, '-34.00835072366249,25.672326385974884', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 604, '-34.00829097985709,25.671937465667725', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 605, '-34.00833797068386,25.671597971792153', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 606, '-34.008523666020075,25.671296417713165', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 607, '-34.00835386807214,25.66978096961975', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 608, '-34.00827211338349,25.66991776227951', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 609, '-34.00834103888004,25.670272994041397', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 610, '-34.008341290432845,25.670482367277145', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 611, '-34.008294239247405,25.670951868989278', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 612, '-34.00828520842895,25.67120913952499', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 613, '-34.007104456046754,25.67116664940454', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 614, '-34.00707361205825,25.6709028359694', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 615, '-34.00707280730892,25.670151114463806', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 616, '-34.007268472169294,25.67008137702942', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 617, '-34.00724407596829,25.669889729924307', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 618, '-34.007668384015375,25.669885575771332', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 619, '-34.00816052771247,25.669896271331254', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 620, '-34.00815891445394,25.669735372066498', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 621, '-34.008397983232086,25.670966506004333', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 622, '-34.00854798696853,25.670481796861623', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 623, '-34.00991348090503,25.669748783111572', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 624, '-34.009844855899175,25.669554579219948', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 625, '-34.00807768663251,25.670939862873638', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 626, '-34.00785076104781,25.670939683914185', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 627, '-34.007658950709946,25.670939683914185', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 628, '-34.007429406621426,25.670939683914185', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 629, '-34.00720615081685,25.670934319496155', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 630, '-34.00743908416274,25.670101958336204', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 631, '-34.00763967192866,25.67010752584042', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 632, '-34.00787325161474,25.67009747028351', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 633, '-34.00807336151231,25.670118927955627', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 634, '-34.00820122403025,25.670058364229135', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 635, '-34.005913449334315,25.669583234859374', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 636, '-34.00658669149673,25.669620037078857', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 637, '-34.00740425106715,25.669016540050507', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 638, '-34.00766523958037,25.66890388727188', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 639, '-34.00823234619466,25.66891134710727', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 640, '-34.008312537998044,25.668921157346063', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL);
INSERT INTO `location` (`country`, `address`, `post_box`, `location_id`, `gps`, `location_name`, `username`, `location_type`, `parent_id`, `description`, `boundary`, `plan`, `icon`) VALUES
(200, NULL, NULL, 641, '-34.00973314376375,25.66891894835544', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 642, '-34.01016225834432,25.66891894835544', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 643, '-34.01016114665132,25.66866785287857', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 644, '-34.010150029720485,25.66844254732132', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 645, '-34.01013898428317,25.66825067025502', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 646, '-34.01014509475648,25.66807364866179', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 647, '-34.010130130124416,25.667870006898966', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 648, '-34.00975536823277,25.667873907741978', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 649, '-34.00976093622453,25.668024122714996', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 650, '-34.00976760641377,25.668214559555054', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 651, '-34.00976760641377,25.668376833200455', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 652, '-34.00977872339467,25.66865175962448', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 653, '-34.00952851725221,25.667831864534037', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 654, '-34.00953739500268,25.66868992467448', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 655, '-34.0090206020396,25.667463541030884', 'Ground', 'NMMU', 4, 382, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 656, '-34.00924685502002,25.66769821620312', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 657, '-34.00946574332071,25.66768339695909', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 658, '-34.00983958860474,25.66768079996109', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 659, '-34.009875656245036,25.667199253997296', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 660, '-34.009529743990555,25.667207635970726', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 661, '-34.00899519109703,25.6677929460252', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 662, '-34.00863045825504,25.66773464421999', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 663, '-34.00829055421552,25.667681037974376', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 664, '-34.009267340767025,25.669322311878204', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 665, '-34.008511817777936,25.66965652341696', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 666, '-34.00849851078995,25.669721961021423', 'Intersection', 'NMMU', 5, 369, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 667, '-34.00488907714586,25.676622787407723', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 668, '-34.0046173793517,25.676253592030434', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 669, '-34.0044641443324,25.675376057624817', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 670, '-34.004121855514825,25.67611008416634', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 671, '-34.00377017879323,25.67537386985032', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 672, '-34.00375088281528,25.674673318862915', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 673, '-34.00201715015183,25.673239099726402', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 674, '-34.002074051698294,25.672909536620523', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 675, '-34.002058574030066,25.672427079451495', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 676, '-34.00206475544429,25.671933424382814', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 677, '-34.00207419394234,25.67158211757055', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 678, '-34.00206303931674,25.671418468330103', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 679, '-34.00207734844542,25.670884656796716', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 680, '-34.00208997317229,25.67066341638565', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 681, '-34.00209309996802,25.670420720514812', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 682, '-34.002114892574056,25.670066809002492', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 683, '-34.00147207692601,25.67005457975813', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 684, '-34.00240117490016,25.670067965984344', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 685, '-34.002281100998935,25.670384466648102', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 686, '-34.00100042430261,25.67006207557199', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 687, '-34.00073300481977,25.67006753418991', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 688, '-34.00031859072895,25.670152064683748', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 689, '-33.99968850681108,25.670227244847638', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 690, '-33.99881517832115,25.670293117644405', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 691, '-33.998621362763,25.670577585697174', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 692, '-33.998712561041906,25.67131519317627', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 693, '-33.99881899506675,25.672161620958605', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 694, '-33.99890124682532,25.67231297492981', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 695, '-33.99962538824674,25.67277018344555', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 696, '-33.99939811738337,25.67326784133911', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 697, '-34.000546393664884,25.673956053808638', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 698, '-34.00077204923423,25.673584848717383', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 699, '-34.00097014787671,25.673179986066202', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 700, '-34.00092164896817,25.672789074378443', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 701, '-34.00079747454561,25.672680534838833', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 702, '-34.0006726195575,25.67270300167013', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 703, '-34.0006558225719,25.672797460766446', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 704, '-34.0006578630839,25.673165917396545', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 705, '-34.00026983791993,25.6731578707695', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 706, '-34.000259789822756,25.67231164861323', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 707, '-34.000262050108574,25.67172690610846', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 708, '-34.000681265716175,25.671746586566314', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 709, '-34.00050326486373,25.67173958107867', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 710, '-34.00113714144935,25.671749711036682', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 711, '-34.00111280958762,25.673205798886784', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 712, '-34.00126268960414,25.673187375068665', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 713, '-34.001552908864014,25.673197908013094', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 714, '-34.00174637101561,25.67319036836625', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 715, '-34.00176104438254,25.673363714864763', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 716, '-34.0011292723596,25.67354679107666', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 717, '-34.00186682029275,25.6724296295165', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 718, '-34.0014736211994,25.671757757663727', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 719, '-34.0018698479811,25.671763122081757', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 720, '-34.001156009508,25.67063257098198', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 721, '-34.000979907464355,25.670607089996338', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 722, '-34.00150192317365,25.670639276504517', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 723, '-34.001891971448934,25.67045520098361', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 724, '-34.000703174943816,25.67107915878296', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 725, '-34.00019687788514,25.67026376724243', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 726, '-34.000118260058784,25.670625865459442', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 727, '-33.999727752663695,25.672624919922782', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 728, '-34.00251449871569,25.66983461380005', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 729, '-34.00318744597021,25.669872164726257', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 730, '-34.01043885386407,25.6747863404471', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 731, '-34.00784570703895,25.67680143046823', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 732, '-34.00786435783057,25.676053988339845', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 733, '-34.007815442000975,25.674256003782375', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 734, '-34.00787325161474,25.673573224836446', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 735, '-34.007899731922265,25.673128997892036', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 736, '-34.008372574410735,25.673012662006272', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 737, '-34.00791679401469,25.67483961582184', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 738, '-34.00789792745796,25.67538946866989', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 739, '-34.00809667685107,25.67603922969613', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 740, '-34.008432173485176,25.676075749268534', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 741, '-34.008753731636816,25.6760573387146', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 742, '-34.008190358616154,25.674844980239868', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 743, '-34.00912281903148,25.676213303427176', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 744, '-34.0091339360968,25.676596418280155', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 745, '-34.009256318473014,25.676708269290884', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 746, '-34.00928068122252,25.67692263488766', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 747, '-34.009245106669866,25.677002292431325', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 748, '-34.00919841504691,25.677062983893165', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 749, '-34.00891604135136,25.677093329624086', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 750, '-34.008861772841676,25.67700760405478', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 751, '-34.008831551401684,25.67694539418585', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 752, '-34.00882275105849,25.676758015830274', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 753, '-34.00886712612758,25.67669124868928', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 754, '-34.008972510423625,25.676608845553574', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 755, '-34.00898711356115,25.676203935852072', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 756, '-34.008992157877046,25.675833393276662', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 757, '-34.00892300430019,25.675649642944336', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 758, '-34.00932959620807,25.6755530834198', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 759, '-34.00922176086159,25.6755530834198', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 760, '-34.00923176620878,25.675791800022125', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 761, '-34.00882361783382,25.67705626420252', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 762, '-34.00884912959353,25.67749366090129', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 763, '-34.0094040943798,25.677500367164612', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 764, '-34.00885052078019,25.677623846000756', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 765, '-34.007896573382894,25.677596954896785', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 766, '-34.00752069912765,25.677647757820978', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 767, '-34.006467110880656,25.677567697559653', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 768, '-34.00610114672194,25.675955414772034', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 769, '-34.00837430673198,25.668056309223175', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 770, '-34.00841046742585,25.668708086013794', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 771, '-34.009512757816125,25.666711123381674', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 772, '-34.00950302183889,25.666377246379852', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 773, '-34.00935405369028,25.66635310649872', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 774, '-34.00923953745715,25.666212303175143', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 775, '-34.008920488188494,25.66620022058487', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 776, '-34.00877596586262,25.666401386260986', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 777, '-34.00876262532784,25.666629374027252', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 778, '-34.008798200082616,25.66668301820755', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 779, '-34.008760401905164,25.66753327846527', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 780, '-34.00866037365193,25.667648583681398', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 781, '-34.00933626643119,25.666570365428925', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 782, '-34.00923178887695,25.666701765161292', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 783, '-34.008498732443286,25.66828429698944', 'Ground', 'NMMU', 4, 380, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 784, '-34.00086751555975,25.67138761281967', 'Ground', 'NMMU', 4, 428, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 786, '-33.99877442350324,25.672731399536133', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 787, '-33.998294106372605,25.670102834701538', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 788, '-33.99994902720706,25.669756391180954', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 789, '-34.00516482614347,25.669718647432887', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 790, '-34.01101269922707,25.668858289718628', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 791, '-34.01095662956664,25.665538414710568', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, NULL, NULL, 792, '-34.01097712540006,25.661755800247192', 'Intersection', 'NMMU', 5, 0, NULL, NULL, NULL, NULL),
(200, '', NULL, 793, '-33.622052692262606,25.138778686523438', 'tgest', 'NMMU', 3, 0, 'asdfasdzcxv', '', '', 'undefined');

-- --------------------------------------------------------

--
-- Table structure for table `location_type`
--

CREATE TABLE `location_type` (
  `location_type_id` int(22) NOT NULL,
  `location_type` varchar(66) NOT NULL,
  `parent_id` int(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `location_type`
--

INSERT INTO `location_type` (`location_type_id`, `location_type`, `parent_id`) VALUES
(1, 'Client', 0),
(2, 'Area', 1),
(3, 'Building', 2),
(4, 'Level', 3),
(5, 'Outdoor Intersection', 2),
(6, 'Staircase', 4),
(7, 'Room', 4),
(8, 'Elevator', 4),
(9, 'Indoor Intersection', 4),
(10, 'Entrance', 4);

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
  `path_type` int(11) NOT NULL,
  `path_route` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `paths`
--

INSERT INTO `paths` (`path_id`, `destination_location_id`, `departure_location_id`, `distance`, `path_type`, `path_route`) VALUES
(526, 486, 383, 26.7, 2, NULL),
(527, 487, 486, 38.58, 2, NULL),
(528, 488, 487, 40.06, 2, NULL),
(530, 375, 383, 26.21, 2, NULL),
(531, 374, 375, 21.54, 2, NULL),
(533, 376, 374, 30.22, 2, NULL),
(534, 489, 374, 27.96, 2, NULL),
(535, 490, 489, 14.03, 2, NULL),
(536, 491, 490, 28.51, 2, NULL),
(537, 492, 491, 11, 2, NULL),
(539, 494, 493, 29.91, 2, NULL),
(540, 495, 494, 12.27, 2, NULL),
(541, 496, 495, 36.85, 2, NULL),
(542, 408, 496, 38.18, 2, NULL),
(543, 497, 495, 14.24, 2, NULL),
(544, 498, 497, 26.62, 2, NULL),
(545, 499, 498, 23.05, 2, NULL),
(546, 500, 499, 28.35, 2, NULL),
(547, 501, 500, 27.87, 2, NULL),
(548, 492, 501, 16.78, 2, NULL),
(549, 502, 493, 21.76, 2, NULL),
(550, 492, 502, 17.21, 2, NULL),
(551, 501, 502, 24.55, 2, NULL),
(553, 504, 503, 68.36, 2, NULL),
(554, 505, 504, 62.2, 2, NULL),
(555, 382, 505, 97.21, 2, NULL),
(556, 380, 505, 24.11, 2, NULL),
(558, 504, 377, 33.68, 2, NULL),
(560, 499, 396, 32.18, 2, NULL),
(561, 506, 503, 48.73, 2, NULL),
(563, 382, 507, 66.4, 2, NULL),
(564, 509, 508, 0, 5, NULL),
(565, 510, 509, 0, 5, NULL),
(566, 508, 505, 53.57, 2, NULL),
(567, 511, 408, 39.64, 2, NULL),
(568, 512, 511, 45.27, 2, NULL),
(570, 514, 513, 17.61, 2, NULL),
(572, 496, 511, 54.75, 2, NULL),
(573, 515, 412, 35.56, 2, NULL),
(574, 516, 515, 20.96, 2, NULL),
(575, 517, 516, 25.91, 2, NULL),
(576, 410, 517, 6.68, 2, NULL),
(578, 519, 518, 98.48, 2, NULL),
(579, 520, 519, 135.93, 2, NULL),
(580, 521, 520, 81.63, 2, NULL),
(581, 522, 521, 48.51, 2, NULL),
(582, 523, 522, 258.15, 2, NULL),
(583, 524, 523, 96.43, 2, NULL),
(584, 525, 524, 41.59, 2, NULL),
(585, 526, 525, 76.82, 2, NULL),
(586, 527, 526, 78.32, 2, NULL),
(587, 528, 527, 84.08, 2, NULL),
(588, 529, 528, 60.01, 2, NULL),
(589, 530, 529, 45.81, 2, NULL),
(590, 531, 530, 14.21, 2, NULL),
(591, 532, 531, 22.49, 2, NULL),
(592, 533, 532, 21.32, 2, NULL),
(593, 534, 533, 20, 2, NULL),
(594, 535, 534, 73.85, 2, NULL),
(595, 536, 535, 119.28, 2, NULL),
(596, 537, 536, 73.44, 2, NULL),
(597, 538, 537, 60.08, 2, NULL),
(598, 539, 538, 59.68, 2, NULL),
(599, 540, 539, 21.16, 2, NULL),
(600, 541, 540, 17.31, 2, NULL),
(601, 542, 541, 21.15, 2, NULL),
(602, 543, 542, 114.37, 2, NULL),
(603, 544, 543, 151.37, 2, NULL),
(604, 545, 544, 26.95, 2, NULL),
(605, 546, 545, 63.57, 2, NULL),
(606, 547, 546, 58.88, 2, NULL),
(607, 404, 547, 28.36, 2, NULL),
(608, 395, 546, 41.29, 2, NULL),
(609, 548, 545, 79.44, 2, NULL),
(610, 397, 548, 51.13, 2, NULL),
(611, 549, 544, 82.43, 2, NULL),
(612, 548, 549, 13.68, 2, NULL),
(613, 550, 512, 18.22, 2, NULL),
(614, 551, 550, 49.06, 2, NULL),
(615, 513, 551, 45.74, 2, NULL),
(616, 390, 551, 28.63, 2, NULL),
(617, 552, 512, 39.51, 1, NULL),
(618, 553, 552, 32.49, 1, NULL),
(619, 554, 553, 29.74, 1, NULL),
(620, 555, 554, 25.27, 1, NULL),
(621, 556, 555, 73.46, 1, NULL),
(622, 557, 556, 89.67, 1, NULL),
(623, 521, 557, 69.73, 1, NULL),
(624, 556, 522, 154.71, 1, NULL),
(625, 558, 519, 189.23, 1, NULL),
(627, 559, 520, 123.07, 2, NULL),
(628, 560, 559, 38.56, 2, NULL),
(629, 561, 560, 23.62, 2, NULL),
(630, 562, 561, 122.68, 2, NULL),
(631, 563, 562, 75.14, 2, NULL),
(632, 564, 563, 38.49, 2, NULL),
(633, 565, 564, 101.77, 2, NULL),
(634, 548, 565, 185.94, 2, NULL),
(635, 566, 550, 42.51, 2, NULL),
(636, 390, 566, 28.49, 2, NULL),
(637, 567, 390, 17.72, 2, NULL),
(638, 568, 567, 39.01, 2, NULL),
(639, 389, 568, 17.45, 2, NULL),
(640, 568, 514, 22.37, 2, NULL),
(641, 569, 514, 21.61, 2, NULL),
(642, 570, 569, 10.69, 2, NULL),
(643, 571, 570, 43.21, 2, NULL),
(644, 572, 571, 19.14, 2, NULL),
(645, 573, 572, 40.23, 2, NULL),
(646, 394, 573, 29.26, 2, NULL),
(647, 574, 514, 33.6, 2, NULL),
(648, 575, 574, 25.89, 2, NULL),
(649, 576, 575, 26.24, 2, NULL),
(650, 577, 576, 22.19, 2, NULL),
(651, 571, 577, 42.25, 2, NULL),
(652, 570, 575, 63.95, 2, NULL),
(653, 578, 575, 44.82, 2, NULL),
(654, 579, 578, 19.58, 2, NULL),
(655, 393, 579, 24.76, 2, NULL),
(656, 575, 393, 43.5, 2, NULL),
(657, 580, 578, 17.09, 2, NULL),
(658, 581, 580, 24.35, 2, NULL),
(659, 392, 581, 6.12, 2, NULL),
(660, 582, 393, 24.04, 2, NULL),
(661, 540, 582, 47.49, 2, NULL),
(662, 539, 393, 54.79, 2, NULL),
(663, 583, 578, 37.02, 2, NULL),
(664, 538, 583, 65.2, 2, NULL),
(665, 581, 583, 19.74, 2, NULL),
(666, 584, 583, 25.06, 2, NULL),
(667, 585, 584, 30.82, 2, NULL),
(668, 586, 585, 15.17, 2, NULL),
(669, 587, 586, 46.52, 2, NULL),
(670, 512, 587, 12.68, 2, NULL),
(671, 550, 587, 12.9, 2, NULL),
(672, 588, 586, 13.54, 2, NULL),
(673, 589, 588, 29.82, 2, NULL),
(674, 408, 589, 54.96, 2, NULL),
(675, 590, 589, 70.1, 2, NULL),
(676, 408, 590, 45.94, 2, NULL),
(677, 591, 590, 17.43, 2, NULL),
(678, 498, 591, 49.49, 2, NULL),
(679, 592, 396, 41.69, 2, NULL),
(680, 593, 592, 19.85, 2, NULL),
(681, 594, 593, 42.94, 2, NULL),
(682, 595, 594, 62.82, 2, NULL),
(683, 536, 595, 20.72, 2, NULL),
(684, 596, 595, 43.95, 2, NULL),
(685, 597, 596, 16.69, 2, NULL),
(686, 598, 597, 25.45, 2, NULL),
(687, 599, 598, 86.42, 2, NULL),
(688, 591, 599, 14.81, 2, NULL),
(689, 594, 599, 20.9, 2, NULL),
(690, 396, 591, 69.1, 2, NULL),
(691, 396, 599, 74.26, 1, NULL),
(692, 600, 396, 15.88, 2, NULL),
(693, 601, 600, 96.6, 2, NULL),
(694, 488, 601, 18.04, 2, NULL),
(695, 384, 601, 19.23, 2, NULL),
(696, 487, 528, 24.75, 3, NULL),
(697, 603, 553, 30.08, 1, NULL),
(698, 604, 603, 36.46, 1, NULL),
(699, 605, 604, 31.73, 1, NULL),
(700, 606, 605, 34.63, 1, NULL),
(701, 496, 606, 61.7, 1, NULL),
(702, 493, 606, 42.03, 1, NULL),
(703, 607, 383, 24.42, 2, NULL),
(704, 608, 607, 15.54, 2, NULL),
(705, 609, 608, 33.63, 2, NULL),
(706, 610, 609, 19.3, 2, NULL),
(707, 611, 610, 43.59, 2, NULL),
(708, 612, 611, 23.74, 2, NULL),
(709, 613, 612, 131.35, 2, NULL),
(710, 614, 613, 24.56, 2, NULL),
(711, 615, 614, 69.29, 2, NULL),
(712, 616, 615, 22.69, 2, NULL),
(713, 617, 616, 17.87, 2, NULL),
(714, 525, 617, 42.55, 2, NULL),
(715, 607, 527, 46.99, 1, NULL),
(716, 618, 617, 47.18, 2, NULL),
(717, 619, 618, 54.73, 2, NULL),
(718, 620, 619, 14.83, 2, NULL),
(719, 607, 620, 22.08, 2, NULL),
(720, 608, 619, 12.56, 2, NULL),
(721, 606, 612, 27.71, 1, NULL),
(722, 621, 611, 11.61, 2, NULL),
(723, 492, 621, 57.44, 2, NULL),
(724, 622, 492, 20.67, 2, NULL),
(725, 610, 622, 22.98, 2, NULL),
(726, 609, 622, 30, 2, NULL),
(728, 623, 533, 27.68, 2, NULL),
(729, 624, 623, 19.46, 2, NULL),
(730, 384, 624, 27.55, 2, NULL),
(731, 624, 532, 37.2, 2, NULL),
(732, 625, 611, 24.1, 2, NULL),
(733, 626, 625, 25.23, 2, NULL),
(734, 627, 626, 21.33, 2, NULL),
(735, 628, 627, 25.52, 2, NULL),
(736, 629, 628, 24.83, 2, NULL),
(737, 614, 629, 15.02, 2, NULL),
(738, 630, 616, 19.07, 2, NULL),
(739, 631, 630, 22.31, 2, NULL),
(740, 632, 631, 25.99, 2, NULL),
(741, 633, 632, 22.34, 2, NULL),
(742, 634, 633, 15.27, 2, NULL),
(743, 608, 634, 15.17, 2, NULL),
(744, 609, 634, 25.16, 2, NULL),
(745, 635, 523, 35.12, 2, NULL),
(746, 636, 635, 74.94, 2, NULL),
(747, 637, 636, 106.58, 2, NULL),
(748, 638, 637, 30.82, 2, NULL),
(749, 639, 638, 63.06, 2, NULL),
(750, 640, 639, 8.96, 2, NULL),
(751, 641, 640, 157.96, 2, NULL),
(752, 642, 641, 47.72, 2, NULL),
(753, 531, 642, 32.34, 2, NULL),
(754, 643, 642, 23.14, 2, NULL),
(755, 644, 643, 20.8, 2, NULL),
(756, 645, 644, 17.73, 2, NULL),
(757, 646, 645, 16.33, 2, NULL),
(758, 647, 646, 18.84, 2, NULL),
(759, 648, 647, 41.67, 2, NULL),
(760, 649, 648, 13.86, 2, NULL),
(761, 650, 649, 17.57, 2, NULL),
(762, 651, 650, 14.96, 2, NULL),
(763, 652, 651, 25.37, 2, NULL),
(764, 641, 652, 25.14, 2, NULL),
(765, 652, 643, 42.55, 2, NULL),
(766, 649, 643, 74.17, 2, NULL),
(767, 381, 649, 31.27, 2, NULL),
(768, 653, 507, 32.2, 2, NULL),
(769, 381, 653, 42.9, 2, NULL),
(770, 654, 503, 30.08, 2, NULL),
(771, 381, 654, 37.14, 2, NULL),
(772, 378, 654, 35.57, 2, NULL),
(773, 384, 378, 46.55, 2, NULL),
(774, 656, 507, 18.32, 2, NULL),
(775, 657, 656, 24.38, 2, NULL),
(776, 658, 657, 41.57, 2, NULL),
(777, 659, 658, 44.57, 2, NULL),
(778, 387, 659, 24.99, 2, NULL),
(779, 660, 657, 49.83, 2, NULL),
(780, 387, 660, 25.08, 2, NULL),
(781, 661, 656, 29.31, 2, NULL),
(782, 662, 661, 40.91, 2, NULL),
(783, 663, 662, 38.12, 2, NULL),
(784, 386, 663, 64.68, 2, NULL),
(785, 662, 505, 29.7, 2, NULL),
(786, 382, 661, 30.49, 2, NULL),
(787, 507, 661, 36.57, 2, NULL),
(788, 507, 506, 18.14, 3, NULL),
(789, 664, 503, 54.02, 2, NULL),
(791, 664, 488, 15.18, 3, NULL),
(792, 665, 383, 14.43, 3, NULL),
(793, 666, 665, 6.21, 3, NULL),
(795, 377, 665, 52.56, 2, NULL),
(796, 667, 562, 134.74, 1, NULL),
(797, 668, 667, 45.51, 1, NULL),
(798, 669, 668, 82.67, 1, NULL),
(799, 519, 669, 143.78, 1, NULL),
(800, 670, 668, 56.67, 1, NULL),
(801, 671, 670, 78.32, 1, NULL),
(802, 672, 671, 64.61, 1, NULL),
(803, 518, 672, 36.06, 1, NULL),
(804, 411, 671, 124.5, 1, NULL),
(805, 411, 558, 60.31, 2, NULL),
(806, 518, 558, 110.65, 2, NULL),
(807, 515, 558, 93.34, 2, NULL),
(808, 413, 515, 36.44, 2, NULL),
(809, 673, 515, 26.5, 2, NULL),
(810, 674, 673, 31.03, 2, NULL),
(811, 675, 674, 44.51, 2, NULL),
(812, 676, 675, 45.51, 2, NULL),
(813, 677, 676, 32.4, 2, NULL),
(814, 678, 677, 15.14, 2, NULL),
(815, 679, 678, 49.23, 2, NULL),
(816, 680, 679, 20.44, 2, NULL),
(817, 681, 680, 22.38, 2, NULL),
(818, 682, 681, 32.71, 2, NULL),
(819, 683, 682, 71.49, 2, NULL),
(820, 435, 683, 31.98, 2, NULL),
(821, 684, 682, 31.83, 2, NULL),
(822, 685, 684, 32.09, 2, NULL),
(823, 416, 685, 27.28, 2, NULL),
(824, 417, 685, 34.43, 2, NULL),
(825, 681, 685, 21.17, 2, NULL),
(826, 686, 683, 52.45, 2, NULL),
(827, 687, 686, 29.74, 2, NULL),
(828, 688, 687, 46.73, 2, NULL),
(829, 689, 688, 70.4, 2, NULL),
(830, 690, 689, 97.3, 2, NULL),
(831, 691, 690, 33.94, 2, NULL),
(832, 692, 691, 68.75, 2, NULL),
(833, 693, 692, 78.92, 2, NULL),
(834, 694, 693, 16.68, 2, NULL),
(835, 695, 694, 90.88, 2, NULL),
(836, 696, 695, 52.38, 2, NULL),
(837, 697, 696, 142.58, 2, NULL),
(838, 698, 697, 42.43, 2, NULL),
(839, 699, 698, 43.34, 2, NULL),
(840, 700, 699, 36.44, 2, NULL),
(841, 701, 700, 17.05, 2, NULL),
(842, 425, 701, 24.57, 2, NULL),
(843, 700, 423, 25.78, 2, NULL),
(844, 702, 701, 14.04, 2, NULL),
(845, 703, 702, 8.91, 2, NULL),
(846, 704, 703, 33.97, 2, NULL),
(847, 698, 704, 40.65, 2, NULL),
(848, 427, 703, 22.85, 2, NULL),
(849, 705, 704, 43.15, 2, NULL),
(850, 706, 705, 78.02, 2, NULL),
(851, 426, 706, 17.42, 2, NULL),
(852, 707, 706, 53.9, 2, NULL),
(855, 709, 708, 19.8, 2, NULL),
(856, 707, 709, 26.85, 2, NULL),
(857, 428, 708, 31.41, 2, NULL),
(858, 429, 709, 61.12, 2, NULL),
(860, 710, 708, 50.69, 2, NULL),
(861, 433, 710, 41.1, 2, NULL),
(862, 711, 699, 16.04, 2, NULL),
(863, 712, 711, 16.75, 2, NULL),
(864, 713, 712, 32.29, 2, NULL),
(865, 714, 713, 21.52, 2, NULL),
(866, 673, 714, 30.44, 2, NULL),
(867, 421, 674, 25.3, 2, NULL),
(868, 714, 421, 40.14, 2, NULL),
(869, 715, 410, 45.24, 2, NULL),
(870, 714, 715, 16.06, 2, NULL),
(871, 716, 711, 31.49, 2, NULL),
(872, 424, 716, 17.75, 2, NULL),
(873, 422, 712, 42.89, 2, NULL),
(874, 717, 421, 32.52, 2, NULL),
(875, 420, 717, 15.46, 2, NULL),
(877, 678, 419, 19.87, 2, NULL),
(878, 418, 680, 30.41, 2, NULL),
(879, 718, 710, 37.42, 2, NULL),
(880, 719, 718, 44.06, 2, NULL),
(881, 419, 719, 23.06, 2, NULL),
(882, 717, 719, 61.44, 2, NULL),
(883, 434, 718, 42.04, 2, NULL),
(885, 720, 433, 61.94, 2, NULL),
(886, 721, 720, 19.72, 2, NULL),
(887, 686, 721, 50.29, 2, NULL),
(888, 722, 720, 38.47, 2, NULL),
(889, 434, 722, 61.11, 2, NULL),
(890, 435, 722, 22.29, 2, NULL),
(891, 723, 435, 42.43, 2, NULL),
(892, 418, 723, 39.72, 2, NULL),
(893, 432, 687, 24.37, 2, NULL),
(894, 724, 432, 69.21, 2, NULL),
(895, 429, 724, 16.85, 2, NULL),
(896, 428, 724, 30.18, 2, NULL),
(897, 688, 431, 30.03, 2, NULL),
(898, 725, 688, 17.01, 2, NULL),
(899, 726, 725, 34.51, 2, NULL),
(900, 430, 726, 38.33, 2, NULL),
(901, 707, 430, 65.01, 2, NULL),
(903, 695, 705, 80.08, 2, NULL),
(904, 727, 695, 17.58, 2, NULL),
(905, 427, 727, 81.64, 2, NULL),
(906, 674, 414, 55.71, 2, NULL),
(907, 676, 415, 68.13, 2, NULL),
(908, 728, 684, 24.93, 2, NULL),
(909, 729, 728, 74.91, 2, NULL),
(910, 523, 729, 300.87, 2, NULL),
(911, 730, 407, 37.05, 1, NULL),
(912, 542, 730, 27.65, 1, NULL),
(914, 732, 731, 68.93, 2, NULL),
(916, 734, 733, 63.26, 2, NULL),
(917, 735, 734, 41.05, 2, NULL),
(918, 736, 735, 53.66, 2, NULL),
(919, 566, 736, 37.39, 2, NULL),
(920, 737, 733, 54.96, 2, NULL),
(921, 738, 737, 50.73, 2, NULL),
(922, 732, 738, 61.37, 2, NULL),
(923, 739, 732, 25.87, 2, NULL),
(924, 740, 739, 37.46, 2, NULL),
(925, 741, 740, 35.8, 2, NULL),
(926, 402, 741, 13.87, 2, NULL),
(927, 391, 572, 13.71, 2, NULL),
(928, 742, 737, 30.42, 2, NULL),
(929, 398, 742, 28.86, 2, NULL),
(930, 743, 400, 6.4, 2, NULL),
(931, 744, 743, 35.34, 2, NULL),
(932, 745, 744, 17.07, 2, NULL),
(933, 746, 745, 19.94, 2, NULL),
(934, 747, 746, 8.34, 2, NULL),
(935, 748, 747, 7.63, 2, NULL),
(936, 749, 748, 31.52, 2, NULL),
(937, 750, 749, 9.94, 2, NULL),
(938, 751, 750, 6.65, 2, NULL),
(939, 752, 751, 17.3, 2, NULL),
(940, 753, 752, 7.89, 2, NULL),
(941, 754, 753, 13.96, 2, NULL),
(942, 755, 754, 37.36, 2, NULL),
(943, 402, 755, 18.48, 2, NULL),
(944, 756, 755, 34.16, 2, NULL),
(945, 757, 756, 18.6, 2, NULL),
(946, 572, 757, 65.47, 2, NULL),
(947, 758, 394, 30.77, 2, NULL),
(948, 759, 758, 11.99, 2, NULL),
(949, 760, 759, 22.03, 2, NULL),
(950, 756, 760, 26.92, 2, NULL),
(951, 400, 755, 21.41, 2, NULL),
(952, 761, 750, 6.17, 1, NULL),
(953, 762, 761, 40.42, 1, NULL),
(954, 763, 762, 61.71, 1, NULL),
(955, 747, 763, 49.2, 1, NULL),
(956, 549, 763, 16.22, 2, NULL),
(957, 764, 549, 65.29, 2, NULL),
(958, 765, 764, 106.1, 2, NULL),
(959, 766, 765, 42.06, 2, NULL),
(960, 767, 766, 117.39, 2, NULL),
(961, 562, 767, 61.16, 2, NULL),
(962, 765, 565, 15.63, 2, NULL),
(963, 731, 765, 73.55, 2, NULL),
(964, 768, 561, 33.21, 2, NULL),
(965, 403, 768, 29.21, 2, NULL),
(966, 405, 559, 47.57, 2, NULL),
(967, 403, 559, 60.7, 2, NULL),
(968, 769, 505, 25.36, 2, NULL),
(969, 770, 769, 60.21, 2, NULL),
(971, 385, 769, 23.74, 2, NULL),
(972, 770, 639, 27.26, 3, NULL),
(973, 527, 640, 32.48, 2, NULL),
(974, 771, 660, 45.8, 2, NULL),
(975, 772, 771, 30.79, 2, NULL),
(976, 773, 772, 16.71, 2, NULL),
(977, 774, 773, 18.18, 2, NULL),
(978, 775, 774, 35.49, 2, NULL),
(979, 776, 775, 24.54, 2, NULL),
(980, 777, 776, 21.07, 2, NULL),
(981, 778, 777, 6.33, 2, NULL),
(982, 779, 778, 78.49, 2, NULL),
(984, 662, 780, 8.6, 2, NULL),
(985, 779, 780, 15.38, 3, NULL),
(986, 409, 776, 38.09, 2, NULL),
(987, 781, 773, 20.12, 2, NULL),
(988, 782, 781, 16.78, 2, NULL),
(989, 778, 782, 48.24, 2, NULL),
(992, 708, 425, 63.4, 2, NULL),
(993, 786, 696, 85.18, 2, NULL),
(994, 787, 786, 248.13, 2, NULL),
(995, 788, 787, 186.77, 2, NULL),
(996, 728, 788, 285.36, 2, NULL),
(997, 789, 635, 84.17, 2, NULL),
(998, 729, 789, 220.33, 2, NULL),
(999, 790, 531, 103.13, 2, NULL),
(1000, 791, 790, 306.07, 2, NULL),
(1001, 792, 791, 348.66, 2, NULL),
(1002, 388, 792, 85.44, 2, NULL),
(1003, 691, 707, 210.97, 2, NULL),
(1004, 487, 374, 33.23, 2, '');

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
(2, 'Walkway'),
(3, 'Stairway'),
(4, 'Elevator'),
(5, 'Inner Connection'),
(6, 'typew'),
(7, 'typew'),
(8, 'typew');

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
-- Table structure for table `trips`
--

CREATE TABLE `trips` (
  `trip_id` bigint(255) NOT NULL,
  `departure_location_id` bigint(255) NOT NULL,
  `destination_location_id` bigint(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  ADD KEY `location_type` (`location_type`),
  ADD KEY `parent_id` (`parent_id`);

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
-- Indexes for table `trips`
--
ALTER TABLE `trips`
  ADD PRIMARY KEY (`trip_id`),
  ADD KEY `departure_location_id` (`departure_location_id`),
  ADD KEY `destination_location_id` (`destination_location_id`);

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
  MODIFY `location_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=794;
--
-- AUTO_INCREMENT for table `location_type`
--
ALTER TABLE `location_type`
  MODIFY `location_type_id` int(22) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `log_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `paths`
--
ALTER TABLE `paths`
  MODIFY `path_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1005;
--
-- AUTO_INCREMENT for table `path_type`
--
ALTER TABLE `path_type`
  MODIFY `path_type_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
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
-- AUTO_INCREMENT for table `trips`
--
ALTER TABLE `trips`
  MODIFY `trip_id` bigint(255) NOT NULL AUTO_INCREMENT;
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
-- Constraints for table `trips`
--
ALTER TABLE `trips`
  ADD CONSTRAINT `trips_ibfk_1` FOREIGN KEY (`departure_location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `trips_ibfk_2` FOREIGN KEY (`destination_location_id`) REFERENCES `location` (`location_id`);

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
