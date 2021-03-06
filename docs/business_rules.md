# Reglas de negocio

Algunas reglas de negocio encontradas sobre el caso de estudio: 

1. **AVION_CARGA**: las dimensiones de las bodegas son siempre las mismas por cada avión.
2. **PASAJERO**: el CURP se emplea como criterio principal para validar si un usuario ya ha sido registrado. 
3. **AEROPUERTO**: tiene una bandera de activo que indica si la aerolínea tiene convenio con dicho aeropuerto. 
4. **AVION_COMERCIAL**: la tripulación debe estar conformada por piloto, copiloto, jefe de sobrecargos, tres sobrecargos. 
5. **AVION_CARGA**: la tripulación debe estar conformada por piloto, dos copilotos y hasta 10 técnicos.
6. Cada empleado puede tener hasta 5 direcciones en internet donde se puede consultar la trayectoria e historial laboral. 
7. Todo pasajero debe contar con su pase de abordar.
8. La aerolínea puede registrar pases de abordar hasta 10 minutos antes de que el avión despegue. 
9. Algunos aviones pueden funjir como comercial y de carga.
10. En la tabla **UBICACION** los valores de latitud, longitud, fecha y hora exacta se actualizan cada minuto.
11. **EQUIPAJE**: un pasajero puede documentar varias maletas, por lo que se le asigna un número consecutivo de equipaje comenzando en 1. 
