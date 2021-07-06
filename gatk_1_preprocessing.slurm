#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --job-name=markDup
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc gatk
module load openjdk/1.8.0_265-b01

input="$1"/"$1".bam
output="$1"/"$1"_markeddup.bam

gatk MarkDuplicatesSpark -I $input -O $output

rm $input
rm "$input".bai
