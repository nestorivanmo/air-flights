--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Script con consultas a la base de datos.

connect em_proy_admin/ema;

--
-- 1: Cantidad de pasajeros que viajaron con air-flights en enero del 2016
--
/*
  id_vuelo | ciudad_origen | ciudad_destinto | num_pasajeros
*/
select lp.id_vuelo, (
		select nombre
		from aeropuerto 
		where id_aeropuerto = q1.id_aeropuerto_origen
	) as ciudad_origen, (
		select nombre
		from aeropuerto
		where id_aeropuerto = q1.id_aeropuerto_destino
	) as ciudad_destino, count(*) as num_pasajeros
from lista_pasajeros lp 
join (
  select v.*
  from vuelo v
  join avion a
  on v.id_avion = a.id_avion
  where a.es_comercial = 1
) q1
on lp.id_vuelo = q1.id_vuelo
where q1.fecha_hora_salida between to_date('1/1/2016', 'dd/mm/yyyy')
and  to_date('31/1/2016', 'dd/mm/yyyy')
group by lp.id_vuelo, q1.id_aeropuerto_origen, q1.id_aeropuerto_destino
order by lp.id_vuelo;

--
-- 2: Aumento del 10% en el sueldo a los empleados que hayan volado en más de 30
-- vuelos y  que tenga arriba de 70 puntos
--
/*
  id_empleado | nombre | ap_paterno | ap_materno | puntos | nombre_puesto | num_vuelos
*/
--q1: empleados que tengan más de 30 vuelos 
--q3: empleados que tengan arriba de 70
select e.id_empleado, e.nombre, e.apellido_paterno, e.apellido_materno, e.puntos,
  count(*) as num_vuelos, (
    select nombre from puesto_asignado where id_puesto_asignado = e.id_puesto_asignado
  ) as puesto
from empleado e
join tripulacion t on t.id_empleado = e.id_empleado
group by e.id_empleado, e.nombre, e.apellido_paterno, e.apellido_materno, e.puntos,
  e.id_puesto_asignado
having count(*) > 30
union
select e.id_empleado,e.nombre,e.apellido_paterno,e.apellido_materno,
	e.puntos, count(*) as num_vuelos, (
    select nombre from puesto_asignado where id_puesto_asignado = e.id_puesto_asignado
  ) as puesto
from empleado e
join tripulacion t on t.id_empleado = e.id_empleado
group by e.id_empleado, e.nombre, e.apellido_paterno, e.apellido_materno, e.puntos,
  e.id_puesto_asignado
having e.puntos > 70 and count(*) > 30;

--
-- 3: Seleccionar el aeropuerto de origen que tenga la mayor cantidad de vuelos
-- de carga y que tenga convenio con air flights usando la tabla_externa.
--
select max(q1.num_vuelos) as max_vuelos
from aeropuerto_ext aex
join (
  select ae.id_aeropuerto, count(*) as num_vuelos
  from aeropuerto_ext ae
  join vuelo v on v.id_aeropuerto_origen = ae.id_aeropuerto
  join avion a on a.id_avion = v.id_avion
  where a.es_carga = 1
  group by ae.id_aeropuerto
) q1
on q1.id_aeropuerto = aex.id_aeropuerto;

--
-- 4: Cantidad de pasajeros ausentes en vuelos del 2019 (v_impresion_lista_pasajeros)
-- 

--
-- 5: Cuantos vuelos de carga y comercial hay en el momento (t_ubicacion)
--

--
-- 6: Obtener la información de pasajeros para id_vuelo = 601
--
prompt conectando como invitado;
connect em_proy_invitado/emi;
