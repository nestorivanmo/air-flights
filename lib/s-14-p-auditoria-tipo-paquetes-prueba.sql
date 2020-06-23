--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  23/06/2020
--@Descripción:     Prueba para procedimiento que hace auditorías sobre tipos de paquetes.
set serveroutput on;

declare
v_clave_tipo_paquete varchar2(5);
v_fecha_auditoria date;
begin
  v_clave_tipo_paquete := 'ALIM';
  v_fecha_auditoria := to_date('06/2018','MM/YYYY');
  sp_auditoria_tipo_paquete(v_clave_tipo_paquete,v_fecha_auditoria);
end;
/
show errors;