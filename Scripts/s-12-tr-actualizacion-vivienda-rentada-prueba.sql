--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 06/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para actualizar el 
--                                     valor de estatus_vivienda_id a RENTADA
--                                     en VIVIENDA a partir de una inserción en
--                                     CONTRATO_RENTA.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando del trigger
--
prompt Información de la vivienda antes de la inserción en CONTRATO_RENTA
select *
from vivienda
where vivienda_id=13;

set serveroutput on
declare
  v_usuario_id number;
  v_vivienda_id number;
  v_contrato_renta_id number;

begin
  v_vivienda_id := 13;
  v_usuario_id := 24;
  v_contrato_renta_id := contrato_renta_seq.currval + 1;

  insert into contrato_renta(contrato_renta_id,folio,
    doc_firmas,usuario_id,vivienda_id)
    values(v_contrato_renta_id,'99836742',
    empty_blob(),v_usuario_id,v_vivienda_id);

  exception
    when others then
    dbms_output.put_line('Ocurrio un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt Información de la vivienda después de la inserción en CONTRATO_RENTA
select *
from vivienda
where vivienda_id=13;

rollback;