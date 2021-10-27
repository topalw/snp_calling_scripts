#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=48G
#SBATCH --job-name=CombineGVCF
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc gatk
module load openjdk/1.8.0_265-b01
sample1="$1"/"$1"_1.list.gvcf.gz
sample2="$1"/"$1"_2.list.gvcf.gz
sample3="$1"/"$1"_3.list.gvcf.gz
out="$1"/"$1"_all.gvcf.gz
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta' # make relative!

gatk CombineGVCFs \
	-R $ref \
	--variant $sample1 \
	--variant $sample2 \
	--variant $sample3 \
	-O $out
