--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Prueba pra trigger que copia los datos de la tabla temporal al log de ubicaciones
set serveroutput on;

/*
Casos de prueba:
1. al actualizar en t_ubicacion 
2. al borrar en t_ubicacion 
*/

-- Prueba 1: update
declare
v_query varchar2(500);
v_latitud number := 31.12194021;
v_longitud number := 107.518547;
v_fecha_hora date := to_date('23/06/2020 11:11:11','dd/mm/yyyy HH24:MI:SS');
v_id_vuelo number := 3601;
--
v_counter_old number;
v_counter_new number;
v_diferencia number;
begin
  select count(*)
  into v_counter_old
  from ubicaciones_log
  where id_vuelo = v_id_vuelo;
  v_query := 'update t_ubicacion
    set latitud = :latitud,
    longitud = :longitud,
    fecha_hora = :fecha_hora
    where id_vuelo = :id_vuelo';
  
  execute immediate v_query using v_latitud, v_longitud, v_fecha_hora,v_id_vuelo;
  select count(*)
  into v_counter_new
  from ubicaciones_log
  where id_vuelo = v_id_vuelo;
  v_diferencia := v_counter_new - v_counter_old;
  if v_diferencia = 1 then
    dbms_output.put_line('Prueba 1 válida');
  else
    dbms_output.put_line('Prueba 1 inválida: diferencia: ' || v_diferencia);
  end if;
end;
/
show errors;
rollback;

-- Prueba 2: delete
declare
v_query varchar2(500);
v_latitud number := 31.12194021;
v_longitud number := 107.518547;
v_fecha_hora date := to_date('23/06/2020 11:11:11','dd/mm/yyyy HH24:MI:SS');
v_id_vuelo number := 3601;
--
v_counter_old number;
v_counter_new number;
v_diferencia number;
begin
  select count(*)
  into v_counter_old
  from ubicaciones_log
  where id_vuelo = v_id_vuelo;
  v_query := 'delete from t_ubicacion where id_vuelo = :id_vuelo';
  execute immediate v_query using v_id_vuelo;
  select count(*)
  into v_counter_new
  from ubicaciones_log
  where id_vuelo = v_id_vuelo;
  v_diferencia := v_counter_new - v_counter_old;
  if v_diferencia = 1 then
    dbms_output.put_line('Prueba 2 válida');
  else
    dbms_output.put_line('Prueba 2 inválida: diferencia: ' || v_diferencia);
  end if;
end;
/
show errors;
rollback;

--v_query := 'delete from t_ubicacion where id_vuelo = 3666';