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

--
-- Insertando registros a la tabla USUARIO
--
declare
  v_identificador_usuario number;
  v_identificador_vivienda number;
  v_identificador_tipo_servicio_vivienda number;
  v_identificador_tipo_servicio number;
  v_identificador_alquiler number;
  v_identificador_historico_estatus_vivienda number;
  v_identificador_contrato_renta number;
  v_identificador_mensaje_usuario number;
  v_identificador_notificacion_usuario number;
  v_auxiliar_loop number;
begin
  v_decision := 1;
  while v_auxiliar_loop = 1 loop
    v_identificador := usuario_seq.nextval;
    v_auxiliar_loop := 0;
  end loop;
end;
    


























