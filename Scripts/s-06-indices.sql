--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Definición y creación de índices.

--
-- Creación del índice TARJETA_CREDITO_USUARIO_ID_IUK
--
create unique index tarjeta_credito_usuario_id_uk on tarjeta_credito(usuario_id);

--
-- Creación del índice VIVIENDA_VIVIENDA_ID_IX
--
create index vivienda_vivienda_id_ix on vivienda(vivienda_id);

--
-- Creación del índice USUARIO_USUARIO_ID_IX
--
create index usuario_usuario_id_ix on usuario(usuario_id);

--
-- Creación del índice VIVIENDA_CAPACIDAD_VIVIENDA_VACACIONAL_IUK
--
create index vivienda_capacidad_vivienda_vacacional_iuk on vivienda(capacidad_personas,es_vacacional);

--
-- Creación del índice PAGO_VIVIENDA_CANTIDAD_DE_PAGOS_IUK
--
create index pago_vivienda_cantidad_de_pagos_iuk on pago_vivienda(vivienda_id,num_pago);

--
-- Creación del índice EVALUACION_CALIFICACION_IUK
--
create index evaluacion_calificacion_ifx on evaluacion(vivienda_id,calificacion);

--
-- Creación del índice HISTORICO_ESTATUS_VIVIENDA_FECHA_ESTATUS_IFX
--
create index historico_estatus_vivienda_fecha_estatus_ifx on historico_estatus_vivienda(to_char(fecha_estatus,'yyyy'));

--
-- Creación del índice CONTRATO_RENTA_FECHA_CONTRATO_IFX
--
create index contrato_renta_fecha_contrato_ifx on contrato_renta(to_char(fecha_contrato,'yyyy'));