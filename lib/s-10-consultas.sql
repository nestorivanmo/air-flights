--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Script con consultas a la base de datos.

--
-- 1: Cantidad de pasajeros que viajaron con air-flights en enero del 2016
--
select count(*) as num_pasajeros
from lista_pasajeros lp, (
  select v.*
  from vuelo v
  join avion a
  on v.id_avion = a.id_avion
  where a.es_comercial = 1
) as q1
where lp.id_vuelo = q1.id_vuelo
and q1.fecha_hora_salida in between (to_date('1/1/2016', 'dd/mm/yyyy')
  and to_date('31/1/2016', 'dd/mm/yyyy')
)
order by q1.fecha_hora_salida;

--
-- 2: Aumento del 10% en el sueldo a los empleados que hayan volado en más de 100
-- vuelos y que los vuelos no hayan sido cancelados
--

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
