--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Escenarios con uso de índices.

whenever sqlerror exit;
/*
lista_ubicaciones
vuelo
lista_paquetes
paquete
lista_pasajeros
pase_abordar
pasajero
equipaje
*/

--
-- Índice non-uniqe
--
prompt creando indice non unique;
create index vu_fecha_hora_salida_ix on vuelo(fecha_hora_salida)
create index vu_fecha_hora_llegada_ix on vuelo(fecha_hora_llegada)


--
-- Índice unique
--
prompt creando indice unique;
create unique index pas_curp_iuk on pasajero(curp);
create unique index pab_folio_iuk on pase_abordar(folio);

--
-- Índice compuesto de tipo unique
--
prompt creando indice compuesto tipo unique;
create index eq_equipajes_iuk on equipaje(id_pasajero, id_vuelo);

--
-- Índice basado en funciones
--
prompt creando indice basado en funciones;
create  index pas_nombre_ix on pasajero(lower(nombre));
create  index pas_apellido_paterno_ix on pasajero(lower(apellido_paterno));
create  index pas_apellido_materno_ix on pasajero(lower(apellido_materno));
create  index ae_nombre_ix on aeropuerto(lower(nombre));