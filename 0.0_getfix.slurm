#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --job-name=getfq
#SBATCH --account jgoudet_barn_owl

# USAGE IS script links_file 

# CARE that this script assumes that files are named Sample_lane_R1/R2).... 

cd ..

awk '{print "wget -q " $1}' $1 | bash
touch *.gz # important so as not to remove old files in scratch

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

# make auxillary files to submit later scripts 

cat prefix.list | sort |uniq > uniq_prefix.list
cat uniq_prefix.list | cut -d '_' -f 1 | sort | uniq > uniq_samples.list
rm prefix.list

