--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 13/04/2024
--@Descripción: Proyecto Global Home - Definición de procedimiento para crear nuevo registro
--                                     de inserción a las tablas USUARIO, VIVIENDA, VIVIENDA_RENTA
--                                     CUENTA_RENTA e IMAGEN_VIVIENDA.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del procedimiento de inserción
--
create or replace procedure insertar_nueva_vivienda_renta_cuenta_renta(p_vivienda_id in number,
  p_pago_mensual in number,p_dia_pago in number,p_clabe in varchar2) is
  v_cuenta_renta_id cuenta_renta.cuenta_renta_id%type;

begin
  v_cuenta_renta_id := cuenta_renta_seq.nextval;

-- Inserción a VIVIENDA_RENTA
  insert into vivienda_renta(vivienda_id,pago_mensual,dia_pago)
  values(p_vivienda_id,p_pago_mensual,p_dia_pago);
-- Inserción a CUENTA_RENTA
  insert into cuenta_renta(cuenta_renta_id,clabe,vivienda_id)
  values(v_cuenta_renta_id,p_clabe,p_vivienda_id);
end;
/