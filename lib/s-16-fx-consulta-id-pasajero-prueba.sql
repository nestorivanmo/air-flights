--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  22/06/2020
--@Descripción:     Prueba para función para determinar si un pasajero existe en la BD.
set serveroutput on;

declare
  v_curp varchar2(18);
  v_pasajero_presente number;
  e_registered_passenger exception;
  pragma
  exception_init(e_registered_passenger, -20005);
begin
  v_curp := 'MARS850904EZ8';
  v_pasajero_presente := fx_checa_pasajero(v_curp);
  if v_pasajero_presente = 0 then
    dbms_output.put_line('Prueba 1 válida');
  elsif v_pasajero_presente = 1 then
    dbms_output.put_line('Prueba 1 inválida: el pasajero ya está registrado');
  end if;
exception
  when e_registered_passenger then
    dbms_output.put_line('Prueba 1 inválida: pasajero registrado más de una vez');
  raise;
end;
/
show errors;

declare
  v_curp varchar2(18);
  v_pasajero_presente number;
  e_registered_passenger exception;
  pragma
  exception_init(e_registered_passenger, -20005);
begin
  v_curp := 'ROPP846918COTHVD95';
  v_pasajero_presente := fx_checa_pasajero(v_curp);
  if v_pasajero_presente = 0 then
    dbms_output.put_line('Prueba 2 inválida: el pasajaero sí existe');
  elsif v_pasajero_presente = 1 then
    dbms_output.put_line('Prueba 2 válida');
  end if;
exception
  when e_registered_passenger then
    dbms_output.put_line('Prueba 2 inválida: pasajero registrado más de una vez');
  raise;
end;
/
show errors;
