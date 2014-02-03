-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2013 at 12:23 AM
-- Server version: 5.6.11
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `books`
--
CREATE DATABASE IF NOT EXISTS `books` DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci;
USE `books`;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE IF NOT EXISTS `books` (
  `imdb` bigint(13) NOT NULL DEFAULT '0',
  `name` varchar(60) COLLATE latin1_general_ci NOT NULL,
  `author` varchar(60) COLLATE latin1_general_ci NOT NULL,
  `yearOfPub` date NOT NULL,
  `cost` double NOT NULL,
  PRIMARY KEY (`imdb`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`imdb`, `name`, `author`, `yearOfPub`, `cost`) VALUES
(1938, 'Wait Until Spring, Bandini', 'John Fante', '1938-04-23', 25.23),
(2458795, 'Moby dick', 'Herman melville', '1951-10-18', 20.25),
(340043539, 'Gabriel Hounds', 'Mary Stewart', '1967-05-06', 40.5),
(345315855, 'Kabumpo in Oz', 'Ruth Plumly Thompson', '1922-01-25', 25),
(425169413, 'Pacific Siege', 'Keith Douglass', '1999-08-09', 60),
(451526775, 'Macbeth', 'William Shakespeare', '1623-04-02', 20),
(593047281, 'Sabre''s Edge, the', 'Allan Mallinson', '2003-08-04', 40),
(709176740, 'S.T.A.R. Flight', 'E. C. Tubb', '1969-06-04', 50.25),
(1551664291, 'Kane', 'Jennifer Blake', '1998-09-10', 60),
(2147483647, 'Cabin Fever', 'Jeff Kinney', '2011-11-15', 30),
(9780373293889, 'Wagering Widow, the', 'Diane Gaston', '2004-07-06', 40.25),
(9780771041969, 'Macken Charm, the', 'Jack Hodgins', '1995-12-12', 40.14),
(9784141659778, 'Galactic Riddle, the', 'Clark Darlton', '1971-05-01', 10.25);

-- --------------------------------------------------------

--
-- Table structure for table `dvds`
--

CREATE TABLE IF NOT EXISTS `dvds` (
  `imdb` bigint(13) NOT NULL,
  `name` varchar(40) COLLATE latin1_general_ci NOT NULL,
  `director` varchar(40) COLLATE latin1_general_ci NOT NULL,
  `yearOfRelease` date NOT NULL,
  `cost` double NOT NULL,
  PRIMARY KEY (`imdb`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `dvds`
--

INSERT INTO `dvds` (`imdb`, `name`, `director`, `yearOfRelease`, `cost`) VALUES
(2134586594851, 'Thor: The Dark World', ' Alan Taylor, James Gunn', '2013-11-08', 40.25),
(9546835475623, 'Gravity', 'Alfonso Cuaron', '2013-10-04', 40.89);

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE IF NOT EXISTS `stock` (
  `imdb` bigint(13) NOT NULL,
  `quantity` int(4) NOT NULL,
  PRIMARY KEY (`imdb`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `table_list`
--

CREATE TABLE IF NOT EXISTS `table_list` (
  `name` varchar(40) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `table_list`
--

INSERT INTO `table_list` (`name`) VALUES
('books'),
('dvds');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(40) COLLATE latin1_general_ci NOT NULL,
  `password` longtext COLLATE latin1_general_ci NOT NULL,
  `email` varchar(40) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `email`) VALUES
('Shadow2004', '219e0ad9fe6e30e972fac1084a06f4971c33b787a8d4f9ea68dc5386798e031c4c40d7d44503976382696e1bd133b44ac1787bc491c332733bccf9fe26608940', 'test@test.com'),
('test', 'ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff', 'test');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
