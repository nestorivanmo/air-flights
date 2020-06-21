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
v_comentarios varchar2(100);
v_poner_comentarios number;
v_asiento varchar2(5);
begin
  v_counter := 1;
  for r in cur_aviones_comerciales loop
    for c in 1 .. 10 loop
      v_presente := dbms_random.value(0,1);
      v_lett_asiento := dbms_random.string('U', 1);
      v_num_asiento := trunc(dbms_random.value(1,10), 0);
      v_asiento := v_lett_asiento || '-' || v_num_asiento;
      v_poner_comentarios := dbms_random.value(0,1);
      if v_poner_comentarios = 1 then
        v_comentarios := 'lorem impsum';
      else
        v_comentarios := ' ';
      end if;
      v_insert_stmt := 'insert into lista_pasajeros (id_lista_pasajeros,
        id_vuelo, id_pase_abordar, asiento, pasajero_presente, atencion_especial
      )
      values(
        lista_pasajeros_seq.nextval, :id_vuelo, :id_pase_abordar, :num_asiento,
        :pasajero_presente, :comentarios_adicionales
      )';
      execute immediate v_insert_stmt using r.id_vuelo, v_counter, v_asiento,
        v_presente, v_comentarios;
      v_counter := v_counter + 1;
    end loop;
  end loop;
end;
/
show errors;