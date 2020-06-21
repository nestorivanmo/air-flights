--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Código de las tablas del caso de estudio.

whenever sqlerror exit;
--
-- Table: AVION
--
prompt creando tabla avion;
create table avion(
    id_avion                    number(10)  not null,
    matricula                   varchar2(10) not null,
    modelo_avion                varchar2(50) not null,
    documento_especificaciones  blob default empty_blob() not null,
    es_carga                    number(1,0) not null,
    es_comercial                number(1,0) not null,
    constraint avion_pk primary key(id_avion),
    constraint av_matricula_uk unique(matricula)
);

--
-- Table: AVION_COMERCIAL
--
prompt creando tabla avion_comercial;
create table avion_comercial(
    id_avion                    number(10,0) not null,
    num_ordinarios              number(3,0) not null,
    num_vip                     number(3,0) not null,
    num_discapacitados          number(3,0) not null,
    constraint avion_comercial_pk primary key (id_avion),
    constraint avc_id_avion_fk foreign key(id_avion) 
    references avion(id_avion),
    constraint avco_num_ordinarios_chk check (num_ordinarios >= 0),
    constraint avco_num_vip_chk check (num_vip >= 0),
    constraint avco_num_discapacitados_chk check (num_discapacitados >= 0)
);

--
-- Table: AVION_CARGA
--
prompt creando tabla avion_carga;
create table avion_carga(
    id_avion                    number(10,0) not null,
    num_bodegas                 number(4,0) not null,
    capacidad_carga             number(5,2) not null,
    alto                        number(3,2) not null,
    ancho                       number(4,2) not null,
    volumen                     number(6,2) as (round(alto*ancho, 2)) virtual,
    capacidad_libras            number(5,2) as (round((capacidad_carga * 2.2046 
    * 1000),2)) virtual,
    constraint avion_carga_pk primary key (id_avion),
    constraint avcarga_id_avion_fk foreign key(id_avion) 
    references avion(id_avion)
);

--
-- Table: PASAJERO
--
prompt creando tabla pasajero;
create table pasajero(
    id_pasajero                 number(10,0) not null,
    nombre                      varchar2(50) not null,
    apellido_paterno            varchar2(50) not null,
    apellido_materno            varchar2(50) null,
    email                       varchar2(100) null,
    fecha_nacimiento            date not null,
    curp                        varchar2(18) not null,
    constraint pasajero_pk primary key (id_pasajero),
    constraint pa_email_uk unique(email)
);

--
-- Table: AEROPUERTO
--
prompt creando tabla aeropuerto;
create table aeropuerto(
    id_aeropuerto               number(10,0) not null,
    clave                       varchar2(5) not null,
    nombre                      varchar2(50) not null,
    latitud                     number(23,20) not null,
    longitud                    number(23,20) not null,
    es_activo                   number(1,0) not null,
    constraint aeropuerto_pk primary key (id_aeropuerto),
    constraint ae_clave_uk unique(clave),
    constraint ae_es_activo_chk check (es_activo in (0, 1))
);

--
-- Table: PUESTO_ASIGNADO
--
prompt creando tabla puesto_asignado;
create table puesto_asignado(
    id_puesto_asignado          number(10,0) not null,
    clave                       varchar2(50) not null,
    nombre                      varchar2(50) not null,
    descripcion                 varchar2(300) not null,
    sueldo_mensual              number(9,2) not null,
    constraint puesto_asignado_pk  primary key (id_puesto_asignado),
    constraint pu_clave_uk unique(clave),
    constraint pu_sueldo_mensual_chk check (sueldo_mensual >= 0)
);

--
-- Table: EMPLEADO
--
prompt creando tabla empleado;
create table empleado(
    id_empleado                 number(10,0) not null,
    nombre                      varchar2(50) not null,
    apellido_paterno            varchar2(50) not null,
    apellido_materno            varchar2(50) not null,
    rfc                         varchar2(13) not null,
    curp                        varchar2(18) not null,
    foto                        blob default empty_blob()not null,
    puntos                      number(3,0) not null,
    id_jefe                     number(10,0) null,
    id_puesto_asignado          number(10,0) not null,
    constraint empleado_pk primary key (id_empleado),
    constraint em_id_jefe_fk foreign key(id_jefe) 
    references empleado(id_empleado),
    constraint em_id_puesto_asignado_fk foreign key(id_puesto_asignado) 
    references puesto_asignado(id_puesto_asignado),
    constraint em_rfc_uk unique(rfc),
    constraint em_curp_uk unique(curp),
    constraint em_puntos_chk check (puntos >= 0 and puntos <= 100)
);

--
-- Table: URL_TRAYECTORIA
--
prompt creando tabla url_trayectoria;
create table url_trayectoria(
    id_url_trayectoria          number(10) not null,
    url_trayectoria             varchar2(300) not null,
    id_empleado                 number(10) not null,
    constraint url_trayectoria_pk primary key (id_url_trayectoria),
    constraint ut_id_empleado_fk foreign key(id_empleado)
    references empleado(id_empleado)
);

--
-- Table: TIPO_PAQUETE
--
prompt creando tabla tipo_paquete;
create table tipo_paquete(
    id_tipo_paquete             number(10,0) not null,
    clave                       varchar2(5) not null,
    descripcion                 varchar2(50) not null,
    indicaciones_generales      varchar2(300) not null,
    constraint tipo_paquete_pk primary key (id_tipo_paquete),
    constraint tp_clave_uk unique(clave)
);

--
-- Table: PAQUETE
--
prompt creando tabla paquete;
create table paquete(
    id_paquete                  number(10,0) not null,
    folio                       varchar2(18) not null,
    peso                        number(8,2) not null, --en kg
    peso_libras                 number(8,2) as (peso * 2.2046) virtual,
    id_tipo_paquete             number(10,0) not null,
    constraint paquete_pk primary key (id_paquete),
    constraint pq_id_tipo_paquete_fk foreign key(id_tipo_paquete) 
    references tipo_paquete(id_tipo_paquete),
    constraint pq_folio_uk unique(folio),
    constraint pq_peso_chk check (peso > 0)
);

--
-- Table: PASE_ABORDAR
--
prompt creando tabla pase_abordar;
create table pase_abordar(
    id_pase_abordar             number(10,0) not null,
    folio                       varchar2(10) not null,
    fecha                       date  default sysdate not null,
    id_pasajero                 number(10,0) not null,
    constraint pase_abordar_pk primary key(id_pase_abordar),
    constraint pab_id_pasajero_fk foreign key(id_pasajero)
    references pasajero(id_pasajero)
);

--
-- Table: STATUS_VUELO
--
prompt creando tabla status_vuelo;
create table status_vuelo(
    id_status_vuelo             number(10,0) not null,
    clave                       varchar2(5) not null,
    descripcion                 varchar2(50) not null,
    constraint status_vuelo_pk primary key(id_status_vuelo),
    constraint sv_clave_uk unique(clave)
);

--
-- Table: VUELO
--
prompt creando tabla vuelo;
create table vuelo(
    id_vuelo                    number(10,0) not null,
    id_aeropuerto_origen        number(10,0) not null,
    id_aeropuerto_destino       number(10,0) not null,
    fecha_hora_salida           date default sysdate not null,
    fecha_hora_llegada          date not null,
    numero_vuelo                varchar2(8) not null,
    sala_abordar                varchar2(5) not null,
    duracion                    varchar2(100)
    as (
        to_char(cast(fecha_hora_llegada as timestamp)-cast(fecha_hora_salida 
        as timestamp))
    ) virtual,
    id_status_vuelo             number(10,0) not null,
    id_avion                    number(10,0) not null,
    constraint vuelo_pk primary key (id_vuelo),
    constraint vu_id_aeropuerto_origen_fk foreign key(id_aeropuerto_origen)
    references aeropuerto(id_aeropuerto),
    constraint vu_id_aeropuerto_destino_fk foreign key(id_aeropuerto_destino)
    references aeropuerto(id_aeropuerto),
    constraint vu_id_status_vuelo_fk foreign key(id_status_vuelo)
    references status_vuelo(id_status_vuelo),
    constraint vu_id_avion_fk foreign key(id_avion)
    references avion(id_avion)
);

---
--- Table: LISTA_UBICACIONES
---
prompt creando table lista_ubicaciones;
create table lista_ubicaciones(
    id_lista_ubicaciones        number(10,0) not null,
    latitud                     number(23,20) not null,
    longitud                    number(23,20) not null,
    fecha_hora                  date not null,
    id_vuelo                    number(10,0) not null,
    constraint lista_ubicaciones_pk primary key(id_lista_ubicaciones),
    constraint lu_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo)
);

--
-- Table: HISTORICO_STATUS_VUELO
--
prompt creando tabla historico_status_vuelo;
create table historico_status_vuelo(
    id_historico_status_vuelo   number(10,0) not null,
    fecha                       date default sysdate not null,
    id_status_vuelo             number(10,0) not null,
    id_vuelo                    number(10,0) not null,
    constraint historico_status_vuelo_pk primary key(id_historico_status_vuelo),
    constraint hsv_vuelo_id_status_vuelo_fk foreign key(id_status_vuelo) 
    references status_vuelo(id_status_vuelo),
    constraint hsv_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo)
);

--
-- Table: LISTA_PAQUETES
--
prompt creando tabla lista_paquetes;
create table lista_paquetes(
    id_lista_paquetes           number(10,0) not null,
    id_vuelo                    number(10,0) not null,
    id_paquete                  number(10,0) not null,
    constraint lista_paquetes_pk primary key(id_lista_paquetes),
    constraint lpq_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo),
    constraint lpq_id_paquete_fk foreign key(id_paquete)
    references paquete(id_paquete),
    constraint lpq_id_paquete_uk unique (id_paquete, id_vuelo)
);

--
-- Table: LISTA_PASAJEROS
--
prompt creando tabla lista_pasajeros;
create table lista_pasajeros(
    id_lista_pasajeros          number(10,0) not null,
    id_vuelo                    number(10,0) not null,
    id_pase_abordar             number(10,0) not null,
    pasajero_presente           number(1,0) not null,
    atencion_especial           varchar2(300) null,
    asiento                     varchar2(5) not null,
    constraint lista_pasajeros_pk primary key(id_lista_pasajeros),
    constraint lpa_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo),
    constraint lpa_id_pase_abordar_fk foreign key(id_pase_abordar)
    references pase_abordar(id_pase_abordar),
    constraint lpa_id_pase_abordar_uk unique (id_pase_abordar, id_vuelo)
);

--
-- Table: TRIPULACION
--
prompt creando tabla tripulacion;
create table tripulacion(
    id_tripulacion              number(10,0) not null,
    id_vuelo                    number(10,0) not null,
    id_empleado                 number(10,0) not null,
    constraint tripulacion_pk primary key(id_tripulacion),
    constraint tr_id_vuelo_fk foreign key(id_vuelo)
    references vuelo(id_vuelo),
    constraint tr_id_empleado_fk foreign key(id_empleado)
    references empleado(id_empleado)
);

--
-- Table: EQUIPAJE
--
prompt creando tabla equipaje;
create table equipaje(
    id_equipaje                 number(10,0) not null,
    numero                      number(1,0) not null,
    peso                        number(4,2) not null,
    id_pasajero                 number(10,0) not null,
    id_vuelo                    number(10,0) not null,
    constraint equipaje_pk primary key(id_equipaje),
    constraint eq_id_pasajero_fk foreign key(id_pasajero)
    references pasajero(id_pasajero),
    constraint eq_id_vuelo_fk foreign key (id_vuelo)
    references vuelo(id_vuelo),
    constraint eq_peso_chk check (peso > 0),
    constraint eq_numero_chk check (numero > 0),
    constraint eq_numero_uk unique (numero, id_pasajero, id_vuelo)
);
