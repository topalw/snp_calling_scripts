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
# run /sample
module load gcc gatk
module load openjdk/1.8.0_265-b01

ls ${1}/*.gvcf.gz > ${1}/${1}.files.list
out=${1}/${1}_all.gvcf.gz

ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta' # make relative!

gatk CombineGVCFs \
	-R $ref \
	--variant ${1}/${1}.files.list \
	-O $out
