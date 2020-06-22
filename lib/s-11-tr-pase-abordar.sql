--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Trigger para validar la hora en la que se inserta un pase de abordar.
set serveroutput on;
create or replace trigger trg_pase_abordar 
before insert or update of id_vuelo, id_pase_abordar on lista_pasajeros
for each row
declare
v_hora_salida vuelo.fecha_hora_salida%type;
v_diferencia number;
begin
  select v.fecha_hora_salida into v_hora_salida
  from vuelo v
  join lista_pasajeros lp
  on lp.id_vuelo = v.id_vuelo
  where v.id_vuelo = :new.id_vuelo;
  v_diferencia := (v_hora_salida - sysdate) * 24 * 60;
  if v_diferencia < 10 then
    raise_application_error(-20003, 'No se puede registar un pase de abordar
      si el vuelo comienza en menos de 10 minutos');
  end if;
end;
/
show errors;