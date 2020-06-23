--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  22/06/2020
--@Descripción:     Script que simula la generación de pases de abordar. 
set serverouput on;

create or replace procedure sp_genera_pase_abordar (
  p_nombre is varchar2, p_apellido_paterno is varchar2, p_apellido_materno 
  is varchar2, p_fecha_nacimiento is date, p_curp is varchar2, p_id_origen is
  number, p_id_destino is number, p_fecha_hora_salida is number, p_num_vuelo is
  varchar2
) is
begin
  
end;
/
show errors;