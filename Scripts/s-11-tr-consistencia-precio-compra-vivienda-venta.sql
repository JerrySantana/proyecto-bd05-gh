--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 06/06/2024
--@Descripción: Proyecto Global Home - Creación del trigger para verificar el 
--                                valor de precio_inicial en la tabla VIVIENDA_VENTA y el valor
--                                de importe de la tabla PAGO_VIVIENDA coincidan, y que el
--                                el importe no sea mayor. También verifica que el número
--                                de pagos ingresados no exeda el máximo de 240 pagos.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del trigger
--
create or replace trigger consistencia_precio_compra_vivienda_venta
  for insert on pago_vivienda
  compound trigger
    v_precio_venta compra_vivienda.precio_venta%type;
    v_pago_acumulado number := 0;
    
  before each row is
    c_nuevo_importe number;
  begin
    c_nuevo_importe := :new.importe;
  
    select precio_venta
    into v_precio_venta
    from compra_vivienda
    where compra_vivienda_id = :new.compra_vivienda_id;
    
    select sum(importe)
    into v_pago_acumulado
    from pago_vivienda
    where compra_vivienda_id = :new.compra_vivienda_id;
    
    v_pago_acumulado := v_pago_acumulado + c_nuevo_importe;
    
    if v_pago_acumulado > v_precio_venta then
      raise_application_error(-20001,'El importe del pago excede el precio inicial de la vivienda');
    end if;
  end before each row;

  after statement is
    c_cantidad_pagos number;
  begin
        -- Obtener la cantidad de pagos existentes para la vivienda
    select count(*)
    into c_cantidad_pagos
    from pago_vivienda
    where compra_vivienda_id = compra_vivienda_id;
    
    if c_cantidad_pagos > 240 then
      raise_application_error(-20002, 'El numero de pago excede la cantidad de pagos permitida (240 máximo).');
    end if;
    
  end after statement;
end consistencia_precio_compra_vivienda_venta;
/
show errors;

commit;
