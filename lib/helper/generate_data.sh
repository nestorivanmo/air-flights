#!/bin/sh
echo "How many thousand datapoints?"
read counter
true > data.sql
for ((i=0; i<=counter; i++)); do
  curl "https://api.mockaroo.com/api/197290a0?count=1000&key=e361cf60" >> data.sql  
done
echo all done
