#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=06:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --job-name=mergeBAM
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc
module load samtools

### this is run /sample ###
sample=$1
files=`ls "$sample"*.sam`
#echo $files
outbam="$sample"_unsorted.bam
sorted="$sample".bam

samtools merge --threads 4 $outbam `find . -name "$sample*.sam"`
samtools sort $outbam -o $sorted -@ 4
samtools index $sorted -@ 4

mkdir $sample 
rm $files
rm $outbam
mv $sample* $sample
