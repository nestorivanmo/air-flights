set serveroutput on;

declare
cursor cur_aviones_comerciales is
  select *
  from vuelo
  where id_avion = (
    select id_avion
    from avion
    where es_comercial = 1
  );
v_counter number;
v_presente number;
v_insert_stmt varchar2;
begin
  v_counter := 1;
  for r in cur_aviones_comerciales loop
    for c in 1 .. 10 loop
      v_presente := dbms_random.value(0,1);
      v_insert_stmt := 'insert into lista_pasajeros(:1, :2, :3, :4, :5, :6)';
      execute immediate v_insert_stmt using lista_pasajeros_seq.nextval,
        r.id_vuelo, v_counter, 'A-23', v_presente, 'lorem ipsum';
      v_counter := v_counter + 1;
    end loop;
  end loop;
end;
/
show errors;