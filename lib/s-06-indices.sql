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
create index pab_id_pase_abordar_ix on pase_abordar(id_pase_abordar);
create index pas_id_pasajero_ix on pasajero(id_pasajero);
create index pq_id_paquete_ix on paquete(id_paquete);

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
create index eq_equipajes_ix on equipaje(id_pasajero, id_vuelo);

--
-- Índice basado en funciones
--
prompt creando indice basado en funciones;
create unique index pas_nombre_ix on pasajero(lower(nombre));
create unique index pas_apellido_paterno_ix on pasajero(lower(apellido_paterno));
create unique index pas_apellido_materno_ix on pasajero(lower(apellido_materno));
create unique index ae_nombre_ix on aeropuerto(lower(nombre));