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
	--variant gvcf/M004207A1_all.gvcf.gz \
	--variant gvcf/M004500E9_all.gvcf.gz \
	--variant gvcf/M006413D9_all.gvcf.gz \
	--variant gvcf/M010969G4_all.gvcf.gz \
	--variant gvcf/M011816F9_all.gvcf.gz \
	--variant gvcf/M011827G10_all.gvcf.gz \
	--variant gvcf/M012772H10_all.gvcf.gz \
	--variant gvcf/M017312G7_all.gvcf.gz \
	--variant gvcf/M022098G2_all.gvcf.gz \
	--variant gvcf/M022154F10_all.gvcf.gz \
	--variant gvcf/M026459C9_all.gvcf.gz \
	--variant gvcf/M031524A6_all.gvcf.gz \
	--variant gvcf/M031532_all.gvcf.gz \
	--variant gvcf/M031581G5_all.gvcf.gz \
	--variant gvcf/M031969_all.gvcf.gz \
	--variant gvcf/M032051B1_all.gvcf.gz \
	--variant gvcf/M032314_all.gvcf.gz \
	--variant gvcf/M032322H7_all.gvcf.gz \
	--variant gvcf/M032347E2_all.gvcf.gz \
	--variant gvcf/M032400_all.gvcf.gz \
	--variant gvcf/M032424C1_all.gvcf.gz \
	--variant gvcf/M034517F2_all.gvcf.gz \
	--variant gvcf/M035431H5_all.gvcf.gz \
	--variant gvcf/M037594_all.gvcf.gz \
	--variant gvcf/M038012_all.gvcf.gz \
	--variant gvcf/M038321_all.gvcf.gz \
	--variant gvcf/M038472_all.gvcf.gz \
	--variant gvcf/M040627_all.gvcf.gz \
	--variant gvcf/M040628_all.gvcf.gz \
	-O gvcf/1founders_all.gvcf.gz

