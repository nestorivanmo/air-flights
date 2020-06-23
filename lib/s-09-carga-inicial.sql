--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Carga inicial de los datos.

whenever sqlerror exit;

connect em_proy_admin/ema;
prompt cargando datos de aeropuerto;
start savingdata/aeropuerto.sql
prompt cargando datos de aviones combinados:
start savingdata/aviones_combinados.sql --1-300 (hib) 301-600 (carg) 601-900 (com)
prompt cargando datos de puesto asignado;
start savingdata/puesto_asignado.sql --9
prompt cargando datos de empleados;
start savingdata/empleados.sql -- 2050
prompt cargando datos de trayectoria;
start savingdata/url_trayectoria.sql
prompt cargando datos de tipo paquete;
start savingdata/tipo_paquete.sql --1 -> 10
prompt cargando datos de paquete;
start savingdata/paquete.sql --> 11k
prompt cargando datos de pasajero;
start savingdata/pasajero.sql --> 25k
prompt cargando datos de pase abordar;
start savingdata/pase_abordar.sql --> 25k
prompt cargando datos de status vuelo;
start savingdata/status_vuelo.sql --> 5
---vuelos
/*
generar 900 vuelos por cada año entre el 2016 y 2019 todos con un status vuelo
entre demorado, cancelado o a tiempo. 
Posteriormente, el histórico tomará cada uno de estos vuelos y dependiendo
de sus status, insertará dentro del histórico con fechas menores y un status
menor.
*/
prompt cargando datos vuelo;
start savingdata/vuelo.sql -- 3600
prompt cargando datos historico status vuelo;
start savingdata/historico_status_vuelo.sql --14000
start savingdata/historico_status_fill.sql -- realiza las insersiones en el procedimiento anterior
prompt cargado datos ubicaciones log;
start savingdata/ubicaciones_log.sql --20k (únicamente hay registros para los vuelos del 2016)
prompt cargando datos lista paquetes;
start savingdata/lista_paquetes.sql --7.2k
/*
num vuelos: 3600; 1200 hib, 1200 comerciales, 1200 carga
hibridos: 1-300; 901-1200; 1801-2100; 2701-3000;
comerciales: 601-900; 1501-1800; 2400-2700; 3301-3600;
*/
prompt cargando datos lista pasajeros;
start savingdata/lista_pasajeros.sql
prompt cargando datos tripulacion;
start savingdata/tripulacion.sql
prompt cargando datos equipaje;
start savingdata/equipaje.sql
prompt cargando datos en t_ubicacion;
start savingdata/t_ubicacion.sql
prompt haciendo commit;
commit;