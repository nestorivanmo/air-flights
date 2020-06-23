--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  23/06/2020
--@Descripción:     Procedimiento para hacer auditorías sobre tipos de paquetes.
set serveroutput on;

create or replace procedure sp_auditoria_tipo_paquete(
  p_clave_paquete in varchar2
) is
cursor cur_aviones sys_refcursor;
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
begin
  /*
    id_vuelo | origen | destino | hora_salida | hora_llegada | id_avion | num_paquetes
  */
  --obteniendo todos los aviones de carga (incluyendo a los híbridos)
  v_es_carga_cur := 1;
  v_es_comercial_cur := 0;
  cur_aviones := fx_obtener_cursor_tipo_aviones(v_es_carga_cur, v_es_comercial_cur);
  loop
  fetch cur_aviones into v_id_avion_cur, v_es_carga_cur, v_es_comercial_cur
    exit when cur_aviones%notfound;
    select v.id_vuelo, v.id_aeropuerto_origen, v.id_aeropuerto_destino, v.fecha_hora_salida,
      v.fecha_hora_llegada, v.numero_vuelo, v.id_status_vuelo, v.id_avion, count(*) as
        num_paquetes
    into v_id_vuelo, v_id_aeropuerto_origen, v_id_aeropureto_destino,
      v_fecha_hora_salida, v_fecha_hora_llegada, v_numero_vuelo, v_id_status_vuelo, 
      v_id_avion, v_num_paquetes
    from vuelo v
    where id_avion = v_id_avion_cur
    join lista_paquetes lp
    on lp.id_vuelo = v.id_vuelo
    group by v.id_vuelo, v.id_aeropuerto_origen, v.id_aeropuerto_destino, 
      v.fecha_hora_salida, v.fecha_hora_llegada, v.numero_vuelo, v.id_status_vuelo
      v.id_avion
    having lp.id_paquete = (
      select id_paquete
      from paquete
      where id_tipo_paquete = (
        select id_tipo_paquete
        from tipo_paquete
        where clave = p_clave_paquete
      )
    );
    dbms_output.put_line(v_id_vuelo 
      || '|'
      || v_id_aeropuerto_origen
      || '|'
      || v_id_aeropureto_destino
      || '|'
      || v_fecha_hora_salida
      || '|'
      || v_fecha_hora_llegada
      || '|'
      || v_numero_vuelo
      || '|'
      || v_id_status_vuelo
      || '|'
      || v_id_avion
      || '|'
      || v_num_paquetes
    );
  end loop;
end;
/
show errors;