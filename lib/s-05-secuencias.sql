--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Secuencias necesarias para insertar registros en las tablas. 

whenever sqlerror exit;

--
-- Sequence: avion_seq
--
prompt creando avion_seq; 
create sequence avion_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
nocache
order;

--
-- Sequence: t_ubicacion_seq
--
prompt creando t_ubicacion_seq;
create sequence t_ubicacion_seq
start with 1 
increment by 1
maxvalue 200000
minvalue 1
cycle
cache 30
noorder;

--
-- Sequence: lista_ubicaciones_seq
--
prompt creando lista_ubicaciones_seq;
create sequence lista_ubicaciones_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 30
noorder;

--
-- Sequence historico_status_vuelo_seq
--
prompt creando historico_status_vuelo_seq;
create sequence historico_status_vuelo_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
cache 10
noorder;

--
-- Sequence status_vuelo_seq
--
prompt creando status_vuelo_seq;
create sequence status_vuelo_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
nocache
order;

--
-- Sequence aeropuerto_seq
--
prompt creando aeropuerto_seq;
create sequence aeropuerto_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
nocache
order;

--
-- Sequence lista_paquetes_seq
--
prompt creando lista_paquetes_seq;
create sequence lista_paquetes_seq
start with 1
increment by 1
nomaxvalue
minvalue 1
nocycle
cache 50
noorder;

--
-- Sequence paquete_seq
--
prompt creando paquete_seq;
create sequence paquete_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
nocache
order;

--
-- Sequence tipo_paquete_seq
--
prompt creando tipo_paquete_seq;
create sequence tipo_paquete_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
nocache
order;

--
-- Sequence lista_pasajeros_seq
--
prompt creando lista_pasajeros_seq;
create sequence lista_pasajeros_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
cache 50
noorder;

--
-- Sequence pase_abordar_seq
--
prompt creando pase_abordar_seq;
create sequence pase_abordar_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
cache 10
order;

--
-- Sequence pasajero_seq
--
prompt creando pasajero_seq;
create sequence pasajero_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
cache 10
order;

--
-- Sequence equipaje_seq
--
prompt creando equipaje_seq;
create sequence equipaje_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
cache 10
order;

--
-- Sequence tripulacion_seq
--
prompt creando tripulacion_seq;
create sequence tripulacion_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
cache 50
noorder;

--
-- Sequence empleado_seq
--
prompt creando empleado_seq;
create sequence empleado_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
nocache
order;

--
-- Sequence puesto_asignado_seq
--
prompt creando puesto_asignado_seq;
create sequence puesto_asignado_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
nocache
order;

--
-- Sequence url_trayectoria_seq
--
prompt creando url_trayectoria_seq;
create sequence url_trayectoria_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
nocache
noorder;

--
-- Sequence vuelo_seq
--
prompt creando vuelo_seq;
create sequence vuelo_seq
start with 1
increment by 1 
nomaxvalue
minvalue 1
nocycle
cache 50
order;