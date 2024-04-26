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
-- Conectando como usuario gsa_proy_admin
--
conn gsa_proy_admin/proy_admin

--
-- Creación de tabla externa MERCADO_INMOBILIARIO_NY_EXT
--



--
-- Creación de tabla externa 
--


--
-- Creacion de la tabla externa 
--
