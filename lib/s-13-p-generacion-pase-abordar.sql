--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  22/06/2020
--@Descripción:     Script que simula la generación de pases de abordar. 
set serverouput on;

prompt compilando funcion;
start s-15-fx-id-pasajero.sql

create or replace procedure sp_genera_pase_abordar (
  p_nombre is varchar2, p_apellido_paterno is varchar2, p_apellido_materno 
  is varchar2, p_email is varchar2, p_fecha_nacimiento is date, 
  p_curp is varchar2, p_id_origen is number, p_id_destino is number, 
  p_fecha_hora_salida is number, p_num_vuelo is
  varchar2
) is
v_pasajero_presente number;
v_insert_stmt varchar2(500);
v_insert_pase_abordar_stmt varchar2(500);
v_id_pasajero number;
v_folio varchar2(10);
begin
  v_pasajero_presente := fx_checa_pasajero(p_curp);
  if v_pasajero_presente = 0 then
    --insertando al pasajero en la BD en caso de que no exista
    v_insert_stmt := 'insert into pasajero (id_pasajero, nombre, apellido_paterno,
        apellido_materno, email, fecha_nacimiento, curp
      ) values(
        pasajero_seq.nextval, :nombre, :ap_pat, :ap_mat, :email, :fecha_nac,
        :curp
      )';
    execute immediate v_insert_stmt using p_nombre, p_apellido_paterno, 
      p_apellido_materno, p_email, p_fecha_nacimiento, p_curp;
    v_id_pasajero := pasajero_seq.currval;
  elsif v_pasajero_presente = 1 then
    select id_pasajero
    into v_id_pasajero
    from pasajero
    where curp = p_curp;
  end if;
  --insertando en pase de abordar
  v_folio := dbms_random.string('U', 4) || '-' || trunc(dbms_random.value(10000, 99999),0);
  v_insert_pase_abordar_stmt := 'insert into pase_abordar (
      id_pase_abordar, folio, fecha, id_pasajero
    ) values (
      pase_abordar_seq.nextval, :folio, :fecha, :id_pasajero
    )';
  execute immediate v_insert_pase_abordar_stmt using v_folio, sysdate, 
    v_id_pasajero;
  --insertando al usuario en la lista de pasajeros del vuelo indicado
  
end;
/
show errors;