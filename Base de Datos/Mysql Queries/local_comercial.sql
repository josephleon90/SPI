-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-01-2014 a las 23:31:24
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
-- Estructura de tabla para la tabla `local_comercial`
--

CREATE TABLE IF NOT EXISTS `local_comercial` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOC_COM_TIPO_ID` int(11) DEFAULT NULL,
  `NOMBRE` text NOT NULL,
  `ESTADO` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_TIENE` (`LOC_COM_TIPO_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `local_comercial`
--

INSERT INTO `local_comercial` (`ID`, `LOC_COM_TIPO_ID`, `NOMBRE`, `ESTADO`) VALUES
(1, 1, 'Mc Donald', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `local_comercial`
--
ALTER TABLE `local_comercial`
  ADD CONSTRAINT `FK_TIENE` FOREIGN KEY (`LOC_COM_TIPO_ID`) REFERENCES `local_comercial_tipo` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
