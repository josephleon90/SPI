-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-01-2014 a las 23:32:37
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
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CLIENTE_ID` int(11) DEFAULT NULL,
  `USUARIO_LOGIN` text NOT NULL,
  `PASSWORD_LOGIN` text NOT NULL,
  `NOMBRE` text,
  `APELLIDO` text,
  `PLACA` text,
  `TIPO` text NOT NULL,
  `ESTADO` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ASIGNADO` (`CLIENTE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`ID`, `CLIENTE_ID`, `USUARIO_LOGIN`, `PASSWORD_LOGIN`, `NOMBRE`, `APELLIDO`, `PLACA`, `TIPO`, `ESTADO`) VALUES
(1, 1, 'prueba', 'prueba', 'Joseph', 'Leon', 'GYH-2598', 'USUARIO', 1),
(2, NULL, '', '', 'Generico', NULL, NULL, 'USUARIO', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `FK_ASIGNADO` FOREIGN KEY (`CLIENTE_ID`) REFERENCES `cliente` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
