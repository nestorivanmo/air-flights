--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Script para la definición de roles. 

whenever sqlerror exit;
prompt conectando como sys;
connect sys as sysdba;

--
-- User: em_proy_admin
--
prompt creando al usuario em_proy_admin;
create user em_proy_admin identified by ema quota unlimited on users;

--
-- User: em_proy_invitado
--
prompt creando al usuario em_proy_invitado;
create user em_proy_invitado identified by emi quota unlimited on users;

--
-- Role: rol_admin: todos los permisos necesarios
--
prompt creando rol rol_admin;
create role rol_admin;
grant create session, create table, create view, create synonym, create public 
    synonym, create procedure, create trigger,  create sequence
to rol_admin;

--
-- Role: rol_invitado: solo permiso para crear sesiones
--
prompt creando rol rol_invitado;
create role rol_invitado;
grant create session, create synonym to rol_invitado;

--
-- Asignación de roles
--
prompt asignando roles;
grant rol_admin to em_proy_admin;
grant rol_invitado to em_proy_invitado;