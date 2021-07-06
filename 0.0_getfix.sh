#!/bin/bash
cd ..

awk '{print "wget -q " $1}' links2 | bash
touch *.gz

echo 'Got files & touched them gently'

for file in *.gz; do
	run=`zcat $file | head -1 | cut -d ':' -f 2`
	sample=`echo $file | cut -d '_' -f 1`
	lane=`echo $file | cut -d '_' -f 2`
	direction=`echo $file | cut -d '_' -f 3`
	new_name="$sample"_"$run"_"$lane"_"$direction".fq.gz
	mv $file $new_name
	echo "$sample"_"$run"_"$lane" >> prefix.list
done

cat prefix.list | sort |uniq > uniq_prefix.list
