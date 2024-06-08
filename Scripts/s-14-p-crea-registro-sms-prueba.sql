--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 07/06/2024
--@Descripción: Proyecto Global Home - Probando procedimiento para notificar a
--                                     usuarios interesados en viviendas sobre su disponibilidad.

--
-- Conectando como admin
--
prompt >> Conectando como admin <<
conn gsa_proy_admin/proy_admin

--
-- Probando procedimiento.
--
set serveroutput on
begin
  dbms_output.put_line('Ejecutando el procedimiento...');
  escribir_registro_sms;
  dbms_output.put_line('El procedimiento se ejecuto sin errores.');
  
  commit;

  exception
    when others then
      dbms_output.put_line('Ocurrio un error: '||sqlerrm);
      rollback;
      raise;
end;
/