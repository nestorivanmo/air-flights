#!/bin/sh
echo "How many thousand datapoints?"
read counter
echo "output file"
read newfilename
true > data.sql
for ((i=0; i<=counter; i++)); do
  curl "https://api.mockaroo.com/api/4ffd5520?count=100&key=e361cf60" >> $newfilename
done
echo all done
