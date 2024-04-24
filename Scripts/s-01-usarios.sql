--@Autor(es): Gerardo Gabriel Santana Amezcua
--@Fecha creación: 21/04/2024
--@Descripción: Proyecto Global Home - Creación de usuarios, roles y permisos.

conn sys/system as sysdba

prompt >> Haciendo Limpieza. <<
declare
    cursor cur_usuarios is
        select username from dba_users where username like 'GSA_PROY%';
    cursor cur_roles is
        select role from dba_roles where role like 'GSA_ROL%';
begin
    for r in cur_usuarios loop
        execute immediate 'drop user '||r.username||' cascade';
    end loop;

    for r in cur_roles loop
        execute immediate 'drop role '||r.role;
    end loop;
end;
/

prompt >> Creando usuario admin. <<
create user gsa_proy_admin identified by proy_admin
quota unlimited on users;

prompt >> Creando usuario invitado. <<
create user gsa_proy_invitado identified by proy_guest;

prompt >> Creando roles de usuario y generando permisos. <<
create role gsa_rol_admin;
create role gsa_rol_invitado;

grant create session, create table, create view, create synonym,
  create public synonym, create procedure, create trigger,
  create sequence to gsa_rol_admin;

grant create session to gsa_rol_invitado;

prompt >> Asignando roles a usuarios. <<
grant gsa_rol_admin to gsa_proy_admin;
grant gsa_rol_invitado to gsa_proy_invitado;