--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Código de las tablas del caso de estudio.

whenever sqlerror exit;

--
--Table: AVION
--
prompt creando avion;
create table avion(
    id_avion                    numeric(10) not null,
    matricula                   varchar(10) not null,
    modelo_avion                varchar(50) not null,
    documento_especificaciones  binary(2000) not null,
    es_carga                    numeric(1,0) not null,
    es_comercial                numeric(1,0) not null,
    
    constraint avion_pk primary key(id_avion)
);

--
--Table: AVION_COMERCIAL
--
prompt creando avion_comercial;
create table avion_comercial(
    id_avion                    numeric(10,0) not null,
    num_ordinarios              numeric(3,0) not null,
    num_vip                     numeric(3,0) not null,
    num_discapacitados          numeric(3,0) not null,

    constraint avion_comercial_pk primary key (id_avion),
    constraint avion_comercial_id_avion_fk foreign key(id_avion) 
    references avion(id_avion)
);

--
--Table: AVION_CARGA
--
create table avion_carga(
    id_avion                    numeric(10,0) not null,
    num_bodegas                 numeric(4,0) not null,
    capacidad_carga             numeric(5,2) not null,
    alto                        numeric(3,2) not null,
    ancho                       numeric(4,2) not null,
    volumen                     numeric(6,2) as (alto*ancho) virtual,

    constraint avion_carga_pk primary key (id_avion),
    constraint avion_carga_id_avion_fk foreign key(id_avion) 
    references avion(id_avion)
);

--
--Table: PASAJERO
--
create table pasajero(
    id_pasajero                 numeric(10,0) not null,
    nombre                      varchar(50) not null,
    apellido_paterno            varchar(50) not null,
    apellido_materno            varchar(50) null,
    email                       varchar(100) null,
    fecha_nacimiento            date not null,
    curp varchar(13)            not null,

    constraint pasajero_pk primary key (id_pasajero)
);

--
--Table: AEROPUERTO
--
create table aeropuerto(
    id_aeropuerto               numeric(10,0) not null,
    clave                       varchar(5) not null,
    nombre                      varchar(50) not null,
    latitud                     numeric(9,7) not null,
    longitud                    numeric(9,7) not null,
    es_activo                   numeric(1,0) not null,

    constraint aeropuerto_pk primary key (id_aeropuerto)
);

--
--Table: PUESTO_ASIGNADO
--
create table puesto_asignado(
    id_puesto_asignado          numeric(10,0) not null,
    clave                       varchar(50) not null,
    nombre                      varchar(50) not null,
    descripcion                 varchar(300) not null,
    sueldo_mensual              numeric(9,2) not null,

    constraint puesto_asignado_pk  primary key (id_puesto_asignado)
);

--
--Table: EMPLEADO
--
create table empleado(
    id_empleado                 numeric(10,0) not null,
    nombre                      varchar(50) not null,
    apellido_paterno            varchar(50) not null,
    apellido_materno            varchar(50) not null,
    rfc                         varchar(13) not null,
    curp                        varchar(18) not null,
    foto                        varbinary(100000) not null,
    puntos                      numeric(3,0) not null,
    id_jefe                     numeric(10,0) null,
    id_puesto_asignado          numeric(10,0) not null,

    constraint empleado_pk primary key (id_empleado),
    constraint empleado_id_jefe_fk foreign key(id_jefe) 
    references empleado(id_empleado),
    constraint empleado_id_puesto_asignado_fk foreign key(id_puesto_asignado) 
    references puesto_asignado(id_puesto_asignado)
);

--
--Table: URL_TRAYECTORIA
--
create table url_trayectoria(
    id_url_trayectoria          numeric(10) not null,
    url                         varchar(30) not null,
    id_empleado                 numeric(10) not null,

    constraint url_trayectoria_pk primary key (id_url_trayectoria),
    constraint url_trayectoria_id_url_trayectoria_fk foreign key(id_empleado)
    references empleado(id_empleado)
);

--
--Table: TIPO_PAQUETE
--
create table tipo_paquete(
    id_tipo_paquete             numeric(10,0) not null,
    clave                       varchar(5) not null,
    descripcion                 varchar(50) not null,
    indicaciones_generales      varchar(30) not null,

    constraint tipo_paquete_pk primary key (id_tipo_paquete)
);

--
--Table: PAQUETE
--
create table paquete(
    id_paquete                  numeric(10,0) not null,
    folio                       varchar(18) not null,
    peso                        numeric(8,2) not null,
    peso_libras                 numeric(8,2) not null,
    id_tipo_paquete             numeric(10,0) not null,

    constraint paquete_pk primary key (id_paquete),
    constraint paquete_id_tipo_paquete_fk foreign key(id_tipo_paquete) 
    references tipo_paquete(id_tipo_paquete)
);

--
--Table: PASE_ABORDAR
--
create table pase_abordar(
    id_pase_abordar             numeric(10,0) not null,
    folio                       varchar(4) not null,
    fecha                       date not null default sysdate,
    asiento                     varchar(5) not null,
    id_pasajero                 numeric(10,0) not null,

    constraint pase_abordar_pk primary key(id_pase_abordar),
    constraint pase_abordar_id_pasajero_fk foreign key(id_pasajero)
    references pasajero(id_pasajero)
);

--
--Table: EQUIPAJE
--
create table equipaje(
    id_equipaje                 numeric(10,0) not null,
    numero                      numeric(1,0) not null,
    peso                        numeric(4,2) not null,
    id_pasajero                 numeric(10,0) not null,

    constraint equipaje_pk primary key(id_equipaje),
    constraint equipaje_id_pasajero_fk foreign key(id_pasajero)
    references pasajero(id_pasajero)
);

--
--Table: STATUS_VUELO
--
create table status_vuelo(
    id_status_vuelo             numeric(10,0) not null,
    clave                       varchar(5) not null,
    descripcion                 varchar(50) not null,

    constraint status_vuelo primary key(id_status_vuelo)
);

--
--Table: VUELO
--
create table vuelo(
    id_vuelo                    numeric(10,0) not null,
    id_aeropuerto_origen        numeric(10,0) not null,
    id_aeropuerto_destino       numeric(10,0 not null,
    fecha_salida                date not null default sysdate,
    fecha_llegada               date not null,
    numero_vuelo                varchar(8) not null,
    sala_abordar                varchar(5) not null,
    distancia                   numeric(7,2) not null,
    duracion                    numeric(2,0) not null,
    id_status_vuelo             numeric(10,0) not null,
    id_avion                    numeric(10,0) not null,

    constraint vuelo_pk primary key (id_vuelo),
    constraint vuelo_id_aeropuerto_origen_fk foreign key(id_aeropuerto_origen)
    references aeropuerto(id_aeropuerto),
    constraint vuelo_id_aeropuerto_destino_fk foreign key(id_aeropuerto_destino)
    references aeropuerto(id_aeropuerto),
    constraint vuelo_id_status_vuelo_fk foreign key(id_status_vuelo)
    references status_vuelo(id_status_vuelo),
    constraint vuelo_id_avion_fk foreign key(id_avion)
    references avion(id_avion)
);

--
--Table: HISTORICO_STATUS_VUELO
--
create table historico_status_vuelo(
    id_historico_status_vuelo   numeric(10,0) not null,
    fecha                       date not null default sysdate,
    id_status_vuelo             numeric(10,0) not null,
    id_vuelo                    numeric(10,0) not null,

    constraint historico_status_vuelo primary key(id_historico_status_vuelo),
    constraint historico_status_vuelo_id_status_vuelo_fk 
    foreign key(id_status_vuelo) references status_vuelo(id_status_vuelo),
    constraint historico_status_vuelo_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo)
);

--
--Table: LISTA_PAQUETES
--
create table lista_paquetes(
    id_lista_paquetes           numeric(10,0) not null,
    id_vuelo                    numeric(10,0) not null,
    id_paquete                  numeric(10,0) not null,

    constraint lista_paquetes_pk primary key(id_lista_paquetes),
    constraint lista_paquetes_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo),
    constraint lista_paquetes_id_paquete_fk foreign key(id_paquete)
    references paquete(id_paquete)
);

--
--Table: LISTA_PASAJEROS
--
create table lista_pasajeros(
    id_lista_pasajeros          numeric(10,0) not null,
    id_vuelo                    numeric(10,0) not null,
    id_pase_abordar             numeric(10,0) not null,
    pasajero_presente           numeric(1,0) not null,
    atencion_especial           varchar(300) not null

    constraint lista_pasajeros_pk primary key(id_lista_pasajeros),
    constraint lista_pasajeros_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo),
    constraint lista_pasajeros_id_pase_abordar_fk foreign key(id_pase_abordar)
    references pase_abordar(id_pase_abordar)
);

--
--Table: TRIPULACION
--
create table tripulacion(
    id_tripulacion              numeric(10,0) not null,
    id_vuelo                    numeric(10,0) not null,
    id_empleado                 numeric(10,0) not null,

    constraint tripulacion_pk primary key(tripulacion_id),
    constraint tripulacion_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo),
    constraint tripulacion_id_empleado_fk foreign key(id_empleado)
    references empleado(id_empleado)
);

--
--Table: T_UBICACION
--
create table t_ubicacion(
    id_ubicacion                numeric(10,0) not null,
    latitud                     numeric(10,7) not null,
    longitud                    numeric(10,7) not null,
    fecha                       date not null,
    tiempo_restante             date not null,
    id_avion                    numeric(10,0) not null,

    constraint t_ubicacion_pk primary key(id_ubicacion),
    constraint t_ubicacion_id_avion_fk foreign key(id_avion)
    references avion(id_avion)
);