--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 06/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para actualizar el 
--                                     valor de estatus_vivienda_id a ALQUILADA
--                                     en VIVIENDA a partir de una inserción en ALQUILER.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando del trigger
--
prompt Información de la vivienda antes de la inserción en ALQUILER
select *
from vivienda
where vivienda_id=10;

commit;

set serveroutput on
declare
  v_usuario_id number;
  v_vivienda_id number;
  v_alquiler_id number;
  v_fecha_salida date;
  v_fecha_entrada date;
  v_estatus_actual_id number;
  v_estatus_vivienda_id number;

begin
  v_vivienda_id := 10;
  v_alquiler_id := alquiler_seq.currval + 1;
  v_fecha_entrada := to_date('01/02/2024','dd/mm/yyyy');
  v_fecha_salida := to_date('20/02/2024','dd/mm/yyyy');
  v_usuario_id := 24;
  
  select estatus_vivienda_id
  into v_estatus_actual_id
  from vivienda
  where vivienda_id = v_vivienda_id;

  select estatus_vivienda_id
  into v_estatus_vivienda_id
  from estatus_vivienda
  where clave='ALQUILADA';

  insert into alquiler(alquiler_id,folio,
    fecha_entrada,fecha_salida,vivienda_id,usuario_id)
    values(v_alquiler_id,'75462837'
    v_fecha_entrada,v_fecha_salida,v_vivienda_id,v_usuario_id);
  
  exception
    when others then
    dbms_output.put_line('Ocurrio un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt
prompt Información de la vivienda después de la inserción en ALQUILER
select *
from vivienda
where vivienda_id=10;

rollback;