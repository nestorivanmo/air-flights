--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Escenarios donde se incluyen vistas.

whenever sqlerror exit;
--
-- View: v_impresion_equipaje
--
prompt creando vista v_impresion_equipaje;
create or replace view v_impresion_equipaje(
    folio, nombre,apellido_paterno,apellido_materno,numero
) as select folio,nombre,apellido_paterno,apellido_materno,numero
from pasajero p
join equipaje e
on p.id_pasajero = e.id_equipaje
join pase_abordar pa
on p.id_pasajero = pa.id_pasajero;

--
-- View: v_impresion_lista_pasajeros
--
prompt creando vista v_impresion_lista_pasajeros;
create or replace view v_impresion_lista_pasajeros(
    numero_vuelo,folio_pase_abordar,pasajero_presente,atencion_especial,asiento
) as select numero_vuelo,folio,pasajero_presente,atencion_especial,asiento
from pase_abordar pa
join lista_pasajeros lp
on pa.id_pase_abordar = lp.id_pase_abordar
join vuelo v 
on lp.id_vuelo = v.id_vuelo;

--
-- View: v_impresion_pase_abordar
--
prompt creando vista v_impresion_pase_abordar;
create or replace view v_impresion_pase_abordar(
    origen,destino,fecha_hora_salida,fecha_hora_llegada,numero_vuelo,
    sala_abordar,nombre_pasajero,apellido_paterno,apellido_materno,asiento
) as select o.nombre,d.nombre,v.fecha_hora_salida,v.fecha_hora_llegada,
v.numero_vuelo,v.sala_abordar,p.nombre,p.apellido_paterno,p.apellido_materno,
lp.asiento
from pasajero p
join pase_abordar pa
on p.id_pasajero= pa.id_pasajero
join lista_pasajeros lp
on pa.id_pase_abordar = lp.id_pase_abordar
join vuelo v 
on lp.id_vuelo = v.id_vuelo
join aeropuerto o 
on v.id_aeropuerto_origen = o.id_aeropuerto
join aeropuerto d
on v.id_aeropuerto_destino = d.id_aeropuerto; 
