--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Trigger para copiar los datos de la tabla temporal al log de ubicaciones
set serveroutput on;

create or replace trigger tr_ubicaciones_log 
after insert or update or delete on t_ubicacion
for each row
begin
  insert into ubicaciones_log(id_ubicaciones_log, id_vuelo, latitud,
    longitud, fecha_hora)
  values(ubicaciones_log_seq.nextval, :old.id_vuelo, :old.latitud,
    :old.longitud, :old.fecha_hora
  );
end;
/
show errors;