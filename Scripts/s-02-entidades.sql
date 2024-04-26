--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 24/04/2024
--@Descripción: Proyecto Global Home - Creación de entidades.

--
-- Definición de la tabla USUARIO
--
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
  constraint  usuario_nombre_usuario_uk unique(nombre_usuario),
  constraint usuario_contraseña_chk check(length(contraseña) between 8 and 15)
);

--
-- Definición de la tabla TARJETA_CREDITO
--
create table tarjeta_credito(
  tarjeta_id number(10,0) not null,
  mes_expiracion varchar2(2) not null,
  año_expiracion varchar2(4) not null,
  num_seguridad varchar2(4) not null,
  num_tarjeta varchar2(16) not null,
  usuario_id not null,
  constraint tarjeta_credito_pk primary key(tarjeta_id),
  constraint tarjeta_credito_usuario_id_fk foreign key(usuario_id) references usuario(usuario_id),
  constraint tarjeta_credito_num_tarjeta_chk check(regexp_like(num_tarjeta, '^\d{16}$')),
  constraint tarjeta_credito_num_seguridad_chk check(regexp_like(num_seguridad,'^\d{4}$'))
);

--
-- Definición de la tabla ESTATUS_VIVIENDA
--
create table estatus_vivienda(
  estatus_vivienda_id number(10,0),
  clave varchar2(10) not null,
  descripcion varchar2(15) not null,
  constraint estatuds_vivienda_pk primary key(estatus_vivienda_id),
  constraint estatus_vivienda_clave_uk unique(clave),
  constraint esatus_vivienda_clave_chk check(clave in ('DISPONIBLE','EN RENTA','ALQUILADA','EN VENTA','VENDIDA','INACTIVA'))
);

--
-- Definición de la tabla VIVIENDA
--
create table vivienda(
  vivienda_id number(10,0),
  es_renta char(1) not null,
  es_vacacional char(1) not null,
  es_venta char(1) not null,
  capacidad_personas numeric(3,0) not null,
  direccion varchar2(50) not null,
  descripcion varchar2(2000) not null,
  latitud number(8,5) not null,
  longitud number(8,5) not null,
  dueño_id not null,
  estatus_vivenda_id not null,
  constraint vivienda_pk primary key(vivienda_id),
  constraint vivienda_dueño_if_fk foreign key(dueño_id) references usuario(usuario_id),
  constraint vivienda_estatus_vivienda_id_fk foreign key(estatus_vivienda_id) references estatus_vivienda(estatus_vivienda_id),
  constraint vivienda_tipo_vivienda_chk check(
    (es_renta='1' and es_venta='0' and es_vacacional='0') or
    (es_renta='0' and es_venta='1' and es_vacacional='0') or
    (es_renta='0' and es_venta='0' and es_vacacional='1') or
    (es_renta='1' and es_venta='0' and es_vacacional='1') or
    (es_renta='0' and es_venta='1' and es_vacacional='1'))
);

--
-- Definición de la tabla/subtipo VIVIENDA_RENTA
--
create table vivienda_renta(
  vivienda_id,
  pago_mensual number(8,2) not null,
  dia_pago number(2,0) not null,
  constraint vivienda_renta_vivienda_id_fk foreign key(vivienda_id) references vivienda(vivienda_id),
  constraint vivienda_renta_pk primary key(vivienda_id),
  constraint vivienda_renta_dia_pago_chk check(dia_pago between 1 and 31)
);

--
-- Definición de la tabla CUENTA_RENTA
--
create table cuenta_renta(
  cuenta_renta_id number(10,0),
  clabe varchar2(18) not null,
  vivienda_id not null,
  constraint cuenta_renta_pk primary key(cuenta_renta_id),
  constraint cuenta_renta_vivienda_id_fk foreign key(vivienda_id) references vivienda_renta(vivienda_id),
  constraint cuenta_renta_clabe_chk check(regexp_like(clabe, '^\d{18}$'))
);

--
-- Definición de la tabla/subtipo VIVIENDA_VENTA
--
create table vivienda_venta(
  vivienda_id,
  comision  number(10,2) generated always as (precio_inicial*0.03),   -- Columna virtual
  pdf_avaluo blob not null,
  codigo_catastral varchar2(18) not null,
  folio varchar2(18) not null,
  precio_inicial number(12,2) not null,
  usuario_id not null,
  constraint vivienda_venta_vivienda_id_fk foreign key(vivienda_id) references vivienda(vivienda_id),
  constraint vivienda_venta_pk primary key(vivienda_id),
  constraint vivienda_venta_usuario_id_fk foreign key(usuario_id) references usuario(usuario_id)
);

--
-- Definición de la tabla PAGO_VIVIENDA
--
create table pago_vivienda(
  pago_vivienda_id number(10,0) not null,
  num_pago number(3,0) not null,
  pdf_comprobante blob not null,
  importe number(15,2) not null,
  fecha_pago date not null,
  vivienda_id not null,
  constraint pago_vivienda_pk primary key(pago_vivienda_id),
  constraint pago_vivienda_vivienda_id_fk foreign key(vivienda_id) references vivienda_venta(vivienda_id),
  constraint pago_vivienda_num_pago_chk check(num_pago between 1 and 240)
);

--
-- Definición de la tabla/subtipo VIVIENDA_VACACIONAL
--
create table vivienda_vacacional(
  vivienda_id,
  costo_por_dia number(7,2) not null,
  estadia_maxima number(2,0) not null,
  deposito_apartado number(5,2) not null,
  constraint vivienda_vacacional_vivienda_id_fk foreign key(vivienda_id) references vivienda(vivienda_id),
  constraint vivienda_vacacional_pk primary key(vivienda_id)
);

--
-- Definición de la tabla ALQUILER
--
create table alquiler(
  alquiler_id number(10,0),
  folio varchar2(8) not null,
  fecha_entrada date not null,
  fecha_salida date not null,
  vivienda_id not null,
  usuario_id not null,
  constraint alquiler_pk primary key(alquiler_id),
  constraint alquiler_vivienda_id_fk foreign key(vivienda_id) references vivienda_vacacional(vivienda_id),
  constraint alquiler_usuario_id_fk foreign key(usuario_id) references usuario(usuario_id)
);

--
-- Definició de la tabla EVALUACION
--
create table evaluacion(
  evaluacion_id number(10,0),
  calificacion number(1,0) not null,
  descripcion varchar2(500) not null,
  fecha_evaluacion date default on null sysdate,    -- Valor default
  alquiler_id not null,
  constraint evaluacion_pk primary key(evaluacion_id),
  constraint evaluacion_calificacion_chk check(calificacion between 1 and 5),
  constraint evaluacion_alquiler_id_fk foreign key(alquiler_id) references alquiler(alquiler_id)
);

--
-- Definición de la tabla TIPO_SERVICIO
--
create table tipo_servicio(
  tipo_servicio_id number(10,0) not null,
  descripcion varchar2(50) not null,
  icono blob not null,
  nombre varchar2(20) not null,
  constraint tipo_servicio_pk primary key(servicio_id),
  constraint tipo_servicio_nombre_uk unique(nombre)
);

--
-- Definición de la tabla TIPO_SERVICIO_VIVIENDA
--
create table tipo_servicio_vivienda(
  tipo_servicio_vivienda_id number(10,0),
  vivienda_id not null,
  tipo_servicio_id not null,
  constraint tipo_servicio_vivienda_pk primary key(tipo_servicio_vivienda_id),
  constraint tipo_servicio_vivienda_vivienda_id_fk foreign key(vivienda_id) references vivienda(vivienda_id),
  constraint tipo_servicio_vivienda_tipo_servicio_id_fk foreign key(tipo_servicio_id) references tipo_servicio(tipo_servicio_id),
  constraint tipo_servicio_vivienda_tipo_servicio_uk unique(vivienda_id, tipo_servicio)
);

--
-- Definición de la tabla HISTORICO_ESTATUS_VIVIENDA
--
create table historico_estatus_vivienda(
  historico_estatus_vivienda_id number(10,0),
  fecha_estatus date default on null sysdate,
  vivienda_id not null,
  estatus_vivienda_id not null,
  constraint historico_estatus_vivienda_pk primary key(historico_estatus_vivienda_id),
  constraint historico_estatus_vivienda_vivienda_id_fk foreign key(vivienda_id) references vivienda(vivienda_id),
  constraint historico_estatus_vivienda_estatus_vivienda_id_fk foreign key(estatus_vivienda_id) references estatus_vivienda(estatus_vivienda_id)
);

--
-- Definición de la tabla IMAGEN_VIVIENDA
--
create table imagen_vivienda(
  num_imagen number(10,0),
  vivienda_id,
  imagen blob not null,
  constraint imagen_vivienda_vivienda_id_fk foreign key(vivienda_id) references vivienda(vivienda_id),
  constraint imagen_vivienda_pk primary key(num_imagen, vivienda_id),
  constraint imagen_vivienda_vivienda_id_num_imagen_uk unique(num_imagen, vivienda_id)
);

--
-- Definción de la tabla MENSAJE_USUARIO
--
create table mensaje_usuario(
  mensaje_usuario_id number(10,0),
  titulo varchar2(40) not null,
  cuerpo varchar2(500) not null,
  mensaje_leido char(1),
  usuario_id not null,
  vivienda_id not null,
  mensaje_respuesta_id,
  constraint mensaje_usuario_pk primary key(mensaje_usuario_id),
  constraint mensaje_usuario_usuario_id_fk foreign key(usuario_id) references usuario(usuario_id),
  constraint mensaje_usuario_vivienda_id_fk foreign key(vivienda_id) references vivienda(vivienda_id),
  constraint mensaje_usuario_mensaje_respuesta_id_fk foreign key(mensaje_respuesta_id) references mensaje_usuario(mensaje_usuario_id),
  constraint mensaje_usuario_mensaje_leido_chk check(mensaje_leido in ('1','0'))
);

--
-- Definición de la table CONTRATO_RENTA
--
create table contrato_renta(
  contrato_renta_id number(10,0),
  folio varchar2(8) not null,
  doc_firmas blob not null,
  fecha_contrato date default on null sysdate,
  usuario_id not null,
  vivienda_id not null,
  constraint contrato_renta_pk primary key(contrato_renta_id),
  constraint contrato_renta_usuario_id_fk foreign key(usuario_id) references usuario(usuario_id),
  constraint contrato_renta_vivienda_id_fk foreign key(vivienda_id) references vivienda_renta(vivienda_id)
);

--
-- Definición de la tabla NOTIFICACION_USUARIO
--
create table notificacion_usuario(
  notificacion_usuario_id number(10,0),
  num_celular varchar2(10) not null,
  notificacion_enviada char(1) not null,
  usuario_id not null,
  vivienda_id not null,
  constraint notificacion_usuario_pk primary key(notificacion_usuario_id),
  constraint notificacion_usuario_notificacion_enviada_chk check (notificacion_enviada in ('1','0')),
  constraint notificacion_usuario_usuario_id_fk foreign key(usuario_id) references usuario(usuario_id),
  constraint notificacion_usuario_vivienda_id_fk foreign key(vivienda_id) references vivienda_vacacional(vivienda_id)
);
