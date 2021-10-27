#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=96G
#SBATCH --job-name=JointGenotyping
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc gatk
module load openjdk/1.8.0_265-b01
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta' #make relative!
interval=/users/atopalou/work/ref_genome_2020/contig_intervals/"$1" #make relative!
# change these accordingly
inputgvcf=all_founders.gvcf.gz 
outputvcf=all_founders_joint_"$1".vcf.gz

# genotype population-merged gvcf for each interval
gatk GenotypeGVCFs -R $ref -L $interval	-V $inputgvcf -O $outputvcf
