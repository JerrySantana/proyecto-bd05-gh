--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 25/04/2024
--@Descripción: Proyecto Global Home - Declaracion del procedimiento CREA_TIPO_SERVICIO_BLOB.

--
-- Conectando como usuario sys
--
conn sys/system as sysdba

--
-- Creación de directory ICON_DIR
--
create or replace directory icon_dir as '/unam-bd/Proyecto/ICONOS';
grant read, write on directory icon_dir to gsa_proy_admin;

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creando el procedimiento de lectura blob
--
create or replace procedure crea_tipo_servicio_blob(p_tipo_servicio_id in number,
  p_descripcion in varchar2, p_nombre in varchar2) is
  
  v_bfile bfile;
  v_src_offset number := 1;
  v_dest_offset number := 1;
  v_dest_blob blob;
  v_src_length number;
  v_dest_length number;
  
  begin
  
    v_bfile := bfilename('ICON_DIR', p_nombre || '.png');
    if dbms_lob.fileexists(v_bfile) = 1 and not
      dbms_lob.isopen(v_bfile) = 1 then
        dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
    else
      raise_application_error(-20001, 'El archivo '
        || lower(p_nombre) || '.png'
        || ' no existe en el directorio ICON_DIR'
        ||' o el archivo esta abierto.');
    end if;
    
    insert into tipo_servicio(tipo_servicio_id,descripcion,icono,nombre)
    values(p_tipo_servicio_id,p_descripcion,empty_blob(),p_nombre);
    
    select icono into v_dest_blob
    from tipo_servicio
    where tipo_servicio_id = p_tipo_servicio_id;
    
    dbms_lob.loadblobfromfile(
      dest_lob => v_dest_blob,
      src_bfile => v_bfile,
      amount => dbms_lob.getlength(v_bfile),
      dest_offset => v_dest_offset,
      src_offset => v_src_offset);
    dbms_lob.close(v_bfile);
    
    v_src_length := dbms_lob.getlength(v_bfile);
    v_dest_length := dbms_lob.getlength(v_dest_blob);
    
    if v_src_length = v_dest_length then
      dbms_output.put_line('Escritura correcta, bytes escritos: '
        || v_src_length);
    else
      raise_application_error(-20002,'Error al escribir datos.\n'
        ||' Se esperaba escribir '||v_src_length
        ||' Pero solo se escribio '||v_dest_length);
    end if;
end;
/
show errors