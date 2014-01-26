-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 26-01-2014 a las 23:41:36
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
CREATE DATABASE IF NOT EXISTS `spi` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `spi`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USUARIO_ID` int(11) DEFAULT NULL,
  `EMAIL` text,
  `TELEFONO` text,
  `DIRECCION` text,
  `ESTADO` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ASIGNADO2` (`USUARIO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`ID`, `USUARIO_ID`, `EMAIL`, `TELEFONO`, `DIRECCION`, `ESTADO`) VALUES
(1, 1, 'joseph_jiw@hotmail.com', '0939125270', 'Sauces 9 Mz R-58 Villa 1', 1);

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `local_comercial_tipo`
--

CREATE TABLE IF NOT EXISTS `local_comercial_tipo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `local_comercial_tipo`
--

INSERT INTO `local_comercial_tipo` (`ID`, `DESCRIPCION`) VALUES
(1, 'Comida'),
(2, 'Ropa'),
(3, 'ET'),
(4, 'Bancos'),
(5, 'Otros');

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
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FK_ASIGNADO2` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`);

--
-- Filtros para la tabla `garaje`
--
ALTER TABLE `garaje`
  ADD CONSTRAINT `FK_RELATIONSHIP_5` FOREIGN KEY (`CLIENTE_ID`) REFERENCES `cliente` (`id`);

--
-- Filtros para la tabla `local_comercial`
--
ALTER TABLE `local_comercial`
  ADD CONSTRAINT `FK_TIENE` FOREIGN KEY (`LOC_COM_TIPO_ID`) REFERENCES `local_comercial_tipo` (`ID`);

--
-- Filtros para la tabla `parqueo`
--
ALTER TABLE `parqueo`
  ADD CONSTRAINT `FK_RELATIONSHIP_3` FOREIGN KEY (`GARAJE_ID`) REFERENCES `garaje` (`ID`);

--
-- Filtros para la tabla `publicidad`
--
ALTER TABLE `publicidad`
  ADD CONSTRAINT `FK_RELATIONSHIP_4` FOREIGN KEY (`LOCAL_COMERCIAL_ID`) REFERENCES `local_comercial` (`ID`);

--
-- Filtros para la tabla `registro`
--
ALTER TABLE `registro`
  ADD CONSTRAINT `FK_RELATIONSHIP_10` FOREIGN KEY (`GARAJE_ID`) REFERENCES `garaje` (`ID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_11` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_9` FOREIGN KEY (`PARQUEO_ID`) REFERENCES `parqueo` (`ID`);

--
-- Filtros para la tabla `reservacion`
--
ALTER TABLE `reservacion`
  ADD CONSTRAINT `FK_RELATIONSHIP_12` FOREIGN KEY (`COD_USUARIO`) REFERENCES `usuario` (`ID`),
  ADD CONSTRAINT `FK_TIENE_7` FOREIGN KEY (`COD_PARQUEO`) REFERENCES `parqueo` (`ID`),
  ADD CONSTRAINT `FK_TIENE_8` FOREIGN KEY (`COD_GARAJE`) REFERENCES `garaje` (`ID`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `FK_ASIGNADO` FOREIGN KEY (`CLIENTE_ID`) REFERENCES `cliente` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
