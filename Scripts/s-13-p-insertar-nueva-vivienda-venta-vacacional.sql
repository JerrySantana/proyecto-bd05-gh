--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 13/04/2024
--@Descripción: Proyecto Global Home - Definición de procedimiento para crear nuevo registro
--                                                                                     de inserción a las tablas USUARIO, VIVIENDA, VIVIENDA_VENTA
--                                                                                     PAGO_VIVIENDA e IMAGEN_VIVIENDA.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creación del procedimiento de inserción
--
create or replace procedure insertar_nueva_vivienda_venta_vacacional(p_nombre_usuario in varchar2,
  p_nombre in varchar2,p_ap_paterno in varchar2,p_ap_materno in varchar2,p_email in varchar2,p_contraseña in varchar2,
  p_capacidad_personas  in number,p_direccion in varchar2,p_descripcion in varchar2,p_latitud in number,
  p_longitud in number,p_estatus_vivienda_id in number,p_cantidad_imagenes in number,p_precio_inicial in number,
  p_codigo_catastral in varchar2,p_folio in varchar2,p_costo_por_dia in number,
  p_estadia_maxima in number,p_deposito_apartado in number) is
  v_vivienda_id vivienda.vivienda_id%type;
  v_usuario_id usuario.usuario_id%type;
  v_pago_vivienda_id pago_vivienda.pago_vivienda_id%type;
  v_fecha date;
  
begin
  v_vivienda_id := vivienda_seq.nextval;
  v_usuario_id := usuario_seq.nextval;
  v_pago_vivienda_id := pago_vivienda_seq.nextval;
  v_fecha := sysdate;
  
-- Inserción a USUARIO
  insert into usuario (usuario_id,nombre_usuario,nombre,ap_paterno,
    ap_materno,email,contraseña)
  values (v_usuario_id,p_nombre_usuario,p_nombre,p_ap_paterno,
    p_ap_materno,p_email,p_contraseña);
-- Inserción a VIVIENDA
  insert into vivienda (vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
  values (v_vivienda_id,'0','0','1',p_capacidad_personas,p_direccion,
    p_descripcion,p_latitud,p_longitud,v_usuario_id,p_estatus_vivienda_id);
-- Inserción a VIVIENDA_VENTA
  crea_vivienda_venta_blob(v_vivienda_id, p_codigo_catastral, p_folio, p_precio_inicial, v_usuario_id);
-- Inserción a PAGO_VIVIENDA
  crea_pago_vivienda_blob(v_pago_vivienda_id, 1, p_precio_inicial, v_fecha, v_vivienda_id);
-- Inserción a VIVIENDA_VACACIONAL
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,estadia_maxima,deposito_apartado)
  values(v_vivienda_id,p_costo_por_dia,p_estadia_maxima,p_deposito_apartado);
-- Inserción a IMAGEN_VIVIENDA
  if p_cantidad_imagenes <= 20 then
    for i in 1..p_cantidad_imagenes loop
      crea_imagen_vivienda_blob(i, v_vivienda_id);
    end loop;
  end if;
end;
/
show errors

commit;