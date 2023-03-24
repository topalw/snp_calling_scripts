#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --job-name=getfq
#SBATCH --account jgoudet_barn_owl

# USAGE IS script links_file

# CARE that this script assumes that files are named Sample_lane_R1/R2)....

cd ..

awk '{print "wget -q " $1}' ${1}| bash
touch *.gz # important so as not to remove old files in scratch

echo 'Got files & touched them gently'

for file in *.gz; do
	run=`zcat $file | head -1 | cut -d ':' -f 2` 
	sample=`echo $file | cut -d '_' -f 1`
	lane=`echo $file | cut -d '_' -f 2`
	direction=`echo $file | cut -d '_' -f 3`
	identifier=`echo $file | cut -d '_' -f 4`
	new_name=${sample}_${run}_${lane}_${direction}_${identifier}.fq.gz
	mv $file $new_name
	echo ${sample}_${run}_${lane}_${direction} >> prefix.list
done

# make auxillary files to submit later scripts
sort prefix.list | uniq  > uniq_prefix1.list  #1 list to feed to aux_00X_merger.slurm
cat uniq_prefix1.list | cut -d '_' -f 1 | sort | uniq > uniq_samples.list
cut -d '_' -f 1,2,3 uniq_prefix1.list | sort | uniq > uniq_prefix.list #list to feed to 1.0 trim
rm prefix.list



