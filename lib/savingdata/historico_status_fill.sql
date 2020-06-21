set serveroutput on;
declare
  cursor cur_vuelos is select * from vuelo;
begin
  for r in cur_vuelos loop
    case
      when r.id_status_vuelo = 3 or r.id_status_vuelo = 4 then
        sp_insert_into_historico(r.fecha_hora_llegada, 2, r.id_vuelo);
        sp_insert_into_historico(r.fecha_hora_llegada, 1, r.id_vuelo);
      when r.id_status_vuelo = 5 then
        sp_insert_into_historico(r.fecha_hora_llegada, 1, r.id_vuelo);
    end case;
  end loop;
end;
/
show errors;