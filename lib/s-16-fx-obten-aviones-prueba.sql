--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  23/06/2020
--@Descripción:     Prueba para función para obtener un cursor de todos los aviones de un tipo determinado.
set serveroutput on;

-- Prueba 1
declare
  cur_aviones sys_refcursor;
  v_es_carga number;
  v_es_comercial number;
  v_counter number;
  v_id_avion number;
  e_invalid_airplane_type exception;
  pragma
  exception_init(e_invalid_airplane_type, -20006);
begin
  v_es_carga := 1;
  v_es_comercial := 0;
  cur_aviones := fx_obtener_cursor_tipo_aviones(v_es_carga, v_es_comercial);
  v_counter := 0;
  loop
  fetch cur_aviones into v_id_avion,v_es_carga,v_es_comercial;
    exit when cur_aviones%notfound;
    if v_es_comercial = 1 and v_es_carga = 0 then
      raise e_invalid_airplane_type;
    end if;
    v_counter := v_counter + 1;
  end loop;
  dbms_output.put_line('Prueba 1 válida: ' || v_counter || ' aviones obtenidos');
exception
  when e_invalid_airplane_type then
    dbms_output.put_line('Prueba 1 inválida: los aviones obtenidos no son del tipo esperado.');
end;
/
show errors;

--Prueba2
declare
  cur_aviones sys_refcursor;
  v_es_carga number;
  v_es_comercial number;
  v_counter number;
  v_id_avion number;
  e_invalid_airplane_type exception;
  pragma
  exception_init(e_invalid_airplane_type, -20006);
begin
  v_es_carga := 0;
  v_es_comercial := 1;
  cur_aviones := fx_obtener_cursor_tipo_aviones(v_es_carga, v_es_comercial);
  v_counter := 0;
  loop
  fetch cur_aviones into v_id_avion,v_es_carga,v_es_comercial;
    exit when cur_aviones%notfound;
    if v_es_carga = 1 and v_es_comercial = 0 then
      raise e_invalid_airplane_type;
    end if;
    v_counter := v_counter + 1;
  end loop;
  dbms_output.put_line('Prueba 2 válida: ' || v_counter || ' aviones obtenidos');
exception
  when e_invalid_airplane_type then
    dbms_output.put_line('Prueba 2 inválida: los aviones obtenidos no son del tipo esperado.');
end;
/
show errors;

--Prueba3
declare
  cur_aviones sys_refcursor;
  v_es_carga number;
  v_es_comercial number;
  v_counter number;
  v_id_avion number;
  e_invalid_airplane_type exception;
  pragma
  exception_init(e_invalid_airplane_type, -20006);
begin
  v_es_carga := 1;
  v_es_comercial := 1;
  cur_aviones := fx_obtener_cursor_tipo_aviones(v_es_carga, v_es_comercial);
  v_counter := 0;
  loop
  fetch cur_aviones into v_id_avion,v_es_carga,v_es_comercial;
    exit when cur_aviones%notfound;
    if v_es_comercial = 0 or v_es_carga = 0 then
      raise e_invalid_airplane_type;
    end if;
    v_counter := v_counter + 1;
  end loop;
  dbms_output.put_line('Prueba 3 válida: ' || v_counter || ' aviones obtenidos');
exception
  when e_invalid_airplane_type then
    dbms_output.put_line('Prueba 3 inválida: los aviones obtenidos no son del tipo esperado.');
end;
/
show errors;