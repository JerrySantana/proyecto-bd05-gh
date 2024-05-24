--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 13/05/2024
--@Descripción: Proyecto Global Home - Declaracion del procedimiento CREA_IMAGEN_VIVIENDA_BLOB.

--
-- Conectando como usuario sys
--
conn sys/system as sysdba

--
-- Creación de directory CONTRATO_DIR
--
create or replace directory img_viv_dir as '/unam-bd/Proyecto/IMG-Vivienda/';
grant read, write on directory img_viv_dir to gsa_proy_admin;

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creando el procedimiento de lectura blob
--
create or replace procedure crea_imagen_vivienda_blob(p_num_imagen in number,
  p_vivienda_id in number) is
  
  v_bfile bfile;
  v_src_offset number := 1;
  v_dest_offset number := 1;
  v_dest_blob blob;
  v_src_length number;
  v_dest_length number;
  
  begin
  
  v_bfile := bfilename('IMG_VIV_DIR','vivienda_'|| to_char(p_vivienda_id) ||'_'|| to_char(p_num_imagen) ||'.png');
  if dbms_lob.fileexists(v_bfile) = 1 and not 
    dbms_lob.isopen(v_bfile) = 1 then
      dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
  else
    raise_application_error(-20001,'El archivo '
      ||' vivienda_'|| to_char(p_vivienda_id) ||'_'|| to_char(p_num_imagen) ||'.png'
      ||' no existe en el directorio IMG_VIV_DIR'
      ||' o el archivo está abierto.');
  end if;
  
  insert into imagen_vivienda(num_imagen,vivienda_id,imagen)
    values(p_num_imagen,p_vivienda_id,empty_blob());
   
  select imagen into v_dest_blob
  from imagen_vivienda
  where num_imagen = p_num_imagen and vivienda_id = p_vivienda_id;
  
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

commit;