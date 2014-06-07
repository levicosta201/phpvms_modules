-- phpMyAdmin SQL Dump
-- version 3.3.7deb7
-- http://www.phpmyadmin.net
-- Host: localhost
-- Server Version: 5.1.61
-- PHP-Version: 5.3.3-7+squeeze8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `root`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `position_flight`
--

CREATE TABLE IF NOT EXISTS `position_flight` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `pilotid` varchar(20) NOT NULL DEFAULT '',
  `flightnum` varchar(20) NOT NULL DEFAULT '',
  `positiontime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lat` varchar(20) NOT NULL DEFAULT '',
  `lng` varchar(20) NOT NULL DEFAULT '',
  `altitude` varchar(20) NOT NULL DEFAULT '',
  `groundspeed` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Daten für Tabelle `acars_position`
--

