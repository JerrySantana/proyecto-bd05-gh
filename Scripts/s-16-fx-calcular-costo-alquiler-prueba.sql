--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 07/06/2024
--@Descripción: Proyecto Global Home - Probando la función para calcular
--                                     el total de un alquiler a partir
--                                     del precio de alquiler por día y los días de alquiler.

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
  v_dias_alquiler number;
  v_vivienda_vacacional_id number;
  v_total_a_pagar number;

begin
  v_dias_alquiler := 30;
  v_vivienda_vacacional_id := 10;

  v_total_a_pagar := fx_calcular_costo_alquiler(v_dias_alquiler,v_vivienda_vacacional_id);

  dbms_output.put_line('El costo de alquilar la vivienda vacacional con id: '||v_vivienda_vacacional_id);
  dbms_output.put_line('durante un periodo de: '||v_dias_alquiler||' dias,');
  dbms_output.put_line('sería de: $'||v_total_a_pagar||' pesos.');

  commit;

  exception
    when others then
      dbms_output.put_line('Ocurrio un error: '||sqlerrm);
      rollback;
      raise;
end;
/