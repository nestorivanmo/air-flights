--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Script inicial de la base de datos.

connect sys/system as sysdba;
whenever sqlerror exit;
show errors;

drop user em_proy_invitado cascade;
drop user em_proy_admin cascade;

drop role rol_admin;
drop role rol_invitado;

start s-01-usuarios.sql
connect em_proy_admin/ema;
start s-02-entidades.sql
start s-03-tablas-temporales.sql
start s-05-secuencias.sql
start s-06-indices.sql
start s-08-vistas.sql
start s-07-sinonimos.sql
start s-09-carga-inicial.sql