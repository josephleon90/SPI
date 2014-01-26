-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-01-2014 a las 23:32:13
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
-- Estructura de tabla para la tabla `registro`
--

CREATE TABLE IF NOT EXISTS `registro` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PARQUEO_ID` int(11) DEFAULT NULL,
  `USUARIO_ID` int(11) DEFAULT NULL,
  `GARAJE_ID` int(11) DEFAULT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `VALOR` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_RELATIONSHIP_10` (`GARAJE_ID`),
  KEY `FK_RELATIONSHIP_11` (`USUARIO_ID`),
  KEY `FK_RELATIONSHIP_9` (`PARQUEO_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `registro`
--

INSERT INTO `registro` (`ID`, `PARQUEO_ID`, `USUARIO_ID`, `GARAJE_ID`, `FECHA_REGISTRO`, `VALOR`) VALUES
(1, 1, 1, 1, '2013-12-15 10:05:41', '1.00');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `registro`
--
ALTER TABLE `registro`
  ADD CONSTRAINT `FK_RELATIONSHIP_10` FOREIGN KEY (`GARAJE_ID`) REFERENCES `garaje` (`ID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_11` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_9` FOREIGN KEY (`PARQUEO_ID`) REFERENCES `parqueo` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
