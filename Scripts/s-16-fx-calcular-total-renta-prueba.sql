--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 07/06/2024
--@Descripción: Proyecto Global Home - Probando la función para calcular
--                                     el total de una renta a partir
--                                     del precio de renta por mes y los meses de renta.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando la función
--
set serveroutput on
declare
  v_cantidad_meses number;
  v_vivienda_renta_id number;
  v_renta_total number;

begin
  v_cantidad_meses := 10;
  v_vivienda_renta_id := 12;

  v_renta_total := fx_calcular_total_renta(v_cantidad_meses,v_vivienda_renta_id);

  dbms_output.put_line('El costo de rentar la vivienda en renta con id: '||v_vivienda_renta_id);
  dbms_output.put_line('durante un periodo de: '||v_cantidad_meses||' meses,');
  dbms_output.put_line('sería de: $'||v_renta_total||' pesos.');

  exception
    when others then
      dbms_output.put_line('Ocurrio un error: '||sqlerrm);
      rollback;
      raise;
end;
/