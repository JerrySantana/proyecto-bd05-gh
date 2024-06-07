--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Definición y creación de tablas temporales.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

prompt >> Creando tablas temporales<<

--
-- Creación de tabla RESUMEN_RENTA_TEMP
--
create global temporary table resumen_renta_temp(
  vivienda_id number(10,0) not null,
  capacidad_personas number(3,0) not null,
  direccion varchar2(50) not null,
  pago_mensual number(8,2) not null,
  dia_pago number(2,0) not null
) on commit delete rows;

--
-- Creación de tabla RESUMEN_VENTA_TEMP
--
create global temporary table resumen_venta_temp(
  vivienda_id number(10,0) not null,
  direccion varchar2(50) not null,
  precio_inicial number(12,2),
  precio_venta number(12,2) not null,
  comision  number(10,2) not null,
  cuenta_depositos varchar(18) not null
) on commit delete rows;

--
-- Creación de tabla RESUMEN_ALQUILER_TEMP
--
create global temporary table resumen_alquiler_temp(
  vivienda_id number(10,0) not null,
  direccion varchar2(50) not null,
  costo_por_dia number(7,2) not null,
  fecha_entrada date not null,
  fecha_salida date not null
  ) on commit delete rows;

commit;

prompt >> Listo! <<
disconnect
