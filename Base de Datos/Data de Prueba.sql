INSERT INTO  `spi`.`CLIENTE` (
`COD_USUARIO` ,
`EMAIL` ,
`TELEFONO` ,
`DIRECCION` ,
`ESTADO`
)
VALUES (
 null ,  'joseph_jiw@hotmail.com',  '0939125279',  'Sauces 9 Mz R-58 Villa 1',  '1'
);


INSERT INTO  `spi`.`USUARIO` (
`COD_CLIENTE` ,
`USUARIO_LOGIN` ,
`PASSWORD_LOGIN` ,
`NOMBRE`,
`APELLIDO`,
`PLACA`,
`TIPO`,
`ESTADO`
)
VALUES (
'1' ,  'prueba',  'prueba', 'Joseph', 'Leon', 'GYH-2598', 'USUARIO', '1'
),
(
'' ,  '',  '', 'Generico', '', '', 'USUARIO', '1'
);


INSERT INTO  `spi`.`GARAJE` (
`COD_CLIENTE` ,
`DESCRIPCION` ,
`DIRECCION` ,
`DIRECCION_CORD` ,
`NUM_PARQUEOS` ,
`NUM_PISOS`  ,
`ESTADO`
)
VALUES (
'1',  'Garaje Bugi-Bugi', '10 de Agosto y Av. Quito', '-2.193811,-79.890568', '50',  '3', '1'
),
(
'1',  'Garaje Rayo McQueen', 'Riomamba y Galecio', '-2.185749,-79.884728', '10',  '0', '1'
);


INSERT INTO  `spi`.`LOCAL_COMERCIAL_TIPO` (
`DESCRIPCION`
)
VALUES (
'Comida'
), 
(
'Vestimenta'
);


INSERT INTO  `spi`.`LOCAL_COMERCIAL` (
`COD_LOC_COM_TIPO` ,
`NOMBRE` ,
`ESTADO`
)
VALUES (
'1',  'Mc Donald',  '1'
);


INSERT INTO  `spi`.`PARQUEO` (
`COD_GARAJE` ,
`COD_DESCRIPCION` ,
`PISO` ,
`ESTADO`
)
VALUES (
'1',  '10',  '2',  '1'
),
(
'2',  'B-56',  '', '1'
);


INSERT INTO `spi`.`REGISTRO` (
`COD_PARQUEO`, 
`COD_USUARIO`, 
`COD_GARAJE`, 
`FECHA_REGISTRO`, 
`VALOR`) 
VALUES (
'1', '1', '1', '2013-12-15 10:05:41', '1.00'
);


INSERT INTO  `spi`.`RESERVACION` (
`COD_PARQUEO` ,
`COD_GARAJE` ,
`COD_USUARIO` ,
`FECHA_REGISTRO` ,
`FECHA_RESERVACION` ,
`ESTADO`
)
VALUES (
'1',  '1',  '1',  '2013-12-15 15:20:41',  '2013-12-16 10:30:00',  '1'
),
(
'2',  '2',  '1',  '2013-12-24 12:21:13',  '2013-01-15 13:21:03',  '1'
)
;