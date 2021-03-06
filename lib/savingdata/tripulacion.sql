set serveroutput on;
create or replace procedure sp_insert_into_tripulacion(
  p_id_tripulacion in number, p_id_vuelo in number, p_id_empleado in number
) is
v_insert_stmt varchar2(400);
begin
  v_insert_stmt := 'insert into tripulacion values (:1, :2, :3)';
  execute immediate v_insert_stmt using p_id_tripulacion, p_id_vuelo, p_id_empleado;
end;
/
show errors;

create or replace procedure sp_insert_empleado(low in number, high in number,
  id_vuelo in number) is
v_random number;
begin
  v_random := dbms_random.value(low, high);
  sp_insert_into_tripulacion(tripulacion_seq.nextval, id_vuelo, v_random);
end;
/
show errors;

declare
cursor cur_vuelos is
  select * from vuelo;
v_es_carga number;
v_es_comercial number;
v_num_tecs number;
begin
  for r in cur_vuelos loop
    select es_carga, es_comercial
    into v_es_carga, v_es_comercial
    from avion
    where id_avion = r.id_avion;
    v_num_tecs := dbms_random.value(1, 10);
    --piloto
    sp_insert_empleado(32, 181, r.id_vuelo);
    --copiloto
    sp_insert_empleado(182, 481, r.id_vuelo);
    if v_es_carga = 1 and v_es_comercial = 1 then
      --2 copilotos
      sp_insert_empleado(182, 481, r.id_vuelo);
      --jefe sobrecargos
      sp_insert_empleado(982, 1081, r.id_vuelo);
      --3 sobrecargos
      sp_insert_empleado(1082, 2081, r.id_vuelo);
      sp_insert_empleado(1082, 2081, r.id_vuelo);
      sp_insert_empleado(1082, 2081, r.id_vuelo);
      --hasta 10 técnicos
      for c in 1 .. v_num_tecs loop
        sp_insert_empleado(482, 981, r.id_vuelo);
      end loop;
    elsif v_es_carga = 1 and v_es_comercial = 0 then
      --2 copilotos      
      sp_insert_empleado(182, 481, r.id_vuelo);
      --hasta 10 técnicos
      for c in 1 .. v_num_tecs loop
        sp_insert_empleado(482, 981, r.id_vuelo);
      end loop;
    else
      --jefe sobrecargos
      sp_insert_empleado(982, 1081, r.id_vuelo);
      -- 3 sobrecagos
      sp_insert_empleado(1082, 2081, r.id_vuelo);
      sp_insert_empleado(1082, 2081, r.id_vuelo);
      sp_insert_empleado(1082, 2081, r.id_vuelo);
    end if;
  end loop;
end;
/
show errors;