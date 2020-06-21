#!/bin/sh
echo "How many thousand datapoints?"
read counter
echo "output file"
read newfilename
echo "url"
read url
for ((i=0; i<counter; i++)); do
  curl "$url" >> $newfilename
done
echo all done
