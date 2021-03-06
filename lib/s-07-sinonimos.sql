--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Sinónimos de la base de datos.

whenever sqlerror exit;

--
-- Synonym: EQUIPAJE
--
prompt creando sinónimo para equipaje;
create or replace public synonym equipaje for em_proy_admin.equipaje;

--
-- Synonym: AEROPUERTO
--
prompt creando sinónimo para aeropuerto;
create or replace public synonym aeropuerto for em_proy_admin.aeropuerto;

--
-- Synonym: VUELO
--
prompt creando sinónimo para vuelo;
create or replace public synonym vuelo for em_proy_admin.vuelo;

--
-- System privileges for table reading
--
prompt asignando permiso de lectura a em_proy_invitado para tabla vuelo;
grant select on vuelo to em_proy_invitado;

prompt asignando permiso de lectura a em_proy_invitado para tabla lista_ubicaciones;
grant select on ubicaciones_log to em_proy_invitado;

prompt asignando permiso de lectura a em_proy_invitado para tabla avion;
grant select on avion to em_proy_invitado;

prompt asignando permiso de lectura a em_proy_invitado para tabla aeropuerto;
grant select on aeropuerto to em_proy_invitado;

prompt asignando permiso de lectura a em_proy_invitado para tabla status_vuelo;
grant select on status_vuelo to em_proy_invitado;

prompt asignando permiso de lectura a em_proy_invitado para tabla historico_status_vuelo;
grant select on historico_status_vuelo to em_proy_invitado;

prompt asignando permiso de lectura para vistas v_impresion_pase_abordar y v_impresion_lista_pasajeros;
grant select on v_impresion_lista_pasajeros to em_proy_invitado;
grant select on v_impresion_pase_abordar to em_proy_invitado;
grant select on v_impresion_equipaje to em_proy_invitado;

-----
prompt conectando como usuario em_proy_invitado para crear sinónimos privados;
connect em_proy_invitado/emi;

--
-- Synonym: LISTA_UBICACIONES
--
prompt creando sinónimo privado para el ususario em_proy_invitado sobre tablalista_ubicaciones;
create or replace synonym ubicaciones_log for 
    em_proy_admin.ubicaciones_log;

--
-- Synonym: AVION
--
prompt creando sinónimo privado para el ususario em_proy_invitado sobre tabla avion;
create or replace synonym avion for em_proy_admin.avion;

--
-- Synonym: STATUS_VUELO
--
prompt creando sinónimo privado para el ususario em_proy_invitado sobre tabla status_vuelo;
create or replace synonym status_vuelo for em_proy_admin.status_vuelo;

--
-- Synonym: HISTORICO_STATUS_VUELO
--
prompt creando sinónimo privado para el ususario em_proy_invitado sobre tabla historico_status_vuelo;
create or replace  synonym historico_status_vuelo for
    em_proy_admin.historico_status_vuelo;

prompt creando sinónimo privado para las vistas;
create or replace synonym v_impresion_pase_abordar for
    em_proy_admin.v_impresion_pase_abordar;
create or replace synonym v_impresion_equipaje for
    em_proy_admin.v_impresion_equipaje;
create or replace synonym v_impresion_lista_pasajeros for
    em_proy_admin.v_impresion_lista_pasajeros;

-----
prompt conectando como usuario em_proy_admin para sinónimos privados en prefijos de tablas;
connect em_proy_admin/ema;

prompt ejecutando bloque anónimo para crear sinónimos privados con prefijos;
declare
cursor cur_admin_tables is
    select table_name
    from all_tables
    where owner = 'EM_PROY_ADMIN';
stmt varchar2(200);
begin
    for r in cur_admin_tables loop
        stmt := 'create or replace synonym XX_'
            || r.table_name || ' for em_proy_admin.'
            || r.table_name;
        execute immediate stmt;
    end loop;
end;
/
show errors;