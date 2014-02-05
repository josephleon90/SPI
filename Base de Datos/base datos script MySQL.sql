/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     29/01/2014 1:41:55                           */
/*==============================================================*/


drop table if exists reservacion;

drop table if exists registro;

drop table if exists publicidad;

drop table if exists local_comercial;

drop table if exists publicidad_tipo;

drop table if exists parqueo;

drop table if exists garaje;

drop table if exists cliente;

drop table if exists usuario;

drop table if exists afiliacion_tipo;

drop table if exists usuario_tipo;


/*==============================================================*/
/* Table: afiliacion_tipo                                       */
/*==============================================================*/
create table afiliacion_tipo
(
   ID                   int not null auto_increment,
   DESCRIPCION          text not null,
   ESTADO               bool,
   primary key (ID)
);

/*==============================================================*/
/* Table: cliente                                               */
/*==============================================================*/
create table cliente
(
   ID                   int(11) not null auto_increment,
   USUARIO_ID           int(11),
   AFILIACION_TIPO_ID   int,
   TELEFONO             text,
   DIRECCION            text,
   ESTADO               bool not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: garaje                                                */
/*==============================================================*/
create table garaje
(
   ID                   int(11) not null auto_increment,
   CLIENTE_ID           int(11),
   DESCRIPCION          text,
   DIRECCION            text not null,
   DIRECCION_CORD       text not null,
   NUM_PARQUEOS         int not null,
   NUM_PISOS            int default NULL,
   ESTADO               bool not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: local_comercial                                       */
/*==============================================================*/
create table local_comercial
(
   ID                   int(11) not null auto_increment,
   CLIENTE_ID           int(11),
   PUBLICIDAD_TIPO_ID   int(11),
   NOMBRE               text not null,
   ESTADO               bool not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: parqueo                                               */
/*==============================================================*/
create table parqueo
(
   ID                   int(11) not null auto_increment,
   GARAJE_ID            int(11),
   COD_DESCRIPCION      text not null,
   PISO                 int default NULL,
   OCUPADO              int,
   ESTADO               bool not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: publicidad                                            */
/*==============================================================*/
create table publicidad
(
   ID                   int(11) not null auto_increment,
   PUBLICIDAD_TIPO_ID   int(11),
   LOCAL_COMERCIAL_ID   int(11),
   IMAGEN               text not null,
   FECHA_REGISTRO       datetime not null,
   FECHA_VENCIMIENTO    datetime not null,
   ESTADO               bool not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: publicidad_tipo                                       */
/*==============================================================*/
create table publicidad_tipo
(
   ID                   int(11) not null auto_increment,
   DESCRIPCION          text not null,
   ESTADO               bool,
   primary key (ID)
);

/*==============================================================*/
/* Table: registro                                              */
/*==============================================================*/
create table registro
(
   ID                   int(11) not null auto_increment,
   GARAJE_ID            int(11),
   PARQUEO_ID           int(11),
   USUARIO_ID           int(11),
   FECHA_REGISTRO       datetime not null,
   VALOR                decimal(5,2) default NULL,
   primary key (ID)
);

/*==============================================================*/
/* Table: reservacion                                           */
/*==============================================================*/
create table reservacion
(
   ID                   int(11) not null auto_increment,
   GARAJE_ID            int(11),
   PARQUEO_ID           int(11),
   USUARIO_ID           int(11),
   FECHA_REGISTRO       datetime not null,
   FECHA_RESERVACION    datetime not null,
   ESTADO               bool not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: usuario                                               */
/*==============================================================*/
create table usuario
(
   ID                   int(11) not null auto_increment,
   USUARIO_TIPO_ID      int,
   EMAIL                text not null,
   PASSWORD             text not null,
   NOMBRE               text,
   APELLIDO             text,
   PLACA                text,
   ESTADO               bool not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: usuario_tipo                                          */
/*==============================================================*/
create table usuario_tipo
(
   ID                   int not null auto_increment,
   DESCRIPCION          text,
   ESTADO               bool,
   primary key (ID)
)


alter table cliente add constraint FK_ESTA_ASIGNADO foreign key (USUARIO_ID)
      references usuario (ID) on delete cascade on update restrict;

alter table cliente add constraint FK_TIPO foreign key (AFILIACION_TIPO_ID)
      references afiliacion_tipo (ID) on delete cascade on update restrict;

alter table garaje add constraint FK_POSEE foreign key (CLIENTE_ID)
      references cliente (ID) on delete cascade on update restrict;

alter table local_comercial add constraint FK_TIENE2 foreign key (CLIENTE_ID)
      references cliente (ID) on delete cascade on update restrict;

alter table local_comercial add constraint FK_TIENE4 foreign key (PUBLICIDAD_TIPO_ID)
      references publicidad_tipo (ID) on delete cascade on update restrict;

alter table parqueo add constraint FK_TIENE3 foreign key (GARAJE_ID)
      references garaje (ID) on delete cascade on update restrict;

alter table publicidad add constraint FK_DEL foreign key (LOCAL_COMERCIAL_ID)
      references local_comercial (ID) on delete cascade on update restrict;

alter table publicidad add constraint FK_DE_LA foreign key (PUBLICIDAD_TIPO_ID)
      references publicidad_tipo (ID) on delete cascade on update restrict;

alter table registro add constraint FK_HACE2 foreign key (USUARIO_ID)
      references usuario (ID) on delete cascade on update restrict;

alter table registro add constraint FK_HACE4 foreign key (PARQUEO_ID)
      references parqueo (ID) on delete cascade on update restrict;

alter table registro add constraint FK_TIENE_TRANSACCIONES foreign key (GARAJE_ID)
      references garaje (ID) on delete cascade on update restrict;

alter table reservacion add constraint FK_HACE1 foreign key (USUARIO_ID)
      references usuario (ID) on delete cascade on update restrict;

alter table reservacion add constraint FK_HACE3 foreign key (GARAJE_ID)
      references garaje (ID) on delete cascade on update restrict;

alter table reservacion add constraint FK_TIENE1 foreign key (PARQUEO_ID)
      references parqueo (ID) on delete cascade on update restrict;

alter table usuario add constraint FK_TIPO_2 foreign key (USUARIO_TIPO_ID)
      references usuario_tipo (ID) on delete cascade on update restrict;
	  
INSERT INTO `afiliacion_tipo` (`ID`, `DESCRIPCION`, `ESTADO`) VALUES
(1, 'Platinium', 1),
(2, 'Golden', 1),
(3, 'Premium', 1);

INSERT INTO  `spi`.`usuario_tipo` (`ID` ,`DESCRIPCION` ,`ESTADO`) VALUES 
(1 ,  'Conductor',  '1'), 
(2 ,  'Local de Parqueo',  '1');

INSERT INTO `usuario` (`ID`, `USUARIO_TIPO_ID`,`EMAIL`, `PASSWORD`, `NOMBRE`, `APELLIDO`, `PLACA`, `ESTADO`) VALUES
(1, 1, 'prueba', 'prueba', 'Joseph', 'Leon', 'GYH-2598', 1),
(2, 1, '', '', 'Generico', NULL, NULL, 1);
	  
INSERT INTO `cliente` (`ID`, `USUARIO_ID`, `AFILIACION_TIPO_ID`, `TELEFONO`, `DIRECCION`, `ESTADO`) VALUES
(1, 1, 1, '0939125270', 'Sauces 9 Mz R-58 Villa 1', 1);

INSERT INTO `garaje` (`ID`, `CLIENTE_ID`, `DESCRIPCION`, `DIRECCION`, `DIRECCION_CORD`, `NUM_PARQUEOS`, `NUM_PISOS`, `ESTADO`) VALUES
(1, 1, 'Parqueos Continental', 'Victor Manuel Rendon y Alfredo Baquerizo Moreno', '-2.190155,-79.881978', 100, 12, 1),
(2, 1, 'Multicomercio', 'Cuenca y Eloy Alfaro', '-2.203203,-79.884276', 200, 0, 1),
(3, 1, 'Banco Park', 'Luque y Pichincha', '-2.193039,-79.88075', 380, 12, 1),
(4, 1, 'Central Park', 'Pedro Carbo y Clemente Ballen', '-2.194412,-79.882119', 54, 0, 1),
(5, 1, 'Multiparqueo', 'Vicente Rocafuerte y Pedro Carbo', '-2.189801,-79.880832', 12, 1, 1);

INSERT INTO `publicidad_tipo` (`ID`, `DESCRIPCION`) VALUES
(1, 'Comida'),
(2, 'Ropa'),
(3, 'ET'),
(4, 'Bancos'),
(5, 'Otros');

INSERT INTO `local_comercial` (`ID`, `CLIENTE_ID`, `PUBLICIDAD_TIPO_ID`, `NOMBRE`, `ESTADO`) VALUES
(1, 1, 1, 'Burguer King', 1),
(2, 1, 2, 'ETAFASHION', 1),
(3, 1, 4, 'Banco Pacifico', 1);

INSERT INTO `parqueo` (`ID`, `GARAJE_ID`, `COD_DESCRIPCION`, `PISO`, `ESTADO`) VALUES
(1, 3, '1', 12, 1),
(2, 3, '2', 12, 1),
(3, 5, '502', 5, 1),
(4, 5, '503', 5, 1);

INSERT INTO `publicidad` (`ID`, `PUBLICIDAD_TIPO_ID`, `IMAGEN`, `FECHA_REGISTRO`, `FECHA_VENCIMIENTO`, `ESTADO`) VALUES
(1, 1, 'deluxe.jpg', '2013-12-25 13:32:16', '2014-03-28 16:16:27', 1),
(2, 1, 'pizza_burguer.jpg', '2014-01-23 00:00:00', '2014-02-28 00:00:00', 1),
(3, 3, 'prestamos.jpg', '2014-01-27 00:00:00', '2014-02-28 00:00:00', 1),
(4, 2, 'PNETA.jpg', '2014-01-27 00:00:00', '2014-03-31 00:00:00', 1);

INSERT INTO `registro` (`ID`, `PARQUEO_ID`, `USUARIO_ID`, `GARAJE_ID`, `FECHA_REGISTRO`, `VALOR`) VALUES
(1, 1, 1, 1, '2013-12-15 10:05:41', '1.00');

INSERT INTO `reservacion` (`ID`, `USUARIO_ID`, `PARQUEO_ID`, `GARAJE_ID`,`REGISTRO_ID`, `FECHA_REGISTRO`, `FECHA_RESERVACION`, `ESTADO`) VALUES
(1, 1, 1, 1, 1, '2013-12-15 15:20:41', '2013-12-16 10:30:00', 1);

