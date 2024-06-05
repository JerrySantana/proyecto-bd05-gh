--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 4/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para actualizar el 
--                                valor de dueño_id en la tabla VIVIENDA a partir del campo
--                                usuario_id de la tabla VIVIENDA_VENTA.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin


-- SI SE DEBE DE CREAR UNA TABLA INTERMEDIA PARA REALIZAR LAS COMPRAS DE VIVIENDAS


--
-- Probando del trigger
--
prompt Información de la vivienda antes de la inserción.
select * from
  vivienda v join vivienda_venta vv
  on v.vivienda_id=vv.vivienda_id
where vv.vivienda_id=5;

set serveroutput on
declare
  v_dueño_id number;
  v_comprador_id number;
  v_vivienda_id number;
begin
  dbms_output.put_line('Realizando una insercion a la tabla Vivienda_venta');
  v_dueño_id := 5;
  v_vivienda_id := 5;
  v_comprador_id := 20;

  dbms_output.put_line('ID de la vivienda a comprar: '||v_vivienda_id);
  dbms_output.put_line('ID del dueño original: '||v_dueño_id);


  dbms_output.put_line('ID del comprador (nuevo dueño): '||v_comprador_id);
  dbms_output.put_line('Realizando la inserción a la tabla VIVIENDA_VENTA');
  insert into vivienda_venta(vivienda_id,
    pdf_avaluo,codigo_catastral,folio,
    precio_inicial,usuario_id)
    values(v_vivienda_id,empty_blob(),
    'MQ345FK8556AA24B7','998256749302298657',
    9983412544.16,v_comprador_id);

  commit;

  exception
  when others then
    dbms_output.put_line('Ocurrio un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt Información de la vivienda después de la inserción.
select * from
  vivienda v join vivienda_venta vv
  on v.vivienda_id=vv.vivienda_id
where vv.vivienda_id=5;