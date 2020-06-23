select count(*) as carga
from t_ubicacion t
join vuelo v 
on v.id_vuelo = t.id_vuelo
join avion av
on av.id_avion = v.id_avion
where av.es_carga = 1
and to_char(t.fecha_hora, 'dd/mm/yyyy') = to_char(sysdate, 'dd/mm/yyyy');
