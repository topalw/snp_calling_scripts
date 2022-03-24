#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G
#SBATCH --job-name=HaplotypeCaller
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc gatk
module load openjdk/1.8.0_265-b01
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'

gatk CombineGVCFs \
	-R $ref \
	--variant files.list \
	-O hubs_all.gvcf.gz

