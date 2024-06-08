--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 7/05/2024
--@Descripción: Proyecto Global Home - Creación de procedimiento para notificar a
--                                     usuarios interesados en viviendas sobre su disponibilidad.

--
-- Conectando como usuarios sys
--
conn sys/system as sysdba

--
-- Creando objeto directory SMS_DIR
--
create or replace directory sms_dir as '/unam-bd/Proyecto/SMS-Usuarios';
grant read, write on directory sms_dir to gsa_proy_admin;

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

prompt >> Creando procedimiento<<
--
-- Creando procedimiento.
--
create or replace procedure escribir_registro_sms is
  vMensaje varchar2(200);
  v_filepath UTL_FILE.FILE_TYPE;
  
  cursor cur_datos_vivienda_notif_usuario is
  select vv.deposito_apartado, vv.vivienda_id, nu.num_celular, u.nombre_usuario 
  from vivienda_vacacional vv, vivienda v, notificacion_usuario nu, usuario u
  where v.estatus_vivienda_id = 1 and nu.vivienda_id = vv.vivienda_id and
    nu.usuario_id = u.usuario_id and nu.notificacion_enviada = '0'
  order by vv.vivienda_id, u.nombre_usuario;
  
  v_vivienda_id vivienda_vacacional.vivienda_id%type;
  v_nombre_usuario usuario.nombre_usuario%type;
  v_num_celular notificacion_usuario.num_celular%type;
  v_depo_apart vivienda_vacacional.deposito_apartado%type;
  
begin
  open cur_datos_vivienda_notif_usuario;
  v_filepath := UTL_FILE.FOPEN('SMS_DIR', 'notificacion-sms.txt', 'a');

  loop
    fetch cur_datos_vivienda_notif_usuario into
      v_depo_apart,v_vivienda_id,v_num_celular,v_vivienda_id;
      
    exit when cur_datos_vivienda_notif_usuario%notfound;
    
    vMensaje := v_nombre_usuario ||', tu vivienda para vacacionar (id : '|| v_vivienda_id ||') se encuentra disponible.'
      ||'Apartala con un depósito de $'|| v_depo_apart ||'. --- Mensaje enviado al número: '|| v_num_celular ||'.';
    
    UTL_FILE.put(v_filepath,vMensaje);
  end loop;
  UTL_FILE.FCLOSE(v_filepath);
end;
/
show errors;

commit;