-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-01-2014 a las 23:32:24
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
-- Estructura de tabla para la tabla `reservacion`
--

CREATE TABLE IF NOT EXISTS `reservacion` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COD_USUARIO` int(11) DEFAULT NULL,
  `COD_PARQUEO` int(11) DEFAULT NULL,
  `COD_GARAJE` int(11) DEFAULT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `FECHA_RESERVACION` datetime NOT NULL,
  `ESTADO` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_RELATIONSHIP_12` (`COD_USUARIO`),
  KEY `FK_TIENE_7` (`COD_PARQUEO`),
  KEY `FK_TIENE_8` (`COD_GARAJE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

--
-- Volcado de datos para la tabla `reservacion`
--

INSERT INTO `reservacion` (`ID`, `COD_USUARIO`, `COD_PARQUEO`, `COD_GARAJE`, `FECHA_REGISTRO`, `FECHA_RESERVACION`, `ESTADO`) VALUES
(1, 1, 1, 1, '2013-12-15 15:20:41', '2013-12-16 10:30:00', 1),
(2, 1, 2, 2, '2013-12-24 12:21:13', '2013-01-15 13:21:03', 1),
(29, 2, 1, 3, '2014-01-14 12:45:02', '2014-01-15 13:45:00', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `reservacion`
--
ALTER TABLE `reservacion`
  ADD CONSTRAINT `FK_RELATIONSHIP_12` FOREIGN KEY (`COD_USUARIO`) REFERENCES `usuario` (`ID`),
  ADD CONSTRAINT `FK_TIENE_7` FOREIGN KEY (`COD_PARQUEO`) REFERENCES `parqueo` (`ID`),
  ADD CONSTRAINT `FK_TIENE_8` FOREIGN KEY (`COD_GARAJE`) REFERENCES `garaje` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
