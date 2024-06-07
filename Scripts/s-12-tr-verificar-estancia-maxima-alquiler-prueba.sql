--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 06/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para verificar que
--                                cada alquiler no sobrepase el tiempo máximo de
--                                estadía en la vivienda_vacacional.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando el funcionamiento del trigger.
--
prompt Verificando la cantidad máxima de estadía para la vivienda con id 1.
select estadia_maxima
from vivienda_vacacional
where vivienda_id = 1;

declare
  v_vivienda_id number;
  v_alquiler_id number;
  v_usuario_id number;
  v_estancia_maxima number;
  v_fecha_entrada date;
  v_fecha_salida date;

begin
  v_vivienda_id := 1;
  v_alquiler_id := alquiler_seq.currval + 1;
  v_usuario_id := 24;

  select estadia_maxima
  into v_estancia_maxima
  from vivienda_vacacional
  where vivienda_id = v_vivienda_id;
  
  select sysdate
  into v_fecha_entrada
  from dual;

  v_fecha_salida := v_fecha_entrada + (v_estancia_maxima + 1);

  dbms_output.put_line('Realizando la inserción a la tabla ALQUILER, con unas estandía mayor a la permitida.');
  insert into alquiler(alquiler_id,folio,
    fecha_entrada,fecha_salida,vivienda_id,usuario_id)
    values(v_alquiler_id,'12345678',
    v_fecha_entrada,v_fecha_salida,v_vivienda_id,v_usuario_id);

  exception
    when others then
    dbms_output.put_line('Ocurrio un error: '||sqlerrm);
    rollback;
    raise;
end;
/