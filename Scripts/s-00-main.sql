--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 13/05/2024
--@Descripción: Proyecto Global Home - Script main

set serveroutput on
start s-01-usuarios.sql

start s-02-entidades.sql

start s-03-tablas-temporales.sql

start s-04-tablas-externas.sql

start s-05-secuencias.sql

start s-06-indices.sql

start s-07-sinonimos.sql

start s-08-vistas.sql

prompt Creando los triggers

start s-11-tr-actualizacion-dueño-vivienda.sql

start s-11-tr-actualizacion-estatus-vivienda.sql

start s-11-tr-actualizacion-mensaje-respuesta.sql

start s-11-tr-consistencia-precio-compra-vivienda-venta.sql

start s-11-tr-verificacion-imagenes-vivienda.sql

start s-11-tr-verificar-estancia-maxima-alquiler.sql

start s-11-tr-actualizacion-vivienda-alquilada.sql

start s-11-tr-actualizacion-vivienda-rentada.sql

prompt Creando los lobs/blobs

start s-17-lob-crea-contrato-renta-blob.sql

start s-17-lob-crea-imagen-vivienda-blob.sql

start s-17-lob-crea-pago-vivienda-blob.sql

start s-17-lob-crea-tipo-servicio-blob.sql

start s-17-lob-crea-vivienda-venta-blob.sql

prompt Creando los procedimientos almacenados

start s-13-p-crear-registro-sms.sql

start s-13-p-insertar-nueva-vivienda-renta-cuenta-renta.sql

prompt Creando las funciones

start s-15-fx-calcular-total-renta.sql

start s-15-fx-calcular-costo-alquiler.sql


show errors;

disconnect;