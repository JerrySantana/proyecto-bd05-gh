--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Creación del trigger para acutalizar el 
--                                valor de dueño_id en la tabla VIVIENDA a partir del campo
--                                usuario_id de la tabla VIVIENDA_VENTA.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del trigger
--
create or replace trigger actualizacion_dueño_vivienda
  after insert on vivienda_venta
for each row
declare
  v_usuario_id number := :new.usuario_id;
  v_vivienda_id number := :new.vivienda_id;
  v_dueño_id number;
begin
  select dueño_id into v_dueño_id from vivienda where vivienda_id = v_vivienda_id;
  if v_dueño_id != v_usuario_id then
    update vivienda set dueño_id = v_usuario_id  where
      vivienda_id = v_vivienda_id;
  end if;
end;
/
show errors;