#/bin/bash

##################################################################################################################################################################
################################   Programa basado en euristicas. Ya que los datos son aleatorios,     ###########################################################
################################   solo le interesa que haya suficientes para los 3 casos.             ###########################################################
################################   Toma los datos usados para los casos individuales                   ###########################################################
################################   Para el caso comun, crea los registros acorde a casos sobrantes.    ###########################################################
################################   el path del script bool2number debe ser el mismo que este archivo   ###########################################################
##################################################################################################################################################################
set -e
num_aviones=300

dh="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $dh
padherramienta=$(realpath bool2number.sh)
echo "Dame el path de tus datos"
read -p ">>" pad

if [ -z $pad ]; then
	pad="../data/"
fi

if ! cd $pad ;then
	echo "No existe ese directorio"
	exit 1000;
fi



##Eliminamos las que sean solo falsas
awk '!/false, false/' avion.sql > data_avion ##Data avion tendrá los registros plausibles
##Tomamos aquellas que sean solo carga
awk '/true, false/' data_avion	| head -n $num_aviones > avion_carga

##Tomamos aquellas que sean solo pasajeros
awk '/false, true/' data_avion | head -n $num_aviones > avion_comercial

##Ambos
awk '/true, true/' data_avion | head -n $num_aviones >avion_ambos



a=$(wc -l "avion_carga" )
b=$(wc -l "avion_carga.sql")
if [ a \> b ];then
	echo "Maldita sea, los aviones para carga son más que los datos que tienes"
	exit 1000
fi;

c=$(wc -l "avion_comercial" )
d=$(wc -l "avion_comercial.sql") 
if [ a \> b ];then
	        echo "Maldita sea, los aviones comerciales son más que los datos que tienes"
		exit 1000
fi;

echo "Todo bien con los datos"

##Concatenamos tipo_avion con sql de avion_carga, ignoramos sentencias vacias
##Esto toma en cuenta que  count(avion_carga) < count(avion_carga.sql) & count(avion_comercial) < count(avion_comercial.sql)
paste -d '\n' avion_carga avion_carga.sql | sed '1,/^$/!d' | sed '$d' > avion_carga_intercalado
paste -d '\n' avion_comercial avion_comercial.sql | sed '1,/^$/!d' |sed '$d' > avion_comercial_intercalado

sort avion_carga.sql > sorted_avion_carga.sql
sort avion_comercial.sql > sorted_avion_comercial.sql
sort avion_carga_intercalado > sorted_a_carga_i
sort avion_comercial_intercalado > sorted_a_comercial_i

comm -23 sorted_avion_carga.sql sorted_a_carga_i > restantes_carga
comm -23 sorted_avion_comercial.sql sorted_a_comercial_i > restantes_comercial

paste -d '\n' avion_ambos restantes_carga restantes_comercial | sed '1,/^$/!d' | sed '$d' > avion_ambos_raw

##Se insertan ambos registros, si sobran borramos
ultima=$(tail -1 "avion_ambos_raw")
if [[ $ultima == *" avion "* ]];then
	sed '$d' avion_ambos_raw > avion_ambos_intercalado;
elif [[ $ultima == *" avion_carga "* ]];then
	sed '$d' avion_ambos_raw > avion_ambos_intercalado;
	sed '$d' avion_ambos_raw > avion_ambos_intercalado;
else
	cat avion_ambos_raw > avion_ambos_intercalado
fi
cat avion_ambos_intercalado > aviones_combinados.sql
cat avion_carga_intercalado >> aviones_combinados.sql
cat avion_comercial_intercalado >> aviones_combinados.sql

rm avion_ambos_raw *_intercalado
rm sorted_*
rm restantes*
rm data_avion avion_carga avion_comercial avion_ambos

$padherramienta aviones_combinados.sql
echo "Terminado (No significa que bien :P)"
