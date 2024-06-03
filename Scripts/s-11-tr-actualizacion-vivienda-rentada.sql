--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 2/06/2024
--@Descripción: Proyecto Global Home - Creación del trigger para actualizar
--                                     el estastus de la vivienda cuando es rentada.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del trigger
--
create or replace trigger actualizar_vivienda_rentada
  for insert on contrato_renta
  compound trigger
    v_vivienda_id number;
  
  before each row is
    v_estatus_vivienda number;
  begin
    v_vivienda_id := :new.vivienda_id;

    select estatus_vivienda_id
    into v_estatus_vivienda
    from vivienda
    where vivienda_id = v_vivienda_id;

    if v_estatus_vivienda != 2 then
      raise_application_error(-20001,'La vivienda no se encuentra disponible para ser rentada.');
    end if;
  end before each row;

  after each row is
    v_estatus_vivienda number;
  begin
    v_vivienda_id := :new.vivienda_id;

    select estatus_vivienda_id
    into v_estatus_vivienda
    from estatus_vivienda
    where clave = 'EN RENTA';

    update vivienda set
    estatus_vivienda_id = v_estatus_vivienda
    where vivienda_id = v_vivienda_id;
  end after each row;
end actualizar_vivienda_rentada;
/
show errors;

commit;