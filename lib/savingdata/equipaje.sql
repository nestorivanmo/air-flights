set serveroutput on;
declare 
cursor cur_vuelos is
  select v.*
  from vuelo v
  join avion a
  on a.id_avion = v.id_avion
  where a.es_comercial = 1;
v_stmt varchar2(400);
v_peso number;
v_counter number;
v_numero number;
begin
  v_stmt := 'insert into equipaje (
    id_equipaje, numero, peso, id_pasajero, id_vuelo
  )
  values(
    equipaje_seq.nextval, :numero, :peso, :id_pasajero, :id_vuelo
  )';
  v_counter := 1;
  v_numero := 1;
  for r in cur_vuelos loop
    for c in 1 .. 10 loop
      v_peso := trunc(dbms_random.value(1, 25),2);
      execute immediate v_stmt using v_numero, v_peso, v_counter, r.id_vuelo;
      v_counter := v_counter + 1;
    end loop;
  end loop;
end;
/
show errors;