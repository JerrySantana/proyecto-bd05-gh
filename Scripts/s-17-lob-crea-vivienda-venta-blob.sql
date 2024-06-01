--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 7/05/2024
--@Descripción: Proyecto Global Home - Declaracion del procedimiento CREA_VIVIENDA_VENTA_BLOB.

--
-- Conectando como usuario sys
--
conn sys/system as sysdba

--
-- Creación de directory PDF_DIR
--
create or replace directory pdf_dir as '/unam-bd/Proyecto/PDF-Avaluos/';
grant read, write on directory pdf_dir to gsa_proy_admin;

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creando el procedimiento de lectura blob
--
create or replace procedure crea_vivienda_venta_blob(p_vivienda_id in number,
  p_codigo_catastral in varchar2, p_folio in varchar2, p_precio_inicial in number, p_usuario_id in number) is
  
  v_bfile bfile;
  v_src_offset number := 1;
  v_dest_offset number := 1;
  v_dest_blob blob;
  v_src_length number;
  v_dest_length number;

begin
  
  v_bfile := bfilename('PDF_DIR', 'avaluo_'|| to_char(p_vivienda_id) ||'.pdf');
  if dbms_lob.fileexists(v_bfile) = 1 and not dbms_lob.isopen(v_bfile) = 1 then
      dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
  else
    raise_application_error(-20001,'El archivo '||' avaluo_' || to_char(p_vivienda_id) || '.pdf'||' no existe en el directorio PDF_DIR'||' o el archivo está abierto.');
  end if;
  
  insert into vivienda_venta(vivienda_id,pdf_avaluo,codigo_catastral,folio,precio_inicial,usuario_id)
  values(p_vivienda_id,empty_blob(),p_codigo_catastral,p_folio,p_precio_inicial,p_usuario_id);
  
  select pdf_avaluo into v_dest_blob from vivienda_venta where vivienda_id = p_vivienda_id;
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
      dbms_output.put_line('Escritura correcta, bytes escritos: '|| v_src_length);
    else
      raise_application_error(-20002,'Error al escribir datos.\n'||' Se esperaba escribir '||v_src_length||' Pero solo se escribio '||v_dest_length);
    end if;
end;
/
show errors

commit;
