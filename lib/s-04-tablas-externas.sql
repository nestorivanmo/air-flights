--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Escenarios con usos de tablas externas.

whenever sqlerror exit;

---
--- Configuracion previa
---
prompt configurando directorios para tablas externas;

prompt conectando como sys;
connect sys as sysdba;

prompt creando directorio tmp_dir;
create or replace directory tmp_dir as '/tmp/bases/proyecto-final';

prompt asignando permisos a em_proy_admin;
grant read, write on directory to em_proy_admin;

prompt conectando como em_proy_admin;
connect em_proy_admin;
show user;
--
-- External Table: Aeropuerto
--
prompt creando tabla externa aeropuerto;
create table aeropuerto_ext(
    id_aeropuerto   number(10,0),
    clave           varchar2(5),
    nombre          varchar2(50),
    latitud         number(9,7),
    longitud        number(9,7),
    es_activo       number(1,0) 
)
organization external (
    type oracle loader
    default directory tmp_dir
    access parameters(
        records delimited by newline
        badfile tmp_dir:'aeropuerto_ext_bad.log'
        logfile tmp_dir:'aeropuerto_ext.log'
        fields terminated by ','
        lrtrim
        missing field values are null(
            id_aeropuerto, clave, nombre, latitud, longitud, es_activo
        )
    )
    location ('aeropuerto_ext.csv')
)
reject limit unlimited;

--
-- Configuracion para prueba de lectura e inserción
---
prompt creando el directorio /tmp/bases/proyecto-final en caso de no existir;
!mkdir -p /tmp/bases/proyecto-final

prompt cambiando permisos de ejecucion;
!chmod 777 /tmp/bases/proyecto-final

prompt copiando el archivo aeropuerto_ext.csv a /tmp/bases/proyecto-final;
!cp aeropuerto_ext.csv /tmp/bases/proyecto-final

prompt mostrando datos de aeropuerto_ext;
col nombre format a20;
select * from aeropuerto_ext;