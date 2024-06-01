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

commit;

declare
  v_usuario_id number;
  v_vivienda_id number;
  v_pago_vivienda_id number;

begin
  v_usuario_id := usuario_seq.nextval;
  v_vivienda_id := vivienda_seq.nextval;
  v_pago_vivienda_id := pago_vivienda_seq.nextval;

  dbms_output.put_line('Ingresando registros');
  insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
    email,contraseña)
    values(v_usuario_id,'homerillo1','Homero','Simpson',
    'homer.j.simpson@mail.com','contraseña123');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'0','1','1',5,'Av. Siempre Viva',
    'Hermosa casa con fachada rosa, vecino es entrometirijillo.',
    12.3456,-7.8910,v_usuario_id,1);
  -- Vivienda_venta
  crea_vivienda_venta_blob(v_vivienda_id,'1lpsG1295Fvc0as987','120987654345464748',1597863.81,v_usuario_id);
  -- Pago_vivienda
  -- execute crea_pago_vivienda_blob(v_pago_vivienda_id,1,1597863.81,sysdate,v_vivienda_id);
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,1250.35,25,725.12);

  commit;

  exception
    when others then
      dbms_output.put_line('Ocurrio un error: '||sqlerrm);
      rollback;
      raise;
end;
/

declare
  v_usuario_id number;
  v_vivienda_id number;
  v_pago_vivienda_id number;

begin
  v_usuario_id := usuario_seq.nextval;
  v_vivienda_id := vivienda_seq.nextval;
  v_pago_vivienda_id := pago_vivienda_seq.nextval;

  dbms_output.put_line('Ingresando registros');
  insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
    email,contraseña)
    values(v_usuario_id,'j.doe123','Jane','Doe',
    'j.doe@mail.com','contra1234');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'0','1','1',777,'Londres SW1A 1AA, Reino Unido',
    'Hermosa vivienda ideal para familias grandes.',51.501,-0.142,v_usuario_id,1);
  -- Vivienda_venta
  crea_vivienda_venta_blob(v_vivienda_id,'Fvc0as9871lpsG1295','345464748120987654',5199951.99,v_usuario_id);
-- -- Pago_vivienda
-- execute crea_pago_vivienda_blob(v_pago_vivienda_id,1,5199951.99,sysdate,v_vivienda_id);
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,58765.25,36,505.25);

  commit;

  exception
    when others then
      dbms_output.put_line('Ocurrio un error: '||sqlerrm);
      rollback;
      raise;
end;
/

declare
  v_usuario_id number;
  v_vivienda_id number;

begin
  v_usuario_id := usuario_seq.nextval;
  v_vivienda_id := vivienda_seq.nextval;

  dbms_output.put_line('Ingresando registros');
  insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
    email,contraseña)
    values(v_usuario_id,'barnicle1','Barney','Stinson',
    'whsurddy@email.com','legendaddy1');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'1','1','0',1,'West 55th Street, New York',
    'Lujoso departamento de soltero, amueblado con diferentes amenidades.',
    19.5678,-12.1234,v_usuario_id,1);
  -- Vivienda_renta y cuenta_renta
  insertar_nueva_vivienda_renta_cuenta_renta(v_vivienda_id,85239.16,25,'665344789012367349');
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,5679.89,23,492.12);

  commit;

  exception
    when others then
      dbms_output.put_line('Ocurrio un error: '||sqlerrm);
      rollback;
      raise;
end;
/

declare
  v_usuario_id number;
  v_vivienda_id number;

begin
  v_usuario_id := usuario_seq.nextval;
  v_vivienda_id := vivienda_seq.nextval;

  dbms_output.put_line('Ingresando registros');
  insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
    ap_materno,email,contraseña)
    values(v_usuario_id,'mrWaye12345','Bruce','Thomas',
    'Wayne','imbatman@mail.com','alfred_12345');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_usuario_id,'1','1','0',2,'380 S. San Rafael Drive, Pasadena',
    'Lujosa mansion, ideal para una escapada romántica.',21.567,-12.334,
    v_usuario_id,1);
  -- Vivienda_renta y cuenta_renta
  insertar_nueva_vivienda_renta_cuenta_renta(v_usuario_id,99939.99,12,'012367349665344789');
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_usuario_id,26799.16,65,988.24);

  commit;

  exception
    when others then
      dbms_output.put_line('Ocurrio un error: '||sqlerrm);
      rollback;
      raise;
end;
/


insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  email,contraseña)
  values(usuario_seq.nextval,'wtvahpnhpn','Spike','Spiegel',
  'cwboybbop@mail.com','bang_12345');

insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'schmosby12','Ted','Evelyn',
  'Mosby','ur.architect@mail.com','no_after_3_am');

insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'markPol12','Marco','Polo',
  'Positivo','mark.positve@mail.com','1plus1_two');

insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'imnotzelda','Link','Hyrule',
  'Hero','link123@mail.com','tururutururu');

insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  email,contraseña)
  values(usuario_seq.nextval,'rbinSparkles','Robin','Sherbatsky',
  'rbn.sh@email.com','but_umm123');

insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'dna123456','Desoxy','Ribonucleic',
  'Acid','dna_master@mail.com','double_helix');
