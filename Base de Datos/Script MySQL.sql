-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 06-02-2014 a las 03:54:01
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
-- Estructura de tabla para la tabla `afiliacion_tipo`
--

CREATE TABLE IF NOT EXISTS `afiliacion_tipo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` text NOT NULL,
  `ESTADO` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `afiliacion_tipo`
--

INSERT INTO `afiliacion_tipo` (`ID`, `DESCRIPCION`, `ESTADO`) VALUES
(1, 'Platinium', 1),
(2, 'Golden', 1),
(3, 'Premium', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USUARIO_ID` int(11) DEFAULT NULL,
  `AFILIACION_TIPO_ID` int(11) DEFAULT NULL,
  `TELEFONO` text,
  `DIRECCION` text,
  `ESTADO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ESTA_ASIGNADO` (`USUARIO_ID`),
  KEY `FK_TIPO` (`AFILIACION_TIPO_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`ID`, `USUARIO_ID`, `AFILIACION_TIPO_ID`, `TELEFONO`, `DIRECCION`, `ESTADO`) VALUES
(1, 1, 1, '0939125270', 'Sauces 9 Mz R-58 Villa 1', 1);

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
  `ESTADO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_POSEE` (`CLIENTE_ID`)
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
  `CLIENTE_ID` int(11) DEFAULT NULL,
  `PUBLICIDAD_TIPO_ID` int(11) DEFAULT NULL,
  `NOMBRE` text NOT NULL,
  `ESTADO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_TIENE2` (`CLIENTE_ID`),
  KEY `FK_TIENE4` (`PUBLICIDAD_TIPO_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `local_comercial`
--

INSERT INTO `local_comercial` (`ID`, `CLIENTE_ID`, `PUBLICIDAD_TIPO_ID`, `NOMBRE`, `ESTADO`) VALUES
(1, 1, 1, 'Burguer King', 1),
(2, 1, 2, 'ETAFASHION', 1),
(3, 1, 4, 'Banco Pacifico', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parqueo`
--

CREATE TABLE IF NOT EXISTS `parqueo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GARAJE_ID` int(11) DEFAULT NULL,
  `COD_DESCRIPCION` text NOT NULL,
  `PISO` int(11) DEFAULT NULL,
  `OCUPADO` tinyint(1) NOT NULL,
  `ESTADO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_TIENE3` (`GARAJE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `parqueo`
--

INSERT INTO `parqueo` (`ID`, `GARAJE_ID`, `COD_DESCRIPCION`, `PISO`, `OCUPADO`, `ESTADO`) VALUES
(1, 3, '1', 12, 0, 1),
(2, 3, '2', 12, 0, 1),
(3, 5, '502', 5, 0, 1),
(4, 5, '503', 5, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicidad`
--

CREATE TABLE IF NOT EXISTS `publicidad` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PUBLICIDAD_TIPO_ID` int(11) DEFAULT NULL,
  `LOCAL_COMERCIAL_ID` int(11) DEFAULT NULL,
  `IMAGEN` text NOT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `FECHA_VENCIMIENTO` datetime NOT NULL,
  `ESTADO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_DEL` (`LOCAL_COMERCIAL_ID`),
  KEY `FK_DE_LA` (`PUBLICIDAD_TIPO_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `publicidad`
--

INSERT INTO `publicidad` (`ID`, `PUBLICIDAD_TIPO_ID`, `LOCAL_COMERCIAL_ID`, `IMAGEN`, `FECHA_REGISTRO`, `FECHA_VENCIMIENTO`, `ESTADO`) VALUES
(1, 1, NULL, 'deluxe.jpg', '2013-12-25 13:32:16', '2014-03-28 16:16:27', 1),
(2, 1, NULL, 'pizza_burguer.jpg', '2014-01-23 00:00:00', '2014-02-28 00:00:00', 1),
(3, 3, NULL, 'prestamos.jpg', '2014-01-27 00:00:00', '2014-02-28 00:00:00', 1),
(4, 2, NULL, 'PNETA.jpg', '2014-01-27 00:00:00', '2014-03-31 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicidad_tipo`
--

CREATE TABLE IF NOT EXISTS `publicidad_tipo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` text NOT NULL,
  `ESTADO` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `publicidad_tipo`
--

INSERT INTO `publicidad_tipo` (`ID`, `DESCRIPCION`, `ESTADO`) VALUES
(1, 'Comida', NULL),
(2, 'Ropa', NULL),
(3, 'ET', NULL),
(4, 'Bancos', NULL),
(5, 'Otros', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

CREATE TABLE IF NOT EXISTS `registro` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GARAJE_ID` int(11) DEFAULT NULL,
  `PARQUEO_ID` int(11) DEFAULT NULL,
  `USUARIO_ID` int(11) DEFAULT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `VALOR` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_HACE2` (`USUARIO_ID`),
  KEY `FK_HACE4` (`PARQUEO_ID`),
  KEY `FK_TIENE_TRANSACCIONES` (`GARAJE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `registro`
--

INSERT INTO `registro` (`ID`, `GARAJE_ID`, `PARQUEO_ID`, `USUARIO_ID`, `FECHA_REGISTRO`, `VALOR`) VALUES
(1, 1, 1, 1, '2013-12-15 10:05:41', '1.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservacion`
--

CREATE TABLE IF NOT EXISTS `reservacion` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GARAJE_ID` int(11) DEFAULT NULL,
  `PARQUEO_ID` int(11) DEFAULT NULL,
  `USUARIO_ID` int(11) DEFAULT NULL,
  `REGISTRO_ID` int(11) DEFAULT NULL,
  `FECHA_REGISTRO` datetime NOT NULL,
  `FECHA_RESERVACION` datetime NOT NULL,
  `ESTADO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ENTRA_POR` (`REGISTRO_ID`),
  KEY `FK_HACE1` (`USUARIO_ID`),
  KEY `FK_HACE3` (`GARAJE_ID`),
  KEY `FK_TIENE1` (`PARQUEO_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `reservacion`
--

INSERT INTO `reservacion` (`ID`, `GARAJE_ID`, `PARQUEO_ID`, `USUARIO_ID`, `REGISTRO_ID`, `FECHA_REGISTRO`, `FECHA_RESERVACION`, `ESTADO`) VALUES
(5, 3, 1, 1, NULL, '2013-01-01 12:14:10', '2014-05-01 12:14:10', 0),
(8, 1, 1, 1, NULL, '2013-12-15 00:00:00', '2014-06-16 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USUARIO_TIPO_ID` int(11) DEFAULT NULL,
  `EMAIL` text NOT NULL,
  `PASSWORD` text NOT NULL,
  `NOMBRE` text,
  `APELLIDO` text,
  `PLACA` text,
  `ESTADO` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_TIPO_2` (`USUARIO_TIPO_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`ID`, `USUARIO_TIPO_ID`, `EMAIL`, `PASSWORD`, `NOMBRE`, `APELLIDO`, `PLACA`, `ESTADO`) VALUES
(1, 1, 'prueba', 'prueba', 'Joseph', 'Leon', 'GYH-2598', 1),
(2, 1, '', '', 'Generico', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_tipo`
--

CREATE TABLE IF NOT EXISTS `usuario_tipo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` text,
  `ESTADO` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `usuario_tipo`
--

INSERT INTO `usuario_tipo` (`ID`, `DESCRIPCION`, `ESTADO`) VALUES
(1, 'Conductor', 1),
(2, 'Local de Parqueo', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `FK_TIPO` FOREIGN KEY (`AFILIACION_TIPO_ID`) REFERENCES `afiliacion_tipo` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_ESTA_ASIGNADO` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `garaje`
--
ALTER TABLE `garaje`
  ADD CONSTRAINT `FK_POSEE` FOREIGN KEY (`CLIENTE_ID`) REFERENCES `cliente` (`ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `local_comercial`
--
ALTER TABLE `local_comercial`
  ADD CONSTRAINT `FK_TIENE4` FOREIGN KEY (`PUBLICIDAD_TIPO_ID`) REFERENCES `publicidad_tipo` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_TIENE2` FOREIGN KEY (`CLIENTE_ID`) REFERENCES `cliente` (`ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `parqueo`
--
ALTER TABLE `parqueo`
  ADD CONSTRAINT `FK_TIENE3` FOREIGN KEY (`GARAJE_ID`) REFERENCES `garaje` (`ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `publicidad`
--
ALTER TABLE `publicidad`
  ADD CONSTRAINT `FK_DE_LA` FOREIGN KEY (`PUBLICIDAD_TIPO_ID`) REFERENCES `publicidad_tipo` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_DEL` FOREIGN KEY (`LOCAL_COMERCIAL_ID`) REFERENCES `local_comercial` (`ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `registro`
--
ALTER TABLE `registro`
  ADD CONSTRAINT `FK_TIENE_TRANSACCIONES` FOREIGN KEY (`GARAJE_ID`) REFERENCES `garaje` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_HACE2` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_HACE4` FOREIGN KEY (`PARQUEO_ID`) REFERENCES `parqueo` (`ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reservacion`
--
ALTER TABLE `reservacion`
  ADD CONSTRAINT `FK_TIENE1` FOREIGN KEY (`PARQUEO_ID`) REFERENCES `parqueo` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_ENTRA_POR` FOREIGN KEY (`REGISTRO_ID`) REFERENCES `registro` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_HACE1` FOREIGN KEY (`USUARIO_ID`) REFERENCES `usuario` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_HACE3` FOREIGN KEY (`GARAJE_ID`) REFERENCES `garaje` (`ID`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `FK_TIPO_2` FOREIGN KEY (`USUARIO_TIPO_ID`) REFERENCES `usuario_tipo` (`ID`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
