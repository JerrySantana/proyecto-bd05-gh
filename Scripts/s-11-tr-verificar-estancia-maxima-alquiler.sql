--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 2/06/2024
--@Descripción: Proyecto Global Home - Creación del trigger para verificar que
--                                cada alquiler no sobrepase el tiempo máximo de
--                                estadía en la vivienda_vacacional.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del trigger para verificar la estadía máxima.
--
create or replace trigger verificacion_estancia_maxima_alquiler
  before insert on alquiler
  for each row
declare
  c_estancia_maxima_vivienda number;
  c_estancia_alquiler number;

begin
  select estadia_maxima
  into c_estancia_maxima_vivienda
  from vivienda_vacacional
  where vivienda_id = :new.vivienda_id;

  c_estancia_alquiler := floor(:new.fecha_salida - :new.fecha_entrada);

  if c_estancia_alquiler > c_estancia_maxima_vivienda then
    raise_application_error(-20002,'No puede rebasar la estancia máxima de esta vivienda. Estancia máxima: '||c_estancia_maxima_vivienda);
  end if;
end;
/
show errors;

commit;