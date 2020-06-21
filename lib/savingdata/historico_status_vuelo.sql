set serveroutput on;

create or replace sp_insert_into_historico(
  p_fecha in date, p_id_status in number, p_id_vuelo in number
) is
begin
  execute immediate 'insert into historico_status_vuelo(
      id_historico_status_vuelo, fecha, id_status, id_vuelo
    ) values (
      historico_status_vuelo_seq.nextval,' 
      || p_fecha      || ','
      || p_id_status  || ','
      || p_id_vuelo   || '
    )';
end;


declare
cursor cur_vuelos is
  select * from vuelo;
begin
  for r in cur_vuelos loop
    case
      when r.id_status_vuelo == 3 || r.id_status_vuelo == 4 then
        sp_insert_into_historico(r.fecha_hora_llegada, 2, r.id_vuelo);
        sp_insert_into_historico(r.fecha_hora_llegada, 1, r.id_vuelo);
      when r.id_status_vuelo == 5 then
        sp_insert_into_historico(r.fecha_hora_llegada, 1, r.id_vuelo);
    end case;
  end loop;
end;
/
show errors;