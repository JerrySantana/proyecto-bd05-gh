--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 08/05/2024
--@Descripción: Proyecto Global Home - Declaracion del procedimiento CREA_VIVIENDA_VENTA_BLOB.

--
-- Conectando como usuario sys
--
conn sys/system as sysdba

--
-- Creación de directory COMP_DIR
--
create or replace directory comp_dir as '/unam-bd/Proyecto/PDF-Comprobante/';
grant read, write on directory comp_dir to gsa_proy_admin;

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Creando el procedimiento de lectura blob
--
create or replace procedure crea_pago_vivienda_blob(p_pago_vivienda_id in number,
  p_num_pago in number,p_importe in number,p_fecha_pago in date,p_vivienda_id in number) is
  
  v_bfile bfile;
  v_src_offset number := 1;
  v_dest_offset number := 1;
  v_dest_blob blob;
  v_src_length number;
  v_dest_length number;
  
begin
  
  v_bfile := bfilename('COMP_DIR', 'comprobante_vivienda_' ||to_char( p_vivienda_id) ||'.pdf');
  if dbms_lob.fileexists(v_bfile) = 1 then
    if not dbms_lob.isopen(v_bfile) = 1 then
      dbms_lob.open(v_bfile, dbms_lob.lob_readonly);
    end if;
  else
    raise_application_error(-20001, 'El archivo comprobante_vivienda_' || to_char(p_vivienda_id) || '.pdf no existe en el directorio COMP_DIR o el archivo está abierto.');
  end if;
  
  insert into pago_vivienda(pago_vivienda_id, num_pago, pdf_comprobante, importe, fecha_pago, vivienda_id)
  values(p_pago_vivienda_id, p_num_pago, empty_blob(), p_importe, p_fecha_pago, p_vivienda_id)
  returning pdf_comprobante into v_dest_blob;
  
  dbms_lob.loadblobfromfile(
    dest_lob => v_dest_blob,
    src_bfile => v_bfile,
    amount => dbms_lob.getlength(v_bfile),
    dest_offset => v_dest_offset,
    src_offset => v_src_offset
  );
  
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
