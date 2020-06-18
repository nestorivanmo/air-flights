#/bin/bash
sed -i -e 's/true/0/g' $1
sed -i -e 's/false/1/g' $1
