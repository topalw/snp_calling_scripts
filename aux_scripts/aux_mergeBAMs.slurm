#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=08:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --job-name=mergeBAM
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc samtools gatk openjdk/1.8.0_265-b01 python

### this is run /sample ###
# like awk '{print "sbatch 1.2_mergeBAMs.slurm " $1}' uniq_samples.list | bash

sample=$1 #library ID
files=`ls "$sample"*.bam` #list all files with LibraryId
sorted="$sample".bam #sorted output + input to Mark duplicates
output="$sample"_markdup.bam
# merge bams + sort
samtools merge --threads 4 - `echo $files` | samtools sort -o $sorted -@ 4
# index
samtools index $sorted -@ 4
# markduplicates
gatk MarkDuplicatesSpark -I $sorted -O $output

mkdir $sample 
rm $sorted
rm ${sorted}.bai
#rm $files
mv ${sample}_* ${sample}/
# added the _ to escape the error of trying to move the directory in itself ... check if it works 
