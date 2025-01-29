#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --job-name=reheader
#SBATCH --account jgoudet_barn_owl
module load samtools

file=${1}
old=${2}
new=${3}

samtools reheader -c "sed -e s/SM:${old}/SM:${new}/g" ../1.data/3.old_bam/${file} > ../1.data/3.old_bam/${new}.bam 

rm ../1.data/3.old_bam/${file} 
