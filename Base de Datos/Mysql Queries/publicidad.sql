-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-01-2014 a las 23:32:02
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
-- Estructura de tabla para la tabla `publicidad`
--

CREATE TABLE IF NOT EXISTS `publicidad` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOCAL_COMERCIAL_ID` int(11) DEFAULT NULL,
  `IMAGEN` text NOT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `FECHA_VENCIMIENTO` datetime NOT NULL,
  `ESTADO` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_RELATIONSHIP_4` (`LOCAL_COMERCIAL_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `publicidad`
--

INSERT INTO `publicidad` (`ID`, `LOCAL_COMERCIAL_ID`, `IMAGEN`, `FECHA_REGISTRO`, `FECHA_VENCIMIENTO`, `ESTADO`) VALUES
(1, 1, 'http://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Cat02.jpg/200px-Cat02.jpg', '2013-12-25 13:32:16', '2014-03-28 16:16:27', 1),
(2, 1, 'http://www.chicadelatele.com/wp-content/uploads/2010/05/New-Season-3-Promo-the-big-bang-theory-7445896-1500-2051.jpg', '2014-01-23 00:00:00', '2014-02-28 00:00:00', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `publicidad`
--
ALTER TABLE `publicidad`
  ADD CONSTRAINT `FK_RELATIONSHIP_4` FOREIGN KEY (`LOCAL_COMERCIAL_ID`) REFERENCES `local_comercial` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
