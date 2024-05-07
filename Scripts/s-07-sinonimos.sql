--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Definición y creación de sinónimos.

--
-- Conectando como admin
--
prompt >> Conectando como usuario admin <<
conn gsa_proy_admin/proy_admin

prompt >> Creando sinónimos públicos <<

--
-- Creación de sinónimo público para la tabla VIVIENDA
--
create or replace public synonym vivienda for gsa_proy_admin.vivienda;

--
-- Creación de sinónimo público para la tabla HISTORICO_ESTATUS_VIVIENDA
--
create or replace public synonym vivienda_renta for gsa_proy_admin.vivienda_renta;

--
-- Creación de sinónimo público para la tabla TIPO_SERVICIO_VIVIENDA
--
create or replace public synonym vivienda_vacacional for gsa_proy_admin.vivienda_vacacional;

--
-- Creación de sinónimo público para la tabla EVALUACION
--
create or replace public synonym vivienda_venta for gsa_proy_admin.vivienda_venta;

--
-- Conectando como usuario sys
--
prompt >> Conectando como usuario sys <<
conn sys/system as sysdba

--
-- Otorgando permiso de creacion de sinónimos privados al usuario invitado
--
prompt >> Otorgando permiso de creación de sinónimos para el usuario invitado <<
grant create synonym to gsa_proy_invitado;

--
-- Conectando como usuario admin
--
prompt >> Conectando como usuario admin <<
conn gsa_proy_admin/proy_admin

--
-- Otorgando permisos de selección para el usuario invitado
--
prompt >> Otorgando permisos de selección para el usuario invitado <<
grant select on mensaje_usuario to gsa_proy_invitado;
grant select on usuario to gsa_proy_invitado;
grant select on evaluacion to gsa_proy_invitado;
grant select on tipo_servicio_vivienda to gsa_proy_invitado;

--
-- Conectando como usuario invitado
--
prompt >> Conectando como usuario invitado <<
conn gsa_proy_invitado/proy_guest

prompt >> Creando sinónimos privados de invitado <<

--
-- Creación de sinónimo privado para tabla MENSAJE_USUARIO
--
create or replace synonym mensaje_usuario for gsa_proy_admin.mensaje_usuario;

--
-- Creación de sinónimo privado para tabla USUARIO
--
create or replace synonym usuario for gsa_proy_admin.usuario;

--
-- Creación de sinónimo privado para tabla EVALUACION
--
create or replace synonym evaluacion for gsa_proy_admin.evaluacion;

--
-- Creacion de sinónimo privado para tabla TIPO_SERVICIO_VIVIENDA
--
create or replace synonym tipo_servicio_vivienda for gsa_proy_admin.tipo_servicio_vivienda;

--
-- Conectando como usuario admin
--
prompt >> Conectando como usuario admin <<
conn gsa_proy_admin/proy_admin

--
-- Creando código PL/SQL para creación de sinónimos privados para cada tabla
--
prompt >> Comenzando
set serveroutput on
declare
  cursor tablas_usuario is select table_name from user_tables;
  prefijo_tabla  varchar2(10) := 'SA';
  nombre_tabla varchar2(80);
begin
  for tabla in tablas_usuario loop
    nombre_tabla := prefijo_tabla || '_' || tabla.table_name;
    
    execute immediate 'create or replace synonym ' || nombre_tabla || ' for ' || tabla.table_name;
    dbms_output.put_line('Sinónimo privado creado para ' || tabla.table_name ||': ' || nombre_tabla || '.');
  end loop;
end;
/

commit;

prompt >> Listo! <<
disconnect