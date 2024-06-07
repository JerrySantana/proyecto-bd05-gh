--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 29/04/2024
--@Descripción: Proyecto Global Home - Definición y creación de vistas.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin


prompt >> Creando vistas <<
--
-- Creación de vista V_USUSARIO
--
create or replace view v_usuario(
  usuario_id,nombre,ap_paterno,nombre_usuario,email,num_tarjeta
) as select u.usuario_id,u.nombre,u.ap_paterno,u.nombre_usuario,u.email, substr(t.num_tarjeta,14,4)
from usuario u,tarjeta_credito t
where u.usuario_id=t.usuario_id;

--
-- Creación de vista V_ALQUILER
--
create or replace view v_alquiler(
  alquiler_id,email,fecha_salida,estadia_maxima
) as select alquiler_id,email,fecha_salida,estadia_maxima
from alquiler a,usuario u,vivienda_vacacional v
where (a.usuario_id=u.usuario_id and a.vivienda_id=v.vivienda_id);

--
-- Creación de vista V_CONTRATO_RENTA
--
create or replace view v_contrato_renta(
  contrato_renta_id,email,fecha_contrato,dia_pago
) as select contrato_renta_id,email,fecha_contrato,dia_pago
from contrato_renta c,vivienda_renta r,usuario u
where (c.vivienda_id=r.vivienda_id and c.usuario_id=u.usuario_id);

--
-- Creación de vista V_COMPRA_VIVIENDA
--
create or replace view v_compra_vivienda(
  compra_vivienda_id,precio_inicial,precio_venta,comision,folio,email
) as select compra_vivienda_id,precio_inicial,precio_venta,comision,folio,email
from compra_vivienda cv, vivienda_venta vv, usuario u
  where (cv.vivienda_id = vv.vivienda_id and cv.usuario_id = u.usuario_id);

--
-- Creación de vista V_TIPO_SERVICIO_VIVIENDA
--
create or replace view v_tipo_servicio_vivienda(
  vivienda_id,descripcion,nombre,capacidad_personas
) as select v.vivienda_id,s.nombre,s.descripcion,v.capacidad_personas
from tipo_servicio_vivienda t,vivienda v,tipo_servicio s
where (t.vivienda_id=v.vivienda_id and t.tipo_servicio_id=s.tipo_servicio_id);

commit;

prompt >> Listo! <<
disconnect