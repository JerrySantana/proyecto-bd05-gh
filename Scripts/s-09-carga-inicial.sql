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
prompt Ingresando registros a la tabla ESTATUS_VIVIENDA
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
prompt Ingresando registros a la tabla TIPO_SERVICIO
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

-- Inserción de usuarios y viviendas
set serveroutput on
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
  crea_pago_vivienda_blob(v_pago_vivienda_id,1,1597863.81,sysdate,v_vivienda_id);
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,1250.35,25,725.12);

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

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
  crea_pago_vivienda_blob(v_pago_vivienda_id,1,5199951.99,sysdate,v_vivienda_id);
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,58765.25,83,505.25);

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

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
    ap_materno,email,contraseña)
    values(v_usuario_id,'litario12','Juanito','Anonimo',
    'Solito','juananlito@mail.com','esunacontra12');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'0','1','1',22,'Calle Ficticia 123, Colonia Inventada',
    'Espaciosa villa en la Ciudad de la Imaginación, ideal para grandes grupos o reuniones familiares.',
    34.0522,-118.2437,v_usuario_id,1);
  -- Vivienda_venta
  crea_vivienda_venta_blob(v_vivienda_id,'1lpsG12as98795Fvc0','434546120987654748',7863159.81,v_usuario_id);
  -- Pago_vivienda
  crea_pago_vivienda_blob(v_pago_vivienda_id,1,7863159.81,sysdate,v_vivienda_id);
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,9990.35,33,895.12);

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

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
    ap_materno,email,contraseña)
    values(v_usuario_id,'jSmth_Explrr','John','Smith',
    'Johnson','john.sj@mail.com','explorer2024');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'0','1','1',125,'123 Ocean Avenue, Miami Beach, Florida, EE.UU.',
    'Lujosa mansión frente al mar, perfecta para albergar hasta 125 personas.',25.7906,-80.1300,v_usuario_id,1);
  -- Vivienda_venta
  crea_vivienda_venta_blob(v_vivienda_id,'FvcG12950as9871lps','876543748145464209',55188963.99,v_usuario_id);
  -- Pago_vivienda
  crea_pago_vivienda_blob(v_pago_vivienda_id,1,55188963.99,sysdate,v_vivienda_id);
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,66766.25,62,788.25);

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

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
    values(v_vivienda_id,5679.89,73,492.12);

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

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

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

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
    values(v_usuario_id,'itsLeviousa','Hermione','Granger',
    'Wilkins','hgw.nmbr1@email.com','ImAWitch123');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'1','1','0',13,'456 Sunset Boulevard, L.A., California',
    'Extraordinario complejo de lujo situado en el prestigioso Sunset Boulevard.',
    34.0983,-118.3267,v_usuario_id,1);
  -- Vivienda_renta y cuenta_renta
  insertar_nueva_vivienda_renta_cuenta_renta(v_vivienda_id,566117.12,20,'367349901665344782');
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,8879.89,43,996.12);

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

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
    values(v_usuario_id,'GlcticHro99','Alex','Vega',
    'Starfield','ale.vstar16@email.com','St4arf1eld1234');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'1','1','0',45,'789 Maple Drive, Aspen, Colorado, EE.UU.',
    'Elegante refugio alpino en Aspen, Colorado, perfecto para vacaciones familiares, retiros de grupo o escapadas con amigos.',
    39.1911,-106.8175,v_usuario_id,1);
  -- Vivienda_renta y cuenta_renta
  insertar_nueva_vivienda_renta_cuenta_renta(v_vivienda_id,661179.12,5,'367349901665344782');
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,8798.89,37,129.99);

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

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
    values(v_usuario_id,'CsmcTrvlr12','Luna','Orion',
    'Starbeam','star.orion@email.com','moonOrion123');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'0','1','0',6,'17 Cherry Tree Lane, Londres, Inglaterra.',
    'Casa victoriana de tres pisos, un lugar donde la magia y la comodidad se entrelazan. Con una fachada pintoresca y un jardín trasero encantador.',
    51.5007,-0.1246,v_usuario_id,1);
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,9288.89,20,859.99);

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

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
    values(v_usuario_id,'CybrNnja97','Max','Steel',
    'Phoenix','elementor12@email.com','TechForce12');
  -- Vivienda
  insert into vivienda(vivienda_id,es_renta,es_vacacional,es_venta,
    capacidad_personas,direccion,descripcion,latitud,longitud,
    dueño_id,estatus_vivienda_id)
    values(v_vivienda_id,'0','1','0',89,'34 Oceanview Drive, Malibú, California, EE. UU.',
    'Casa contemporánea de diseño arquitectónico ofrece un lujo sin igual con vistas panorámicas al océano Pacífico y todas las comodidades imaginables.',
    34.0259,-118.7798,v_usuario_id,1);
  -- Vivienda_vacacional
  insert into vivienda_vacacional(vivienda_id,costo_por_dia,
    estadia_maxima,deposito_apartado)
    values(v_vivienda_id,6935.89,52,999.99);

  for i in 1..5 loop
    crea_imagen_vivienda_blob(i,v_vivienda_id);
  end loop;

  commit;

  exception
    when others then
      dbms_output.put_line('Ocurrio un error: '||sqlerrm);
      rollback;
      raise;
end;
/

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  email,contraseña)
  values(usuario_seq.nextval,'wtvahpnhpn','Spike','Spiegel',
  'cwboybbop@mail.com','bang_12345');

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'schmosby12','Ted','Evelyn',
  'Mosby','ur.architect@mail.com','no_after_3_am');

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'markPol12','Marco','Polo',
  'Positivo','mark.positve@mail.com','1plus1_two');

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'imnotzelda','Link','Hyrule',
  'Hero','link123@mail.com','tururutururu');

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  email,contraseña)
  values(usuario_seq.nextval,'rbinSparkles','Robin','Sherbatsky',
  'rbn.sh@email.com','but_umm123');

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'dna123456','Desoxy','Ribonucleic',
  'Acid','dna_master@mail.com','double_helix');

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'jon.snow456','Jon','Snow',
  'Stark','jon.nieves@mail.com','Ghost2023');

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'frodo.bolson16','Frodo','Baggings',
  'Took','bolsonsito1@mail.com','MyPrecious12');

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'walter.blanco99','Walter','White',
  'Lambert','sayMyName@mail.com','ImTheDanger12');

prompt Insertando un nuevo usuario.
insert into usuario(usuario_id,nombre_usuario,nombre,ap_paterno,
  ap_materno,email,contraseña)
  values(usuario_seq.nextval,'deducting_a221b','Sherlock','Holmes',
  'Vernet','baker.street@mail.com','ViolinMoriarty1');

commit;

prompt Insertando a tabla TIPO_SERVICIO_VIVIENDA
set serveroutput on
declare
  v_vivienda_id number;
  v_tipo_servicio_vivienda_id number;

begin
  for i in 1..10 loop
    v_vivienda_id := i;

    for j in 1..6 loop
      v_tipo_servicio_vivienda_id := tipo_servicio_vivienda_seq.nextval;

      insert into tipo_servicio_vivienda(tipo_servicio_vivienda_id,
        vivienda_id,tipo_servicio_id)
      values(v_tipo_servicio_vivienda_id,
        v_vivienda_id,j);
    end loop;
  end loop;
  
  commit;
  
  exception
  when others then
    raise_application_error(-20001,'Ocurrio un error: '||sqlerrm);
    rollback;
    raise;
end;
/

prompt Insertando a tabla ALQUILER
insert into alquiler(alquiler_id,folio,fecha_entrada,
  fecha_salida,vivienda_id,usuario_id)
  values(alquiler_seq.nextval,'78549012',
  to_date('01-01-2010','dd-mm-yyyy'),
  to_date('21-01-2010','dd-mm-yyyy'),
  1,11);
insert into alquiler(alquiler_id,folio,fecha_entrada,
  fecha_salida,vivienda_id,usuario_id)
  values(alquiler_seq.nextval,'02578419',
  to_date('01-02-2010','dd-mm-yyyy'),
  to_date('22-04-2010','dd-mm-yyyy'),
  2,12);
insert into alquiler(alquiler_id,folio,fecha_entrada,
  fecha_salida,vivienda_id,usuario_id)
  values(alquiler_seq.nextval,'12883459',
  to_date('01-03-2010','dd-mm-yyyy'),
  to_date('31-03-2010','dd-mm-yyyy'),
  3,13);
insert into alquiler(alquiler_id,folio,fecha_entrada,
  fecha_salida,vivienda_id,usuario_id)
  values(alquiler_seq.nextval,'12986466',
  to_date('01-04-2010','dd-mm-yyyy'),
  to_date('30-05-2010','dd-mm-yyyy'),
  4,14);
insert into alquiler(alquiler_id,folio,fecha_entrada,
  fecha_salida,vivienda_id,usuario_id)
  values(alquiler_seq.nextval,'02578419',
  to_date('01-05-2010','dd-mm-yyyy'),
  to_date('05-07-2010','dd-mm-yyyy'),
  5,15);

commit;

prompt Insertando a tabla EVALUACION
insert into evaluacion(evaluacion_id,calificacion,descripcion,
  fecha_evaluacion,alquiler_id)
  values(evaluacion_seq.nextval,3,
  'La estancia estuvo muy bien, pero el lugar y los vecinos, dejan mucho qué desear.',
  to_date('28-01-2010','dd-mm-yyyy'),1);
insert into evaluacion(evaluacion_id,calificacion,descripcion,
  fecha_evaluacion,alquiler_id)
  values(evaluacion_seq.nextval,5,
  'La estancia estuvo increible, todo el lugar es maravilloso, pero me perdi en tantos cuartos.',
  to_date('30-04-2010','dd-mm-yyyy'),2);
insert into evaluacion(evaluacion_id,calificacion,descripcion,
  fecha_evaluacion,alquiler_id)
  values(evaluacion_seq.nextval,4,
  'Estuvo fenomenal, casi como un cuento de hadas. Pero todo es como lo imaginaba, no sorprende mucho.',
  to_date('08-04-2010','dd-mm-yyyy'),3);
insert into evaluacion(evaluacion_id,calificacion,descripcion,
  fecha_evaluacion,alquiler_id)
  values(evaluacion_seq.nextval,2,
  'Fatal, el lugar si cuenta vista al mar, pero no hay construccion. Cuando llegamos nos dieron unas casas de campaña y ya. Super horrible.',
  to_date('02-06-2010','dd-mm-yyyy'),4);
insert into evaluacion(evaluacion_id,calificacion,descripcion,
  fecha_evaluacion,alquiler_id)
  values(evaluacion_seq.nextval,1,
  'No soy para nada asqueroso, pero lo que vi en este lugar, no está para nada dentro de los niveles seguros de salubridad.',
  to_date('06-07-2010','dd-mm-yyyy'),5);

commit;

prompt Insertando a tabla MENSAJE_USUARIO
