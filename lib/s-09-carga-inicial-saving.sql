--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Carga inicial de los datos.

whenever sqlerror exit;
start savingdata/aeropuerto.sql
start savingdata/aviones_combinados.sql --1-300 (hib) 301-600 (carg) 601-900 (com)
start savingdata/puesto_asignado.sql --9
start savingdata/empleados.sql -- 2050
start savingdata/url_trayectoria.sql
start savingdata/tipo_paquete.sql --1 -> 10
start savingdata/paquete.sql --> 11k
start savingdata/pasajero.sql --> 25k
start savingdata/pase_abordar.sql --> 25k
start savingdata/status_vuelo.sql --> 5
---vuelos
/*
generar 900 vuelos por cada año entre el 2016 y 2019 todos con un status vuelo
entre demorado, cancelado o a tiempo. 
Posteriormente, el histórico tomará cada uno de estos vuelos y dependiendo
de sus status, insertará dentro del histórico con fechas menores y un status
menor.
*/
start savingdata/vuelo.sql -- 3600
start savingdata/historico_status_vuelo.sql --14000
start savingdata/historico_status_fill.sql -- realiza las insersiones en el procedimiento anterior
start savingdata/lista_ubicaciones.sql --20k (únicamente hay registros para los vuelos del 2016)
start savingdata/lista_paquetes.sql --7.2k
/*
num vuelos: 3600; 1200 hib, 1200 comerciales, 1200 carga
hibridos: 1-300; 901-1200; 1801-2100; 2701-3000;
comerciales: 601-900; 1501-1800; 2400-2700; 3301-3600;
*/
start savingdata/lista_pasajeros.sql
start savingdata/tripulacion.sql
start savingdata/equipaje.sql