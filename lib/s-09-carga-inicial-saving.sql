start saving-data/aviones_combinados.sql; --1-300 (hib) 301-600 (carg) 601-900 (com)
start saving-data/puesto_asignado.sql; --9
start saving-data/empleados.sql; -- 2050
start saving-data/url_trayectoria.sql;
start saving-data/tipo_paquete.sql; --1 -> 10
start saving-data/paquete.sql; --> 11k
start saving-data/pasajero.sql; --> 20k
start saving-data/pase_abordar.sql --> 25k
start saving-data/status_vuelo.sql --> 5
---vuelos
/*
generar 900 vuelos por cada año entre el 2016 y 2019 todos con un status vuelo
entre demorado, cancelado o a tiempo. 
Posteriormente, el histórico tomará cada uno de estos vuelos y dependiendo
de sus status, insertará dentro del histórico con fechas menores y un status
menor.
*/
start saving-data/vuelo.sql; -- 3600
start saving-data/historico_status_vuelo.sql --14000