--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 24/05/2024
--@Descripción: Proyecto Global Home - Creación de función para calcular
--                                     el total de una renta a partir
--                                     del precio de renta por mes y los meses de renta.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del función de calculo de renta.
--
create or replace function fx_calcular_total_renta(
  p_cantidad_meses_renta number,
  p_vivienda_renta_id number
  ) return number is

  v_renta_total number;
  v_pago_mensual vivienda_renta.pago_mensual%type;

begin
  select pago_mensual
    into v_pago_mensual
  from vivienda_renta
  where vivienda_id=p_vivienda_renta_id;

  v_renta_total := p_cantidad_meses_renta * v_pago_mensual;

  return v_renta_total;
  
  exception
    when others then
      dbms_output.put_line('Error al obtener el resultado, revisa los parámetros.');
      raise;
end;
/
show errors;

commit;