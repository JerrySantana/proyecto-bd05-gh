--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 4/06/2024
--@Descripción: Proyecto Global Home - Prueba del trigger para actualizar el
--                                     valor del campo mensaje_leido cuando
--                                     cuando se inserta a MENSAJE_USUARIO un
--                                     nuevo registro con referencia a un mensaje anterior.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando del trigger
--
prompt Información del mensaje original antes de la inserción.
select *
from mensaje_usuario
where mensaje_usuario_id = 2;

commit;

set serverouput on
declare
  v_mensaje_usuario_id number;
  v_mensaje_respuesta_id number;
  v_usuario_id number;
  v_vivienda_id number;

begin
  dbms_output.put_line('Realizando un insert sobre la tabla MENSAJE_USUARIO.');
  v_mensaje_usuario_id := mensaje_usuario_seq.currval + 1;
  v_mensaje_respuesta_id := 2;
  select usuario_id,vivienda_id
  into v_usuario_id,v_vivienda_id
  from mensaje_usuario
  where mensaje_usuario_id=v_mensaje_respuesta_id;

  dbms_output.put_line('ID del nuevo mensaje_usuario: '||v_mensaje_usuario_id);
  dbms_output.put_line('ID del mensaje al que responde el nuevo mensaje: '||v_mensaje_respuesta_id);
  dbms_output.put_line('Realizando la inserción dentro de MENSAJE_USUARIO.');
  insert into mensaje_usuario(mensaje_usuario_id,
    titulo,cuerpo,usuario_id,vivienda_id,mensaje_respuesta_id)
    values(v_mensaje_usuario_id,'Respuesta al mensaje.',
    'Esto es una prueba, Lorem Ipsum.',v_usuario_id,v_vivienda_id);
  
  exception
    when others then
    dbms_output.put_line('Ocurrió un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt Información del mensaje original desapués de la inserción.
select *
from mensaje_usuario
where mensaje_usuario_id = 2;

rollback;