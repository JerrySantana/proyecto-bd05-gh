--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 4/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para actualizar el 
--                                     valor de dueño_id en la tabla VIVIENDA a partir del campo
--                                     usuario_id de la tabla COMPRA_VIVIENDA.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando del trigger
--
prompt Información de la vivienda antes de la inserción.
select * from vivienda
where vivienda_id=5;

commit;

set serveroutput on
declare
  v_dueño_id number;
  v_comprador_id number;
  v_vivienda_id number;
begin
  dbms_output.put_line('Realizando una insercion a la tabla compra_vivienda');
  v_dueño_id := 5;
  v_vivienda_id := 5;
  v_comprador_id := 20;

  dbms_output.put_line('ID de la vivienda a comprar: '||v_vivienda_id);
  dbms_output.put_line('ID del dueño original: '||v_dueño_id);
  dbms_output.put_line('ID del comprador (nuevo dueño): '||v_comprador_id);
  dbms_output.put_line('Realizando la inserción a la tabla COMPRA_VIVIENDA');
  insert into compra_vivienda(compra_vivienda_id,
    precio_venta,cuenta_depositos,vivienda_id,usuario_id)
    values(compra_vivienda_seq.nextval,
    9983412544.16,'876459032718394567',
    v_vivienda_id,v_comprador_id);

  exception
  when others then
    dbms_output.put_line('Ocurrio un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt Información de la vivienda después de la inserción.
select * from vivienda
where vivienda_id=5;

rollback;