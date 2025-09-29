-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2025 at 04:07 PM
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
-- Database: `tavern_publico`
--

-- --------------------------------------------------------

--
-- Table structure for table `blocked_dates`
--

CREATE TABLE `blocked_dates` (
  `id` int(11) NOT NULL,
  `block_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blocked_dates`
--

INSERT INTO `blocked_dates` (`id`, `block_date`) VALUES
(11, '2025-09-28'),
(12, '2025-09-29'),
(13, '2025-09-30'),
(15, '2025-10-02');

-- --------------------------------------------------------

--
-- Table structure for table `blocked_slots`
--

CREATE TABLE `blocked_slots` (
  `block_id` int(11) NOT NULL,
  `block_reason` varchar(255) NOT NULL,
  `block_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `assigned_table` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `admin_reply` text DEFAULT NULL,
  `replied_at` timestamp NULL DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `subject`, `message`, `admin_reply`, `replied_at`, `is_read`, `created_at`, `deleted_at`) VALUES
(5, 'user', 'penapaul858@gmail.com', 'reservation', 'good night', 'Good', '2025-09-26 16:13:46', 1, '2025-09-26 16:13:22', NULL),
(6, 'user', 'penapaul858@gmail.com', 'reservation', 'I want to rreserve', 'You\'ve found a PHP warning bug. The error messages you\'re seeing, \"Constant DB_SERVER already defined', '2025-09-26 17:04:36', 1, '2025-09-26 17:04:03', NULL),
(7, 'dfgh', '12jfksdfvk@gmail.com', 'dfg', 'dwfg', NULL, NULL, 0, '2025-09-27 06:54:57', NULL),
(8, 'fgh', '123454@gmail.com', 'Reservation Inquiry', 'efghjcvb', NULL, NULL, 0, '2025-09-27 06:59:18', NULL),
(9, 'admin', 'keycm109@gmail.com', 'Reservation Inquiry', 'HELLLO', 'sdfgh', '2025-09-28 12:44:50', 1, '2025-09-27 15:02:49', '2025-09-28 20:43:08'),
(10, 'user', 'penapaul858@gmail.com', 'Reservation Inquiry', 'Of course. I\'ve updated the notification_control.php file to include a \"View\" button for both messages and comments. Clicking this button will open a modal window displaying the full text, which is especially useful for longer entries.', NULL, NULL, 0, '2025-09-28 10:00:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deletion_history`
--

CREATE TABLE `deletion_history` (
  `log_id` int(11) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `deleted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `purge_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deletion_history`
--

INSERT INTO `deletion_history` (`log_id`, `item_type`, `item_id`, `item_data`, `deleted_at`, `purge_date`) VALUES
(2, 'reservation', 29, '{\"reservation_id\":29,\"user_id\":14,\"res_date\":\"2025-09-28\",\"res_time\":\"14:00:00\",\"num_guests\":10,\"res_name\":\"ed\",\"res_phone\":\"09663195259\",\"res_email\":\"karllouisnavarro@gmail.com\",\"status\":\"Pending\",\"created_at\":\"2025-09-28 18:04:53\",\"assigned_table\":null,\"table_id\":null,\"is_notified\":0,\"deleted_at\":null,\"source\":\"Online\"}', '2025-09-28 12:43:02', '2025-10-28'),
(3, 'contact_message', 9, '{\"id\":9,\"name\":\"admin\",\"email\":\"keycm109@gmail.com\",\"subject\":\"Reservation Inquiry\",\"message\":\"HELLLO\",\"admin_reply\":\"HElllo Karlll Louis\",\"replied_at\":\"2025-09-27 23:03:15\",\"is_read\":1,\"created_at\":\"2025-09-27 23:02:49\",\"deleted_at\":null}', '2025-09-28 12:43:08', '2025-10-28'),
(4, 'user', 34, '{\"user_id\":34,\"username\":\"vincr\",\"email\":\"key@gmail.com\",\"verification_token\":null,\"is_verified\":1,\"is_admin\":0,\"avatar\":null,\"mobile\":null,\"birthday\":null,\"created_at\":\"2025-09-28 20:46:34\",\"deleted_at\":null}', '2025-09-28 12:46:45', '2025-10-28'),
(6, 'event', 7, '{\"id\":7,\"title\":\"dfghjkl\",\"date\":\"275760-07-06\",\"end_date\":null,\"description\":\"hgfdsdf\",\"image\":\"uploads\\/68d62b59851c63.68834595.png\",\"deleted_at\":null}', '2025-09-28 12:56:56', '2025-10-28'),
(7, 'menu_item', 24, '{\"id\":24,\"name\":\"ertgh\",\"category\":\"Specialty\",\"price\":\"400.00\",\"image\":\"uploads\\/68d6d906e925d9.11936485.jpg\",\"description\":\"dfg\",\"deleted_at\":null}', '2025-09-28 13:03:04', '2025-10-28'),
(8, 'testimonial', 2, '{\"id\":2,\"user_id\":14,\"reservation_id\":18,\"rating\":3,\"comment\":\"Based on the code, the rating feature will only appear on the homepage under specific conditions. It is not visible in your screenshot because one or more of the following requirements have not been met:\",\"is_featured\":1,\"created_at\":\"2025-09-26 23:04:18\",\"deleted_at\":null}', '2025-09-28 13:12:53', '2025-10-28'),
(9, 'testimonial', 3, '{\"id\":3,\"user_id\":14,\"reservation_id\":24,\"rating\":3,\"comment\":\"dfghn\",\"is_featured\":1,\"created_at\":\"2025-09-27 02:02:39\",\"deleted_at\":null}', '2025-09-28 13:20:14', '2025-10-28'),
(10, 'gallery_image', 12, '{\"id\":12,\"image\":\"uploads\\/68d62b9ea7afe7.31026399.png\",\"description\":\"seiokjhgfdsxcvbnmjhfdxcv\",\"deleted_at\":null}', '2025-09-28 13:23:23', '2025-10-28');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `end_date` date DEFAULT NULL,
  `description` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `date`, `end_date`, `description`, `image`, `deleted_at`) VALUES
(6, 'Hello', '2025-12-21', NULL, 'im', 'uploads/68d62337a1aaf5.89438545.png', NULL),
(7, 'dfghjkl', '275760-07-06', NULL, 'hgfdsdf', 'uploads/68d62b59851c63.68834595.png', '2025-09-28 12:56:56'),
(8, 'Chrismast', '2025-12-21', '2025-12-25', 'My apologies. I shortened the code in my last response to make it easier to copy, but I see now that you\'d prefer to see it fully formatted. You are correct, no functionality was removed, it was only compressed.', 'uploads/68d62ec99388d6.32195318.png', NULL),
(9, 'Hallowen', '2025-11-01', '2025-11-05', 'Happ Halloween', 'uploads/68d9326184f316.63890607.jpeg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `image`, `description`, `deleted_at`) VALUES
(12, 'uploads/68d62b9ea7afe7.31026399.png', 'seiokjhgfdsxcvbnmjhfdxcv', '2025-09-28 13:23:23'),
(13, 'uploads/68d93279eccaf8.63602197.png', 'view lang', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hero_slides`
--

CREATE TABLE `hero_slides` (
  `id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `video_path` varchar(255) DEFAULT NULL,
  `media_type` varchar(10) NOT NULL DEFAULT 'image',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hero_slides`
--

INSERT INTO `hero_slides` (`id`, `image_path`, `title`, `subtitle`, `video_path`, `media_type`, `created_at`, `deleted_at`) VALUES
(12, 'uploads/68d80a5b4966f3.20083863.jpg', 'Tavern Publico', 'Where good company gathers', '', 'image', '2025-09-27 16:01:31', NULL),
(13, '', '', '', 'uploads/68d80a65aadfd9.10474346.mp4', 'video', '2025-09-27 16:01:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `name`, `category`, `price`, `image`, `description`, `deleted_at`) VALUES
(18, 'sdfgh', 'Specialty', 34.00, 'uploads/68d6239f7c51c5.11311157.png', 'dfgh', NULL),
(21, 'cfe', 'Lunch', 23.00, 'uploads/68d62a9ca42191.99713898.png', 'Completely replace the code in your update.php file with this corrected version. The only change is to the sanitize function.', NULL),
(22, 'asdf', 'Lunch', 234.00, 'uploads/68d657427b8541.26434268.png', 'sdfghgfdvb', NULL),
(23, 'wdefg', 'Specialty', 2.00, 'uploads/68d6d8f85b38e2.02182447.png', 'defgh', NULL),
(24, 'ertgh', 'Specialty', 400.00, 'uploads/68d6d906e925d9.11936485.jpg', 'dfg', '2025-09-28 13:03:04'),
(25, 'ert', 'Specialty', 34.00, 'uploads/68d6d914ba4907.26884802.png', 'wertghj', NULL),
(26, 'caramel', 'Coffee', 85.00, 'uploads/68d9329e59bee4.03672499.jpg', 'yummy', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `link`, `is_read`, `created_at`) VALUES
(1, 1, 'his table is designed to store the ratings and comments that guests submit about their reservations. It also includes a', NULL, 1, '2025-09-26 16:03:27'),
(2, 1, 'his table is designed to store the ratings and comments that guests submit about their reservations. It also includes a', NULL, 1, '2025-09-26 16:03:28'),
(3, 1, 'his table is designed to store the ratings and comments that guests submit about their reservations. It also includes a', NULL, 1, '2025-09-26 16:03:28'),
(4, 1, 'cvbnhgsx', NULL, 1, '2025-09-26 16:05:31'),
(5, 14, 'gvfdcvccc', NULL, 1, '2025-09-26 16:10:02'),
(6, 14, 'Good', NULL, 1, '2025-09-26 16:13:46'),
(7, 14, 'You\'ve found a PHP warning bug. The error messages you\'re seeing, \"Constant DB_SERVER already defined', NULL, 1, '2025-09-26 17:04:36'),
(8, 1, 'HElllo Karlll Louis', NULL, 1, '2025-09-27 15:03:15'),
(9, 1, 'sdfgh', NULL, 1, '2025-09-28 12:44:50');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `reservation_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `res_date` date NOT NULL,
  `res_time` time NOT NULL,
  `num_guests` int(11) NOT NULL,
  `res_name` varchar(100) NOT NULL,
  `res_phone` varchar(20) NOT NULL,
  `res_email` varchar(100) NOT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `assigned_table` varchar(50) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `is_notified` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `source` varchar(50) NOT NULL DEFAULT 'Online'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`reservation_id`, `user_id`, `res_date`, `res_time`, `num_guests`, `res_name`, `res_phone`, `res_email`, `status`, `created_at`, `assigned_table`, `table_id`, `is_notified`, `deleted_at`, `source`) VALUES
(15, NULL, '2025-09-16', '11:00:00', 1, 'Vincent paul GNC Pena', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Confirmed', '2025-09-16 14:18:15', NULL, NULL, 0, NULL, 'Online'),
(16, NULL, '2025-09-25', '11:00:00', 1, 'Vincent paul', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Confirmed', '2025-09-25 07:46:26', NULL, NULL, 0, NULL, 'Online'),
(17, 14, '2025-09-26', '11:00:00', 1, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Cancelled', '2025-09-26 10:14:04', NULL, NULL, 1, NULL, 'Online'),
(18, 14, '2025-09-26', '11:00:00', 1, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-09-26 10:15:37', NULL, NULL, 1, NULL, 'Online'),
(19, 1, '2025-09-26', '11:00:00', 6, 'KIm', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Pending', '2025-09-26 12:40:27', NULL, NULL, 0, NULL, 'Online'),
(20, 14, '2025-09-26', '11:00:00', 1, 'Tavern Publico', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-26 15:00:23', NULL, NULL, 1, NULL, 'Online'),
(21, 14, '2025-09-26', '11:00:00', 1, 'Tavern', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-26 15:10:00', NULL, NULL, 1, NULL, 'Online'),
(22, 14, '2025-09-27', '11:00:00', 1, 'Vincent', '09663195259', 'karllouisnavarro@gmail.com', 'Declined', '2025-09-26 17:03:24', NULL, NULL, 1, NULL, 'Online'),
(23, 14, '2025-09-27', '11:00:00', 56, 'isaac macaraeg', '09667785843', 'vincentpaul.pena@gnc.edu.ph', 'Pending', '2025-09-26 17:26:35', NULL, NULL, 0, NULL, 'Online'),
(24, 14, '2025-09-27', '11:00:00', 12, 'Vincent paul D Pena', '09667785843', 'penapaul858@gmail.com', 'Confirmed', '2025-09-26 17:31:35', NULL, NULL, 1, NULL, 'Online'),
(25, 14, '2025-09-27', '11:00:00', 54, 'Tavern', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-26 17:52:10', NULL, NULL, 1, '2025-09-27 14:55:34', 'Online'),
(26, 1, '2025-09-27', '11:00:00', 50, 'Tavern', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-27 15:02:30', NULL, NULL, 1, NULL, 'Online'),
(27, 14, '2025-09-28', '11:00:00', 10, 'Kimberly Anne D. Pena', '09663195259', 'karllouisnavarro@gmail.com', 'Confirmed', '2025-09-28 08:29:56', NULL, NULL, 1, NULL, 'Online'),
(28, NULL, '2025-02-12', '20:47:00', 10, 'Vincent paul D Pena', '09667785843', 'keycm109@gmail.com', 'Confirmed', '2025-09-28 09:47:55', NULL, NULL, 0, NULL, 'Walk-in'),
(29, 14, '2025-09-28', '14:00:00', 10, 'ed', '09663195259', 'karllouisnavarro@gmail.com', 'Pending', '2025-09-28 10:04:53', NULL, NULL, 0, '2025-09-28 12:43:02', 'Online'),
(30, 14, '2025-10-01', '11:00:00', 10, 'James', '09667785843', 'keycm109@gmail.com', 'Pending', '2025-09-28 10:35:49', NULL, NULL, 0, NULL, 'Online');

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `table_id` int(11) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `capacity` int(11) NOT NULL,
  `status` enum('Available','Unavailable','Maintenance') DEFAULT 'Available',
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `bio` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`id`, `name`, `title`, `bio`, `image`, `created_at`, `deleted_at`) VALUES
(1, 'fdghyjuh', 'rtyui', 'rtyuik', 'uploads/68d66bb522e764.00626705.jpg', '2025-09-26 10:32:21', NULL),
(2, 'karl', 'CEO', 'FULL STACK', 'uploads/68d9322c4e2517.13457155.jpg', '2025-09-28 13:03:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reservation_id` int(11) NOT NULL,
  `rating` int(1) NOT NULL,
  `comment` text NOT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `user_id`, `reservation_id`, `rating`, `comment`, `is_featured`, `created_at`, `deleted_at`) VALUES
(1, 14, 20, 5, 'wonderul', 1, '2025-09-26 15:01:26', NULL),
(2, 14, 18, 3, 'Based on the code, the rating feature will only appear on the homepage under specific conditions. It is not visible in your screenshot because one or more of the following requirements have not been met:', 1, '2025-09-26 15:04:18', '2025-09-28 21:12:53'),
(3, 14, 24, 3, 'dfghn', 1, '2025-09-26 18:02:39', '2025-09-28 21:20:14'),
(4, 14, 25, 3, 'dsfghj', 0, '2025-09-26 18:05:48', NULL),
(5, 14, 21, 3, 'sdfgh', 0, '2025-09-26 18:10:52', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `verification_token` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `avatar` varchar(255) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `verification_token`, `is_verified`, `is_admin`, `avatar`, `mobile`, `birthday`, `created_at`, `deleted_at`) VALUES
(1, 'admin', 'keycm109@gmail.com', '$2y$10$/3fYTIq9ymjPWjHRo9TVoOrTaDtdzRQ69miUzRMdbWL6HU3aXuOVe', NULL, 0, 1, 'uploads/avatars/68d6892138f3e7.41591577.jpg', NULL, NULL, '2025-07-16 15:38:28', NULL),
(14, 'user', 'penapaul858@gmail.com', '$2y$10$PCJ8NoYx/TzZnoAVVo63euwQ5yGQpAGl0h61xmWe1X/ngnBI5AShu', 'NULL', 1, 0, 'uploads/avatars/68d6673d7d9171.74377892.jpg', '09334257317', '2002-02-12', '2025-09-25 09:10:18', NULL),
(34, 'vincr', 'key@gmail.com', '$2y$10$AIIfwy1awioAEwnV6ki3eetNw67Ald16ZKPo.3a0YgxlCU8.rOVLS', NULL, 1, 0, NULL, NULL, NULL, '2025-09-28 12:46:34', '2025-09-28 12:46:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blocked_dates`
--
ALTER TABLE `blocked_dates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `block_date` (`block_date`);

--
-- Indexes for table `blocked_slots`
--
ALTER TABLE `blocked_slots`
  ADD PRIMARY KEY (`block_id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deletion_history`
--
ALTER TABLE `deletion_history`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_item_type` (`item_type`),
  ADD KEY `idx_purge_date` (`purge_date`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hero_slides`
--
ALTER TABLE `hero_slides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_table_id` (`table_id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`table_id`),
  ADD UNIQUE KEY `table_name` (`table_name`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reservation_id` (`reservation_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blocked_dates`
--
ALTER TABLE `blocked_dates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `blocked_slots`
--
ALTER TABLE `blocked_slots`
  MODIFY `block_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `deletion_history`
--
ALTER TABLE `deletion_history`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `hero_slides`
--
ALTER TABLE `hero_slides`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `table_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `fk_table_id` FOREIGN KEY (`table_id`) REFERENCES `tables` (`table_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD CONSTRAINT `testimonials_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `testimonials_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`reservation_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
