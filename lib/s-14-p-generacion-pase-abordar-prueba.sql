--@Autor(es):       Hector Espo Rojas, Néstor Martínez Ostoa
--@Fecha creación:  22/06/2020
--@Descripción:     Prueba para el procedimiento que simula la generación de pases de abordar. 
set serveroutput on;

/*
Casos de prueba:
1. Usuario no registrado y vuelo válido
2. Usuario no registrado y vuelo inválido
3. Usuario registrado y vuelo válido
4. Usuario registrado y vuelo inválido
*/
--Prueba1
declare
v_nombre varchar2(50) := 'Marco';
v_apellido_paterno varchar2(50) := 'Romanoff';
v_apellido_materno varchar2(50) := 'Goddard';
v_email varchar2(100) := 'marco_rom@google.com';
v_fecha_nacimiento date := to_date('1977/11/05', 'YYYY/MM/DD');
v_curp varchar2(18) := 'ROGM771105GRXUKI43';
v_id_aeropuerto_origen number := 798;
v_id_aeropuerto_destino number := 796;
v_fecha_hora_salida date := to_date('2016-08-12 19:11:44', 'YYYY/MM/DD HH24:MI:SS');
v_num_vuelo varchar2(8) := 'WOU-7593';
v_atencion_especial varchar2(300) := 'lorem ipsum';
v_nuevo_pasajero_registrado number;
v_id_vuelo number;
v_id_pasajero number;
v_id_pase_abordar number;
v_id_lista_pasajeros number;
begin
  --generando pase de abordar con el procedimiento almacenado
  sp_genera_pase_abordar(v_nombre, v_apellido_paterno, v_apellido_materno,
    v_email, v_fecha_nacimiento, v_curp, v_id_aeropuerto_origen, 
    v_id_aeropuerto_destino, v_fecha_hora_salida, v_num_vuelo, 
    v_atencion_especial);
  --comprobando que se insertó el pasajero
  dbms_output.put_line('TRATANDO DE SELECCIONAR EL ID DEL PASAJERO...');
  select id_pasajero
  into v_id_pasajero
  from pasajero
  where curp = v_curp;
  dbms_output.put_line('SE ENCONTRÓ PASAJERO CON ID: ' || v_id_pasajero || ' Y CURP: ' || v_curp);
  --comprobando que se haya insertado en pase de abordar
  select id_pase_abordar
  into v_id_pase_abordar
  from pase_abordar
  where id_pasajero = v_id_pasajero
  and fecha = (
    select max(fecha)
    from pase_abordar
    where id_pasajero = v_id_pasajero
  );
  dbms_output.put_line('SE ENCONTRÓ PASE DE ABORDAR CON ID: ' || v_id_pase_abordar);
  --comprobando que se haya insertado en lista pasajeros
  v_id_vuelo := fx_checa_vuelo(v_id_aeropuerto_origen, v_id_aeropuerto_destino,
    v_fecha_hora_salida, v_num_vuelo);
  select id_lista_pasajeros
  into v_id_lista_pasajeros
  from lista_pasajeros
  where id_vuelo = v_id_vuelo
  and id_pase_abordar = v_id_pase_abordar;
  dbms_output.put_line('SE ENCONTRÓ LISTA PASAJEROS CON ID: ' || v_id_lista_pasajeros);
  dbms_output.put_line('Prueba 1 válida');
exception
  when NO_DATA_FOUND then
    dbms_output.put_line('Prueba 1 inválida: no se encontró la información deseada.');
  raise;
end;
/
show errors;
rollback;


--Prueba2
declare
v_nombre varchar2(50);
v_apellido_paterno varchar2(50);
v_apellido_materno varchar2(50);
v_email varchar2(100);
v_fecha_nacimiento date;
v_curp varchar2(18);
v_id_aeropuerto_origen number;
v_id_aeropuerto_destino number;
v_fecha_hora_salida date;
v_num_vuelo varchar2(8);
v_atencion_especial varchar2(300);
v_nuevo_pasajero_registrado number;
v_id_vuelo number;
v_id_pasajero number;
v_id_pase_abordar number;
v_id_lista_pasajeros number;

e_nonexistent_flight exception;
pragma
exception_init(e_nonexistent_flight, -20004);

begin
  v_nombre := 'Cordie';
  v_apellido_paterno := 'Lipp';
  v_apellido_materno := 'Gowdridge';
  v_email := 'lipp_cordie90@google.com';
  v_fecha_nacimiento := to_date('1983/11/26', 'YYYY/MM/DD');
  v_curp := 'OBHH979725GRQUJI56';
  --datos del vuelo con id 255
  v_id_aeropuerto_origen := 798;
  v_id_aeropuerto_destino := 796;
  v_fecha_hora_salida := to_date('2023-08-12 19:11:44', 'YYYY/MM/DD HH24:MI:SS'
  );
  v_num_vuelo := 'WOU-7593';
  v_atencion_especial := 'lorem ipsum dolores et al';
  v_id_vuelo := fx_checa_vuelo(v_id_aeropuerto_origen, v_id_aeropuerto_destino,
    v_fecha_hora_salida, v_num_vuelo);
  --generando pase de abordar
  sp_genera_pase_abordar(v_nombre, v_apellido_paterno, v_apellido_materno,
    v_email, v_fecha_nacimiento, v_curp, v_id_aeropuerto_origen, 
    v_id_aeropuerto_destino, v_fecha_hora_salida, v_num_vuelo, 
    v_atencion_especial);
  --comprobando
  select id_pasajero into v_id_pasajero from pasajero where curp = v_curp;
  select id_pase_abordar
  into v_id_pase_abordar
  from pase_abordar
  where id_pasajero = v_id_pasajero
  and fecha = (
    select max(fecha)
    from pase_abordar
    where id_pase_abordar = v_id_pasajero
  );
  select id_lista_pasajeros
  into v_id_lista_pasajeros
  from lista_pasajeros
  where id_vuelo = v_id_vuelo and id_pase_abordar = v_id_pase_abordar;
  dbms_output.put_line('Prueba 2 invalida: no debería hacer inserciones');
exception
  when e_nonexistent_flight then
    dbms_output.put_line('Prueba 2 válida');
end;
/
show errors;
rollback;

--Prueba3
-----  
declare
v_nombre varchar2(50) := 'Cob';
v_apellido_paterno varchar2(50) := 'Keppe';
v_apellido_materno varchar2(50) := 'Goddard';
v_email varchar2(100) := 'cgillimghamr6@netlog.com';
v_fecha_nacimiento date := to_date('1988/10/09', 'YYYY/MM/DD');
v_curp varchar2(18) := 'JSVW056457TSMQXD22';

v_id_aeropuerto_origen number := 798;
v_id_aeropuerto_destino number := 796;
v_fecha_hora_salida date := to_date('2016-08-12 19:11:44', 'YYYY/MM/DD HH24:MI:SS');
v_num_vuelo varchar2(8) := 'WOU-7593';
v_atencion_especial varchar2(300) := 'lorem ipsum';
v_nuevo_pasajero_registrado number;
v_id_vuelo number;
v_id_pasajero number;
v_id_pase_abordar number;
v_id_lista_pasajeros number;
begin
  --generando pase de abordar con el procedimiento almacenado
  sp_genera_pase_abordar(v_nombre, v_apellido_paterno, v_apellido_materno,
    v_email, v_fecha_nacimiento, v_curp, v_id_aeropuerto_origen, 
    v_id_aeropuerto_destino, v_fecha_hora_salida, v_num_vuelo, 
    v_atencion_especial);
  --comprobando que se insertó el pasajero
  dbms_output.put_line('TRATANDO DE SELECCIONAR EL ID DEL PASAJERO...');
  select id_pasajero
  into v_id_pasajero
  from pasajero
  where curp = v_curp;
  dbms_output.put_line('SE ENCONTRÓ PASAJERO CON ID: ' || v_id_pasajero || ' Y CURP: ' || v_curp);
  --comprobando que se haya insertado en pase de abordar
  select id_pase_abordar
  into v_id_pase_abordar
  from pase_abordar
  where id_pasajero = v_id_pasajero
  and fecha = (
    select max(fecha)
    from pase_abordar
    where id_pasajero = v_id_pasajero
  );
  dbms_output.put_line('SE ENCONTRÓ PASE DE ABORDAR CON ID: ' || v_id_pase_abordar);
  --comprobando que se haya insertado en lista pasajeros
  v_id_vuelo := fx_checa_vuelo(v_id_aeropuerto_origen, v_id_aeropuerto_destino,
    v_fecha_hora_salida, v_num_vuelo);
  select id_lista_pasajeros
  into v_id_lista_pasajeros
  from lista_pasajeros
  where id_vuelo = v_id_vuelo
  and id_pase_abordar = v_id_pase_abordar;
  dbms_output.put_line('SE ENCONTRÓ LISTA PASAJEROS CON ID: ' || v_id_lista_pasajeros);
  dbms_output.put_line('Prueba 3 válida');
exception
  when NO_DATA_FOUND then
    dbms_output.put_line('Prueba 3 inválida: no se encontró la información deseada.');
  raise;
end;
/
show errors;
rollback;

--Prueba 4

declare
v_nombre varchar2(50);
v_apellido_paterno varchar2(50);
v_apellido_materno varchar2(50);
v_email varchar2(100);
v_fecha_nacimiento date;
v_curp varchar2(18);
v_id_aeropuerto_origen number;
v_id_aeropuerto_destino number;
v_fecha_hora_salida date;
v_num_vuelo varchar2(8);
v_atencion_especial varchar2(300);
v_nuevo_pasajero_registrado number;
v_id_vuelo number;
v_id_pasajero number;
v_id_pase_abordar number;
v_id_lista_pasajeros number;

e_nonexistent_flight exception;
pragma
exception_init(e_nonexistent_flight, -20004);

begin
 v_nombre := 'Cob';
  v_apellido_paterno := 'Keppe';
  v_apellido_materno := 'Gillimgham';
  v_email := 'cgillimghamr6@netlog.com';
  v_fecha_nacimiento := to_date('1988/10/09', 'YYYY/MM/DD');
  v_curp := 'JSVW056457TSMQXD22';
  --datos del vuelo con id 255
  v_id_aeropuerto_origen := 798;
  v_id_aeropuerto_destino := 796;
  v_fecha_hora_salida := to_date('2023-08-12 19:11:44', 'YYYY/MM/DD HH24:MI:SS'
  );
  v_num_vuelo := 'WOU-7593';
  v_atencion_especial := 'lorem ipsum dolores et al';
  v_id_vuelo := fx_checa_vuelo(v_id_aeropuerto_origen, v_id_aeropuerto_destino,
    v_fecha_hora_salida, v_num_vuelo);
  --generando pase de abordar
  sp_genera_pase_abordar(v_nombre, v_apellido_paterno, v_apellido_materno,
    v_email, v_fecha_nacimiento, v_curp, v_id_aeropuerto_origen, 
    v_id_aeropuerto_destino, v_fecha_hora_salida, v_num_vuelo, 
    v_atencion_especial);
  --comprobando
  select id_pasajero into v_id_pasajero from pasajero where curp = v_curp;
  select id_pase_abordar
  into v_id_pase_abordar
  from pase_abordar
  where id_pasajero = v_id_pasajero
  and fecha = (
    select max(fecha)
    from pase_abordar
    where id_pase_abordar = v_id_pasajero
  );
  select id_lista_pasajeros
  into v_id_lista_pasajeros
  from lista_pasajeros
  where id_vuelo = v_id_vuelo and id_pase_abordar = v_id_pase_abordar;
  dbms_output.put_line('Prueba 4 invalida: no debería hacer inserciones');
exception
  when e_nonexistent_flight then
    dbms_output.put_line('Prueba 4 válida');
end;
/
show errors;
rollback;
