--@Autor(es):       Hector Espino Rojas, Néstor Martínez Ostoa
--@Fecha creación:  15/06/2020
--@Descripción:     Carga inicial de los datos.


whenever sqlerror exit;
--
-- AVION / AVION_COMERCIAL / AVION_CARGA
--

--preparando avion
!../lib/helper/depurar.sh
start data/aviones_combinados.sql;
--
-- PASAJERO 20K
--
start data/pasajero.sql;
--
-- AEROPUERTO 1K
--
start data/aeropuerto.sql;
--
-- PUESTO ASIGNADO
--
start data/puesto_asignado.sql;
--
-- EMPLEADO
--
start data/empleado.sql;
--
-- URL_TRAYECTORIA
--
start data/url_trayectoria.sql
--
-- TIPO_PAQUETE
--
start data/tipo_paquete.sql;
--
-- PAQUETE (1-20000)
--
start data/paquete.sql;
--
-- PASE_ABORDAR 11k
--
start data/pase_abordar.sql;
--
-- STATUS_VUELO
--
start data/status_vuelo.sql;
--
-- VUELO
--
start data/vuelo.sql;
--
-- LISTA UBICACIONES
--
start data/lista_ubicaciones.sql;
--
-- HISTORICO STATUS VUELO
--
start data/historico_status_vuelo.sql;
--
-- LISTA PAQUETES
--
start data/lista_paquetes.sql;
--
-- LISTA PASAJEROS
--
start data/lista_pasajeros.sql;
--
-- TRIPULACION
--
start data/tripulacion.sql;
