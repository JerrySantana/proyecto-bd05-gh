--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 06/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para verificar el 
--                                valor de precio_inicial en la tabla VIVIENDA_VENTA y el valor
--                                de importe de la tabla PAGO_VIVIENDA coincidan, y que el
--                                el importe no sea mayor. También verifica que el número
--                                de pagos ingresados no exeda el máximo de 240 pagos.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando del trigger
--
prompt Verificando que las tablas PAGO_VIVIENDA y COMPRA_VIVIENDA no tengan registros relacionados con la vivienda con id 6
select *
from pago_vivienda
  join compra_vivienda cv
  using(compra_vivienda_id)
where cv.vivienda_id = 6;

commit;

declare
  v_importe number;
  v_fecha_pago date;
  v_usuario_id number;
  v_vivienda_id number;
  v_compra_pago_id number;
  v_pago_vivienda_id number;

begin
  v_vivienda_id := 6;
  v_usuario_id := 24;
  v_compra_pago_id := compra_pago_seq.currval + 1;
  v_precio_venta := 480000;
  v_pago_vivienda_id := pago_vivienda_seq.currval;

  select sysdate
  into v_fecha_pago
  from dual;

  insert into compra_pago(compra_pago_id,precio_venta,
    cuenta_depositos,vivienda_id,usuario_id)
    values(v_compra_vivienda_id,v_precio_venta,
    '123456789098765432',v_vivienda_id,v_usuario_id);

  v_importe := v_precio_venta/240;

  for i in 1..241 loop
    insert into pago_vivienda(pago_vivienda_id,num_pago,
      pdf_comprobante,importe,fecha_pago,compra_vivienda_id)
      values(v_pago_vivienda_id + i,
      i,empty_blob(),v_importe,
      v_fecha_pago,v_compra_pago_id);
    
    commit;
  end loop;

  exception
    when others then
    dbms_output.put_line('Ocurrió un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt Verificando que las tablas PAGO_VIVIENDA y COMPRA_VIVIENDA después de la insercion.
select *
from pago_vivienda
  join compra_vivienda cv
  using(compra_vivienda_id)
where cv.vivienda_id = 6;

delete from pago_vivienda
where compra_vivienda_id = compra_vivienda_seq.currval + 1;

delete from compra_vivienda
where compra_vivienda_id = compra_vivienda_seq.currval + 1;

commit;