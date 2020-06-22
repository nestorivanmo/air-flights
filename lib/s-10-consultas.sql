--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Script con consultas a la base de datos.

connect em_proy_admin/ema;

--
-- 1: Cantidad de pasajeros que viajaron con air-flights en enero del 2016
--
/*
  id_vuelo | ciudad_origen | ciudad_destinto | num_pasajeros

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
*/
--
-- 2: Aumento del 10% en el sueldo a los empleados que hayan volado en más de 100
-- vuelos y que los vuelos no hayan sido cancelados o que tenga arriba de 5000 puntos
--
/*
  id_empleado | nombre | ap_paterno | ap_materno | puntos | nombre_puesto | num_vuelos
*/
--q1: empleados que tengan más de 100 vuelos
--q2: q1 - vuelos cancelados ?  
--q3: empleados que tengan arriba de 5,000

/*s
--algebra relacional: q1 U q3
select e.id_empleado, e.nombre, count(*) as num_vuelos
from empleado e
join tripulacion t
on t.id_empleado = e.id_empleado
group by e.id_empleado, e.nombre
having count(*) > 20;
/*
--q3 empleados que tengan arriba de 5,000
select e.id_empleado,e.nombre,e.apellido_paterno,e.apellido_materno,
	e.puntos,
	(select nombre from puesto_asignado
	where id_puesto_asignado = e.id_puesto_asignado) as nombre_puesto
from empleado e
where e.puntos > 90
order by e.nombre;
*/


--
-- 3: Cantidad de aeroupuertos que tengan convenio con air-flights (usando t ext)
--

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
