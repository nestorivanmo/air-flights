set serveroutput on;

declare 
cursor cur_vuelos is
  select * from vuelo;
v_stmt varchar2(400);
v_peso number;
v_counter number;
begin
  v_stmt := 'insert into equipaje values(:1, :2, :3, :4, :5)';
  v_counter := 1;
  for r in cur_vuelos loop
    for c in 1 .. 10 loop
      v_peso := dbms_random.value(1, 25);
      execute immediate v_stmt using equipaje_seq.nextval, 1, v_peso, v_counter, 
      r.id_vuelo;
      v_counter := v_counter + 1;
    end loop;
  end loop;
end;
/
show errors;