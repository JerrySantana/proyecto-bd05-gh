--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Cargando registros a cada tabla.

--
-- Conectando como usuario sys
--
conn sys/system as sysdba

--
-- Creación del directory
--
create or replace directory csv_dir as '/unam-bd/Proyecto/Datos-CSV';
grant read, write on directory csv_dir to gsa_proy_admin;

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Insertando registros a la tabla ESTATUS_VIVIENDA.
--
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(1,'DISPONIBLE','Vivienda disponible.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(2,'EN RENTA','Vivienda rentada.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(3,'ALQUILADA','Vivienda alquilada.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(4,'EN VENTA','Vivienda en venta.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(5,'VENDIDA','Vivienda vendida.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(6,'INACTIVA','Vivienda inactiva.');





























