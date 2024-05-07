--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Definición y creación de tablas externas.

--
-- Conectando como usuario sys
--
conn sys/system as sysdba

--
-- Creando directorio para guardar los archivos csv
--
!mkdir -p /unam-bd/Proyecto/ext

--
-- Creación del directory
--
create or replace directory tab_ext_dir as '/unam-bd/Proyecto/ext';
grant read, write on directory tab_ext_dir to gsa_proy_admin;

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

prompt >> Creando tablas externas<<

--
-- Creación de tabla externa MERC_INM_NUEVA_YORK_EXT
--
create table merc_inm_nueva_york_ext(
  tipo_vivienda varchar2(255),
  precio_usd varchar2(255),
  num_cuartos varchar2(255),
  metros_cuadrados varchar2(255),
  direccion varchar2(255),
  latitud varchar2(255),
  longitud varchar2(255)
)
  organization external(
    type oracle_loader
    default directory tab_ext_dir
    access parameters(
      records delimited by newline
      badfile tab_ext_dir:'merc_inm_nueva_york_ext_bad.log'
      logfile tab_ext_dir:'merc_inm_nueva_york_ext.log'
      fields terminated by ','
      lrtrim
      missing field values are null
      (
        tipo_vivienda,precio_usd,num_cuartos,metros_cuadrados,direccion,latitud,longitud
      )
    ) location('NY-House-Dataset.csv')
) reject limit unlimited;

--
-- Creación de tabla externa MERC_INM_CDMX_EXT
--
create table merc_inm_cdmx_ext(
  tipo_vivienda varchar2(255),
  dir_aprox varchar2(255),
  latitud_longitud varchar2(255),
  precio varchar2(255),
  moneda varchar2(255),
  superficie_m2 varchar2(255)
)
  organization external(
    type oracle_loader
    default directory tab_ext_dir
    access parameters(
      records delimited by newline
      badfile tab_ext_dir:'merc_inm_cdmx_ext_bad.log'
      logfile tab_ext_dir:'merc_inm_cdmx_ext.log'
      fields terminated by ','
      lrtrim
      missing field values are null
      (
        tipo_vivienda,dir_aprox,latitud_longitud,precio,moneda,superficie_m2
      )
    ) location('mexico-city-real-estate.csv')
) reject limit unlimited;

--
-- Cambiando permisos
--
!chmod 755 /unam-bd/Proyecto
!chmod 777 /unam-bd/Proyecto/ext

commit;

prompt >> Listo! <<
disconnect
