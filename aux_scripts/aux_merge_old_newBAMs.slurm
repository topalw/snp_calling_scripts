#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=36G
#SBATCH --job-name=mergeBAM
#SBATCH --account jgoudet_barn_owl

module load samtools 

### this is run /sample ###

sample=$1 #library ID
new=../1.data/2.bam/${sample}.bam 
old=../1.data/3.old_bam/${sample}.bam 
sorted=../1.data/4.merged_bam/${sample}_sorted.bam
# merge bams + sort
samtools merge --threads 4 - $new $old | samtools sort -o $sorted -@ 4
# index
samtools index $sorted -@ 4

