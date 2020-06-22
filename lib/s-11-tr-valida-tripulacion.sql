--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Trigger para validar la cantidad de tripulantes.
set serveroutput on;

create or replace function fn_obtener_clave_puesto_asignado(
  p_id_empleado in number 
)
return varchar2 is
v_clave varchar2(5);
begin
  select pa.clave
  into v_clave
  from puesto_asignado pa
  join empleado e
  on e.id_puesto_asignado = pa.id_puesto_asignado
  where e.id_empleado = p_id_empleado;
  return v_clave;
end;
/
show errors;

create or replace function fn_contar_puestos(
  p_clave in varchar2,
  p_id_vuelo in number
)
return number is 
v_cantidad number;
begin
  select count(*)
  into v_cantidad
  from tripulacion t
  join empleado e
  on e.id_empleado = t.id_empleado
  join puesto_asignado pa
  on pa.id_puesto_asignado = e.id_puesto_asignado
  where pa.clave = p_clave and t.id_vuelo = p_id_vuelo;
  return v_cantidad;
end;
/
show errors;

create or replace procedure sp_evaluacion(
  p_cantidad_maxima in number, p_cantidad_actual in number, p_clave in varchar2
) is 
begin
  if p_cantidad_actual > p_cantidad_maxima then
    raise_application_error(-20001, 'Excedido el numero de ' || p_clave);
  end if;
end;
/
show errors;

create or replace trigger trg_valida_tripulacion
before insert or update of id_vuelo, id_empleado on tripulacion
declare
v_es_carga number;
v_es_comercial number;
v_clave_puesto varchar2(50);
v_cantidad_tripulantes number;
cursor cur_empleados is
  select * from tripulacion
  where id_vuelo = id_vuelo;
begin
  v_clave_puesto := fn_obtener_clave_puesto_asignado(id_empleado);
  v_cantidad_tripulantes := fn_contar_puestos(v_clave_puesto, id_vuelo);
  v_cantidad_tripulantes := v_cantidad_tripulantes + 1;
  --seleccionando el tipo de vuelo
  select a.es_carga, a.es_comercial
  into v_es_carga, v_es_comercial
  from avion a
  join vuelo v
  on v.id_avion = a.id_avion
  where v.id_vuelo = id_vuelo;
  case
    when v_es_carga = 1 and v_es_comercial = 1 then
      case v_clave_puesto
        when 'PIL' then
          sp_evaluacion(1, v_cantidad_tripulantes, v_clave_puesto);
        when 'COP' then
          sp_evaluacion(2, v_cantidad_tripulantes, v_clave_puesto);
        when 'TEC' then
          sp_evaluacion(10, v_cantidad_tripulantes, v_clave_puesto);
        when 'JEFSOB' then
          sp_evaluacion(1, v_cantidad_tripulantes, v_clave_puesto);
        when 'SOB' then
          sp_evaluacion(3, v_cantidad_tripulantes, v_clave_puesto);
      end case;
    when v_es_carga = 1 and v_es_comercial = 0 then
      case v_clave_puesto
        when 'PIL' then
          sp_evaluacion(1, v_cantidad_tripulantes, v_clave_puesto);
        when 'COP' then
          sp_evaluacion(2, v_cantidad_tripulantes, v_clave_puesto);
        when 'TEC' then
          sp_evaluacion(10, v_cantidad_tripulantes, v_clave_puesto);
        when 'JEFSOB' then
          raise_application_error(-20002, 'No se puede insertar ' || v_clave_puesto || ' en este tipo de vuelo');
        when 'SOB' then
          raise_application_error(-20002, 'No se puede insertar ' || v_clave_puesto || ' en este tipo de vuelo');
      end case;
    when v_es_carga = 0 and v_es_comercial = 1 then
      case v_clave_puesto
        when 'PIL' then
          sp_evaluacion(1, v_cantidad_tripulantes, v_clave_puesto);
        when 'COP' then
          sp_evaluacion(1, v_cantidad_tripulantes, v_clave_puesto);
        when 'TEC' then
          raise_application_error(-20002, 'No se puede insertar ' || v_clave_puesto || ' en este tipo de vuelo');
        when 'JEFSOB' then
          sp_evaluacion(1, v_cantidad_tripulantes, v_clave_puesto);
        when 'SOB' then
          sp_evaluacion(3, v_cantidad_tripulantes, v_clave_puesto);
      end case;
  end case;
end;
/
show errors;