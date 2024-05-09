--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 08/05/2024
--@Descripción: Proyecto Global Home - Declaracion del procedimiento CREA_CONTRATO_RENTA_BLOB.

--
-- Conectando como usuario sys
--
conn sys/system as sysdba

--
-- Creación de directory CONTRATO_DIR
--
create or replace directory contrato_dir as '/unam-bd/Proyecto/PDF-Contrato';
grant read, write on directory contrato_dir to gsa_proy_admin;

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creando el procedimiento de lectura blob
--
create or replace procedure crea_contrato_renta_blob(p_contrato_renta_id in number,
  p_folio in varchar2, p_fecha_contrato in date, p_usuario_id in number,p_vivienda_id in number) is

  v_bfile bfile;
  v_src_offset number := 1;
  v_dest_offset number := 1;
  v_dest_blob blob;
  v_src_length number;
  v_dest_length number;
  
  begin
  
  v_bfile := bfilename('CONTRATO_DIR','contrato_renta_'|| to_char(p_vivienda_id) ||'.pdf');
  if dbms_lob.filexists(v_bfile) = 1 and not 
    dbms_lob.isopen(v_bfile) = 1 then
      dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
  else
    raise_application_error(-20001,'El archivo '
      ||' contrato_renta_'|| to_char(p_vivienda_id) ||'.pdf'
      ||' no existe en el directorio COMP_DIR'
      ||' o el archivo está abierto.');
  end if;
  
  insert into contrato_renta(contrato_renta_id,folio,doc_firmas,fecha_contrato,usuario_id,vivienda_id)
    values(p_contrato_renta_id,p_folio,empty_blob(),p_fecha_contrato,p_usuario_id,p_vivienda_id);
  
  select doc_firmas into v_dest_blob
  from contrato_renta
  where contrato_renta_id = p_contrato_renta_id;
  
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