-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2016 at 06:04 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `meetup3`
--

-- --------------------------------------------------------

--
-- Table structure for table `about`
--

CREATE TABLE `about` (
  `category` varchar(20) NOT NULL DEFAULT '',
  `keyword` varchar(20) NOT NULL DEFAULT '',
  `group_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `about`
--

INSERT INTO `about` (`category`, `keyword`, `group_id`) VALUES
('sport', 'football', 1),
('fashion', 'money', 2);

-- --------------------------------------------------------

--
-- Table structure for table `an_event`
--

CREATE TABLE `an_event` (
  `event_id` int(20) NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `location_name` varchar(20) NOT NULL,
  `zipcode` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `an_event`
--

INSERT INTO `an_event` (`event_id`, `title`, `description`, `start_time`, `end_time`, `location_name`, `zipcode`) VALUES
(1, 'event1', 'event1 description', '2016-12-01 10:00:00', '2016-12-01 16:00:00', 'brooklyn', 11201),
(2, 'event2', 'event 2 is in the past', '2016-11-21 00:00:00', '2016-11-22 00:00:00', 'manhattan', 90210),
(3, 'event3', 'this is happening in the future', '2016-12-14 07:00:00', '2016-12-14 11:00:00', 'manhattan', 90210);

-- --------------------------------------------------------

--
-- Table structure for table `a_group`
--

CREATE TABLE `a_group` (
  `group_id` int(20) NOT NULL,
  `group_name` varchar(20) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `creator` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `a_group`
--

INSERT INTO `a_group` (`group_id`, `group_name`, `description`, `creator`) VALUES
(1, 'group1', 'group1 description', 'lolaly'),
(2, 'group2', 'group2 description', 'chandrika');

-- --------------------------------------------------------

--
-- Table structure for table `belongs_to`
--

CREATE TABLE `belongs_to` (
  `group_id` int(20) NOT NULL,
  `username` varchar(20) NOT NULL DEFAULT '',
  `authorized` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `belongs_to`
--

INSERT INTO `belongs_to` (`group_id`, `username`, `authorized`) VALUES
(1, 'chandrika', 0),
(1, 'lolaly', 1),
(2, 'chandrika', 1);

-- --------------------------------------------------------

--
-- Table structure for table `friend`
--

CREATE TABLE `friend` (
  `friend_of` varchar(20) NOT NULL DEFAULT '',
  `friend_to` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `interest`
--

CREATE TABLE `interest` (
  `category` varchar(20) NOT NULL DEFAULT '',
  `keyword` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interest`
--

INSERT INTO `interest` (`category`, `keyword`) VALUES
('sport', 'football'),
('fashion', 'money');

-- --------------------------------------------------------

--
-- Table structure for table `interested_in`
--

CREATE TABLE `interested_in` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `category` varchar(20) NOT NULL DEFAULT '',
  `keyword` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interested_in`
--

INSERT INTO `interested_in` (`username`, `category`, `keyword`) VALUES
('lolaly', 'sport', 'football'),
('chandrika', 'fashion', 'money');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_name` varchar(20) NOT NULL DEFAULT '',
  `zipcode` int(5) NOT NULL,
  `address` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `latitude` decimal(50,0) NOT NULL,
  `longitude` decimal(50,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_name`, `zipcode`, `address`, `description`, `latitude`, `longitude`) VALUES
('brooklyn', 11201, 'qwerty', 'this is brooklyn', '124', '13'),
('manhattan', 90210, 'nyu', 'this is manhattan', '124', '55');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `firstname` varchar(20) NOT NULL DEFAULT '',
  `lastname` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(32) NOT NULL DEFAULT '',
  `zipcode` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`username`, `password`, `firstname`, `lastname`, `email`, `zipcode`) VALUES
('chandrika', '1a1dc91c907325c69271ddf0c944bc72', 'chandrika', 'khanduri', 'asdf@nyu.edu', 90210),
('lolaly', '5f4dcc3b5aa765d61d8327deb882cf99', 'lolaly', 'luo', 'sfdbr@nyu.edu', 11201);

-- --------------------------------------------------------

--
-- Table structure for table `organize`
--

CREATE TABLE `organize` (
  `event_id` int(20) NOT NULL,
  `group_id` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organize`
--

INSERT INTO `organize` (`event_id`, `group_id`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `sign_up`
--

CREATE TABLE `sign_up` (
  `event_id` int(20) NOT NULL,
  `username` varchar(20) NOT NULL DEFAULT '',
  `rating` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about`
--
ALTER TABLE `about`
  ADD PRIMARY KEY (`group_id`,`keyword`,`category`),
  ADD KEY `keyword` (`keyword`,`category`);

--
-- Indexes for table `an_event`
--
ALTER TABLE `an_event`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `location_name` (`location_name`,`zipcode`);

--
-- Indexes for table `a_group`
--
ALTER TABLE `a_group`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `creator` (`creator`);

--
-- Indexes for table `belongs_to`
--
ALTER TABLE `belongs_to`
  ADD PRIMARY KEY (`group_id`,`username`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `friend`
--
ALTER TABLE `friend`
  ADD PRIMARY KEY (`friend_to`,`friend_of`),
  ADD KEY `friend_of` (`friend_of`);

--
-- Indexes for table `interest`
--
ALTER TABLE `interest`
  ADD PRIMARY KEY (`keyword`,`category`);

--
-- Indexes for table `interested_in`
--
ALTER TABLE `interested_in`
  ADD PRIMARY KEY (`username`,`keyword`,`category`),
  ADD KEY `keyword` (`keyword`,`category`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_name`,`zipcode`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `organize`
--
ALTER TABLE `organize`
  ADD PRIMARY KEY (`event_id`,`group_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `sign_up`
--
ALTER TABLE `sign_up`
  ADD PRIMARY KEY (`event_id`,`username`),
  ADD KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `an_event`
--
ALTER TABLE `an_event`
  MODIFY `event_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `a_group`
--
ALTER TABLE `a_group`
  MODIFY `group_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `about`
--
ALTER TABLE `about`
  ADD CONSTRAINT `about_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `a_group` (`group_id`),
  ADD CONSTRAINT `about_ibfk_2` FOREIGN KEY (`keyword`,`category`) REFERENCES `interest` (`keyword`, `category`);

--
-- Constraints for table `an_event`
--
ALTER TABLE `an_event`
  ADD CONSTRAINT `an_event_ibfk_1` FOREIGN KEY (`location_name`,`zipcode`) REFERENCES `location` (`location_name`, `zipcode`);

--
-- Constraints for table `a_group`
--
ALTER TABLE `a_group`
  ADD CONSTRAINT `a_group_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `member` (`username`);

--
-- Constraints for table `belongs_to`
--
ALTER TABLE `belongs_to`
  ADD CONSTRAINT `belongs_to_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `a_group` (`group_id`),
  ADD CONSTRAINT `belongs_to_ibfk_2` FOREIGN KEY (`username`) REFERENCES `member` (`username`);

--
-- Constraints for table `friend`
--
ALTER TABLE `friend`
  ADD CONSTRAINT `friend_ibfk_1` FOREIGN KEY (`friend_to`) REFERENCES `member` (`username`),
  ADD CONSTRAINT `friend_ibfk_2` FOREIGN KEY (`friend_of`) REFERENCES `member` (`username`);

--
-- Constraints for table `interested_in`
--
ALTER TABLE `interested_in`
  ADD CONSTRAINT `interested_in_ibfk_1` FOREIGN KEY (`username`) REFERENCES `member` (`username`),
  ADD CONSTRAINT `interested_in_ibfk_2` FOREIGN KEY (`keyword`,`category`) REFERENCES `interest` (`keyword`, `category`);

--
-- Constraints for table `organize`
--
ALTER TABLE `organize`
  ADD CONSTRAINT `organize_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `an_event` (`event_id`),
  ADD CONSTRAINT `organize_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `a_group` (`group_id`);

--
-- Constraints for table `sign_up`
--
ALTER TABLE `sign_up`
  ADD CONSTRAINT `sign_up_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `an_event` (`event_id`),
  ADD CONSTRAINT `sign_up_ibfk_2` FOREIGN KEY (`username`) REFERENCES `member` (`username`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
