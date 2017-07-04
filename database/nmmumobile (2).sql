-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2017 at 10:17 PM
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
  `parent_id` bigint(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`country`, `address`, `post_box`, `location_id`, `gps`, `location_name`, `username`, `location_type`, `parent_id`) VALUES
(200, NULL, NULL, 360, '-34.008578,25.669485', 'Nelson Mandela University', 'NMMU', 1, NULL),
(200, NULL, NULL, 361, '-33.988012,25.657674', 'Second Avenue', 'NMMU', 2, 360),
(200, NULL, NULL, 367, '-33.872440,25.552591', 'Missionvale', 'NMMU', 2, 360),
(200, NULL, NULL, 368, '-33.965241,25.617134', 'Bird Street', 'NMMU', 2, 360),
(200, NULL, NULL, 369, '-34.0081858,25.6646675', 'South', 'NMMU', 2, 360),
(200, NULL, NULL, 370, '-33.971628,22.534518', 'George', 'NMMU', 2, 360),
(200, NULL, NULL, 371, '-34.0009942,25.6692978', 'North', 'NMMU', 2, 360),
(200, 'N/A', '', 374, '-34.00900192085222,25.66980879753828', '1 Main Building', 'NMMU', 3, 369),
(200, 'N/A', '', 375, '-34.0088089002989,25.669789519160986', '2 Council Chamber', 'NMMU', 3, 369),
(200, 'N/A', '', 376, '-34.0092735941058,25.669800247997046', '3 Auditorium', 'NMMU', 3, 369),
(200, 'N/A', '', 377, '-34.00869550573039,25.66908895969391', '4 Old Mutual Lecture Halls', 'NMMU', 3, 369),
(200, 'N/A', '', 378, '-34.00954929640648,25.669075548648834', '5 Sanlam Lecture Halls', 'NMMU', 3, 369),
(200, 'N/A', '', 380, '-34.00860879213464,25.66831648349762', '6 Education, Writing Centre\n& ABSA Computer lab', 'NMMU', 3, 369),
(200, 'N/A', '', 381, '-34.00958806697072,25.668291673064232', '7 Mathematics & Applied Mathematics', 'NMMU', 3, 369),
(200, 'N/A', '', 382, '-34.009108644771096,25.667195320129395', '8 Library and School of Architecture', 'NMMU', 3, 369),
(200, 'N/A', '', 383, '-34.008573217300516,25.669794380664825', '9 Embizweni ', 'NMMU', 3, 369),
(200, 'N/A', '', 384, '-34.00959779434966,25.66957712173462', '10 Music', 'NMMU', 3, 369),
(200, 'N/A', '', 385, '-34.00832551320831,25.668307095766068', '11 Education', 'NMMU', 3, 369),
(200, 'N/A', '', 386, '-34.00834218896232,25.66698208451271', '12 Biological Sciences', 'NMMU', 3, 369),
(200, 'N/A', '', 387, '-34.00965560275004,25.667254328727722', '13 Physics and Chemistry', 'NMMU', 3, 369),
(200, 'N/A', '', 388, '-34.011745439130685,25.661766529083252', '15 Technical Services/Procurement', 'NMMU', 3, 369),
(200, 'N/A', '', 389, '-34.00853192007832,25.67406814545393', '17 Unitas Main Block', 'NMMU', 3, 369),
(200, 'N/A', '', 390, '-34.00875576197144,25.67341536283493', '58 Unitas Annex', 'NMMU', 3, 369),
(200, 'N/A', '', 391, '-34.00872431801857,25.674973726272583', '59 Veritas Annex', 'NMMU', 3, 369),
(200, 'N/A', '', 392, '-34.00941293792194,25.673401951789856', '60 Xanadu Annex', 'NMMU', 3, 369),
(200, 'N/A', '', 393, '-34.00969907514357,25.674096643924713', '19 Xanadu Main Block', 'NMMU', 3, 369),
(200, 'N/A', '', 394, '-34.00937206109728,25.675223171710968', '20 Melodi Main Block', 'NMMU', 3, 369),
(200, 'N/A', '', 395, '-34.010814725967,25.678476691246033', '24 Indoor Sport Centre and Sport Offices', 'NMMU', 3, 369),
(200, 'N/A', '', 396, '-34.00960101036646,25.670601725578308', '35 Universet Lecture Halls', 'NMMU', 3, 369),
(200, 'N/A', '', 397, '-34.00920564113309,25.67826747894287', '36 Stadium and Clubhouse', 'NMMU', 3, 369),
(200, 'N/A', '', 398, '-34.00841931107145,25.674992501735687', '27 Study Centre (Veritas)', 'NMMU', 3, 369),
(200, 'N/A', '', 399, '-34.00872431801857,25.674973726272583', '18 Veritas Main Block', 'NMMU', 3, 369),
(200, 'N/A', '', 400, '-34.00917966462464,25.676202178001404', '59 Veritas Annex', 'NMMU', 3, 369),
(200, 'N/A', '', 401, '-34.00917966462464,25.676202178001404', '50 Melodi Annex', 'NMMU', 3, 369),
(200, 'N/A', '', 402, '-34.00882179423462,25.6761834025383', '59 Veritas Annex', 'NMMU', 3, 369),
(200, 'N/A', '', 403, '-34.0062553417948,25.675698928534985', '125 Human Movement Science', 'NMMU', 3, 369),
(200, 'N/A', '', 404, '-34.01082474848148,25.679216980934143', '126 Dietetics', 'NMMU', 3, 369),
(200, 'N/A', '', 405, '-34.00625593138617,25.675319731235504', '126 Dietetics', 'NMMU', 3, 369),
(200, 'N/A', '', 406, '-34.00706091631194,25.67507565021515', '51 Unitas/Veritas Clubhouse and Pool', 'NMMU', 3, 369),
(200, 'N/A', '', 407, '-34.01065809945916,25.675089061260223', '53 Xanadu/Melodi Clubhouse ', 'NMMU', 3, 369),
(200, 'N/A', '', 408, '-34.009280284693304,25.671851634979248', '123', 'NMMU', 3, 369),
(200, 'N/A', '', 409, '-34.00865423340499,25.666015148162842', '127 Life Sciences', 'NMMU', 3, 369),
(200, 'N/A', '', 410, '-34.001980915503246,25.673776636064076', '201 Lebombo Residence', 'NMMU', 3, 371),
(200, 'N/A', '', 411, '-34.00297263539996,25.67442598729076', '251 Letaba Residence', 'NMMU', 3, 371),
(200, 'N/A', '', 412, '-34.00238124509304,25.673847198486328', '252 Campus Health Services', 'NMMU', 3, 371),
(200, 'N/A', '', 413, '-34.00238124509304,25.67308008670807', '229 Technical Services', 'NMMU', 3, 371),
(200, 'N/A', '', 414, '-34.002548499975305,25.672715306282043', '230 Tennis Clubhouse', 'NMMU', 3, 371),
(200, 'N/A', '', 415, '-34.0026774294835,25.67192405462265', '212 Heinz Betz Centre ', 'NMMU', 3, 371),
(200, 'N/A', '', 416, '-34.00252625170009,25.670394524931908', '288 Engineering Building II', 'NMMU', 3, 371),
(200, 'N/A', '', 417, '-34.00226233866034,25.670757293701172', '276 Engineering Building', 'NMMU', 3, 371),
(200, 'N/A', '', 418, '-34.001888126255295,25.670886039733887', '286 Bitumen Building', 'NMMU', 3, 371),
(200, 'N/A', '', 419, '-34.001903849498774,25.671516358852386', '205 Laboratories', 'NMMU', 3, 371),
(200, 'N/A', '', 420, '-34.00172774900558,25.672430992126465', '219 Student Services Centre', 'NMMU', 3, 371),
(200, 'N/A', '', 421, '-34.00187240300892,25.672782361507416', '225 EBEIT Lab ', 'NMMU', 3, 371),
(200, 'N/A', '', 422, '-34.00140070426386,25.672752857208252', '215 Food Court (cafeteria)  and Muslim Prayer Room', 'NMMU', 3, 371),
(200, 'N/A', '', 423, '-34.001152275205044,25.67281723022461', '217 Goldfields Auditorium', 'NMMU', 3, 371),
(200, 'N/A', '', 424, '-34.0012812068326,25.673605799674988', '235 Conference Centre', 'NMMU', 3, 371),
(200, 'N/A', '', 425, '-34.00081579418204,25.672414898872375', '222 D Block (main entrance, cashiers, ABSA Alumni Centre, Student Counselling)', 'NMMU', 3, 371),
(200, 'N/A', '', 426, '-34.00041641777999,25.67230761051178', '209 Human Resources and Contact Centre', 'NMMU', 3, 371),
(200, 'N/A', '', 427, '-34.00045100951113,25.672776997089386', '260 Main Administration Building', 'NMMU', 3, 371),
(200, 'N/A', '', 428, '-34.000696295927916,25.671406388282776', '202 Science and Health Sciences', 'NMMU', 3, 371),
(200, 'N/A', '', 429, '-34.000551639921646,25.67107915878296', '207 Lecture Halls (N1 and N2)', 'NMMU', 3, 371),
(200, 'N/A', '', 430, '-34.000123959853624,25.67104160785675', '208 Art', 'NMMU', 3, 371),
(200, 'N/A', '', 431, '-34.00041956248341,25.67045420408249', '206 Nursing', 'NMMU', 3, 371),
(200, 'N/A', '', 432, '-34.000752900385045,25.670330822467804', '226 Goldfields Computer Centre (writing centre, Offices etc.)', 'NMMU', 3, 371),
(200, 'N/A', '', 433, '-34.00115651173071,25.67130446434021', '203 Engineering', 'NMMU', 3, 371),
(200, 'N/A', '', 434, '-34.00148246556736,25.671301782131195', '204 Built Environment ', 'NMMU', 3, 371),
(200, 'N/A', '', 435, '-34.001513322577296,25.670397877693176', '261 MTLC Building (eNtsa, library, CTLM, Senate Hall, lecture halls)', 'NMMU', 3, 371),
(200, 'N/A', NULL, 436, '-34.00900192085222,25.66980879753828', 'Ground', 'NMMU', 4, 374),
(200, 'N/A', NULL, 437, '-34.00900192085222,25.66980879753828', 'Entrance', 'NMMU', 10, 436),
(200, 'N/A', NULL, 438, '-34.0088089002989,25.669789519160986', 'Ground', 'NMMU', 4, 375),
(200, 'N/A', NULL, 439, '-34.0088089002989,25.669789519160986', 'Entrance', 'NMMU', 10, 438),
(200, 'N/A', NULL, 440, '-34.0092735941058,25.669800247997046', 'Ground', 'NMMU', 4, 376),
(200, 'N/A', NULL, 441, '-34.0092735941058,25.669800247997046', 'Entrance', 'NMMU', 10, 440),
(200, 'N/A', NULL, 442, '-34.00869550573039,25.66908895969391', 'Ground', 'NMMU', 4, 377),
(200, 'N/A', NULL, 443, '-34.00869550573039,25.66908895969391', 'Entrance', 'NMMU', 10, 442),
(200, 'N/A', NULL, 444, '-34.00954929640648,25.669075548648834', 'Ground', 'NMMU', 4, 378),
(200, 'N/A', NULL, 445, '-34.00954929640648,25.669075548648834', 'Entrance', 'NMMU', 10, 444),
(200, 'N/A', NULL, 446, '-34.00860879213464,25.66831648349762', 'Ground', 'NMMU', 4, 380),
(200, 'N/A', NULL, 447, '-34.00860879213464,25.66831648349762', 'Entrance', 'NMMU', 10, 446),
(200, 'N/A', NULL, 448, '-34.00958806697072,25.668291673064232', 'Ground', 'NMMU', 4, 381),
(200, 'N/A', NULL, 449, '-34.00958806697072,25.668291673064232', 'Entrance', 'NMMU', 10, 448),
(200, 'N/A', NULL, 450, '-34.009108644771096,25.667195320129395', 'Ground', 'NMMU', 4, 382),
(200, 'N/A', NULL, 451, '-34.009108644771096,25.667195320129395', 'Entrance', 'NMMU', 10, 450),
(200, 'N/A', NULL, 452, '-34.008573217300516,25.669794380664825', 'Ground', 'NMMU', 4, 383),
(200, 'N/A', NULL, 453, '-34.008573217300516,25.669794380664825', 'Entrance', 'NMMU', 10, 452),
(200, 'N/A', NULL, 454, '-34.00959779434966,25.66957712173462', 'Ground', 'NMMU', 4, 384),
(200, 'N/A', NULL, 455, '-34.00959779434966,25.66957712173462', 'Entrance', 'NMMU', 10, 454),
(200, 'N/A', NULL, 456, '-34.00832551320831,25.668307095766068', 'Ground', 'NMMU', 4, 385),
(200, 'N/A', NULL, 457, '-34.00832551320831,25.668307095766068', 'Entrance', 'NMMU', 10, 456),
(200, 'N/A', NULL, 458, '-34.00834218896232,25.66698208451271', 'Ground', 'NMMU', 4, 386),
(200, 'N/A', NULL, 459, '-34.00834218896232,25.66698208451271', 'Entrance', 'NMMU', 10, 458),
(200, 'N/A', NULL, 460, '-34.00965560275004,25.667254328727722', 'Ground', 'NMMU', 4, 387),
(200, 'N/A', NULL, 461, '-34.00965560275004,25.667254328727722', 'Entrance', 'NMMU', 10, 460),
(200, 'N/A', NULL, 462, '-34.011745439130685,25.661766529083252', 'Ground', 'NMMU', 4, 388),
(200, 'N/A', NULL, 463, '-34.011745439130685,25.661766529083252', 'Entrance', 'NMMU', 10, 462),
(200, 'N/A', NULL, 464, '-34.00853192007832,25.67406814545393', 'Ground', 'NMMU', 4, 389),
(200, 'N/A', NULL, 465, '-34.00853192007832,25.67406814545393', 'Entrance', 'NMMU', 10, 464),
(200, 'N/A', NULL, 466, '-34.00875576197144,25.67341536283493', 'Ground', 'NMMU', 4, 390),
(200, 'N/A', NULL, 467, '-34.00875576197144,25.67341536283493', 'Entrance', 'NMMU', 10, 466),
(200, 'N/A', NULL, 468, '-34.00872431801857,25.674973726272583', 'Ground', 'NMMU', 4, 391),
(200, 'N/A', NULL, 469, '-34.00872431801857,25.674973726272583', 'Entrance', 'NMMU', 10, 468),
(200, 'N/A', NULL, 470, '-34.00941293792194,25.673401951789856', 'Ground', 'NMMU', 4, 392),
(200, 'N/A', NULL, 471, '-34.00941293792194,25.673401951789856', 'Entrance', 'NMMU', 10, 470),
(200, 'N/A', NULL, 472, '-34.00969907514357,25.674096643924713', 'Ground', 'NMMU', 4, 393),
(200, 'N/A', NULL, 473, '-34.00969907514357,25.674096643924713', 'Entrance', 'NMMU', 10, 472),
(200, 'N/A', NULL, 474, '-34.00937206109728,25.675223171710968', 'Ground', 'NMMU', 4, 394),
(200, 'N/A', NULL, 475, '-34.00937206109728,25.675223171710968', 'Entrance', 'NMMU', 10, 474),
(200, 'N/A', NULL, 476, '-34.010814725967,25.678476691246033', 'Ground', 'NMMU', 4, 395),
(200, 'N/A', NULL, 477, '-34.010814725967,25.678476691246033', 'Entrance', 'NMMU', 10, 476),
(200, 'N/A', NULL, 478, '-34.00960101036646,25.670601725578308', 'Ground', 'NMMU', 4, 396),
(200, 'N/A', NULL, 479, '-34.00960101036646,25.670601725578308', 'Entrance', 'NMMU', 10, 478),
(200, 'N/A', NULL, 480, '-34.00920564113309,25.67826747894287', 'Ground', 'NMMU', 4, 397),
(200, 'N/A', NULL, 481, '-34.00920564113309,25.67826747894287', 'Entrance', 'NMMU', 10, 480),
(200, 'N/A', NULL, 482, '-34.00841931107145,25.674992501735687', 'Ground', 'NMMU', 4, 398),
(200, 'N/A', NULL, 483, '-34.00841931107145,25.674992501735687', 'Entrance', 'NMMU', 10, 482),
(200, 'N/A', NULL, 484, '-34.00872431801857,25.674973726272583', 'Ground', 'NMMU', 4, 399),
(200, 'N/A', NULL, 485, '-34.00872431801857,25.674973726272583', 'Entrance', 'NMMU', 10, 484),
(200, 'N/A', NULL, 486, '-34.00917966462464,25.676202178001404', 'Ground', 'NMMU', 4, 400),
(200, 'N/A', NULL, 487, '-34.00917966462464,25.676202178001404', 'Entrance', 'NMMU', 10, 486),
(200, 'N/A', NULL, 488, '-34.00917966462464,25.676202178001404', 'Ground', 'NMMU', 4, 401),
(200, 'N/A', NULL, 489, '-34.00917966462464,25.676202178001404', 'Entrance', 'NMMU', 10, 488),
(200, 'N/A', NULL, 490, '-34.00882179423462,25.6761834025383', 'Ground', 'NMMU', 4, 402),
(200, 'N/A', NULL, 491, '-34.00882179423462,25.6761834025383', 'Entrance', 'NMMU', 10, 490),
(200, 'N/A', NULL, 492, '-34.0062553417948,25.675698928534985', 'Ground', 'NMMU', 4, 403),
(200, 'N/A', NULL, 493, '-34.0062553417948,25.675698928534985', 'Entrance', 'NMMU', 10, 492),
(200, 'N/A', NULL, 494, '-34.01082474848148,25.679216980934143', 'Ground', 'NMMU', 4, 404),
(200, 'N/A', NULL, 495, '-34.01082474848148,25.679216980934143', 'Entrance', 'NMMU', 10, 494),
(200, 'N/A', NULL, 496, '-34.00625593138617,25.675319731235504', 'Ground', 'NMMU', 4, 405),
(200, 'N/A', NULL, 497, '-34.00625593138617,25.675319731235504', 'Entrance', 'NMMU', 10, 496),
(200, 'N/A', NULL, 498, '-34.00706091631194,25.67507565021515', 'Ground', 'NMMU', 4, 406),
(200, 'N/A', NULL, 499, '-34.00706091631194,25.67507565021515', 'Entrance', 'NMMU', 10, 498),
(200, 'N/A', NULL, 500, '-34.01065809945916,25.675089061260223', 'Ground', 'NMMU', 4, 407),
(200, 'N/A', NULL, 501, '-34.01065809945916,25.675089061260223', 'Entrance', 'NMMU', 10, 500),
(200, 'N/A', NULL, 502, '-34.009280284693304,25.671851634979248', 'Ground', 'NMMU', 4, 408),
(200, 'N/A', NULL, 503, '-34.009280284693304,25.671851634979248', 'Entrance', 'NMMU', 10, 502),
(200, 'N/A', NULL, 504, '-34.00865423340499,25.666015148162842', 'Ground', 'NMMU', 4, 409),
(200, 'N/A', NULL, 505, '-34.00865423340499,25.666015148162842', 'Entrance', 'NMMU', 10, 504),
(200, 'N/A', NULL, 506, '-34.001980915503246,25.673776636064076', 'Ground', 'NMMU', 4, 410),
(200, 'N/A', NULL, 507, '-34.001980915503246,25.673776636064076', 'Entrance', 'NMMU', 10, 506),
(200, 'N/A', NULL, 508, '-34.00297263539996,25.67442598729076', 'Ground', 'NMMU', 4, 411),
(200, 'N/A', NULL, 509, '-34.00297263539996,25.67442598729076', 'Entrance', 'NMMU', 10, 508),
(200, 'N/A', NULL, 510, '-34.00238124509304,25.673847198486328', 'Ground', 'NMMU', 4, 412),
(200, 'N/A', NULL, 511, '-34.00238124509304,25.673847198486328', 'Entrance', 'NMMU', 10, 510),
(200, 'N/A', NULL, 512, '-34.00238124509304,25.67308008670807', 'Ground', 'NMMU', 4, 413),
(200, 'N/A', NULL, 513, '-34.00238124509304,25.67308008670807', 'Entrance', 'NMMU', 10, 512),
(200, 'N/A', NULL, 514, '-34.002548499975305,25.672715306282043', 'Ground', 'NMMU', 4, 414),
(200, 'N/A', NULL, 515, '-34.002548499975305,25.672715306282043', 'Entrance', 'NMMU', 10, 514),
(200, 'N/A', NULL, 516, '-34.0026774294835,25.67192405462265', 'Ground', 'NMMU', 4, 415),
(200, 'N/A', NULL, 517, '-34.0026774294835,25.67192405462265', 'Entrance', 'NMMU', 10, 516),
(200, 'N/A', NULL, 518, '-34.00252625170009,25.670394524931908', 'Ground', 'NMMU', 4, 416),
(200, 'N/A', NULL, 519, '-34.00252625170009,25.670394524931908', 'Entrance', 'NMMU', 10, 518),
(200, 'N/A', NULL, 520, '-34.00226233866034,25.670757293701172', 'Ground', 'NMMU', 4, 417),
(200, 'N/A', NULL, 521, '-34.00226233866034,25.670757293701172', 'Entrance', 'NMMU', 10, 520),
(200, 'N/A', NULL, 522, '-34.001888126255295,25.670886039733887', 'Ground', 'NMMU', 4, 418),
(200, 'N/A', NULL, 523, '-34.001888126255295,25.670886039733887', 'Entrance', 'NMMU', 10, 522),
(200, 'N/A', NULL, 524, '-34.001903849498774,25.671516358852386', 'Ground', 'NMMU', 4, 419),
(200, 'N/A', NULL, 525, '-34.001903849498774,25.671516358852386', 'Entrance', 'NMMU', 10, 524),
(200, 'N/A', NULL, 526, '-34.00172774900558,25.672430992126465', 'Ground', 'NMMU', 4, 420),
(200, 'N/A', NULL, 527, '-34.00172774900558,25.672430992126465', 'Entrance', 'NMMU', 10, 526),
(200, 'N/A', NULL, 528, '-34.00187240300892,25.672782361507416', 'Ground', 'NMMU', 4, 421),
(200, 'N/A', NULL, 529, '-34.00187240300892,25.672782361507416', 'Entrance', 'NMMU', 10, 528),
(200, 'N/A', NULL, 530, '-34.00140070426386,25.672752857208252', 'Ground', 'NMMU', 4, 422),
(200, 'N/A', NULL, 531, '-34.00140070426386,25.672752857208252', 'Entrance', 'NMMU', 10, 530),
(200, 'N/A', NULL, 532, '-34.001152275205044,25.67281723022461', 'Ground', 'NMMU', 4, 423),
(200, 'N/A', NULL, 533, '-34.001152275205044,25.67281723022461', 'Entrance', 'NMMU', 10, 532),
(200, 'N/A', NULL, 534, '-34.0012812068326,25.673605799674988', 'Ground', 'NMMU', 4, 424),
(200, 'N/A', NULL, 535, '-34.0012812068326,25.673605799674988', 'Entrance', 'NMMU', 10, 534),
(200, 'N/A', NULL, 536, '-34.00081579418204,25.672414898872375', 'Ground', 'NMMU', 4, 425),
(200, 'N/A', NULL, 537, '-34.00081579418204,25.672414898872375', 'Entrance', 'NMMU', 10, 536),
(200, 'N/A', NULL, 538, '-34.00041641777999,25.67230761051178', 'Ground', 'NMMU', 4, 426),
(200, 'N/A', NULL, 539, '-34.00041641777999,25.67230761051178', 'Entrance', 'NMMU', 10, 538),
(200, 'N/A', NULL, 540, '-34.00045100951113,25.672776997089386', 'Ground', 'NMMU', 4, 427),
(200, 'N/A', NULL, 541, '-34.00045100951113,25.672776997089386', 'Entrance', 'NMMU', 10, 540),
(200, 'N/A', NULL, 542, '-34.000696295927916,25.671406388282776', 'Ground', 'NMMU', 4, 428),
(200, 'N/A', NULL, 543, '-34.000696295927916,25.671406388282776', 'Entrance', 'NMMU', 10, 542),
(200, 'N/A', NULL, 544, '-34.000551639921646,25.67107915878296', 'Ground', 'NMMU', 4, 429),
(200, 'N/A', NULL, 545, '-34.000551639921646,25.67107915878296', 'Entrance', 'NMMU', 10, 544),
(200, 'N/A', NULL, 546, '-34.000123959853624,25.67104160785675', 'Ground', 'NMMU', 4, 430),
(200, 'N/A', NULL, 547, '-34.000123959853624,25.67104160785675', 'Entrance', 'NMMU', 10, 546),
(200, 'N/A', NULL, 548, '-34.00041956248341,25.67045420408249', 'Ground', 'NMMU', 4, 431),
(200, 'N/A', NULL, 549, '-34.00041956248341,25.67045420408249', 'Entrance', 'NMMU', 10, 548),
(200, 'N/A', NULL, 550, '-34.000752900385045,25.670330822467804', 'Ground', 'NMMU', 4, 432),
(200, 'N/A', NULL, 551, '-34.000752900385045,25.670330822467804', 'Entrance', 'NMMU', 10, 550),
(200, 'N/A', NULL, 552, '-34.00115651173071,25.67130446434021', 'Ground', 'NMMU', 4, 433),
(200, 'N/A', NULL, 553, '-34.00115651173071,25.67130446434021', 'Entrance', 'NMMU', 10, 552),
(200, 'N/A', NULL, 554, '-34.00148246556736,25.671301782131195', 'Ground', 'NMMU', 4, 434),
(200, 'N/A', NULL, 555, '-34.00148246556736,25.671301782131195', 'Entrance', 'NMMU', 10, 554),
(200, 'N/A', NULL, 556, '-34.001513322577296,25.670397877693176', 'Ground', 'NMMU', 4, 435),
(200, 'N/A', NULL, 557, '-34.001513322577296,25.670397877693176', 'Entrance', 'NMMU', 10, 556);

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
(1, 'Area', 0),
(2, 'Campus', 1),
(3, 'Building', 2),
(4, 'Level', 3),
(5, 'Parking', 4),
(6, 'Staircase', 4),
(7, 'Room', 4),
(8, 'Elevator', 4),
(9, 'Bank', 4),
(10, 'Entrance', 4),
(11, 'Restaurant', 5),
(12, 'Library', 2),
(15, 'Outdoor Intersection', 2),
(16, 'Indoor Intersection', 4);

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
(3, 'Stairway');

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
  MODIFY `location_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=558;
--
-- AUTO_INCREMENT for table `location_type`
--
ALTER TABLE `location_type`
  MODIFY `location_type_id` int(22) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `log_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `paths`
--
ALTER TABLE `paths`
  MODIFY `path_id` bigint(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `path_type`
--
ALTER TABLE `path_type`
  MODIFY `path_type_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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
