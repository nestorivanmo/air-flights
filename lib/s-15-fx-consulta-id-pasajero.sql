--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  22/06/2020
--@Descripción:     Función para determinar si un pasajero existe en la BD.
set serveroutput on;

create or replace function fx_checa_pasajero(
  p_curp in varchar2
) return number is
v_pasajero_presente number;
e_registered_passenger exception;
pragma
exception_init(e_registered_passenger, -20005);
begin
  v_pasajero_presente := 0;
  select count(*)
  into v_pasajero_presente
  from pasajero
  where curp = p_curp;
  if v_pasajero_presente > 1 then
    raise e_registered_passenger;
  end if;
  return v_pasajero_presente;
end;
/ 
show errors;