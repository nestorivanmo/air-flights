--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Escenarios con usos de tablas temporales.

whenerver sqlerror exit;

--
-- Table: T_UBICACION
--
prompt creando tabla t_ubicacion;
create table t_ubicacion(
    id_ubicacion                number(10,0) not null,
    latitud                     number(10,7) not null,
    longitud                    number(10,7) not null,
    fecha_hora                  date not null,
    id_avion                    number(10,0) not null,
    tiempo_restante             date as (
        select (v.fecha_hora_llegada - fecha_hora)
        from vuelo v
        where v.id_vuelo = id_vuelo
    ) virtual,
    constraint t_ubicacion_pk primary key(id_ubicacion),
    constraint vuelo_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo)
);