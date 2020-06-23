--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  23/06/2020
--@Descripción:     Prueba para procedimiento que hace auditorías sobre tipos de paquetes.
set serveroutput on;

declare
v_clave_tipo_paquete varchar2(5);
begin
  v_clave_tipo_paquete := 'ALIM';
  sp_auditoria_tipo_paquete(v_clave_tipo_paquete);
end;
/
show errors;