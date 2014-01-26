-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-01-2014 a las 23:31:51
-- Versión del servidor: 5.6.12-log
-- Versión de PHP: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `spi`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parqueo`
--

CREATE TABLE IF NOT EXISTS `parqueo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GARAJE_ID` int(11) DEFAULT NULL,
  `COD_DESCRIPCION` text NOT NULL,
  `PISO` int(11) DEFAULT NULL,
  `ESTADO` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_RELATIONSHIP_3` (`GARAJE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `parqueo`
--

INSERT INTO `parqueo` (`ID`, `GARAJE_ID`, `COD_DESCRIPCION`, `PISO`, `ESTADO`) VALUES
(1, 3, '1', 12, 1),
(2, 3, '2', 12, 1),
(3, 5, '502', 5, 1),
(4, 5, '503', 5, 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `parqueo`
--
ALTER TABLE `parqueo`
  ADD CONSTRAINT `FK_RELATIONSHIP_3` FOREIGN KEY (`GARAJE_ID`) REFERENCES `garaje` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
