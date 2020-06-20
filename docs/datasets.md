# Datasets
- Avion: 900 general e intercalados entre aviones comercial y aviones carga. 
- Puesto Asingado: 
 1. Director General -> 1
 2. Gerente Pilotos (jefe Dir Gral) -> 10
 3. Gerente Sobrecargos (jefe Dir Gral) -> 10
 4. Gerente Técnicos (jefe Dir Gral) -> 10
 5. Piloto (jefe 2) -> 150
 6. Copiloto (jefe 5) -> 300
 7. Jefe Sobrecargos (jefe 3) -> 100
 8. Sobrecargos (jefe 7) -> 1000
 9. Tecnicos (jefe 4) -> 500
- Empleado -> 2050
- Url Trayectoria -> 4831 + algunos otros para empleados random
- Tipo Paquete: 
 1. Alimentos
 2. Cuidado personal
 3. Deportes
 4. Electronicos
 5. Herramientas
 6. Hogar
 7. Instrumentos musicales
 8. Libros
 9. Oficina y papeleria
 10. Otros
- Paquete: 10k
- Pasajero: 30k
- Pase Abordar: 25k y borrar a los pasajeros que no tengan pase de abordar asociado
- Status Vuelo: 
 1. PROGRAMADO
 2. ABORDANDO
 3. A TIEMPO
 4. DEMORADO
 5. CANCELADO
- Vuelo: tener en cuenta el histórico. 
 1. PROGRAMADO: pueden ser cualquiera de los 500 aviones las veces que sean; solo revisar que no se ocupe el mismo id de avion para a la misma fecha. 
 2. ABORDANDO: 
- Historico: la idea es generar 500 vuelos con status abordando, posteriormente implementar con un cursor la inserción de más elementos dentro del histórico. Repetir lo mismo con diferentes fechas de generación. 
- Lista ubicaciones: Generar varias ubicaciones para un id_vuelo en particular. 
- Lista paquetes: emplear un cursor y seleccionar aleatoriamente un paquete y dentro del cursor seleccionar unicamente vuelos que sean de carga o híbridos. Por cada vuelo encontrado, generar un número aleatorio de inserciones pues deber de haber más de una por cada vuelo. 
- Lista pasajeros: usar mockaroo pero conociendo primero el rango de los aviones que son comerciales
- Tripulacion: emplear un cursor y dependiendo de su tipo, insertar la cantidad de tripulantes. 
- Equipaje: usando mockaroo considerando los vuelos comerciales o híbridos. 
