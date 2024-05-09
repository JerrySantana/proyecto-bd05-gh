--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 1/05/2024
--@Descripción: Proyecto Global Home - Creación del trigger para acutalizar el 
--                                valor de mensaje_leido en la tabla MENSAJE_USUARIO
--                                a partir del campo mensaje_respuesta_id de la tabla MENSAJE_USUARIO.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del trigger
--
create or replace trigger actualizacion_mensaje_respuesta
  after insert on mensaje_usuario
for each row
declare
  v_mensaje_respuesta_id number;
begin
  if :new.mensaje_respuesta_id is not null then
    v_mensaje_respuesta_id := :new.mensaje_respuesta_id;
  update mensaje_usuario set mensaje_leido = '1' where
     mensaje_usuario_id = v_mensaje_respuesta_id;
  end if;
end;
/
show errors;