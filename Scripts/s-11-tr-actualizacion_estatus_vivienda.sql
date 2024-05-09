--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 1/05/2024
--@Descripción: Proyecto Global Home - Creación del trigger para realizar inserciones en 
--                                HISTORICO_ESTATUS_VIVIENDA a partir de la actualización de
--                                estatus_vivienda en la tabla VIVIENDA.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del trigger
--
create or replace trigger actualizacion_estatus_vivienda
  before update of estatus_vivienda_id on vivienda
  for each row
declare
  v_estatus_vivienda_old number := :old.estatus_vivienda_id;
  v_estatus_vivienda_new number := :new.estatus_vivienda_id;
  v_vivienda number := :new.vivienda_id;
  v_hist_id number;
  v_fecha_cambio date;
begin
  select historico_estatus_vivienda_seq.nextval into v_hist_id from dual;
  select sysdate into v_fecha_cambio from dual;
  
  insert into historico_estatus_vivienda
    (historico_estatus_vivienda_id, fecha_estatus, vivienda_id, estatus_vivienda_id)
    values (v_hist_id, v_fecha_cambio, v_vivienda, v_estatus_vivienda_old);
end;
/
show errors;