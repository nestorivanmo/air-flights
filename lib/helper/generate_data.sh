#!/bin/sh
echo "How many thousand datapoints?"
read counter
echo "output file"
read newfilename
true > data.sql
for ((i=0; i<counter; i++)); do
  curl "https://api.mockaroo.com/api/197290a0?count=1000&key=e361cf60" >> $newfilename
done
echo all done
