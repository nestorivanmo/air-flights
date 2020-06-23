--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  23/06/2020
--@Descripción:     Procedimiento para hacer auditorías sobre tipos de paquetes.
set serveroutput on;

CREATE OR REPLACE DIRECTORY CTEST AS '/tmp/proyecto-final/auditoria'; 
GRANT READ ON DIRECTORY CTEST TO PUBLIC;

create or replace procedure sp_auditoria_tipo_paquete(
  p_clave_paquete in varchar2,
  p_fecha_auditoria in date
) is
cur_aviones SYS_REFCURSOR;
v_es_carga_cur number;
v_es_comercial_cur number;
v_id_avion_cur number;
--variables de vuelo
v_id_vuelo number;
v_id_aeropuerto_origen number;
v_id_aeropureto_destino number;
v_fecha_hora_salida date;
v_fecha_hora_llegada date;
v_id_status_vuelo number;
v_numero_vuelo varchar2(8);
v_id_avion number;
v_num_paquetes number;

cursor cur_vuelos is 
   select v.id_vuelo,v.fecha_hora_salida,v.fecha_hora_llegada,sv.descripcion,
   v.id_avion,ao.nombre as aeropuerto_origen, ad.nombre as aeropuerto_destino,
   v.numero_vuelo,count(*) as num_paquetes 
  from vuelo v
  join lista_paquetes lp
  on v.id_vuelo = lp.id_vuelo
  join avion av
  on v.id_avion = av.id_avion
  join paquete pa
  on pa.id_paquete = lp.id_paquete
  join aeropuerto ao
  on v.id_aeropuerto_origen = ao.id_aeropuerto
  join aeropuerto ad
  on v.id_aeropuerto_destino = ad.id_aeropuerto
  join status_vuelo sv
  on sv.id_status_vuelo = v.id_status_vuelo
  where av.es_carga = 1 
  and to_char(v.fecha_hora_salida,'YYYY/MM') = 
  to_char(p_fecha_auditoria,'YYYY/MM') 
  and pa.id_tipo_paquete = (
    select id_tipo_paquete from tipo_paquete where clave = p_clave_paquete
  )
  group by v.id_vuelo,v.fecha_hora_salida,v.fecha_hora_llegada,sv.descripcion,
   v.id_avion,ao.nombre, ad.nombre,v.numero_vuelo
  order by num_paquetes;
--declaración para escritura de archivos
output_file  UTL_FILE.FILE_TYPE; 
begin
  --obteniendo todos los aviones de carga (incluyendo a los híbridos)
  v_es_carga_cur := 1;
  v_es_comercial_cur := 0;
  cur_aviones := fx_obtener_cursor_tipo_aviones(v_es_carga_cur, 
  v_es_comercial_cur);
  --manejo de archivo
  output_file := UTL_FILE.FOPEN('CTEST', 'auditoria_paquete.txt', 'W');
  UTL_FILE.PUT_LINE(output_file, '
    id_vuelo | numero_vuelo | aeropuerto_origen | aeropuerto_destino |
    fecha_salida | status | id_avion | numero paquetes
  ');
  for r in cur_vuelos loop

    dbms_output.put_line(r.id_vuelo ||','|| r.numero_vuelo
    ||','|| r.aeropuerto_origen 
    ||','|| r.aeropuerto_destino
    ||','|| to_char(r.fecha_hora_salida,'YYYY/MM/DD HH24:MI:SS') 
    ||','|| r.descripcion 
    ||','|| r.id_avion  
    ||','||r.num_paquetes);

    UTL_FILE.PUT_LINE(output_file, "test");
  end loop;
  UTL_FILE.CLOSE(output_file);
end;
/
show errors;