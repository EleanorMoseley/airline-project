-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jul 07, 2023 at 12:33 PM
-- Server version: 5.7.39
-- PHP Version: 7.4.33

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
-- Table structure for table `Flight`
--

CREATE TABLE `Flight` (
  `airline_name` varchar(100) NOT NULL,
  `flight_number` int(11) NOT NULL,
  `departure_airport` varchar(100) DEFAULT NULL,
  `departure_date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `arrival_airport` varchar(100) DEFAULT NULL,
  `arrival_date_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `base_price` decimal(8,2) DEFAULT NULL,
  `airplane_id` int(11) DEFAULT NULL,
  `flight_status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Flight`
--

INSERT INTO `Flight` (`airline_name`, `flight_number`, `departure_airport`, `departure_date_time`, `arrival_airport`, `arrival_date_time`, `base_price`, `airplane_id`, `flight_status`) VALUES
('United', 102, 'SFO', '2023-04-09 17:25:25', 'LAX', '2023-04-09 20:50:25', '300.00', 3, 'on-time'),
('United', 104, 'PVG', '2023-05-04 17:25:25', 'BEI', '2023-05-04 20:50:25', '300.00', 3, 'on-time'),
('United', 106, 'SFO', '2023-03-04 18:25:25', 'LAX', '2023-03-04 21:50:25', '350.00', 3, 'delayed'),
('United', 134, 'JFK', '2023-02-11 18:25:25', 'BOS', '2023-02-11 21:50:25', '300.00', 3, 'delayed'),
('United', 206, 'SFO', '2023-09-04 17:25:25', 'LAX', '2023-09-04 20:50:25', '400.00', 2, 'on-time'),
('United', 207, 'LAX', '2023-10-05 17:25:25', 'SFO', '2023-10-05 20:50:25', '300.00', 2, 'on-time'),
('United', 296, 'PVG', '2023-07-30 17:25:25', 'SFO', '2023-07-30 20:50:25', '3000.00', 1, 'on-time'),
('United', 715, 'PVG', '2023-04-28 14:25:25', 'BEI', '2023-04-28 17:50:25', '500.00', 1, 'delayed]'),
('United', 839, 'SHEN', '2022-08-26 17:25:25', 'BEI', '2022-08-26 20:50:25', '300.00', 3, 'on-time');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Flight`
--
ALTER TABLE `Flight`
  ADD PRIMARY KEY (`flight_number`,`departure_date_time`,`airline_name`),
  ADD KEY `airline_name` (`airline_name`),
  ADD KEY `departure_airport` (`departure_airport`),
  ADD KEY `arrival_airport` (`arrival_airport`),
  ADD KEY `airplane_id` (`airplane_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Flight`
--
ALTER TABLE `Flight`
  ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`airline_name`) REFERENCES `Airline` (`name`),
  ADD CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`departure_airport`) REFERENCES `Airport` (`name`),
  ADD CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`arrival_airport`) REFERENCES `Airport` (`name`),
  ADD CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`airplane_id`) REFERENCES `Airplane` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
