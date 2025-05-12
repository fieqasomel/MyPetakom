-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: May 12, 2025 at 06:04 AM
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
-- Database: `mypetakom`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_ID` int(15) NOT NULL,
  `slot_ID` int(15) NOT NULL,
  `student_ID` int(15) NOT NULL,
  `attendance_date` date NOT NULL,
  `attendance_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance slot`
--

CREATE TABLE `attendance slot` (
  `slot_ID` int(15) NOT NULL,
  `event_ID` int(15) NOT NULL,
  `slot_name` varchar(50) NOT NULL,
  `slot_date` date NOT NULL,
  `start_time` time NOT NULL,
  `attendance_qr` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `event_ID` int(15) NOT NULL,
  `staff_ID` int(15) NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `geolocation` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `venue` varchar(100) NOT NULL,
  `event_level` enum('international','national','state','district','UMPSA') NOT NULL,
  `event_status` enum('upcoming','ongoing','completed','cancelled','postponed') NOT NULL,
  `merit_eligible` tinyint(1) NOT NULL,
  `merit_status` enum('pending','approved','rejected','') NOT NULL,
  `event_qr` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event committee`
--

CREATE TABLE `event committee` (
  `committee_ID` int(15) NOT NULL,
  `event_ID` int(15) NOT NULL,
  `student_ID` int(15) NOT NULL,
  `role` enum('main committee','committee','','') NOT NULL,
  `assign_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `merit claim`
--

CREATE TABLE `merit claim` (
  `claim_ID` int(15) NOT NULL,
  `event_ID` int(15) NOT NULL,
  `student_ID` int(15) NOT NULL,
  `claim_status` enum('draft','submitted','approved','rejected') NOT NULL,
  `claim_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `merit record`
--

CREATE TABLE `merit record` (
  `record_ID` int(15) NOT NULL,
  `event_ID` int(15) NOT NULL,
  `student_ID` int(15) NOT NULL,
  `attendance_ID` int(15) NOT NULL,
  `committee` int(15) NOT NULL,
  `merit_type` int(20) NOT NULL,
  `points` int(10) NOT NULL,
  `awarded_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_ID` int(15) NOT NULL,
  `user_ID` int(15) NOT NULL,
  `position` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_ID` int(15) NOT NULL,
  `user_ID` int(15) NOT NULL,
  `matric_no` varchar(20) NOT NULL,
  `program` varchar(50) NOT NULL,
  `year` int(1) NOT NULL,
  `semester` int(1) NOT NULL,
  `student_passport` varchar(255) NOT NULL,
  `is_petakom_member` tinyint(1) NOT NULL,
  `membership_date` date NOT NULL,
  `membership_status` enum('pending','approved','rejected') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student merit`
--

CREATE TABLE `student merit` (
  `stdmerit_ID` int(15) NOT NULL,
  `student_ID` int(15) NOT NULL,
  `semester` varchar(15) NOT NULL,
  `year` int(1) NOT NULL,
  `total_merit` int(5) NOT NULL,
  `stdmerit_qr` varchar(255) NOT NULL,
  `last_updated` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_ID` int(15) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `user_type` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_num` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_ID`, `username`, `password`, `user_type`, `name`, `email`, `phone_num`) VALUES
(4, 'afiq', '$2y$10$8OF6OluU6wC1HwjBIzyVW.tilxN1BzPNVSYuC/oAJgV', 'student', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_ID`),
  ADD KEY `FK_att_std` (`student_ID`),
  ADD KEY `FK_att_slot` (`slot_ID`);

--
-- Indexes for table `attendance slot`
--
ALTER TABLE `attendance slot`
  ADD PRIMARY KEY (`slot_ID`),
  ADD KEY `FK_slot_event` (`event_ID`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`event_ID`),
  ADD KEY `FK_event_staff` (`staff_ID`);

--
-- Indexes for table `event committee`
--
ALTER TABLE `event committee`
  ADD PRIMARY KEY (`committee_ID`),
  ADD KEY `FK_com_event` (`event_ID`),
  ADD KEY `FK_com_std` (`student_ID`);

--
-- Indexes for table `merit claim`
--
ALTER TABLE `merit claim`
  ADD PRIMARY KEY (`claim_ID`),
  ADD KEY `FK_claim_event` (`event_ID`),
  ADD KEY `FK_claim_std` (`student_ID`);

--
-- Indexes for table `merit record`
--
ALTER TABLE `merit record`
  ADD PRIMARY KEY (`record_ID`),
  ADD KEY `FK_record_att` (`attendance_ID`),
  ADD KEY `FK_record_event` (`event_ID`),
  ADD KEY `FK_record_std` (`student_ID`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_ID`),
  ADD KEY `FK_staff_user` (`user_ID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_ID`),
  ADD KEY `FK_student` (`user_ID`);

--
-- Indexes for table `student merit`
--
ALTER TABLE `student merit`
  ADD PRIMARY KEY (`stdmerit_ID`),
  ADD KEY `FK_stdmerit_std` (`student_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_ID` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendance slot`
--
ALTER TABLE `attendance slot`
  MODIFY `slot_ID` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `event_ID` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event committee`
--
ALTER TABLE `event committee`
  MODIFY `committee_ID` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `merit claim`
--
ALTER TABLE `merit claim`
  MODIFY `claim_ID` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `merit record`
--
ALTER TABLE `merit record`
  MODIFY `record_ID` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_ID` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_ID` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student merit`
--
ALTER TABLE `student merit`
  MODIFY `stdmerit_ID` int(15) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_ID` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `FK_att_slot` FOREIGN KEY (`slot_ID`) REFERENCES `attendance slot` (`slot_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_att_std` FOREIGN KEY (`student_ID`) REFERENCES `student` (`student_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendance slot`
--
ALTER TABLE `attendance slot`
  ADD CONSTRAINT `FK_slot_event` FOREIGN KEY (`event_ID`) REFERENCES `event` (`event_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `FK_event_staff` FOREIGN KEY (`staff_ID`) REFERENCES `staff` (`staff_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `event committee`
--
ALTER TABLE `event committee`
  ADD CONSTRAINT `FK_com_event` FOREIGN KEY (`event_ID`) REFERENCES `event` (`event_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_com_std` FOREIGN KEY (`student_ID`) REFERENCES `student` (`student_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `merit claim`
--
ALTER TABLE `merit claim`
  ADD CONSTRAINT `FK_claim_event` FOREIGN KEY (`event_ID`) REFERENCES `event` (`event_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_claim_std` FOREIGN KEY (`student_ID`) REFERENCES `student` (`student_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `merit record`
--
ALTER TABLE `merit record`
  ADD CONSTRAINT `FK_record_att` FOREIGN KEY (`attendance_ID`) REFERENCES `attendance` (`attendance_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_record_event` FOREIGN KEY (`event_ID`) REFERENCES `event` (`event_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_record_std` FOREIGN KEY (`student_ID`) REFERENCES `student` (`student_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `FK_staff_user` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `FK_student` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student merit`
--
ALTER TABLE `student merit`
  ADD CONSTRAINT `FK_stdmerit_std` FOREIGN KEY (`student_ID`) REFERENCES `student` (`student_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
