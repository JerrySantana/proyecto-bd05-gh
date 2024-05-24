--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 1/05/2024
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
create or replace trigger consistencia_precio_vivienda_venta
  for insert on pago_vivienda
  compound trigger
    v_precio_inicial vivienda_venta.precio_inicial%type;
    v_pago_acumulado number := 0;
    c_importe_nuevo number := :new.importe;
    c_vivienda_id number := :new.vivienda_id;

  before statement is
    c_cantidad_pagos number;
  begin
        -- Obtener la cantidad de pagos existentes para la vivienda
    select count(*)
    into c_cantidad_pagos
    from pago_vivienda
    where vivienda_id = c_vivienda_id;
    
    if c_cantidad_pagos >= 240 then
      raise_application_error(-20002, 'El numero de pago excede la cantidad de pagos permitida (240 máximo).');
    end if;
  end before statement;

  before each row is
  begin
    -- Obtener el precio inicial de la vivienda correspondiente a la vivienda_id de la nueva fila
    select precio_inicial
    into v_precio_inicial
    from vivienda_venta
    where vivienda_id = c_vivienda_id;

    -- Obtener el total acumulado de pagos existentes para la vivienda
    select sum(importe)
    into v_pago_acumulado
    from pago_vivienda
    where vivienda_id = c_vivienda_id;

    -- Incrementar el total acumulado de pagos con el importe del nuevo pago
    v_pago_acumulado := v_pago_acumulado + c_importe_nuevo;

    -- Verificar si el total acumulado de pagos excede el precio inicial de la vivienda
    if v_pago_acumulado > v_precio_inicial then
      raise_application_error(-20001, 'El importe del pago excede el precio inicial de la vivienda.');
    end if;
  end before each row;

end consistencia_precio_vivienda_venta;
/
show errors;

commit;