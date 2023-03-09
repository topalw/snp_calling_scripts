#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --job-name=merge00X
#SBATCH --account jgoudet_barn_owl

# USAGE IS awk '{print "sbatch aux_00X_merger.slurm " $1}' ../uniq_prefix1.list 

# This is meant to take all files that belong to the same run and lane but are indexed 001,002...etc 
# and merge them into one 
# these 00X files originate from old sequencing management in GTF and the modern approach is 001 only

cd ..

prefix=${1}
zcat ${prefix}_00* | gzip -c > ${prefix}.fq.gz 

echo "It worked see?"

