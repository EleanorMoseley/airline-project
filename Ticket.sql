-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jul 07, 2023 at 12:40 PM
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
-- Table structure for table `Ticket`
--

CREATE TABLE `Ticket` (
  `id` int(11) NOT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `airline_name` varchar(100) DEFAULT NULL,
  `flight_number` int(11) DEFAULT NULL,
  `departure_date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sold_price` decimal(8,2) DEFAULT NULL,
  `payment_info_card_type` varchar(10) DEFAULT NULL,
  `payment_info_card_number` varchar(20) DEFAULT NULL,
  `payment_info_name_on_card` varchar(100) DEFAULT NULL,
  `payment_info_expiration_date` date DEFAULT NULL,
  `purchase_date_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Ticket`
--

INSERT INTO `Ticket` (`id`, `customer_email`, `airline_name`, `flight_number`, `departure_date_time`, `sold_price`, `payment_info_card_type`, `payment_info_card_number`, `payment_info_name_on_card`, `payment_info_expiration_date`, `purchase_date_time`) VALUES
(1, 'testcustomer@nyu.edu', 'United', 102, '2023-04-09 17:25:25', '300.00', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-03-04 16:55:55'),
(2, ' user1@nyu.edu', 'United', 102, '2023-04-09 17:25:25', '300.00', 'credit', '1111-2222-3333-5555', 'User 1', '2027-03-01', '2023-03-03 16:55:55'),
(3, 'user2@nyu.edu', 'United', 102, '2023-04-09 17:25:25', '300.00', 'credit', '1111-2222-3333-5555', ' User 2', '2027-03-01', '2023-04-04 15:55:55'),
(4, 'user1@nyu.edu', 'United', 104, '2023-05-04 17:25:25', '300.00', 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-03-21 15:55:55'),
(5, 'testcustomer@nyu.edu', 'United', 104, '2023-05-04 17:25:25', '300.00', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-04-28 15:55:55'),
(6, 'testcustomer@nyu.edu', 'United', 106, '2023-03-04 18:25:25', '350.00', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-03-02 16:55:55'),
(7, ' user3@nyu.edu', 'United', 106, '2023-03-04 18:25:25', '350.00', 'credit', '1111-2222-3333-5555', 'User 3', '2027-03-01', '2023-02-03 16:55:55'),
(8, 'user3@nyu.edu', 'United', 839, '2022-08-26 17:25:25', '300.00', 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01', '2022-08-03 15:55:55'),
(9, 'user3@nyu.edu', 'United', 102, '2023-04-09 17:25:25', '300.00', 'credit', '1111-2222-3333-5555', 'User3', '2023-03-01', '2023-02-04 16:55:55'),
(11, 'user3@nyu.edu', 'United', 134, '2023-02-11 18:25:25', '300.00', 'credit', '1111-2222-3333-5555', 'User 3', '2027-03-01', '2022-12-23 16:55:55'),
(12, 'testcustomer@nyu.edu', 'United', 715, '2023-04-28 14:25:25', '500.00', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01', '2022-12-02 16:55:55'),
(14, 'user3@nyu.edu', 'United', 206, '2023-09-04 17:25:25', '400.00', 'credit', '1111-2222-3333-5555', 'User3', '2023-03-01', '2023-06-20 15:55:55'),
(15, 'user1@nyu.edu', 'United', 206, '2023-09-04 17:25:25', '400.00', 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-06-21 15:55:55'),
(16, 'user2@nyu.edu', 'United', 206, '2023-09-04 17:25:25', '400.00', 'credit', '1111-2222-3333-5555', 'User 2', '2023-03-01', '2023-04-19 15:55:55'),
(17, 'user1@nyu.edu', 'United', 207, '2023-10-05 17:25:25', '300.00', 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-03-11 16:55:55'),
(18, 'testcustomer@nyu.edu', 'United', 207, '2023-10-05 17:25:25', '300.00', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01', '2023-04-25 15:55:55'),
(19, 'user1@nyu.edu', 'United', 296, '2023-07-30 17:25:25', '3000.00', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01', '2023-06-22 15:55:55'),
(20, 'testcustomer@nyu.edu', 'United', 296, '2023-07-30 17:25:25', '3000.00', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01', '2023-02-12 16:55:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Ticket`
--
ALTER TABLE `Ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `airline_name` (`airline_name`,`flight_number`,`departure_date_time`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Ticket`
--
ALTER TABLE `Ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`airline_name`,`flight_number`,`departure_date_time`) REFERENCES `Flight` (`airline_name`, `flight_number`, `departure_date_time`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
