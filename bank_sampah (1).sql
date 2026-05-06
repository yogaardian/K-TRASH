-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2026 at 07:36 AM
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
-- Database: `bank_sampah`
--

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `status` enum('online','busy','offline') DEFAULT 'offline'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver_locations`
--

CREATE TABLE `driver_locations` (
  `id` int(11) NOT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver_locations`
--

INSERT INTO `driver_locations` (`id`, `driver_id`, `order_id`, `lat`, `lng`, `created_at`) VALUES
(1, 2, 2, -7.121, 110.121, '2026-05-04 07:58:28'),
(2, 2, 2, -7.155, 110.155, '2026-05-04 07:58:46'),
(3, 2, 2, -9.155, 130.155, '2026-05-04 07:58:55'),
(4, 2, 2, -9.156, 130.156, '2026-05-04 08:00:24'),
(5, 2, 2, -9.156, 130.156, '2026-05-04 08:00:25'),
(6, 2, 2, -9.157, 130.157, '2026-05-04 08:00:36'),
(7, 2, 2, -9.157, 130.157, '2026-05-04 08:00:44'),
(8, 2, 2, -9.158, 130.158, '2026-05-04 08:00:59'),
(9, 2, 8, -7.5428591, 111.6504791, '2026-05-05 12:45:46'),
(10, 2, 3, -7.542925, 111.650395, '2026-05-05 14:32:14'),
(11, 2, 11, -7.542925, 111.650395, '2026-05-05 14:34:05'),
(12, 2, 7, 37.4219983, -122.084, '2026-05-06 05:06:12'),
(13, 2, 12, -7.8, 110.3, '2026-05-06 05:13:42'),
(14, 2, 12, 37.4219983, -122.084, '2026-05-06 05:13:43'),
(15, 2, 13, 37.4219983, -122.084, '2026-05-06 05:14:21');

-- --------------------------------------------------------

--
-- Table structure for table `harga_sampah`
--

CREATE TABLE `harga_sampah` (
  `id` int(11) NOT NULL,
  `jenis` varchar(50) DEFAULT NULL,
  `sub_jenis` varchar(50) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `status` enum('pending','searching_driver','assigned','on_the_way','arrived','completed','cancelled') DEFAULT 'pending',
  `user_lat` double DEFAULT NULL,
  `user_lng` double DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `jenis_sampah` text DEFAULT NULL,
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `driver_id`, `status`, `user_lat`, `user_lng`, `address`, `created_at`, `jenis_sampah`, `catatan`) VALUES
(1, 1, 1, 'assigned', -7.12, 110.12, 'Rumah saya', '2026-05-04 07:30:03', NULL, NULL),
(2, 1, 2, 'assigned', -7.12, 110.12, 'Rumah saya', '2026-05-04 07:32:21', NULL, NULL),
(3, 1, 2, 'assigned', -7.123, 110.123, 'Jl. Mawar No 1', '2026-05-05 07:17:22', NULL, NULL),
(4, 1, NULL, 'pending', -7.5488756, 111.6459529, 'FJ2W+C9M, Purwosari, Kecamatan Wonoasri, Kabupaten Madiun, Indonesia', '2026-05-05 07:27:08', 'organik', ''),
(5, 1, NULL, 'pending', -7.5488744, 111.6459555, 'FJ2W+C9M, Purwosari, Kecamatan Wonoasri, Kabupaten Madiun, Indonesia', '2026-05-05 08:30:54', 'organik', ''),
(6, 1, NULL, 'pending', -7.5488732, 111.6459575, 'FJ2W+C9M, Purwosari, Kecamatan Wonoasri, Kabupaten Madiun, Indonesia', '2026-05-05 09:01:47', 'organik', ''),
(7, 1, 2, 'assigned', -7.5488732, 111.6459575, 'FJ2W+C9M, Purwosari, Kecamatan Wonoasri, Kabupaten Madiun, Indonesia', '2026-05-05 09:03:51', 'anorganik', ''),
(8, 1, 2, 'assigned', -7.548868, 111.6459513, 'FJ2W+C9M, Purwosari, Kecamatan Wonoasri, Kabupaten Madiun, Indonesia', '2026-05-05 09:09:56', 'lainnya', ''),
(9, 1, 2, 'assigned', -7.5488738, 111.6459583, 'FJ2W+C9M, Purwosari, Kecamatan Wonoasri, Kabupaten Madiun, Indonesia', '2026-05-05 09:11:29', 'organik', ''),
(10, 1, 2, 'assigned', -7.5488738, 111.6459583, 'FJ2W+C9M, Purwosari, Kecamatan Wonoasri, Kabupaten Madiun, Indonesia', '2026-05-05 09:11:46', 'organik, anorganik', ''),
(11, 1, 2, 'assigned', -7.5428207, 111.6504189, 'FM52+79V, Bangunsari, Kecamatan Wonoasri, Kabupaten Madiun, Indonesia', '2026-05-05 14:33:48', 'organik, anorganik, lainnya', ''),
(12, 1, 2, 'assigned', -7.5560089, 111.6590633, 'CMV5+8GM, Pandean, Kecamatan Mejayan, Kabupaten Madiun, Indonesia', '2026-05-06 05:10:33', 'organik', ''),
(13, 1, 2, 'assigned', -7.5560089, 111.6590633, 'CMV5+8GM, Pandean, Kecamatan Mejayan, Kabupaten Madiun, Indonesia', '2026-05-06 05:14:14', 'organik, anorganik, lainnya', '');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `type` enum('credit','debit') DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` enum('user','petugas','admin') DEFAULT 'user',
  `nomor_hp` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `email`, `password`, `role`, `nomor_hp`) VALUES
(1, 'yoga', 'yoga@gmail.com', '123123123', 'user', '085748185726'),
(2, 'Petugas Demo', 'petugas@test.com', '123456', 'petugas', '081234567890'),
(3, 'User Demo', 'user@test.com', '123456', 'user', '081234567891');

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_locations`
--
ALTER TABLE `driver_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `harga_sampah`
--
ALTER TABLE `harga_sampah`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver_locations`
--
ALTER TABLE `driver_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `harga_sampah`
--
ALTER TABLE `harga_sampah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
