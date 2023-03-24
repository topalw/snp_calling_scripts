#!/bin/bash

# run ./scipt path/to/individual/list

cp ${1} ${1}2
sed -i -e 's/^/..\//g' ${1}
sed -i -e 's/^/\//g' ${1}2 ; sed -i -e 's/$/_markdup.bam/g' ${1}2
paste -d '' ${1} ${1}2 > ${1}3 ; mv ${1}3 ${1}; rm ${1}2 


