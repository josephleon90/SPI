/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     25/12/2013 19:19:17                          */
/*==============================================================*/


ALTER TABLE USUARIO DROP FOREIGN KEY FK_ASIGNADO;
 
ALTER TABLE CLIENTE DROP FOREIGN KEY FK_ASIGNADO2;

drop table if exists REGISTRO;

drop table if exists RESERVACION;

drop table if exists PARQUEO;

drop table if exists GARAJE;
 
drop table if exists USUARIO;

drop table if exists CLIENTE;

drop table if exists PUBLICIDAD;

drop table if exists LOCAL_COMERCIAL;

drop table if exists LOCAL_COMERCIAL_TIPO;

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE
(
   COD_CLIENTE          int not null auto_increment,
   COD_USUARIO          int,
   EMAIL                text,
   TELEFONO             text,
   DIRECCION            text,
   ESTADO               int not null,
   primary key (COD_CLIENTE)
);

/*==============================================================*/
/* Table: GARAJE                                                */
/*==============================================================*/
create table GARAJE
(
   COD_GARAJE           int not null auto_increment,
   COD_CLIENTE          int,
   DESCRIPCION          text,
   DIRECCION            text not null,
   DIRECCION_CORD       text not null,
   NUM_PARQUEOS         int not null,
   NUM_PISOS            int,
   ESTADO               int not null,
   primary key (COD_GARAJE)
);

/*==============================================================*/
/* Table: LOCAL_COMERCIAL                                       */
/*==============================================================*/
create table LOCAL_COMERCIAL
(
   COD_LOCAL_COMERCIAL  int not null auto_increment,
   COD_LOC_COM_TIPO     int,
   NOMBRE               text not null,
   ESTADO               int not null,
   primary key (COD_LOCAL_COMERCIAL)
);

/*==============================================================*/
/* Table: LOCAL_COMERCIAL_TIPO                                  */
/*==============================================================*/
create table LOCAL_COMERCIAL_TIPO
(
   COD_LOC_COM_TIPO     int not null auto_increment,
   DESCRIPCION          text not null,
   primary key (COD_LOC_COM_TIPO)
);

/*==============================================================*/
/* Table: PARQUEO                                               */
/*==============================================================*/
create table PARQUEO
(
   COD_PARQUEO          int not null auto_increment,
   COD_GARAJE           int,
   COD_DESCRIPCION      text not null,
   PISO                 int,
   ESTADO               int not null,
   primary key (COD_PARQUEO)
);

/*==============================================================*/
/* Table: PUBLICIDAD                                            */
/*==============================================================*/
create table PUBLICIDAD
(
   COD_PUBLICIDAD       int not null auto_increment,
   COD_USUARIO          int,
   COD_LOCAL_COMERCIAL  int,
   IMAGEN               longblob not null,
   FECHA_REGISTRO       datetime not null,
   FECHA_VENCIMIENTO    datetime not null,
   ESTADO               int not null,
   primary key (COD_PUBLICIDAD)
);

/*==============================================================*/
/* Table: REGISTRO                                              */
/*==============================================================*/
create table REGISTRO
(
   COD_REGISTRO         int not null auto_increment,
   COD_PARQUEO          int,
   COD_USUARIO          int,
   COD_GARAJE           int,
   FECHA_REGISTRO       datetime not null,
   VALOR                numeric(5,2),
   primary key (COD_REGISTRO)
);

/*==============================================================*/
/* Table: RESERVACION                                           */
/*==============================================================*/
create table RESERVACION
(
   COD_RESERVACION      int not null auto_increment,
   COD_USUARIO          int,
   COD_PARQUEO          int,
   COD_GARAJE           int,
   FECHA_REGISTRO       datetime not null,
   FECHA_RESERVACION    datetime not null,
   ESTADO               int not null,
   primary key (COD_RESERVACION)
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO
(
   COD_USUARIO          int not null auto_increment,
   COD_CLIENTE          int,
   USUARIO_LOGIN        text not null,
   PASSWORD_LOGIN       text not null,
   NOMBRE               text,
   APELLIDO             text,
   PLACA                text,
   TIPO                 text not null,
   ESTADO               int not null,
   primary key (COD_USUARIO)
);

alter table CLIENTE add constraint FK_ASIGNADO2 foreign key (COD_USUARIO)
      references USUARIO (COD_USUARIO) on delete restrict on update restrict;

alter table GARAJE add constraint FK_RELATIONSHIP_5 foreign key (COD_CLIENTE)
      references CLIENTE (COD_CLIENTE) on delete restrict on update restrict;

alter table LOCAL_COMERCIAL add constraint FK_TIENE foreign key (COD_LOC_COM_TIPO)
      references LOCAL_COMERCIAL_TIPO (COD_LOC_COM_TIPO) on delete restrict on update restrict;

alter table PARQUEO add constraint FK_RELATIONSHIP_3 foreign key (COD_GARAJE)
      references GARAJE (COD_GARAJE) on delete restrict on update restrict;

alter table PUBLICIDAD add constraint FK_RELATIONSHIP_13 foreign key (COD_USUARIO)
      references USUARIO (COD_USUARIO) on delete restrict on update restrict;

alter table PUBLICIDAD add constraint FK_RELATIONSHIP_4 foreign key (COD_LOCAL_COMERCIAL)
      references LOCAL_COMERCIAL (COD_LOCAL_COMERCIAL) on delete restrict on update restrict;

alter table REGISTRO add constraint FK_RELATIONSHIP_10 foreign key (COD_GARAJE)
      references GARAJE (COD_GARAJE) on delete restrict on update restrict;

alter table REGISTRO add constraint FK_RELATIONSHIP_11 foreign key (COD_USUARIO)
      references USUARIO (COD_USUARIO) on delete restrict on update restrict;

alter table REGISTRO add constraint FK_RELATIONSHIP_9 foreign key (COD_PARQUEO)
      references PARQUEO (COD_PARQUEO) on delete restrict on update restrict;

alter table RESERVACION add constraint FK_RELATIONSHIP_12 foreign key (COD_USUARIO)
      references USUARIO (COD_USUARIO) on delete restrict on update restrict;

alter table RESERVACION add constraint FK_TIENE_7 foreign key (COD_PARQUEO)
      references PARQUEO (COD_PARQUEO) on delete restrict on update restrict;

alter table RESERVACION add constraint FK_TIENE_8 foreign key (COD_GARAJE)
      references GARAJE (COD_GARAJE) on delete restrict on update restrict;

alter table USUARIO add constraint FK_ASIGNADO foreign key (COD_CLIENTE)
      references CLIENTE (COD_CLIENTE) on delete restrict on update restrict;

