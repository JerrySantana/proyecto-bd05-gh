--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 06/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para actualizar el 
--                                     valor de estatus_vivienda_id a VENDIDA
--                                     en VIVIENDA a partir de una inserción en
--                                     COMPRA_VIVIENDA.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando del trigger
--
prompt Información de la vivienda antes de la inserción en COMPRA_VIVIENDA
select *
from vivienda
where vivienda_id=6;

set serveroutput on
declare
  v_usuario_id number;
  v_vivienda_id number;
  v_compra_vivienda_id number;

begin
  v_vivienda_id := 6;
  v_compra_vivienda_id := compra_vivienda_seq.currval + 1;
  v_usuario_id := 24;

  insert into compra_vivienda(compra_vivienda_id,
    precio_venta,cuenta_depositos,vivienda_id,usuario_id)
    values(v_compra_vivienda_id,11111.11,
    '123456789098765432',v_vivienda_id,v_usuario_id);
  
  exception
    when others then
    dbms_output.put_line('Ocurrio un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt Información de la vivienda después de la inserción en COMPRA_VIVIENDA
select *
from vivienda
where vivienda_id=6;

rollback;