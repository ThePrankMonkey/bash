#!/bin/bash

arr=("admin.test.local"
     "lab.test.local"
     "centos.test.local"
     )

touch ./results
echo "" > ./results

for i in "${arr[@]}"
do
   echo "copying from $i"
   scp root@"$i":/etc/passwd ./temp
   cat ./temp >> ./results
done

touch ./findings
echo "" > ./findings
cat ./results | awk -F ':' '{ print $7 }' | sort | uniq -c | sort -nr > ./findings
HIGHEST="$(head -n 1 ./findings | tr -s " " | awk '{ print $1 }')"
grep "$HIGHEST /" ./findings
