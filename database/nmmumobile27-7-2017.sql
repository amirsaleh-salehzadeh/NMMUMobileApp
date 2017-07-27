-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 27, 2017 at 10:25 AM
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
(200, NULL, NULL, 360, '-34.01303096346168,25.670464006290445', 'Nelson Mandela University', 'NMMU', 1, 0),
(200, NULL, NULL, 361, '-33.988012,25.657674', 'Second Avenue', 'NMMU', 2, 360),
(200, NULL, NULL, 367, '-33.872440,25.552591', 'Missionvale', 'NMMU', 2, 360),
(200, NULL, NULL, 368, '-33.965241,25.617134', 'Bird Street', 'NMMU', 2, 360),
(200, NULL, NULL, 369, '-34.0081858,25.6646675', 'South', 'NMMU', 2, 360),
(200, NULL, NULL, 370, '-33.971628,22.534518', 'George', 'NMMU', 2, 360),
(200, NULL, NULL, 371, '-34.0009942,25.6692978', 'North', 'NMMU', 2, 360),
(200, NULL, NULL, 374, '-34.00900192085222,25.66980879753828', '1 Main Building', 'NMMU', 3, 369),
(200, NULL, NULL, 375, '-34.0088089002989,25.669789519160986', '2 Council Chamber', 'NMMU', 3, 369),
(200, NULL, NULL, 376, '-34.0092735941058,25.669800247997046', '3 Auditorium', 'NMMU', 3, 369),
(200, NULL, NULL, 377, '-34.008591004719435,25.66909432411194', '4 Old Mutual Lecture Halls', 'NMMU', 3, 369),
(200, NULL, NULL, 378, '-34.00954929640648,25.669075548648834', '5 Sanlam Lecture Halls', 'NMMU', 3, 369),
(200, NULL, NULL, 380, '-34.008498732443286,25.66828429698944', '6 Education, Writing Centre', 'NMMU', 3, 369),
(200, NULL, NULL, 381, '-34.00958806697072,25.668291673064232', '7 Mathematics & Applied Mathematics', 'NMMU', 3, 369),
(200, NULL, NULL, 382, '-34.0090206020396,25.667463541030884', '8 Library and School of Architecture', 'NMMU', 3, 369),
(200, NULL, NULL, 383, '-34.008573217300516,25.669794380664825', '9 Embizweni ', 'NMMU', 3, 369),
(200, NULL, NULL, 384, '-34.00959779434966,25.66957712173462', '10 Music', 'NMMU', 3, 369),
(200, NULL, NULL, 385, '-34.00832551320831,25.668307095766068', '11 Education', 'NMMU', 3, 369),
(200, NULL, NULL, 386, '-34.00834218896232,25.66698208451271', '12 Biological Sciences', 'NMMU', 3, 369),
(200, NULL, NULL, 387, '-34.00965560275004,25.667254328727722', '13 Physics and Chemistry', 'NMMU', 3, 369),
(200, NULL, NULL, 388, '-34.011745439130685,25.661766529083252', '15 Technical Services/Procurement', 'NMMU', 3, 369),
(200, NULL, NULL, 389, '-34.00853192007832,25.67406814545393', '17 Unitas Main Block', 'NMMU', 3, 369),
(200, NULL, NULL, 390, '-34.00875576197144,25.67341536283493', '58 Unitas Annex', 'NMMU', 3, 369),
(200, NULL, NULL, 391, '-34.00872431801857,25.674973726272583', '59 Veritas Annex', 'NMMU', 3, 369),
(200, NULL, NULL, 392, '-34.00941293792194,25.673401951789856', '60 Xanadu Annex', 'NMMU', 3, 369),
(200, NULL, NULL, 393, '-34.00969907514357,25.674096643924713', '19 Xanadu Main Block', 'NMMU', 3, 369),
(200, NULL, NULL, 394, '-34.00937206109728,25.675223171710968', '20 Melodi Main Block', 'NMMU', 3, 369),
(200, NULL, NULL, 395, '-34.010814725967,25.678476691246033', '24 Indoor Sport Centre and Sport Offices', 'NMMU', 3, 369),
(200, NULL, NULL, 396, '-34.00960101036646,25.670601725578308', '35 Universet Lecture Halls', 'NMMU', 3, 369),
(200, NULL, NULL, 397, '-34.00920564113309,25.67826747894287', '36 Stadium and Clubhouse', 'NMMU', 3, 369),
(200, NULL, NULL, 398, '-34.00841931107145,25.674992501735687', '27 Study Centre (Veritas)', 'NMMU', 3, 369),
(200, NULL, NULL, 399, '-34.00872431801857,25.674973726272583', '18 Veritas Main Block', 'NMMU', 3, 369),
(200, NULL, NULL, 400, '-34.00917966462464,25.676202178001404', '59 Veritas Annex', 'NMMU', 3, 369),
(200, NULL, NULL, 401, '-34.00917966462464,25.676202178001404', '50 Melodi Annex', 'NMMU', 3, 369),
(200, NULL, NULL, 402, '-34.00882179423462,25.6761834025383', '59 Veritas Annex', 'NMMU', 3, 369),
(200, NULL, NULL, 403, '-34.0062553417948,25.675698928534985', '125 Human Movement Science', 'NMMU', 3, 369),
(200, NULL, NULL, 404, '-34.01082474848148,25.679216980934143', '126 Dietetics', 'NMMU', 3, 369),
(200, NULL, NULL, 405, '-34.00625593138617,25.675319731235504', '126 Dietetics', 'NMMU', 3, 369),
(200, NULL, NULL, 406, '-34.00706091631194,25.67507565021515', '51 Unitas/Veritas Clubhouse and Pool', 'NMMU', 3, 369),
(200, NULL, NULL, 407, '-34.01065809945916,25.675089061260223', '53 Xanadu/Melodi Clubhouse ', 'NMMU', 3, 369),
(200, NULL, NULL, 408, '-34.009280284693304,25.671851634979248', '123', 'NMMU', 3, 369),
(200, NULL, NULL, 409, '-34.00865423340499,25.666015148162842', '127 Life Sciences', 'NMMU', 3, 369),
(200, NULL, NULL, 410, '-34.001980915503246,25.673776636064076', '201 Lebombo Residence', 'NMMU', 3, 371),
(200, NULL, NULL, 411, '-34.00297263539996,25.67442598729076', '251 Letaba Residence', 'NMMU', 3, 371),
(200, NULL, NULL, 412, '-34.00238124509304,25.673847198486328', '252 Campus Health Services', 'NMMU', 3, 371),
(200, NULL, NULL, 413, '-34.00238124509304,25.67308008670807', '229 Technical Services', 'NMMU', 3, 371),
(200, NULL, NULL, 414, '-34.002548499975305,25.672715306282043', '230 Tennis Clubhouse', 'NMMU', 3, 371),
(200, NULL, NULL, 415, '-34.0026774294835,25.67192405462265', '212 Heinz Betz Centre ', 'NMMU', 3, 371),
(200, NULL, NULL, 416, '-34.00252625170009,25.670394524931908', '288 Engineering Building II', 'NMMU', 3, 371),
(200, NULL, NULL, 417, '-34.00226233866034,25.670757293701172', '276 Engineering Building', 'NMMU', 3, 371),
(200, NULL, NULL, 418, '-34.001888126255295,25.670886039733887', '286 Bitumen Building', 'NMMU', 3, 371),
(200, NULL, NULL, 419, '-34.001903849498774,25.671516358852386', '205 Laboratories', 'NMMU', 3, 371),
(200, NULL, NULL, 420, '-34.00172774900558,25.672430992126465', '219 Student Services Centre', 'NMMU', 3, 371),
(200, NULL, NULL, 421, '-34.00187240300892,25.672782361507416', '225 EBEIT Lab ', 'NMMU', 3, 371),
(200, NULL, NULL, 422, '-34.00140070426386,25.672752857208252', '215 Food Court (cafeteria)  and Muslim Prayer Room', 'NMMU', 3, 371),
(200, NULL, NULL, 423, '-34.001152275205044,25.67281723022461', '217 Goldfields Auditorium', 'NMMU', 3, 371),
(200, NULL, NULL, 424, '-34.0012812068326,25.673605799674988', '235 Conference Centre', 'NMMU', 3, 371),
(200, NULL, NULL, 425, '-34.00081579418204,25.672414898872375', '222 D Block (main entrance, cashiers, ABSA Alumni Centre, Student Counselling)', 'NMMU', 3, 371),
(200, NULL, NULL, 426, '-34.00041641777999,25.67230761051178', '209 Human Resources and Contact Centre', 'NMMU', 3, 371),
(200, NULL, NULL, 427, '-34.00045100951113,25.672776997089386', '260 Main Administration Building', 'NMMU', 3, 371),
(200, NULL, NULL, 428, '-34.000696295927916,25.671406388282776', '202 Science and Health Sciences', 'NMMU', 3, 371),
(200, NULL, NULL, 429, '-34.000551639921646,25.67107915878296', '207 Lecture Halls (N1 and N2)', 'NMMU', 3, 371),
(200, NULL, NULL, 430, '-34.000123959853624,25.67104160785675', '208 Art', 'NMMU', 3, 371),
(200, NULL, NULL, 431, '-34.00041956248341,25.67045420408249', '206 Nursing', 'NMMU', 3, 371),
(200, NULL, NULL, 432, '-34.000752900385045,25.670330822467804', '226 Goldfields Computer Centre (writing centre, Offices etc.)', 'NMMU', 3, 371),
(200, NULL, NULL, 433, '-34.00115651173071,25.67130446434021', '203 Engineering', 'NMMU', 3, 371),
(200, NULL, NULL, 434, '-34.00148246556736,25.671301782131195', '204 Built Environment ', 'NMMU', 3, 371),
(200, NULL, NULL, 435, '-34.001513322577296,25.670397877693176', '261 MTLC Building (eNtsa, library, CTLM, Senate Hall, lecture halls)', 'NMMU', 3, 371),
(200, NULL, NULL, 486, '-34.00857585762075,25.669504702091217', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 487, '-34.00900942488215,25.669448375701904', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 488, '-34.00928290463156,25.669485926628113', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 489, '-34.009024988793975,25.670110881328583', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 490, '-34.00890270083858,25.67014843225479', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 491, '-34.00872705055816,25.670373737812042', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 492, '-34.00873363228519,25.670492835013192', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 493, '-34.00873149740518,25.67091554403305', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 494, '-34.008913775311264,25.67115420493451', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 495, '-34.00902367661416,25.671166308590614', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 496, '-34.0090315715349,25.671566018041403', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 497, '-34.00915172339827,25.671164989471436', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 498, '-34.009309517503326,25.670947824171208', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 499, '-34.00932292598442,25.670698285102844', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 500, '-34.00913509341085,25.670490353948026', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 501, '-34.008884496593794,25.67049012053758', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 502, '-34.0087292739817,25.67067950963974', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 503, '-34.0092695812717,25.668736269215742', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 504, '-34.00861394498071,25.668721510730165', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 505, '-34.00860238006387,25.668055046393192', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 506, '-34.00930347445785,25.668209195137024', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 507, '-34.0092662545686,25.66801759492455', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 508, '-34.00852874873689,25.66748068202287', 'Randevous', 'NMMU', 3, 369),
(200, NULL, NULL, 509, '-34.00852874873689,25.66748068202287', 'Ground', 'NMMU', 4, 508),
(200, NULL, NULL, 510, '-34.00852874873689,25.66748068202287', 'Entrance', 'NMMU', 10, 509),
(200, NULL, NULL, 511, '-34.00903169598392,25.67215994706521', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 512, '-34.00902054196231,25.672650933265686', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 513, '-34.009011648298305,25.673876702785492', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 514, '-34.008877654575194,25.673978456300233', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 515, '-34.00220615062431,25.673414292400253', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 516, '-34.00220350390403,25.673722807447234', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 517, '-34.00197096900792,25.67370512215848', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 518, '-34.003879289502876,25.674314160161316', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 519, '-34.0046714291231,25.67383646965027', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 520, '-34.00588991468845,25.673954486846924', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 521, '-34.00587284783834,25.673069212887754', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 522, '-34.00584573257521,25.672543952079195', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 523, '-34.005892138186276,25.669963359832764', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 524, '-34.00669051360126,25.669886114143537', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 525, '-34.00708526651283,25.66956639289856', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 526, '-34.00766937045138,25.669255256652832', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 527, '-34.008344816323714,25.66927134990692', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 528, '-34.00907211569606,25.669297628225877', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 529, '-34.00961162259228,25.66928207874298', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 530, '-34.010023533147944,25.669290125370026', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 531, '-34.0101501773359,25.66926954807286', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 532, '-34.01017743683605,25.669511289252682', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 533, '-34.01016234471633,25.669741871305064', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 534, '-34.010186900485714,25.669956798441035', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 535, '-34.01023396097791,25.670756034100236', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 536, '-34.01023420418654,25.67205011844635', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 537, '-34.01022162682577,25.672846734523773', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 538, '-34.01022162682577,25.673498511314392', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 539, '-34.0101901834157,25.67414492368698', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 540, '-34.01018082864328,25.674374191874335', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 541, '-34.010183871657965,25.67456195079967', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 542, '-34.0101901834157,25.67479133605957', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 543, '-34.01013672959185,25.67603051662445', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 544, '-34.01017760604844,25.677672028541565', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 545, '-34.010174461706306,25.67796438932419', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 546, '-34.010451163366525,25.67856788635254', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 547, '-34.010570647895584,25.679190158843994', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 548, '-34.009470938086466,25.677814452851067', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 549, '-34.00943631971511,25.677672028541565', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 550, '-34.009010446114154,25.672848234459366', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 551, '-34.009011648298305,25.673380494117737', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 552, '-34.00866924152564,25.67258656024933', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 553, '-34.00838194897147,25.6726505428137', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 554, '-34.00811567977452,25.672681404918876', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 555, '-34.00789548607108,25.672613382339478', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 556, '-34.0072350413487,25.67263381083285', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 557, '-34.00649915091532,25.6730318069458', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 558, '-34.002991401432865,25.67377209663391', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 559, '-34.005828969246224,25.675287635454424', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 560, '-34.0058288696351,25.67570596933365', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 561, '-34.00580253441773,25.67596019245684', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 562, '-34.00597351665372,25.67727506160736', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 563, '-34.006539524358274,25.677720308303833', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 564, '-34.00688541609845,25.677736401557922', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 565, '-34.00780052238581,25.677720685093163', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 566, '-34.00869814604682,25.673114245656166', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 567, '-34.00866479467536,25.673573224836446', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 568, '-34.00867705194378,25.673996165973904', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 569, '-34.008755955059655,25.674161173373136', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 570, '-34.00875959348421,25.67427704196143', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 571, '-34.008820251658115,25.674740127567816', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 572, '-34.00884534261898,25.674945549005997', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 573, '-34.00920625408842,25.67497662658809', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 574, '-34.00917961194731,25.673993168928405', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 575, '-34.00933464796371,25.674268305301666', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 576, '-34.00933613071415,25.67444919718946', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 577, '-34.009182955017295,25.674603476120865', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 578, '-34.009511002916234,25.67383110523224', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 579, '-34.00968708727107,25.673828423023224', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 580, '-34.00945922078351,25.67365649342537', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 581, '-34.009467404347234,25.673392507774793', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 582, '-34.009754266034776,25.674348771572113', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 583, '-34.00963619585926,25.67345896848599', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 584, '-34.0095474898923,25.67320907606529', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 585, '-34.00958282105776,25.67287745184194', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 586, '-34.00951423916178,25.672735133789956', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 587, '-34.00909613806879,25.672753890101376', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 588, '-34.00959411410598,25.672624203525743', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 589, '-34.00960522932485,25.672300978981184', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 590, '-34.009603074926325,25.67154049873352', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 591, '-34.009603074926325,25.67135140299797', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 592, '-34.00996634530381,25.670703356154263', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 593, '-34.00995435746904,25.670918226242065', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 594, '-34.00991976960845,25.671382248401642', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 595, '-34.010047898721844,25.672045986318835', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 596, '-34.010027743385315,25.67252218723297', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 597, '-34.00987768182205,25.672519526643782', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 598, '-34.00971202148745,25.6723290681839', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 599, '-34.00973199574528,25.671391755518243', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 600, '-34.009472388833714,25.670526822732427', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 601, '-34.009445008437254,25.669479309806434', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 602, '-34.008591004719435,25.66909432411194', 'Ground', 'NMMU', 4, 377),
(200, NULL, NULL, 603, '-34.00835072366249,25.672326385974884', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 604, '-34.00829097985709,25.671937465667725', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 605, '-34.00833797068386,25.671597971792153', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 606, '-34.008523666020075,25.671296417713165', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 607, '-34.00835386807214,25.66978096961975', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 608, '-34.00827211338349,25.66991776227951', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 609, '-34.00834103888004,25.670272994041397', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 610, '-34.008341290432845,25.670482367277145', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 611, '-34.008294239247405,25.670951868989278', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 612, '-34.00828520842895,25.67120913952499', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 613, '-34.007104456046754,25.67116664940454', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 614, '-34.00707361205825,25.6709028359694', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 615, '-34.00707280730892,25.670151114463806', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 616, '-34.007268472169294,25.67008137702942', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 617, '-34.00724407596829,25.669889729924307', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 618, '-34.007668384015375,25.669885575771332', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 619, '-34.00816052771247,25.669896271331254', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 620, '-34.00815891445394,25.669735372066498', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 621, '-34.008397983232086,25.670966506004333', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 622, '-34.00854798696853,25.670481796861623', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 623, '-34.00991348090503,25.669748783111572', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 624, '-34.009844855899175,25.669554579219948', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 625, '-34.00807768663251,25.670939862873638', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 626, '-34.00785076104781,25.670939683914185', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 627, '-34.007658950709946,25.670939683914185', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 628, '-34.007429406621426,25.670939683914185', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 629, '-34.00720615081685,25.670934319496155', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 630, '-34.00743908416274,25.670101958336204', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 631, '-34.00763967192866,25.67010752584042', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 632, '-34.00787325161474,25.67009747028351', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 633, '-34.00807336151231,25.670118927955627', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 634, '-34.00820122403025,25.670058364229135', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 635, '-34.005913449334315,25.669583234859374', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 636, '-34.00658669149673,25.669620037078857', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 637, '-34.00740425106715,25.669016540050507', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 638, '-34.00766523958037,25.66890388727188', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 639, '-34.00823234619466,25.66891134710727', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 640, '-34.008312537998044,25.668921157346063', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 641, '-34.00973314376375,25.66891894835544', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 642, '-34.01016225834432,25.66891894835544', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 643, '-34.01016114665132,25.66866785287857', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 644, '-34.010150029720485,25.66844254732132', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 645, '-34.01013898428317,25.66825067025502', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 646, '-34.01014509475648,25.66807364866179', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 647, '-34.010130130124416,25.667870006898966', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 648, '-34.00975536823277,25.667873907741978', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 649, '-34.00976093622453,25.668024122714996', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 650, '-34.00976760641377,25.668214559555054', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 651, '-34.00976760641377,25.668376833200455', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 652, '-34.00977872339467,25.66865175962448', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 653, '-34.00952851725221,25.667831864534037', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 654, '-34.00953739500268,25.66868992467448', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 655, '-34.0090206020396,25.667463541030884', 'Ground', 'NMMU', 4, 382),
(200, NULL, NULL, 656, '-34.00924685502002,25.66769821620312', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 657, '-34.00946574332071,25.66768339695909', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 658, '-34.00983958860474,25.66768079996109', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 659, '-34.009875656245036,25.667199253997296', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 660, '-34.009529743990555,25.667207635970726', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 661, '-34.00899519109703,25.6677929460252', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 662, '-34.00863045825504,25.66773464421999', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 663, '-34.00829055421552,25.667681037974376', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 664, '-34.009267340767025,25.669322311878204', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 665, '-34.008511817777936,25.66965652341696', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 666, '-34.00849851078995,25.669721961021423', 'Intersection', 'NMMU', 5, 369),
(200, NULL, NULL, 667, '-34.00488907714586,25.676622787407723', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 668, '-34.0046173793517,25.676253592030434', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 669, '-34.0044641443324,25.675376057624817', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 670, '-34.004121855514825,25.67611008416634', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 671, '-34.00377017879323,25.67537386985032', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 672, '-34.00375088281528,25.674673318862915', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 673, '-34.00201715015183,25.673239099726402', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 674, '-34.002074051698294,25.672909536620523', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 675, '-34.002058574030066,25.672427079451495', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 676, '-34.00206475544429,25.671933424382814', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 677, '-34.00207419394234,25.67158211757055', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 678, '-34.00206303931674,25.671418468330103', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 679, '-34.00207734844542,25.670884656796716', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 680, '-34.00208997317229,25.67066341638565', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 681, '-34.00209309996802,25.670420720514812', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 682, '-34.002114892574056,25.670066809002492', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 683, '-34.00147207692601,25.67005457975813', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 684, '-34.00240117490016,25.670067965984344', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 685, '-34.002281100998935,25.670384466648102', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 686, '-34.00100042430261,25.67006207557199', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 687, '-34.00073300481977,25.67006753418991', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 688, '-34.00031859072895,25.670152064683748', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 689, '-33.99968850681108,25.670227244847638', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 690, '-33.99881517832115,25.670293117644405', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 691, '-33.998621362763,25.670577585697174', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 692, '-33.998712561041906,25.67131519317627', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 693, '-33.99881899506675,25.672161620958605', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 694, '-33.99890124682532,25.67231297492981', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 695, '-33.99962538824674,25.67277018344555', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 696, '-33.99939811738337,25.67326784133911', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 697, '-34.000546393664884,25.673956053808638', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 698, '-34.00077204923423,25.673584848717383', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 699, '-34.00097014787671,25.673179986066202', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 700, '-34.00092164896817,25.672789074378443', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 701, '-34.00079747454561,25.672680534838833', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 702, '-34.0006726195575,25.67270300167013', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 703, '-34.0006558225719,25.672797460766446', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 704, '-34.0006578630839,25.673165917396545', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 705, '-34.00026983791993,25.6731578707695', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 706, '-34.000259789822756,25.67231164861323', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 707, '-34.000262050108574,25.67172690610846', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 708, '-34.000681265716175,25.671746586566314', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 709, '-34.00050326486373,25.67173958107867', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 710, '-34.00113714144935,25.671749711036682', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 711, '-34.00111280958762,25.673205798886784', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 712, '-34.00126268960414,25.673187375068665', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 713, '-34.001552908864014,25.673197908013094', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 714, '-34.00174637101561,25.67319036836625', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 715, '-34.00176104438254,25.673363714864763', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 716, '-34.0011292723596,25.67354679107666', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 717, '-34.00186682029275,25.6724296295165', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 718, '-34.0014736211994,25.671757757663727', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 719, '-34.0018698479811,25.671763122081757', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 720, '-34.001156009508,25.67063257098198', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 721, '-34.000979907464355,25.670607089996338', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 722, '-34.00150192317365,25.670639276504517', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 723, '-34.001891971448934,25.67045520098361', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 724, '-34.000703174943816,25.67107915878296', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 725, '-34.00019687788514,25.67026376724243', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 726, '-34.000118260058784,25.670625865459442', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 727, '-33.999727752663695,25.672624919922782', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 728, '-34.00251449871569,25.66983461380005', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 729, '-34.00318744597021,25.669872164726257', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 730, '-34.01043885386407,25.6747863404471', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 731, '-34.00784570703895,25.67680143046823', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 732, '-34.00786435783057,25.676053988339845', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 733, '-34.007815442000975,25.674256003782375', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 734, '-34.00787325161474,25.673573224836446', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 735, '-34.007899731922265,25.673128997892036', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 736, '-34.008372574410735,25.673012662006272', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 737, '-34.00791679401469,25.67483961582184', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 738, '-34.00789792745796,25.67538946866989', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 739, '-34.00809667685107,25.67603922969613', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 740, '-34.008432173485176,25.676075749268534', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 741, '-34.008753731636816,25.6760573387146', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 742, '-34.008190358616154,25.674844980239868', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 743, '-34.00912281903148,25.676213303427176', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 744, '-34.0091339360968,25.676596418280155', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 745, '-34.009256318473014,25.676708269290884', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 746, '-34.00928068122252,25.67692263488766', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 747, '-34.009245106669866,25.677002292431325', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 748, '-34.00919841504691,25.677062983893165', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 749, '-34.00891604135136,25.677093329624086', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 750, '-34.008861772841676,25.67700760405478', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 751, '-34.008831551401684,25.67694539418585', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 752, '-34.00882275105849,25.676758015830274', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 753, '-34.00886712612758,25.67669124868928', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 754, '-34.008972510423625,25.676608845553574', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 755, '-34.00898711356115,25.676203935852072', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 756, '-34.008992157877046,25.675833393276662', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 757, '-34.00892300430019,25.675649642944336', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 758, '-34.00932959620807,25.6755530834198', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 759, '-34.00922176086159,25.6755530834198', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 760, '-34.00923176620878,25.675791800022125', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 761, '-34.00882361783382,25.67705626420252', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 762, '-34.00884912959353,25.67749366090129', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 763, '-34.0094040943798,25.677500367164612', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 764, '-34.00885052078019,25.677623846000756', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 765, '-34.007896573382894,25.677596954896785', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 766, '-34.00752069912765,25.677647757820978', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 767, '-34.006467110880656,25.677567697559653', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 768, '-34.00610114672194,25.675955414772034', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 769, '-34.00837430673198,25.668056309223175', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 770, '-34.00841046742585,25.668708086013794', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 771, '-34.009512757816125,25.666711123381674', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 772, '-34.00950302183889,25.666377246379852', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 773, '-34.00935405369028,25.66635310649872', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 774, '-34.00923953745715,25.666212303175143', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 775, '-34.008920488188494,25.66620022058487', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 776, '-34.00877596586262,25.666401386260986', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 777, '-34.00876262532784,25.666629374027252', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 778, '-34.008798200082616,25.66668301820755', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 779, '-34.008760401905164,25.66753327846527', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 780, '-34.00866037365193,25.667648583681398', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 781, '-34.00933626643119,25.666570365428925', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 782, '-34.00923178887695,25.666701765161292', 'Intersection', 'NMMU', 5, 0),
(200, NULL, NULL, 783, '-34.008498732443286,25.66828429698944', 'Ground', 'NMMU', 4, 380);

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
  `path_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `paths`
--

INSERT INTO `paths` (`path_id`, `destination_location_id`, `departure_location_id`, `distance`, `path_type`) VALUES
(526, 486, 383, 26.7, 2),
(527, 487, 486, 38.58, 2),
(528, 488, 487, 40.06, 2),
(530, 375, 383, 26.21, 2),
(531, 374, 375, 21.54, 2),
(532, 487, 374, 30.09, 2),
(533, 376, 374, 30.22, 2),
(534, 489, 374, 27.96, 2),
(535, 490, 489, 14.03, 2),
(536, 491, 490, 28.51, 2),
(537, 492, 491, 11, 2),
(539, 494, 493, 29.91, 2),
(540, 495, 494, 12.27, 2),
(541, 496, 495, 36.85, 2),
(542, 408, 496, 38.18, 2),
(543, 497, 495, 14.24, 2),
(544, 498, 497, 26.62, 2),
(545, 499, 498, 23.05, 2),
(546, 500, 499, 28.35, 2),
(547, 501, 500, 27.87, 2),
(548, 492, 501, 16.78, 2),
(549, 502, 493, 21.76, 2),
(550, 492, 502, 17.21, 2),
(551, 501, 502, 24.55, 2),
(553, 504, 503, 68.36, 2),
(554, 505, 504, 62.2, 2),
(555, 382, 505, 97.21, 2),
(556, 380, 505, 24.11, 2),
(558, 504, 377, 33.68, 2),
(560, 499, 396, 32.18, 2),
(561, 506, 503, 48.73, 2),
(563, 382, 507, 66.4, 2),
(564, 509, 508, 0, 5),
(565, 510, 509, 0, 5),
(566, 508, 505, 53.57, 2),
(567, 511, 408, 39.64, 2),
(568, 512, 511, 45.27, 2),
(570, 514, 513, 17.61, 2),
(572, 496, 511, 54.75, 2),
(573, 515, 412, 35.56, 2),
(574, 516, 515, 20.96, 2),
(575, 517, 516, 25.91, 2),
(576, 410, 517, 6.68, 2),
(578, 519, 518, 98.48, 2),
(579, 520, 519, 135.93, 2),
(580, 521, 520, 81.63, 2),
(581, 522, 521, 48.51, 2),
(582, 523, 522, 258.15, 2),
(583, 524, 523, 96.43, 2),
(584, 525, 524, 41.59, 2),
(585, 526, 525, 76.82, 2),
(586, 527, 526, 78.32, 2),
(587, 528, 527, 84.08, 2),
(588, 529, 528, 60.01, 2),
(589, 530, 529, 45.81, 2),
(590, 531, 530, 14.21, 2),
(591, 532, 531, 22.49, 2),
(592, 533, 532, 21.32, 2),
(593, 534, 533, 20, 2),
(594, 535, 534, 73.85, 2),
(595, 536, 535, 119.28, 2),
(596, 537, 536, 73.44, 2),
(597, 538, 537, 60.08, 2),
(598, 539, 538, 59.68, 2),
(599, 540, 539, 21.16, 2),
(600, 541, 540, 17.31, 2),
(601, 542, 541, 21.15, 2),
(602, 543, 542, 114.37, 2),
(603, 544, 543, 151.37, 2),
(604, 545, 544, 26.95, 2),
(605, 546, 545, 63.57, 2),
(606, 547, 546, 58.88, 2),
(607, 404, 547, 28.36, 2),
(608, 395, 546, 41.29, 2),
(609, 548, 545, 79.44, 2),
(610, 397, 548, 51.13, 2),
(611, 549, 544, 82.43, 2),
(612, 548, 549, 13.68, 2),
(613, 550, 512, 18.22, 2),
(614, 551, 550, 49.06, 2),
(615, 513, 551, 45.74, 2),
(616, 390, 551, 28.63, 2),
(617, 552, 512, 39.51, 1),
(618, 553, 552, 32.49, 1),
(619, 554, 553, 29.74, 1),
(620, 555, 554, 25.27, 1),
(621, 556, 555, 73.46, 1),
(622, 557, 556, 89.67, 1),
(623, 521, 557, 69.73, 1),
(624, 556, 522, 154.71, 1),
(625, 558, 519, 189.23, 1),
(627, 559, 520, 123.07, 2),
(628, 560, 559, 38.56, 2),
(629, 561, 560, 23.62, 2),
(630, 562, 561, 122.68, 2),
(631, 563, 562, 75.14, 2),
(632, 564, 563, 38.49, 2),
(633, 565, 564, 101.77, 2),
(634, 548, 565, 185.94, 2),
(635, 566, 550, 42.51, 2),
(636, 390, 566, 28.49, 2),
(637, 567, 390, 17.72, 2),
(638, 568, 567, 39.01, 2),
(639, 389, 568, 17.45, 2),
(640, 568, 514, 22.37, 2),
(641, 569, 514, 21.61, 2),
(642, 570, 569, 10.69, 2),
(643, 571, 570, 43.21, 2),
(644, 572, 571, 19.14, 2),
(645, 573, 572, 40.23, 2),
(646, 394, 573, 29.26, 2),
(647, 574, 514, 33.6, 2),
(648, 575, 574, 25.89, 2),
(649, 576, 575, 26.24, 2),
(650, 577, 576, 22.19, 2),
(651, 571, 577, 42.25, 2),
(652, 570, 575, 63.95, 2),
(653, 578, 575, 44.82, 2),
(654, 579, 578, 19.58, 2),
(655, 393, 579, 24.76, 2),
(656, 575, 393, 43.5, 2),
(657, 580, 578, 17.09, 2),
(658, 581, 580, 24.35, 2),
(659, 392, 581, 6.12, 2),
(660, 582, 393, 24.04, 2),
(661, 540, 582, 47.49, 2),
(662, 539, 393, 54.79, 2),
(663, 583, 578, 37.02, 2),
(664, 538, 583, 65.2, 2),
(665, 581, 583, 19.74, 2),
(666, 584, 583, 25.06, 2),
(667, 585, 584, 30.82, 2),
(668, 586, 585, 15.17, 2),
(669, 587, 586, 46.52, 2),
(670, 512, 587, 12.68, 2),
(671, 550, 587, 12.9, 2),
(672, 588, 586, 13.54, 2),
(673, 589, 588, 29.82, 2),
(674, 408, 589, 54.96, 2),
(675, 590, 589, 70.1, 2),
(676, 408, 590, 45.94, 2),
(677, 591, 590, 17.43, 2),
(678, 498, 591, 49.49, 2),
(679, 592, 396, 41.69, 2),
(680, 593, 592, 19.85, 2),
(681, 594, 593, 42.94, 2),
(682, 595, 594, 62.82, 2),
(683, 536, 595, 20.72, 2),
(684, 596, 595, 43.95, 2),
(685, 597, 596, 16.69, 2),
(686, 598, 597, 25.45, 2),
(687, 599, 598, 86.42, 2),
(688, 591, 599, 14.81, 2),
(689, 594, 599, 20.9, 2),
(690, 396, 591, 69.1, 2),
(691, 396, 599, 74.26, 1),
(692, 600, 396, 15.88, 2),
(693, 601, 600, 96.6, 2),
(694, 488, 601, 18.04, 2),
(695, 384, 601, 19.23, 2),
(696, 487, 528, 24.75, 3),
(697, 603, 553, 30.08, 1),
(698, 604, 603, 36.46, 1),
(699, 605, 604, 31.73, 1),
(700, 606, 605, 34.63, 1),
(701, 496, 606, 61.7, 1),
(702, 493, 606, 42.03, 1),
(703, 607, 383, 24.42, 2),
(704, 608, 607, 15.54, 2),
(705, 609, 608, 33.63, 2),
(706, 610, 609, 19.3, 2),
(707, 611, 610, 43.59, 2),
(708, 612, 611, 23.74, 2),
(709, 613, 612, 131.35, 2),
(710, 614, 613, 24.56, 2),
(711, 615, 614, 69.29, 2),
(712, 616, 615, 22.69, 2),
(713, 617, 616, 17.87, 2),
(714, 525, 617, 42.55, 2),
(715, 607, 527, 46.99, 1),
(716, 618, 617, 47.18, 2),
(717, 619, 618, 54.73, 2),
(718, 620, 619, 14.83, 2),
(719, 607, 620, 22.08, 2),
(720, 608, 619, 12.56, 2),
(721, 606, 612, 27.71, 1),
(722, 621, 611, 11.61, 2),
(723, 492, 621, 57.44, 2),
(724, 622, 492, 20.67, 2),
(725, 610, 622, 22.98, 2),
(726, 609, 622, 30, 2),
(728, 623, 533, 27.68, 2),
(729, 624, 623, 19.46, 2),
(730, 384, 624, 27.55, 2),
(731, 624, 532, 37.2, 2),
(732, 625, 611, 24.1, 2),
(733, 626, 625, 25.23, 2),
(734, 627, 626, 21.33, 2),
(735, 628, 627, 25.52, 2),
(736, 629, 628, 24.83, 2),
(737, 614, 629, 15.02, 2),
(738, 630, 616, 19.07, 2),
(739, 631, 630, 22.31, 2),
(740, 632, 631, 25.99, 2),
(741, 633, 632, 22.34, 2),
(742, 634, 633, 15.27, 2),
(743, 608, 634, 15.17, 2),
(744, 609, 634, 25.16, 2),
(745, 635, 523, 35.12, 2),
(746, 636, 635, 74.94, 2),
(747, 637, 636, 106.58, 2),
(748, 638, 637, 30.82, 2),
(749, 639, 638, 63.06, 2),
(750, 640, 639, 8.96, 2),
(751, 641, 640, 157.96, 2),
(752, 642, 641, 47.72, 2),
(753, 531, 642, 32.34, 2),
(754, 643, 642, 23.14, 2),
(755, 644, 643, 20.8, 2),
(756, 645, 644, 17.73, 2),
(757, 646, 645, 16.33, 2),
(758, 647, 646, 18.84, 2),
(759, 648, 647, 41.67, 2),
(760, 649, 648, 13.86, 2),
(761, 650, 649, 17.57, 2),
(762, 651, 650, 14.96, 2),
(763, 652, 651, 25.37, 2),
(764, 641, 652, 25.14, 2),
(765, 652, 643, 42.55, 2),
(766, 649, 643, 74.17, 2),
(767, 381, 649, 31.27, 2),
(768, 653, 507, 32.2, 2),
(769, 381, 653, 42.9, 2),
(770, 654, 503, 30.08, 2),
(771, 381, 654, 37.14, 2),
(772, 378, 654, 35.57, 2),
(773, 384, 378, 46.55, 2),
(774, 656, 507, 18.32, 2),
(775, 657, 656, 24.38, 2),
(776, 658, 657, 41.57, 2),
(777, 659, 658, 44.57, 2),
(778, 387, 659, 24.99, 2),
(779, 660, 657, 49.83, 2),
(780, 387, 660, 25.08, 2),
(781, 661, 656, 29.31, 2),
(782, 662, 661, 40.91, 2),
(783, 663, 662, 38.12, 2),
(784, 386, 663, 64.68, 2),
(785, 662, 505, 29.7, 2),
(786, 382, 661, 30.49, 2),
(787, 507, 661, 36.57, 2),
(788, 507, 506, 18.14, 3),
(789, 664, 503, 54.02, 2),
(791, 664, 488, 15.18, 3),
(792, 665, 383, 14.43, 3),
(793, 666, 665, 6.21, 3),
(795, 377, 665, 52.56, 2),
(796, 667, 562, 134.74, 1),
(797, 668, 667, 45.51, 1),
(798, 669, 668, 82.67, 1),
(799, 519, 669, 143.78, 1),
(800, 670, 668, 56.67, 1),
(801, 671, 670, 78.32, 1),
(802, 672, 671, 64.61, 1),
(803, 518, 672, 36.06, 1),
(804, 411, 671, 124.5, 1),
(805, 411, 558, 60.31, 2),
(806, 518, 558, 110.65, 2),
(807, 515, 558, 93.34, 2),
(808, 413, 515, 36.44, 2),
(809, 673, 515, 26.5, 2),
(810, 674, 673, 31.03, 2),
(811, 675, 674, 44.51, 2),
(812, 676, 675, 45.51, 2),
(813, 677, 676, 32.4, 2),
(814, 678, 677, 15.14, 2),
(815, 679, 678, 49.23, 2),
(816, 680, 679, 20.44, 2),
(817, 681, 680, 22.38, 2),
(818, 682, 681, 32.71, 2),
(819, 683, 682, 71.49, 2),
(820, 435, 683, 31.98, 2),
(821, 684, 682, 31.83, 2),
(822, 685, 684, 32.09, 2),
(823, 416, 685, 27.28, 2),
(824, 417, 685, 34.43, 2),
(825, 681, 685, 21.17, 2),
(826, 686, 683, 52.45, 2),
(827, 687, 686, 29.74, 2),
(828, 688, 687, 46.73, 2),
(829, 689, 688, 70.4, 2),
(830, 690, 689, 97.3, 2),
(831, 691, 690, 33.94, 2),
(832, 692, 691, 68.75, 2),
(833, 693, 692, 78.92, 2),
(834, 694, 693, 16.68, 2),
(835, 695, 694, 90.88, 2),
(836, 696, 695, 52.38, 2),
(837, 697, 696, 142.58, 2),
(838, 698, 697, 42.43, 2),
(839, 699, 698, 43.34, 2),
(840, 700, 699, 36.44, 2),
(841, 701, 700, 17.05, 2),
(842, 425, 701, 24.57, 2),
(843, 700, 423, 25.78, 2),
(844, 702, 701, 14.04, 2),
(845, 703, 702, 8.91, 2),
(846, 704, 703, 33.97, 2),
(847, 698, 704, 40.65, 2),
(848, 427, 703, 22.85, 2),
(849, 705, 704, 43.15, 2),
(850, 706, 705, 78.02, 2),
(851, 426, 706, 17.42, 2),
(852, 707, 706, 53.9, 2),
(855, 709, 708, 19.8, 2),
(856, 707, 709, 26.85, 2),
(857, 428, 708, 31.41, 2),
(858, 429, 709, 61.12, 2),
(859, 425, 708, 63.4, 2),
(860, 710, 708, 50.69, 2),
(861, 433, 710, 41.1, 2),
(862, 711, 699, 16.04, 2),
(863, 712, 711, 16.75, 2),
(864, 713, 712, 32.29, 2),
(865, 714, 713, 21.52, 2),
(866, 673, 714, 30.44, 2),
(867, 421, 674, 25.3, 2),
(868, 714, 421, 40.14, 2),
(869, 715, 410, 45.24, 2),
(870, 714, 715, 16.06, 2),
(871, 716, 711, 31.49, 2),
(872, 424, 716, 17.75, 2),
(873, 422, 712, 42.89, 2),
(874, 717, 421, 32.52, 2),
(875, 420, 717, 15.46, 2),
(877, 678, 419, 19.87, 2),
(878, 418, 680, 30.41, 2),
(879, 718, 710, 37.42, 2),
(880, 719, 718, 44.06, 2),
(881, 419, 719, 23.06, 2),
(882, 717, 719, 61.44, 2),
(883, 434, 718, 42.04, 2),
(885, 720, 433, 61.94, 2),
(886, 721, 720, 19.72, 2),
(887, 686, 721, 50.29, 2),
(888, 722, 720, 38.47, 2),
(889, 434, 722, 61.11, 2),
(890, 435, 722, 22.29, 2),
(891, 723, 435, 42.43, 2),
(892, 418, 723, 39.72, 2),
(893, 432, 687, 24.37, 2),
(894, 724, 432, 69.21, 2),
(895, 429, 724, 16.85, 2),
(896, 428, 724, 30.18, 2),
(897, 688, 431, 30.03, 2),
(898, 725, 688, 17.01, 2),
(899, 726, 725, 34.51, 2),
(900, 430, 726, 38.33, 2),
(901, 707, 430, 65.01, 2),
(902, 707, 691, 210.97, 2),
(903, 695, 705, 80.08, 2),
(904, 727, 695, 17.58, 2),
(905, 427, 727, 81.64, 2),
(906, 674, 414, 55.71, 2),
(907, 676, 415, 68.13, 2),
(908, 728, 684, 24.93, 2),
(909, 729, 728, 74.91, 2),
(910, 523, 729, 300.87, 2),
(911, 730, 407, 37.05, 1),
(912, 542, 730, 27.65, 1),
(914, 732, 731, 68.93, 2),
(916, 734, 733, 63.26, 2),
(917, 735, 734, 41.05, 2),
(918, 736, 735, 53.66, 2),
(919, 566, 736, 37.39, 2),
(920, 737, 733, 54.96, 2),
(921, 738, 737, 50.73, 2),
(922, 732, 738, 61.37, 2),
(923, 739, 732, 25.87, 2),
(924, 740, 739, 37.46, 2),
(925, 741, 740, 35.8, 2),
(926, 402, 741, 13.87, 2),
(927, 391, 572, 13.71, 2),
(928, 742, 737, 30.42, 2),
(929, 398, 742, 28.86, 2),
(930, 743, 400, 6.4, 2),
(931, 744, 743, 35.34, 2),
(932, 745, 744, 17.07, 2),
(933, 746, 745, 19.94, 2),
(934, 747, 746, 8.34, 2),
(935, 748, 747, 7.63, 2),
(936, 749, 748, 31.52, 2),
(937, 750, 749, 9.94, 2),
(938, 751, 750, 6.65, 2),
(939, 752, 751, 17.3, 2),
(940, 753, 752, 7.89, 2),
(941, 754, 753, 13.96, 2),
(942, 755, 754, 37.36, 2),
(943, 402, 755, 18.48, 2),
(944, 756, 755, 34.16, 2),
(945, 757, 756, 18.6, 2),
(946, 572, 757, 65.47, 2),
(947, 758, 394, 30.77, 2),
(948, 759, 758, 11.99, 2),
(949, 760, 759, 22.03, 2),
(950, 756, 760, 26.92, 2),
(951, 400, 755, 21.41, 2),
(952, 761, 750, 6.17, 1),
(953, 762, 761, 40.42, 1),
(954, 763, 762, 61.71, 1),
(955, 747, 763, 49.2, 1),
(956, 549, 763, 16.22, 2),
(957, 764, 549, 65.29, 2),
(958, 765, 764, 106.1, 2),
(959, 766, 765, 42.06, 2),
(960, 767, 766, 117.39, 2),
(961, 562, 767, 61.16, 2),
(962, 765, 565, 15.63, 2),
(963, 731, 765, 73.55, 2),
(964, 768, 561, 33.21, 2),
(965, 403, 768, 29.21, 2),
(966, 405, 559, 47.57, 2),
(967, 403, 559, 60.7, 2),
(968, 769, 505, 25.36, 2),
(969, 770, 769, 60.21, 2),
(971, 385, 769, 23.74, 2),
(972, 770, 639, 27.26, 3),
(973, 527, 640, 32.48, 2),
(974, 771, 660, 45.8, 2),
(975, 772, 771, 30.79, 2),
(976, 773, 772, 16.71, 2),
(977, 774, 773, 18.18, 2),
(978, 775, 774, 35.49, 2),
(979, 776, 775, 24.54, 2),
(980, 777, 776, 21.07, 2),
(981, 778, 777, 6.33, 2),
(982, 779, 778, 78.49, 2),
(984, 662, 780, 8.6, 2),
(985, 779, 780, 15.38, 3),
(986, 409, 776, 38.09, 2),
(987, 781, 773, 20.12, 2),
(988, 782, 781, 16.78, 2),
(989, 778, 782, 48.24, 2);

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
  MODIFY `location_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=784;
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
  MODIFY `path_id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=990;
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
