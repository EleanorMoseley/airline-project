-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 07, 2023 at 04:21 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airline`
--

-- --------------------------------------------------------

--
-- Table structure for table `airline`
--

CREATE TABLE `airline` (
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airline`
--

INSERT INTO `airline` (`name`) VALUES
('American Airline'),
('United');

-- --------------------------------------------------------

--
-- Table structure for table `airlinestaff`
--

CREATE TABLE `airlinestaff` (
  `username` varchar(100) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `airline_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airlinestaff`
--

INSERT INTO `airlinestaff` (`username`, `password`, `first_name`, `last_name`, `date_of_birth`, `airline_name`) VALUES
('admin', 'e2fc714c4727ee9395f324cd2e7f331f', 'Roe', 'Jones', '1978-05-25', 'United');

-- --------------------------------------------------------

--
-- Table structure for table `airplane`
--

CREATE TABLE `airplane` (
  `airline_name` varchar(100) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `num_seats` int(11) DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airplane`
--

INSERT INTO `airplane` (`airline_name`, `id`, `num_seats`, `manufacturer`, `age`) VALUES
('United', 1, 4, 'Boeing', 10),
('United', 2, 4, 'Airbus', 12),
('United', 3, 50, 'Boeing', 8);

-- --------------------------------------------------------

--
-- Table structure for table `airport`
--

CREATE TABLE `airport` (
  `name` varchar(100) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `airport_type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airport`
--

INSERT INTO `airport` (`name`, `city`, `country`, `airport_type`) VALUES
('BEI', 'Beijing', 'China', 'Both'),
('BOS', 'Boston', 'USA', 'Both'),
('HKA', 'Hong Kong', 'China', 'Both'),
('JFK', 'NYC', 'USA', 'Both'),
('LAX', 'Los Angeles', 'USA', 'Both'),
('PVG', 'Shanghai', 'China', 'Both'),
('SFO', 'San Francisco', 'USA', 'Both'),
('SHEN', 'Shenzhen', 'China', 'Both');

-- --------------------------------------------------------

--
-- Table structure for table `arrival`
--

CREATE TABLE `arrival` (
  `airport_name` varchar(50) NOT NULL,
  `flight_number` int(11) NOT NULL,
  `departure_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `airline_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `email` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `address_building_number` int(11) DEFAULT NULL,
  `address_street` varchar(100) DEFAULT NULL,
  `address_city` varchar(100) DEFAULT NULL,
  `address_state` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `passport_number` varchar(100) DEFAULT NULL,
  `passport_expiration` date DEFAULT NULL,
  `passport_country` varchar(100) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`email`, `name`, `password`, `address_building_number`, `address_street`, `address_city`, `address_state`, `phone_number`, `passport_number`, `passport_expiration`, `passport_country`, `date_of_birth`) VALUES
('testcustomer@nyu.edu', 'Jon Snow', '81dc9bdb52d04dc20036dbd8313ed055', 1555, 'Jay St', 'Brooklyn', 'New York', '123-4321-4321', '54321', '2025-12-24', 'USA', '1999-12-19'),
('user1@nyu.edu', 'Alice Bob', '81dc9bdb52d04dc20036dbd8313ed055', 5405, 'Jay Street', 'Brooklyn', 'New York', '123-4322-4322', '54322', '2025-12-25', 'USA', '1999-11-19'),
('user2@nyu.edu', 'Cathy Wood', '81dc9bdb52d04dc20036dbd8313ed055', 1702, 'Jay Street', 'Brooklyn', 'New York', '123-4323-4323', '54323', '2025-10-24', 'USA', '1999-10-19'),
('user3@nyu.edu', 'Trudy Jones', '81dc9bdb52d04dc20036dbd8313ed055', 1890, 'Jay Street', 'Brooklyn', 'New York', '123-4324-4324', '54324', '2025-09-24', 'USA', '1999-09-19');

-- --------------------------------------------------------

--
-- Table structure for table `departure`
--

CREATE TABLE `departure` (
  `airport_name` varchar(50) NOT NULL,
  `flight_number` int(11) NOT NULL,
  `departure_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `airline_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flight`
--

CREATE TABLE `flight` (
  `airline_name` varchar(100) NOT NULL,
  `flight_number` int(11) NOT NULL,
  `departure_airport` varchar(100) DEFAULT NULL,
  `departure_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `arrival_airport` varchar(100) DEFAULT NULL,
  `arrival_date_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `base_price` decimal(8,2) DEFAULT NULL,
  `airplane_id` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flight`
--

INSERT INTO `flight` (`airline_name`, `flight_number`, `departure_airport`, `departure_date_time`, `arrival_airport`, `arrival_date_time`, `base_price`, `airplane_id`, `status`) VALUES
('United', 102, 'SFO', '2023-04-09 17:25:25', 'LAX', '2023-04-09 20:50:25', 300.00, 3, 'on-time'),
('United', 104, 'PVG', '2023-05-04 17:25:25', 'BEI', '2023-05-04 20:50:25', 300.00, 3, 'on-time'),
('United', 106, 'SFO', '2023-03-04 18:25:25', 'LAX', '2023-03-04 21:50:25', 350.00, 3, 'delayed'),
('United', 134, 'JFK', '2023-02-11 18:25:25', 'BOS', '2023-02-11 21:50:25', 300.00, 3, 'delayed'),
('United', 206, 'SFO', '2023-09-04 17:25:25', 'LAX', '2023-09-04 20:50:25', 400.00, 2, 'on-time'),
('United', 207, 'LAX', '2023-10-05 17:25:25', 'SFO', '2023-10-05 20:50:25', 300.00, 2, 'on-time'),
('United', 296, 'PVG', '2023-07-30 17:25:25', 'SFO', '2023-07-30 20:50:25', 3000.00, 1, 'on-time'),
('United', 715, 'PVG', '2023-04-28 14:25:25', 'BEI', '2023-04-28 17:50:25', 500.00, 1, 'delayed'),
('United', 839, 'SHEN', '2022-08-26 17:25:25', 'BEI', '2022-08-26 20:50:25', 300.00, 3, 'on-time');

-- --------------------------------------------------------

--
-- Table structure for table `has`
--

CREATE TABLE `has` (
  `flight_number` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `departure_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `airline_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `ticket_id` int(11) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `sold_price` decimal(10,2) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_time` time DEFAULT NULL,
  `card_type` varchar(20) DEFAULT NULL,
  `card_number` varchar(20) DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `name_on_card` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`ticket_id`, `customer_email`, `sold_price`, `purchase_date`, `purchase_time`, `card_type`, `card_number`, `expiration_date`, `name_on_card`) VALUES
(1, 'testcustomer@nyu.edu', 300.00, '2023-03-04', '11:55:55', 'credit', '1111-2222-3333-4444', '2027-03-01', 'Test Customer 1'),
(2, 'user1@nyu.edu', 300.00, '2023-03-03', '11:55:55', 'credit', '1111-2222-3333-5555', '2027-03-01', 'User 1'),
(3, 'user2@nyu.edu', 300.00, '2023-04-04', '11:55:55', 'credit', '1111-2222-3333-5555', '2027-03-01', 'User 2'),
(4, 'user1@nyu.edu', 300.00, '2023-03-21', '11:55:55', 'credit', '1111-2222-3333-5555', '2023-03-01', 'User 1'),
(5, 'testcustomer@nyu.edu', 300.00, '2023-04-28', '11:55:55', 'credit', '1111-2222-3333-4444', '2027-03-01', 'Test Customer 1'),
(6, 'testcustomer@nyu.edu', 350.00, '2023-03-02', '11:55:55', 'credit', '1111-2222-3333-4444', '2027-03-01', 'Test Customer 1'),
(7, 'user3@nyu.edu', 350.00, '2023-02-03', '11:55:55', 'credit', '1111-2222-3333-5555', '2027-03-01', 'User 3'),
(8, 'user3@nyu.edu', 300.00, '2022-08-03', '11:55:55', 'credit', '1111-2222-3333-5555', '2023-03-01', 'User 3'),
(9, 'user3@nyu.edu', 300.00, '2023-02-04', '11:55:55', 'credit', '1111-2222-3333-5555', '2023-03-01', 'User 3'),
(11, 'user3@nyu.edu', 300.00, '2022-12-23', '11:55:55', 'credit', '1111-2222-3333-5555', '2027-03-01', 'User 3'),
(12, 'testcustomer@nyu.edu', 500.00, '2022-12-02', '11:55:55', 'credit', '1111-2222-3333-4444', '2023-03-01', 'Test Customer 1'),
(14, 'user3@nyu.edu', 400.00, '2023-06-20', '11:55:55', 'credit', '1111-2222-3333-5555', '2023-03-01', 'User 3'),
(15, 'user1@nyu.edu', 400.00, '2023-06-21', '11:55:55', 'credit', '1111-2222-3333-5555', '2023-03-01', 'User 1'),
(16, 'user2@nyu.edu', 400.00, '2023-04-19', '11:55:55', 'credit', '1111-2222-3333-5555', '2023-03-01', 'User 2'),
(17, 'user1@nyu.edu', 300.00, '2023-03-11', '11:55:55', 'credit', '1111-2222-3333-5555', '2023-03-01', 'User 1'),
(18, 'testcustomer@nyu.edu', 300.00, '2023-04-25', '11:55:55', 'credit', '1111-2222-3333-4444', '2023-03-01', 'Test Customer 1'),
(19, 'user1@nyu.edu', 3000.00, '2023-06-22', '11:55:55', 'credit', '1111-2222-3333-4444', '2023-03-01', 'Test Customer 1'),
(20, 'testcustomer@nyu.edu', 3000.00, '2023-02-12', '11:55:55', 'credit', '1111-2222-3333-4444', '2023-03-01', 'Test Customer 1');

-- --------------------------------------------------------

--
-- Table structure for table `rate`
--

CREATE TABLE `rate` (
  `flight_number` int(11) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `departure_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `rating` int(11) DEFAULT NULL,
  `airline_name` varchar(100) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rate`
--

INSERT INTO `rate` (`flight_number`, `customer_email`, `departure_date_time`, `rating`, `airline_name`, `comment`) VALUES
(102, 'testcustomer@nyu.edu', '2023-04-09 17:25:25', 4, 'United', 'Very Comfortable'),
(102, 'user1@nyu.edu', '2023-04-09 17:25:25', 5, 'United', 'Relaxing, check-in and onboarding very professional'),
(102, 'user2@nyu.edu', '2023-04-09 17:25:25', 3, 'United', 'Satisfied and will use the same flight again'),
(104, 'testcustomer@nyu.edu', '2023-05-04 17:25:25', 1, 'United', 'Customer Care services are not good'),
(104, 'user1@nyu.edu', '2023-05-04 17:25:25', 5, 'United', 'Comfortable journey and Professional');

-- --------------------------------------------------------

--
-- Table structure for table `staffemail`
--

CREATE TABLE `staffemail` (
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staffemail`
--

INSERT INTO `staffemail` (`username`, `email`) VALUES
('admin', 'staff@nyu.edu');

-- --------------------------------------------------------

--
-- Table structure for table `staffphone`
--

CREATE TABLE `staffphone` (
  `username` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staffphone`
--

INSERT INTO `staffphone` (`username`, `phone_number`) VALUES
('admin', '111-2222-3333'),
('admin', '444-5555-6666');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `id` int(11) NOT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `airline_name` varchar(100) DEFAULT NULL,
  `flight_number` int(11) DEFAULT NULL,
  `departure_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sold_price` decimal(8,2) DEFAULT NULL,
  `payment_info_card_type` varchar(10) DEFAULT NULL,
  `payment_info_card_number` varchar(20) DEFAULT NULL,
  `payment_info_name_on_card` varchar(100) DEFAULT NULL,
  `payment_info_expiration_date` date DEFAULT NULL,
  `purchase_date_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `customer_email`, `airline_name`, `flight_number`, `departure_date_time`, `sold_price`, `payment_info_card_type`, `payment_info_card_number`, `payment_info_name_on_card`, `payment_info_expiration_date`, `purchase_date_time`) VALUES
(1, 'testcustomer@nyu.edu', 'United', 102, '2023-04-09 17:25:25', 300.00, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-03-04 16:55:55'),
(2, 'user1@nyu.edu', 'United', 102, '2023-04-09 17:25:25', 300.00, 'credit', '1111-2222-3333-5555', 'User 1', '2027-03-01', '2023-03-03 16:55:55'),
(3, 'user2@nyu.edu', 'United', 102, '2023-04-09 17:25:25', 300.00, 'credit', '1111-2222-3333-5555', 'User 2', '2027-03-01', '2023-04-04 15:55:55'),
(4, 'user1@nyu.edu', 'United', 104, '2023-05-04 17:25:25', 300.00, 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-03-21 15:55:55'),
(5, 'testcustomer@nyu.edu', 'United', 104, '2023-05-04 17:25:25', 300.00, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-04-28 15:55:55'),
(6, 'testcustomer@nyu.edu', 'United', 106, '2023-03-04 18:25:25', 350.00, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-03-02 16:55:55'),
(7, 'user3@nyu.edu', 'United', 106, '2023-03-04 18:25:25', 350.00, 'credit', '1111-2222-3333-5555', 'User 3', '2027-03-01', '2023-02-03 16:55:55'),
(8, 'user3@nyu.edu', 'United', 839, '2022-08-26 17:25:25', 300.00, 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01', '2022-08-03 15:55:55'),
(9, 'user3@nyu.edu', 'United', 102, '2023-08-09 17:25:25', 300.00, 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01', '2023-02-04 16:55:55'),
(11, 'user3@nyu.edu', 'United', 134, '2023-02-11 18:25:25', 300.00, 'credit', '1111-2222-3333-5555', 'User 3', '2027-03-01', '2022-12-23 16:55:55'),
(12, 'testcustomer@nyu.edu', 'United', 715, '2023-04-28 14:25:25', 500.00, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01', '2022-12-02 16:55:55'),
(14, 'user3@nyu.edu', 'United', 206, '2023-09-04 17:25:25', 400.00, 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01', '2023-06-20 15:55:55'),
(15, 'user1@nyu.edu', 'United', 206, '2023-09-04 17:25:25', 400.00, 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-06-21 15:55:55'),
(16, 'user2@nyu.edu', 'United', 206, '2023-09-04 17:25:25', 400.00, 'credit', '1111-2222-3333-5555', 'User 2', '2023-03-01', '2023-06-25 15:55:55'),
(17, 'user2@nyu.edu', 'United', 207, '2023-10-05 17:25:25', 400.00, 'credit', '1111-2222-3333-5555', 'User 2', '2023-03-01', '2023-07-03 15:55:55'),
(18, 'user1@nyu.edu', 'United', 207, '2023-10-05 17:25:25', 400.00, 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-07-04 15:55:55'),
(19, 'testcustomer@nyu.edu', 'United', 296, '2023-07-30 17:25:25', 300.00, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-07-01 15:55:55'),
(20, 'user1@nyu.edu', 'United', 296, '2023-07-30 17:25:25', 300.00, 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-07-01 15:55:55');

-- --------------------------------------------------------

--
-- Table structure for table `uses`
--

CREATE TABLE `uses` (
  `flight_number` int(11) NOT NULL,
  `airplane_id` int(11) NOT NULL,
  `departure_date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `airline_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `works`
--

CREATE TABLE `works` (
  `staff_username` varchar(100) NOT NULL,
  `airline_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `airline`
--
ALTER TABLE `airline`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `airlinestaff`
--
ALTER TABLE `airlinestaff`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `airplane`
--
ALTER TABLE `airplane`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `arrival`
--
ALTER TABLE `arrival`
  ADD PRIMARY KEY (`airport_name`,`flight_number`,`departure_date_time`),
  ADD KEY `airline_name` (`airline_name`,`flight_number`,`departure_date_time`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `departure`
--
ALTER TABLE `departure`
  ADD PRIMARY KEY (`airport_name`,`flight_number`,`departure_date_time`),
  ADD KEY `airline_name` (`airline_name`,`flight_number`,`departure_date_time`);

--
-- Indexes for table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`flight_number`,`departure_date_time`,`airline_name`),
  ADD KEY `airline_name` (`airline_name`),
  ADD KEY `departure_airport` (`departure_airport`),
  ADD KEY `arrival_airport` (`arrival_airport`),
  ADD KEY `airplane_id` (`airplane_id`);

--
-- Indexes for table `has`
--
ALTER TABLE `has`
  ADD PRIMARY KEY (`flight_number`,`ticket_id`,`departure_date_time`),
  ADD KEY `airline_name` (`airline_name`,`flight_number`,`departure_date_time`),
  ADD KEY `ticket_id` (`ticket_id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`ticket_id`,`customer_email`),
  ADD KEY `customer_email` (`customer_email`);

--
-- Indexes for table `rate`
--
ALTER TABLE `rate`
  ADD PRIMARY KEY (`flight_number`,`customer_email`,`departure_date_time`),
  ADD KEY `airline_name` (`airline_name`,`flight_number`,`departure_date_time`),
  ADD KEY `customer_email` (`customer_email`);

--
-- Indexes for table `staffemail`
--
ALTER TABLE `staffemail`
  ADD PRIMARY KEY (`username`,`email`);

--
-- Indexes for table `staffphone`
--
ALTER TABLE `staffphone`
  ADD PRIMARY KEY (`username`,`phone_number`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `airline_name` (`airline_name`,`flight_number`,`departure_date_time`);

--
-- Indexes for table `uses`
--
ALTER TABLE `uses`
  ADD PRIMARY KEY (`flight_number`,`airplane_id`,`departure_date_time`),
  ADD KEY `airline_name` (`airline_name`,`flight_number`,`departure_date_time`),
  ADD KEY `airplane_id` (`airplane_id`);

--
-- Indexes for table `works`
--
ALTER TABLE `works`
  ADD PRIMARY KEY (`staff_username`,`airline_name`),
  ADD KEY `airline_name` (`airline_name`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `arrival`
--
ALTER TABLE `arrival`
  ADD CONSTRAINT `arrival_ibfk_1` FOREIGN KEY (`airport_name`) REFERENCES `airport` (`name`),
  ADD CONSTRAINT `arrival_ibfk_2` FOREIGN KEY (`airline_name`,`flight_number`,`departure_date_time`) REFERENCES `flight` (`airline_name`, `flight_number`, `departure_date_time`);

--
-- Constraints for table `departure`
--
ALTER TABLE `departure`
  ADD CONSTRAINT `departure_ibfk_1` FOREIGN KEY (`airport_name`) REFERENCES `airport` (`name`),
  ADD CONSTRAINT `departure_ibfk_2` FOREIGN KEY (`airline_name`,`flight_number`,`departure_date_time`) REFERENCES `flight` (`airline_name`, `flight_number`, `departure_date_time`);

--
-- Constraints for table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`airline_name`) REFERENCES `airline` (`name`),
  ADD CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`departure_airport`) REFERENCES `airport` (`name`),
  ADD CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`arrival_airport`) REFERENCES `airport` (`name`),
  ADD CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`airplane_id`) REFERENCES `airplane` (`id`);

--
-- Constraints for table `has`
--
ALTER TABLE `has`
  ADD CONSTRAINT `has_ibfk_1` FOREIGN KEY (`airline_name`,`flight_number`,`departure_date_time`) REFERENCES `flight` (`airline_name`, `flight_number`, `departure_date_time`),
  ADD CONSTRAINT `has_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`);

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  ADD CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`customer_email`) REFERENCES `customer` (`email`);

--
-- Constraints for table `rate`
--
ALTER TABLE `rate`
  ADD CONSTRAINT `rate_ibfk_1` FOREIGN KEY (`airline_name`,`flight_number`,`departure_date_time`) REFERENCES `flight` (`airline_name`, `flight_number`, `departure_date_time`),
  ADD CONSTRAINT `rate_ibfk_2` FOREIGN KEY (`customer_email`) REFERENCES `customer` (`email`);

--
-- Constraints for table `staffemail`
--
ALTER TABLE `staffemail`
  ADD CONSTRAINT `staffemail_ibfk_1` FOREIGN KEY (`username`) REFERENCES `airlinestaff` (`username`);

--
-- Constraints for table `staffphone`
--
ALTER TABLE `staffphone`
  ADD CONSTRAINT `staffphone_ibfk_1` FOREIGN KEY (`username`) REFERENCES `airlinestaff` (`username`);

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`airline_name`,`flight_number`,`departure_date_time`) REFERENCES `flight` (`airline_name`, `flight_number`, `departure_date_time`);

--
-- Constraints for table `uses`
--
ALTER TABLE `uses`
  ADD CONSTRAINT `uses_ibfk_1` FOREIGN KEY (`airline_name`,`flight_number`,`departure_date_time`) REFERENCES `flight` (`airline_name`, `flight_number`, `departure_date_time`),
  ADD CONSTRAINT `uses_ibfk_2` FOREIGN KEY (`airplane_id`) REFERENCES `airplane` (`id`);

--
-- Constraints for table `works`
--
ALTER TABLE `works`
  ADD CONSTRAINT `works_ibfk_1` FOREIGN KEY (`staff_username`) REFERENCES `airlinestaff` (`username`),
  ADD CONSTRAINT `works_ibfk_2` FOREIGN KEY (`airline_name`) REFERENCES `airline` (`name`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
