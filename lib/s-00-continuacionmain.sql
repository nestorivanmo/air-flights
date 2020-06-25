start s-10-consultas.sql
connect em_proy_admin/ema;
start s-15-fx-consulta-id-pasajero.sql
start s-15-fx-consulta-vuelo.sql
start s-15-fx-obten-aviones.sql
start s-16-fx-consulta-id-pasajero-prueba.sql
start s-16-fx-consulta-vuelo-prueba.sql
start s-16-fx-obten-aviones-prueba.sql

-- lo ponemos aquí, porque sino al terminar la sesion se pierden los datos
start s-11-tr-registro-ubicaciones.sql
start s-12-tr-registro-ubicaciones-prueba.sql


start s-13-p-auditoria-tipo-paquetes.sql
start s-13-p-generacion-pase-abordar.sql
start s-14-p-auditoria-tipo-paquetes-prueba.sql
start s-14-p-generacion-pase-abordar-prueba.sql


start s-11-tr-pase-abordar.sql
start s-11-tr-valida-tripulacion.sql


start resultados-proyecto-final.sql