--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  22/06/2020
--@Descripción:     Prueba de la función para determinar si un vuelo existe.
set serveroutput on;

declare 
v_id_aeropuerto_origen number; 
v_id_aeropuerto_destino number;
v_fecha_hora_salida date;
v_numero_vuelo varchar2(8);
v_id_vuelo number;
e_nonexistent_flight exception;
pragma
exception_init(e_nonexistent_flight, -20004);
begin
  dbms_output.put_line('comenzando prueba 1');
  v_id_aeropuerto_origen := 996;
  v_id_aeropuerto_destino := 592;
  v_fecha_hora_salida := to_date('2016/11/28 04:11:51', 'YYYY/MM/DD HH24:MI:SS');
  v_numero_vuelo := 'ZH-9471';
  v_id_vuelo := fx_checa_vuelo(v_id_aeropuerto_origen, v_id_aeropuerto_destino,
  v_fecha_hora_salida, v_numero_vuelo);
  if v_id_vuelo = 1 then 
    dbms_output.put_line('Prueba válida');
  else
    dbms_output.put_line('Prueba fallida, id_vuelo incorrecto' || v_id_vuelo);
  end if;
exception
  when e_nonexistent_flight then
    dbms_output.put_line('Prueba fallida, no debería lanzar excepción'|| v_id_vuelo);
  raise;
end;
/
show errors;


declare 
v_id_aeropuerto_origen number; 
v_id_aeropuerto_destino number;
v_fecha_hora_salida date;
v_numero_vuelo varchar2(8);
v_id_vuelo number;
e_nonexistent_flight exception;
pragma
exception_init(e_nonexistent_flight, -20004);
begin
  dbms_output.put_line('comenzando prueba 2');
  v_id_aeropuerto_origen := 10;
  v_id_aeropuerto_destino := 10;
  v_fecha_hora_salida := to_date('2016/10/10 06:08:30', 'YYYY/MM/DD HH24:MI:SS');
  v_numero_vuelo := 'AB-1345';
  v_id_vuelo := fx_checa_vuelo(v_id_aeropuerto_origen, v_id_aeropuerto_destino,
    v_fecha_hora_salida, v_numero_vuelo);
  dbms_output.put_line('Prueba fallida, no debería regresar id_vuelo');
exception
  when e_nonexistent_flight then
    dbms_output.put_line('Prueba válida');
end;
/
show errors;
