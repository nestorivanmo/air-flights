--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  22/06/2020
--@Descripción:     Función para determinar si un vuelo existe.
set serverouput on;

create or replace function fx_checa_vuelo( 
  p_id_aeropuerto_origen in number, p_id_aeropuerto_destino in number,
  p_fecha_hora_salida in date, p_numero_vuelo in varchar2
) return number is
v_num number;
v_id_vuelo number;
begin
  select id_vuelo
  into v_id_vuelo
  from vuelo
  where id_aeropuerto_origen = p_id_aeropuerto_origen
  and id_aeropuerto_destino = p_id_aeropuerto_destino
  and fecha_hora_salida = p_fecha_hora_salida
  and numero_vuelo = p_numero_vuelo;
  return id_vuelo;
exception
  when NO_DATA_FOUND then
    raise_application_error(20004, 'El vuelo no existe para los datos proporcionados');
end;
/ 
show errors;