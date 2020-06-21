set serveroutput on;
declare
cursor cur_aviones_comerciales is
  select v.*
  from vuelo v
  join avion a
  on v.id_avion = a.id_avion
  where a.es_comercial = 1;
v_counter number;
v_presente number;
v_insert_stmt varchar2(1000);
v_num_asiento number;
v_lett_asiento varchar2(1);
begin
  v_counter := 1;
  for r in cur_aviones_comerciales loop
    for c in 1 .. 10 loop
      v_presente := dbms_random.value(0,1);
      v_lett_asiento := dbms_random.string('U', 1);
      v_num_asiento := dbms_random.value(1,10);
      v_insert_stmt := 'insert into lista_pasajeros values(:1, :2, :3, :4, :5, :6)';
      execute immediate v_insert_stmt using lista_pasajeros_seq.nextval,
        r.id_vuelo, v_counter, v_lett_asiento || '-' || v_num_asiento, v_presente,
        'lorem ipsum';
      v_counter := v_counter + 1;
    end loop;
  end loop;
end;
/
show errors;