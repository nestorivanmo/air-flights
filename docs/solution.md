# Solución

### Entidades

- *default*
  - con fechas
- *columnas virtuales*
  - convertir a libras la carga de los paquetes.
  - agregar volumen a la capacidad de carga. 
  - agregar distancia del vuelo
  - Tabla virtual sobre vuelo: 
    - distancia
    - duración de vuelo
  - Tabla virtual sobre Ubicación:
    - tiempo actual para finalizar el vuelo
- Agregar tabla extra para atributo multivalorado de Empleado

### Tablas temporales

- Compras sobre un vuelo
- Tabla ubicación

### Tablas externas

- sobre la tabla Aeropuerto

### Secuencias

### Índices

- Non Unique
- Unique
  - CURP
  - Folio del pase de abordar
  - id del paquete
- Índice compuesto
- Índices basado en funciones

### Triggers
- Cada que se haga una inserción sobre T_UBICACION, el trigger deberá copiar los datos, antes de actualizarlos, a la tabla LISTA_UBICACIONES
- Se debe lanzar cada que se vaya a actualizar la tabla UBICACION
- Para verificar que no se creen pases de abordar si el vuelo està a menos de 10 minutos de despegar.
- Para verificar la regla de negocio de url_trayectoria sobre la tabla empleado
- Para verificar que se inserten correctamente la cantidad de tripulantes en la tripulacion; este trigger depende de si el vuelo es comercial o de cargao o ambos.

### Vistas

- v_vuelo_pantallas_aeropuerto:
  - numero de vuelo
  - origen
  - destino
  - status
  - tiempo 
- v_vuelo_informacion_detallada:
  - num_avion
  - tipo_avion
  - cantidad_tripulantes
  - cantidad_pasajeros
  - cantidad_paquetes
- v_pase_de_abordar_impresion:
  - num_vuelo
  - origen
  - destino
  - nombre
  - apellido_pat
  - apellido_mat
  - num_sala
  - hora_salida
-v_equipaje:
  - folio_pase
  - nombre
  - numero_maleta
v_pasajeros:
  - folio
  - id_vuelo
  - id_pase_abordar
  - pasajero_presente
  - atención_especial






