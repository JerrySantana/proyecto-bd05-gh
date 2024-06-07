--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 06/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para verificar que
--                                cada vivienda tenga máximo 20 imagenes.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando el trigger
--
prompt Verificando la cantidad de imagenes existentes para la vivienda con id 1.
select count(*)
from imagen_vivienda
where vivienda_id = 1;

declare
  v_cantidad_imagenes number;
  v_vivienda_id number;
  v_num_imagen number;

begin
  v_vivienda_id := 1;

  select count(*)
  into v_cantidad_imagenes
  from imagen_vivienda
  where vivienda_id = 1;

  v_num_imagen := v_cantidad_imagenes;

  dbms_output.put_line('Se van a realizar 16 inserciones más en la tabla IMAGEN_VIVIENDA, lo que generará un error al final.');

  for i in 1..16 loop
    insert into imagen_vivienda(num_imagen,
      vivienda_id,imagen)
      values(v_num_imagen + i,
      v_vivienda_id,empty_blob());
    
    commit;
  end loop;

  exception
    when others then
    dbms_output.put_line('Ocurrio un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt Verificando la cantidad de imagenes existentes para la vivienda con id 1
prompt después de las inserciones.
select count(*)
from imagen_vivienda
where vivienda_id = 1;

