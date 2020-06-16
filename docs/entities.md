# Entidades
Lista de entidades completas sobre el caso de estudio:

1. AVION
	- matricula varchar2 (10)
	- modelo varchar2 (50)
	- documento_especificaciones binary (2000)
2. AVION_COMERCIAL
	- num_ordinarios number (3,0)
	- num_vip number
	- num_discapacitados number
3. AVION_CARGA
	- num_bodegas number
	- capacidad_carga number
	- alto number
	- ancho number
	+ volumen number
4. PASAJERO
	- nombre varchar2
	- apellido_paterno varchar2
	- apellido_materno varchar2 null
	- email varchar2 null
	- fecha_nacimiento date
	- curp varchar2
5. AEROPUERTO
	- clave varchar2
	- nombre varchar2
	- latitud varchar2
	- longitud varchar2
	- es_activo number (1,0)
6. PUESTO_ASIGNADO
	- clave varchar2
	- nombre varchar2
	- descripcion varchar2
	- sueldo_mensual number
7. DIRECCIONES_TRAYECTORIA
	- id_empleado FK
	- direccion_url varchar2
8. EMPLEADO
	- nombre varchar2
	- apellido_paterno varchar2
	- apellido_materno varchar2
	- rfc varchar2
	- curp varchar2
	- foto binary
	- puntos number default 0
	- id_puesto_asignado FK
	- id_jefe FK null
9. TIPO_PAQUETE
	- clave varchar2
	- descripcion varchar2
	- indicaciones_generales varchar2
10. PAQUETE
	- folio number(18,0)
	- peso number
	+ peso_libras number
	- id_tipo_paquete FK
11. PASE_ABORDAR
	- folio varchar2
	- fecha_impresion default sysdate
	- asiento varchar2 
12. MALETA
	- folio_pase_abordar varchar2 FK
	- numero number
	- peso number
13. STATUS_VUELO
	- clave varchar2
	- descripcion varchar2
14. HISTORICO_STATUS_VUELO
	- fecha default sysdate
15. VUELO
	- id_aeropuerto_origen FK
	- id_aeropuerto_destino FK
	- fecha_salida default sysdate
	- hora_salida date
	- fecha_llegada
	- hora_llegada date
	- id_avion FK
	- numero varchar2
	- sala_abordar varchar2 null
	+ distancia number
	+ duracion number
16. LISTA_PAQUETES
	- id_vuelo FK
	- id_paquete FK
17. LISTA_PASAJEROS
	- id_pase_abordar FK
	- atencion_especial varchar2 null
	- pasajero_presente number (1,0)
18. TRIPULACION
	- id_vuelo FK
	- id_empleado FK
19. UBICACION_AVION
	- id_avion FK
	- latitud number
	- longitud number
	- fecha date
	- hora date
	+ tiempo_restante date
