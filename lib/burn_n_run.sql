connect sys/system as sysdba;
/*
drop user em_proy_invitado cascade;
drop user em_proy_admin cascade;

drop role rol_admin;
drop role rol_invitado;

start s-01-usuarios.sql

start s-02-entidades.sql
*/
connect em_proy_admin/ema;
start s-03-tablas-temporales.sql