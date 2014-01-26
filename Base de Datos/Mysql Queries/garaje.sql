-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-01-2014 a las 23:31:05
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
-- Estructura de tabla para la tabla `garaje`
--

CREATE TABLE IF NOT EXISTS `garaje` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CLIENTE_ID` int(11) DEFAULT NULL,
  `DESCRIPCION` text,
  `DIRECCION` text NOT NULL,
  `DIRECCION_CORD` text NOT NULL,
  `NUM_PARQUEOS` int(11) NOT NULL,
  `NUM_PISOS` int(11) DEFAULT NULL,
  `ESTADO` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_RELATIONSHIP_5` (`CLIENTE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `garaje`
--

INSERT INTO `garaje` (`ID`, `CLIENTE_ID`, `DESCRIPCION`, `DIRECCION`, `DIRECCION_CORD`, `NUM_PARQUEOS`, `NUM_PISOS`, `ESTADO`) VALUES
(1, 1, 'Parqueos Continental', 'Victor Manuel Rendon y Alfredo Baquerizo Moreno', '-2.190155,-79.881978', 100, 12, 1),
(2, 1, 'Multicomercio', 'Cuenca y Eloy Alfaro', '-2.203203,-79.884276', 200, 0, 1),
(3, 1, 'Banco Park', 'Luque y Pichincha', '-2.193039,-79.88075', 380, 12, 1),
(4, 1, 'Central Park', 'Pedro Carbo y Clemente Ballen', '-2.194412,-79.882119', 54, 0, 1),
(5, 1, 'Multiparqueo', 'Vicente Rocafuerte y Pedro Carbo', '-2.189801,-79.880832', 12, 1, 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `garaje`
--
ALTER TABLE `garaje`
  ADD CONSTRAINT `FK_RELATIONSHIP_5` FOREIGN KEY (`CLIENTE_ID`) REFERENCES `cliente` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
