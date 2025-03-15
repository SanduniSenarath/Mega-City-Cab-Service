-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2025 at 07:06 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cabservicedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `nic` varchar(12) NOT NULL,
  `email` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `isBook` tinyint(1) NOT NULL,
  `isDelete` tinyint(1) NOT NULL,
  `phoneno` int(10) NOT NULL,
  `username` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `name`, `nic`, `email`, `address`, `isBook`, `isDelete`, `phoneno`, `username`) VALUES
(20, 'Sanduni Senarath', '988350516V', 'ssnsenarath@gmail.com', '295/1, Humbutiyawa, Nittambuwa', 0, 0, 767390530, 'sanduni_sena'),
(21, 'Sanduni Senarath', '988350516V', 'ssnsenarath@gmail.com', '295/1, Humbutiyawa, Nittambuwa', 0, 0, 767390530, 'sanduni');

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `id` int(10) NOT NULL,
  `nic` varchar(12) NOT NULL,
  `name` varchar(225) NOT NULL,
  `phoneno` int(10) NOT NULL,
  `addressno` varchar(225) NOT NULL,
  `addressLine1` varchar(225) NOT NULL,
  `addressLine2` varchar(225) NOT NULL,
  `gender` varchar(25) NOT NULL,
  `isDelete` tinyint(1) NOT NULL,
  `isAvailable` tinyint(1) NOT NULL,
  `username` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`id`, `nic`, `name`, `phoneno`, `addressno`, `addressLine1`, `addressLine2`, `gender`, `isDelete`, `isAvailable`, `username`, `email`) VALUES
(28, '718003261V', 'Jeevika Rajapaksha', 775784340, '295/1', 'Humbutiyawa', 'Nittambuwa', 'Female', 0, 0, 'TestDriver', 'ssnsenarath@gmail.com'),
(29, '988350516V', 'Sanduni Senarath', 767390530, '295/1', 'Humbutiyawa', 'Nittambuwa', 'Female', 0, 0, 'Sanduni_driver', 'ssnsenarath@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `drivervehicle`
--

CREATE TABLE `drivervehicle` (
  `empSchNo` int(10) NOT NULL,
  `vehicleno` varchar(200) NOT NULL,
  `driverUsername` varchar(200) NOT NULL,
  `isavailable` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `drivervehicle`
--

INSERT INTO `drivervehicle` (`empSchNo`, `vehicleno`, `driverUsername`, `isavailable`) VALUES
(5486, 'WP-AB-1234', 'TestDriver', 1),
(5368, 'WP-AB-5678', 'Sanduni_driver', 1);

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE `price` (
  `id` int(10) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`id`, `price`) VALUES
(1, 320);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `id` int(10) NOT NULL,
  `bookNumber` int(10) NOT NULL,
  `startLocation` varchar(200) NOT NULL,
  `endLocation` varchar(100) NOT NULL,
  `distance` double NOT NULL,
  `amount` double NOT NULL,
  `empSchNo` int(10) NOT NULL,
  `username` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`id`, `bookNumber`, `startLocation`, `endLocation`, `distance`, `amount`, `empSchNo`, `username`, `date`, `time`) VALUES
(17, 791383, 'Nittambuwa', 'Gampaha', 25, 8000, 5486, 'sanduni_sena', '2025-03-10', '17:46:00');

-- --------------------------------------------------------

--
-- Table structure for table `userlogin`
--

CREATE TABLE `userlogin` (
  `id` int(10) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userlogin`
--

INSERT INTO `userlogin` (`id`, `username`, `password`, `role`) VALUES
(34, 'Admin', 'Admin@123', 'admin'),
(35, 'sanduni_sena', 'Sanduni@2024', 'customer'),
(36, 'sanduni', 'Sandu@123', 'customer'),
(38, 'TestDriver', 'Test@1234', 'driver'),
(39, 'Sanduni_driver', 'Sanduni@2025', 'driver');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `id` int(10) NOT NULL,
  `vehicle_number` varchar(10) NOT NULL,
  `available_seats` int(5) NOT NULL,
  `type` varchar(25) NOT NULL,
  `isAvailable` tinyint(1) NOT NULL,
  `owner` varchar(20) NOT NULL,
  `colour` varchar(20) NOT NULL,
  `fuel_type` varchar(20) NOT NULL,
  `chassisNumber` varchar(100) NOT NULL,
  `brandName` varchar(100) NOT NULL,
  `isDelete` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`id`, `vehicle_number`, `available_seats`, `type`, `isAvailable`, `owner`, `colour`, `fuel_type`, `chassisNumber`, `brandName`, `isDelete`) VALUES
(18, 'WP-AB-1234', 4, 'Car', 0, 'Sanduni Senarath', 'White', 'Petrol', 'WBA4B11020P123456', 'Toyota', 0),
(20, 'WP-AB-5678', 12, 'Van', 0, 'Navodya Senarath', 'Black', 'Diesel', 'ABC4B11020P123456', 'Nissan', 0),
(21, 'ABC-1234', 4, 'Toyota', 1, 'John Doe', 'Blue', 'Petrol', 'CH123456789', 'Toyota', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userlogin`
--
ALTER TABLE `userlogin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `driver`
--
ALTER TABLE `driver`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `price`
--
ALTER TABLE `price`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `userlogin`
--
ALTER TABLE `userlogin`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
