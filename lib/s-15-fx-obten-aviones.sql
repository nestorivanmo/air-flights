--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  23/06/2020
--@Descripción:     Función para obtener un cursor de todos los aviones de un tipo determinado.
set serveroutput on;
create or replace function fx_obtener_cursor_tipo_aviones(
  p_es_carga in number, p_es_comercial in number
) return sys_refcursor is
  v_cursor_aviones sys_refcursor;
begin
  if p_es_carga = 1 and p_es_comercial = 0 then
    open v_cursor_aviones for
    'select id_avion,es_carga,es_comercial from avion where es_carga = 1';
  elsif p_es_carga = 0 and p_es_comercial = 1 then
    open v_cursor_aviones for
    'select id_avion,es_carga,es_comercial from avion where es_comercial = 1';
  else
    open v_cursor_aviones for
    'select id_avion,es_carga,es_comercial from avion where es_carga = 1 and es_comercial = 1';
  end if;
  return v_cursor_aviones;
end;
/ 
show errors;