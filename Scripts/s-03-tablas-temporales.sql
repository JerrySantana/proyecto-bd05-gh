--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Definición y creación de tablas temporales.

--
-- Creación de tabla RESUMEN_RENTA_TEMP
--
create global temporary table resumen_renta_temp(
  vivienda_id,
  capacidad_personas number(3,0) not null,
  direccion varchar2(50) not null,
  pago_mensual number(8,2) not null,
  dia_pago number(2,0) not null,
  constraint informacion_renta_temp_vivienda_id_fk foreign key(vivienda_id) references vivienda_rent(vivienda_id),
  constraint informacion_renta_temp_pk primary key(vivienda_id)
) on commit delete rows;

--
-- Creación de tabla RESUMEN_VENTA_TEMP
--
create global temporary table resumen_venta_temp(
  vivienda_id,
  direccion varchar2(50) not null,
  precio_inicial number(12,2) not null,
  comision  number(10,2) generated always as (precio_inicial*0.03),
  pdf_avaluo blob not null,
  constraint informacion_renta_temp_vivienda_id_fk foreign key(vivienda_id) references vivienda_venta(vivienda_id),
  constraint informacion_renta_temp_pk primary key(vivienda_id)
) on commit delete rows;

--
-- Creación de tabla RESUMEN_ALQUILER_TEMP
--
create global temporary table resumen_alquiler_temp(
  vivienda_id,
  direccion varchar2(50) not null,
  costo_por_dia number(7,2) not null,
  fecha_entrada date not null,
  fecha_salida date not null,
  constraint informacion_renta_temp_vivienda_id_fk foreign key(vivienda_id) references vivienda_vacacional(vivienda_id),
  constraint informacion_renta_temp_pk primary key(vivienda_id)
  ) on commit delete rows;