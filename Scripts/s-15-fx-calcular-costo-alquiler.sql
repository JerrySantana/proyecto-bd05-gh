--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 24/05/2024
--@Descripción: Proyecto Global Home - Creación de función para calcular
--                                     el total de un alquiler a partir
--                                     del precio de alquiler por día y los días de alquiler.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del función de calculo de alquiler.
--
create or replace function fx_calcular_costo_alquiler(
  p_dias_alquiler number,
  p_vivienda_vacacional_id number
  ) return number is

  v_total_alquiler number;
  v_maximos_dias_alquiler vivienda_vacacional.costo_por_dia%type;
  v_costo_por_dia vivienda_vacacional.costo_por_dia%type;

begin
  select estadia_maxima,costo_por_dia
    into v_maximos_dias_alquiler,
    v_costo_por_dia
  from vivienda_vacacional
  where vivienda_id=p_vivienda_vacacional_id;

  if p_dias_alquiler <= v_maximos_dias_alquiler then
    v_total_alquiler := p_dias_alquiler * v_costo_por_dia;
  else
    dbms_output.put_line('No puede alquilar esta vivienda por más días de los permitidos.');
  end if;

  exception
    when others then
      dbms_output.put_line('Error al obtener el resultado, revisa los parámetros.');


  return v_total_alquiler;
end;
/
show errors;

commit;