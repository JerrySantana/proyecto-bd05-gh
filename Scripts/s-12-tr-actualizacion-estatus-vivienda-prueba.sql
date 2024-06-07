--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 4/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para insertar en
--                                     HISTORICO_ESTATUS_VIVIENDA a partir de
--                                     actualizar el valor del campo estatus_vivienda_id 
--                                     de la tabla VIVIENDA.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando del trigger
--
prompt Información dentro del historico sobre la vivienda 8 antes del update.
select * from
historico_estatus_vivienda
where vivienda_id=8;

prompt Estatus de la vivienda con id 8 antes del update.
select estatus_vivienda_id
from vivienda
where vivienda_id=8;

commit;

set serveroutput on
declare
  v_vivienda_id number;
  v_estatus_vivienda_id number;
  v_estatus_vivienda_id_actual number;

begin
  dbms_output.put_line('Realizando un update sobre un registro de la tabla vivienda.');
  v_vivienda_id := 8;
  v_estatus_vivienda_id := 6;
  select estatus_vivienda_id
  into v_estatus_vivienda_id_actual
  from vivienda
  where vivienda_id = v_vivienda_id;

  dbms_output.put_line('ID de la vivienda: '||v_vivienda_id);
  dbms_output.put_line('ID del nuevo estatus de la vivienda: '||v_estatus_vivienda_id);
  dbms_output.put_line('ID del estatus actual de la vivienda: '||v_estatus_vivienda_id_actual);
  dbms_output.put_line('Realizando el update sobre el registro con id '||v_vivienda_id||' de la tabla VIVIENDA');
  update vivienda set
    estatus_vivienda_id = v_estatus_vivienda_id
  where vivienda_id = v_vivienda_id;

  exception
  when others then
    dbms_output.put_line('Ocurrio un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt Información dentro del historico sobre la vivienda 8 después del update.
select * from
historico_estatus_vivienda
where vivienda_id=8;

prompt Estatus de la vivienda con id 8 después del update.
select estatus_vivienda_id
from vivienda
where vivienda_id=8;

rollback;