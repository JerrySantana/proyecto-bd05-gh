--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Definición y creación de secuencias.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

prompt >> Creando secuencias<<

--
-- Secuencia USUARIO_SEQ
--
create sequence usuario_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 10
noorder;

--
--Secuencia  TARJETA_CREDITO_SEQ
--
create sequence tarjeta_credito_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache  5
order;

--
-- Secuencia VIVIENDA_SEQ
--
create sequence vivienda_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 100
noorder;

--
-- Secuencia CUENTA_RENTA_SEQ
--
create sequence cuenta_renta_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 5
order;

--
-- Secuencia PAGO_VIVIENDA_SEQ
--
create sequence pago_vivienda_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 10
order;

--
-- Secuencia ALQUILER_SEQ
--
create sequence alquiler_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 5
order;

--
-- Secuencua EVALUACION_SEQ
--
create sequence evaluacion_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
nocache
noorder;

--
-- Secuencia TIPO_SERVICIO_SEQ
--
create sequence tipo_servicio_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
nocache
noorder;

--
-- Secuencia TIPO_SERVICIO_VIVIENDA_SEQ
--
create sequence tipo_servicio_vivienda_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 15
noorder;

--
-- Secuencia HISTORICO_ESTATUS_VIVIENDA_SEQ
--
create sequence historico_estatus_vivienda_seq
start with 1000
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 10
order;

--
-- Secuencia IMAGEN_VIVIENDA_SEQ
--
create sequence imagen_vivienda_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
nocache
order;

--
-- Secuencia MENSAJE_USUARIO_SEQ
--
create sequence mensaje_usuario_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 5
noorder;

-- Secuencia CONTRATO_RENTA_SEQ
--
create sequence contrato_renta_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 5
order;

--
-- Secuencia NOTIFICACION_USUARIO_SEQ
--
create sequence notificacion_usuario_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
nocache
noorder;

prompt >> Listo! <<
disconnect