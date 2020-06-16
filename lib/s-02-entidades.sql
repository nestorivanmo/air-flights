--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Código de las tablas del caso de estudio.

--
--Table: AVION
--
prompt creando avion;
create table avion(
    id_avion                    numeric(10) not null
    constraint avion_pk primary key,
    matricula                   varchar(10) not null,
    modelo_avion                varchar(50) not null,
    documento_especificaciones  binary(2000) not null,
    es_carga                    numeric(1,0) not null,
    es_comercial                numeric(1,0) not null
);

--
--Table: AVION_COMERCIAL
--
prompt creando avion_comercial;
create table avion_comercial(
    id_avion numeric(10,0) not null
    constraint avion_comercial_pk primary key,
    num_ordinarios numeric(3,0) not null,
    num_vip numeric(3,0) not null,
    num_discapacitados numeric(3,0) not null,
    constraint avion_comercial_id_avion_fk foreign key(id_avion) 
    references avion(id_avion)
);

create table avion_carga(
    id_avion numeric(10,0) not null
    constraint avion_carga_pk primary key,
    num_bodegas numeric(4,0) not null,
    capacidad_carga numeric(5,2) not null,
    alto numeric(3,2) not null,
    ancho numeric(4,2) not null,
    volumen numeric(6,2) as (alto*ancho) virtual,
    constraint avion_carga_id_avion_fk foreign key(id_avion) 
    references avion(id_avion)
);

create table pasajero(
    id_pasajero numeric(10,0) not null
    constraint pasajero_pk primary key,
    nombre varchar(50) not null,
    apellido_paterno varchar(50) not null,
    apellido_materno varchar(50) null,
    email varchar(100) null,
    fecha_nacimiento date not null,
    curp varchar(13) not null
);

create table aeropuerto(
    id_aeropuerto numeric(10,0) not null
    constraint aeropuerto_pk primary key,
    clave varchar(5) not null,
    nombre varchar(50) not null,
    latitud numeric(9,7) not null,
    longitud numeric(9,7) not null,
    es_activo numeric(1,0) not null
);

create table puesto_asignado(
    id_puesto_asignado numeric(10,0) not null
    constraint puesto_asignado_pk primary key,
    clave varchar(50) not null,
    nombre varchar(50) not null,
    descripcion varchar(300) not null,
    sueldo_mensual numeric(9,2) not null
);

create table empleado(
    id_empleado numeric(10,0) not null
    constraint empleado_pk primary key,
    nombre varchar(50) not null,
    apellido_paterno varchar(50) not null,
    apellido_materno varchar(50) not null,
    rfc varchar(13) not null,
    curp varchar(18) not null,
    foto varbinary(100000) not null,
    puntos numeric(3,0) not null,
    id_jefe numeric(10,0) null,
    id_puesto_asignado numeric(10,0) not null,
    constraint empleado_id_jefe_fk foreign key(id_jefe) 
    references empleado(id_empleado),
    constraint empleado_id_puesto_asignado_fk foreign key(id_puesto_asignado) 
    references puesto_asignado(id_puesto_asignado)
);
