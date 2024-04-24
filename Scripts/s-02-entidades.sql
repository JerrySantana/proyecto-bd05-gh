--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 21/04/2024
--@Descripción: Proyecto Global Home - Creación de entidades.

-- Definición de la tabla USUARIO
create table usuario(
  usuario_id number(10,0),
  nombre_usuario varchar2(10) not null,
  nombre varchar2(20) not null,
  ap_paterno varchar2(15) not null,
  ap_materno varchar2(15),
  email varchar2(30) not null,
  contraseña varchar(15) not null,
  constraint usuario_pk primary key(usuario_id),
  constraint  usuario_email_uk unique(email),
  constraint  usuario_nombre_usuario_uk unique(nombre_usuario)
);

-- Definición de la tabla TIPO_SERVICIO
create table tipo_servicio(
  servicio_id number(10,0) not null,
  descripcion varchar2(50) not null,
  icono blob not null,
  nombre varchar2(20) not null,
  constraint tipo_servicio_pk primary key(servicio_id),
  constraint tipo_servicio_nombre_uk unique(nombre)
);

-- Definición de la tabla ESTATUS

-- Definición de la tabla VIVIENDA
