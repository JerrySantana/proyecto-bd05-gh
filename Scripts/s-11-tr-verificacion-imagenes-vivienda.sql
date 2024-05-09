--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 8/05/2024
--@Descripción: Proyecto Global Home - Creación del trigger para verificar que
--                                cada vivienda tenga máximo 20 imagenes.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del trigger para verificar el número máximo de imagenes
--
create or replace trigger verificacion_imagenes_vivienda
  for insert on imagenes_vivienda
  compound trigger
    c_cantidad_imagenes number := 0;
    c_vivienda_id number := :new.vivienda_id;
    
    before statement is
    begin
      select count(*) into c_cantidad_imagenes
      from imagen_vivienda
      where vivienda_id = c_vivienda_id;
      
      if c_cantidad_imagenes = 20 then
        raise_application_error(-20002,'Se ha alcanzado el número máximo de imágenes para esta vivienda');
      end if;
    end before statement;
end verificacion_imagenes_vivienda;
/
show errors;