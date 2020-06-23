--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  22/06/2020
--@Descripción:     Función para determinar si un pasajero existe en la BD.
set serverouput on;

crete or replace function fx_checa_pasajero(
  p_curp in varchar2
) return number is
v_pasajero_presente number;
begin
  v_pasajero_presente := 0;
  select count(*)
  into v_pasajero_presente
  from pasajero
  where curp = v_curp;
  if v_pasajero_presente > 1 then
    raise_application_error(20004, 'Pasajero registrado más de una vez en la base de datos');
  end if;
  return v_pasajero_presente;
end;
/ 
show errors;