--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  23/06/2020
--@Descripción:     Función para obtener un cursor de todos los aviones de un tipo determinado.
set serveroutput on;
create or replace function fx_obtener_cursor_tipo_aviones(
  p_es_carga in number, p_es_comercial in number
) return sys_refcursor is
  v_cursor_aviones sys_refcursor;
begin
  open v_cursor_aviones for
    'select * from avion where es_carga = ' || es_carga || ' and es_comercial = ' || es_comercial;
  return v_cursor_aviones;
end;
/ 
show errors;