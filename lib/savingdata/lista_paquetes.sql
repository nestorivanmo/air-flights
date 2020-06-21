set serveroutput on;

create or replace procedure sp_insert_into_lista_paquetes(
  p_id_vuelo in number,
  p_id_paquete in number
) is 
  v_sql_stmt varchar2;
begin
  v_sql_stmt := '
    insert into lista_paquetes(id_lista_paquetes, id_vuelo, id_paquete)
    values(lista_paquetes_seq.nextval, :1, :2)
  ';
  execute immediate v_sql_stmt using p_id_vuelo, p_id_paquete;
end;
/
show errors;

declare
cursor cur_vuelos_carga is
  select v.*
  from vuelo v
  join avion a
  on v.id_avion = a.id_avion
  where a.es_carga = 1;
v_id_paquete paquete.id_paquete%type;
v_counter number;
begin
  v_counter := 1;
  for r in cur_vuelos_carga loop
    for c in 1 .. 3 loop
      sp_insert_into_lista_paquetes(r.id_vuelo, v_counter);
      v_counter := v_counter + 1;
    end loop;
  end loop;
end;
/
show errors;