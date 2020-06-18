#/bin/bash
##Eliminamos las que sean solo falsas
awk '!/false, false/' data > data_avion
##Tomamos aquellas que sean solo carga
awk '/true, false/' data_avion > avion_carga

##Tomamos aquellas que sean solo pasajeros
awk '/false, true/' data > avion_pasajeros

##Ambos
awk '/true, true/' data >avion_ambos

a=$(wc -l "avion_carga" )
b=$(wc -l "avion_carga.sql")
if [ a \> b ];then
	echo "Maldita sea, los aviones para carga son más que los datos que tienes"
	exit 1000
fi;
echo "Carga: $a"
echo "Datos: $b"

c=$(wc -l "avion_pasajeros" )
d=$(wc -l "avion_comercial.sql") 
if [ a \> b ];then
	        echo "hola"
		exit 1000
fi;
echo "Pasajeros: $c"
echo "Datos: $d"


##Concatenamos tipo_avion con sql de avion_carga, ignoramos sentencias vacias
##Esto toma en cuenta que  count(avion_carga) < count(avion_carga.sql) & count(avion_pasajeros) < count(avion_comercial.sql)
paste -d '\n' avion_carga avion_carga.sql | sed '1,/^$/!d' | sed '$d' > avion_carga_intercalado
paste -d '\n' avion_pasajeros avion_comercial.sql | sed '1,/^$/!d' |sed '$d' > avion_comercial_intercalado


comm -23 
