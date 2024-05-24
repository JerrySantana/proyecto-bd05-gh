--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 29/04/2024
--@Descripción: Proyecto Global Home - Cargando registros a cada tabla.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Insertando registros a la tabla ESTATUS_VIVIENDA.
--
prompt 'Ingresando registros a la tabla ESTATUS_VIVIENDA'
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(1,'DISPONIBLE','Vivienda disponible.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(2,'EN RENTA','Vivienda rentada.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(3,'ALQUILADA','Vivienda alquilada.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(4,'EN VENTA','Vivienda en venta.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(5,'VENDIDA','Vivienda vendida.');
insert into estatus_vivienda(estatus_vivienda_id,clave,descripcion)
  values(6,'INACTIVA','Vivienda inactiva.');

--
-- Insertando registros a la tabla TIPO_SERVICIO
--
prompt 'Ingresando registros a la tabla TIPO_SERVICIO'
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Aire acondicionado, frescura en casa.','AC');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Acceso sin esfuerzo.','ASCENSOR');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Vistas magníficas al exterior, para descansar.','BALCON');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Almacenamiento extra.','BODEGA');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Calidez para empocas invernales.','CALEFACCION');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Activa tu cuerpo.','CANCHA-DEPORTIVA');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Tu espacio, garantizado.','ESTACIONAMIENTO');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Tranquilidad asegurada.','GUARDIA');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Activa tu bienestar.','GYM');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Lujo relajante.','JACUZZI');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Naturaleza en tu hogar.','JARDIN');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Diversion en familia.','JUEGO-DE-MESA');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Limpieza al alcance de tu hogar.','LAVANDERIA');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Mascotas bienvenidas.','PET-FRIENDLY');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Refréscate en el verano.','PISCINA');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Bienestar en tu hogar.','SAUNA');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Entretenimiento en un solo lugar.','SMART-TV');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Espacio al aire libre para disfrutar con familia o amigos.','TERRAZA');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Seguridad 24/7.','VIGILANCIA');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Conéctate sin límites.','WiFi');
execute crea_tipo_servicio_blob(tipo_servicio_seq.nextval,'Diversión asegurada para los más pequeños.','ZONA-JUEGOS');

--
-- Insertando registros a las tablas USUARIO , VIVIENDA, VIVIENDA_RENTA, VIVIENDA_VENTA, VIVIENDA_VACACIONAL,
-- CUENTA_RENTA, TARJETA_CREDITO 
--
prompt 'Registrando nueva vivienda venta-vacacional.'
execute insertar_nueva_vivienda_venta_vacacional('homerillo','Homero','Simpson',null,'homer.simp@mail.com','homJsim123',5,'Av. Siempre Viva, Springfield','Hermosa casa con fachada rosa y puerta cafe.',12.3456,-7.8910,1,5,1597863.81,'1lpsG1295Fvc0as987','120987654345464748',1563.25,21,536.99);
prompt 'Registrando nueva vivienda venta-vacacional.'
execute insertar_nueva_vivienda_venta_vacacional('mrCorlone','Michael','Corleone','Puzo','miky.cor@mail.com','offer101',25,'Long Island, Nueva York','Casa muy grande y bella, podría haber cuerpos en las paredes.',19.5678,-12.1234,1,5,127891321.10,'ABC12345678901234','891234567890123456',12324.15,65,6566.10);

prompt 'Registrando nueva vivienda renta-vacacional.'
execute insertar_nueva_vivienda_renta_vacacional('rickyChez','Richard','Sanchez',null,'wubaluba@email.com','dubdub5',5,'Tierra 626','Casa duh',6.1234,-1.1212,1,5,18992.00,25,'012345678901234567',1506.12,10,599.09);
prompt 'Registrando nueva vivienda renta-vacacional.'
execute insertar_nueva_vivienda_renta_vacacional('TheBarnicle','Barney','Stinson',null,'legen.dary@mail.com','waitfor1',1,'Nueva York','Departamento para soltero, con amenidades',12.1234,56.2134,1,5,2380.00,1,'019283746574839201',238.00,1,238.00);

show errors;

disconnect;

