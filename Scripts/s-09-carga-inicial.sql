--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Cargando registros a cada tabla.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Insertando registros a la tabla ESTATUS_VIVIENDA.
--
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
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Aire acondicionado, frescura en casa.','AC');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Acceso sin esfuerzo.','ASCENSOR');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Vistas magníficas al exterior, para descansar.','BALCON');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Almacenamiento extra.','BODEGA');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Calidez para empocas invernales.','CALEFACCION');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Activa tu cuerpo.','CANCHA-DEPORTIVA');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Tu espacio, garantizado.','ESTACIONAMIENTO');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Tranquilidad asegurada.','GUARDIA');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Activa tu bienestar.','GYM');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Lujo relajante.','JACUZZI');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Naturaleza en tu hogar.','JARDIN');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Diversion en familia.','JUEGO-DE-MESA');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Limpieza al alcance de tu hogar.','LAVANDERIA');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Mascotas bienvenidas.','PET-FRIENDLY');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Refréscate en el verano.','PISCINA');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Bienestar en tu hogar.','SAUNA');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Entretenimiento en un solo lugar.','SMART-TV');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Espacio al aire libre para disfrutar con familia o amigos.','TERRAZA');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Seguridad 24/7.','VIGILANCIA');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Conéctate sin límites.','WiFi');
variable v_id number exec crea_tipo_servicio_blob(:v_id,'Diversión asegurada para los más pequeños.','ZONA-JUEGOS');

--
-- Insertando registros a las tablas USUARIO , VIVIENDA, VIVIENDA_RENTA, VIVIENDA_VENTA, VIVIENDA_VACACIONAL,
-- CUENTA_RENTA, TARJETA_CREDITO 
--
set serveroutput on
declare
  v_usuario_id usuario.usuario_id%type;
  v_vivienda_id vivienda.vivienda_id%type;
begin
  dbms_output.put_line('Insertando los usuarios dueños de viviendas y sus respectivas viviendas.');
  for i in 1..2 loop
    v_usuario_id := usuario_seq.nextval;
    v_vivienda_id := vivienda_seq.nextval;
    -- Insertando registro a la tabla USUARIO
    insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,ap_materno,email,contraseña)
      values(v_usuario_id,'&nombre_usuario','&nombre','&ap_paterno','&ap_materno','&email','&contraseña');
    -- Insertando registro a la tabla Vivienda
    insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,capacidad_personas,direccion,
      descripcion,latitud,longitud,dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'1','1','0','&capacidad_personas','&direccion',
      '&descripcion','&latitud','&longitud',v_usuario_id,1);
    -- Insertando registro a la tabla VIVIENDA_RENTA
    insert into vivienda_renta(vivienda_id,pago_mensual,dia_pago)
    values(v_vivienda_id,'&pago_mensual','&dia_pago');
    -- Insertando registro a la tabla VIVIENDA_VACACIONAL
    insert into vivienda_vacacional(vivienda_id,costo_por_dia,estadia_maxima,deposito_apartado)
    values(v_vivienda_id,'&costo_por_dia','&estadia_maxima','&deposito_apartado');
    -- Insertando registro a la tabla CUENTA_RENTA
    insert into cuenta_renta(cuenta_renta_id,clabe,vivienda_id)
    values(cuenta_renta_seq.nextval,
      to_char(round(dbms_random.value(100000000000000000,999999999999999999))),
      v_vivienda_id);
  end loop;
  for i in 1..2 loop
    v_usuario_id := usuario_seq.nextval;
    v_vivienda_id := vivienda_seq.nextval;
    -- Insertando registro a la tabla USUARIO
    insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,ap_materno,email,contraseña)
      values(v_usuario_id,'&nombre_usuario','&nombre','&ap_paterno','&ap_materno','&email','&contraseña');
    -- Insertando registro a la tabla VIVIENDA
    insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,capacidad_personas,direccion,
      descripcion,latitud,longitud,dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'0','1','1','&capacidad_personas','&direccion',
      '&descripcion','&latitud','&longitud',v_usuario_id,1);
    -- Insertando registro a la tabla VIVIENDA_VENTA
    crea_vivienda_venta_blob(v_vivienda_id,
      dbms_random.string('x',18),
      to_char(round(dbms_random.value(100000000000000000,999999999999999999))),
      dbms_random.value(10000000,9999999999),
      v_usuario_id, 'avaluo');
  end loop;
  dbms_output.put_line('Insertando usuarios clientes.');
  for i in 1..6 loop
    v_usuario_id := usuario_seq.nextval;
    -- Insertando registro a la tabla USUARIO
    insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,ap_materno,email,contraseña)
      values(v_usuario_id,'&nombre_usuario','&nombre','&ap_paterno','&ap_materno','&email','&contraseña');
    -- Insertando registro a la tabla TARJETA_CREDITO
    insert into tarjeta_credito(tarjeta_id,mes_expiracion,año_expiracion,num_seguridad,num_tarjeta,usuario_id)
    values(tarjeta_credito_seq.nextval,
      to_char(round(dbms_random.value(1,12))),
      to_char(round(dbms_random.value(2024,2054))),
      to_char(round(dbms_random.value(1111,9999))),
      to_char(round(dbms_random.value(100000000000000000,999999999999999999))),
      v_usuario_id);
  end loop;
end;

