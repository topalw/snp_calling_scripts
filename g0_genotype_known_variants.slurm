#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=24G
#SBATCH --job-name=GenotypeGVCF
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc gatk
module load openjdk/1.8.0_265-b01

#usage is .slurm SampleID as long as sample files are in their folders through 1.2_mergeBAMs.slurm

# this is a list of snps from a vcf file as scaffold:position
variants='/users/atopalou/work/snps_to_genotype.list'

ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'

# change these accordingly
gvcf="$1"/"$1"_all.gvcf.gz
vcf="$1"/"$1".vcf.gz

# genotype the gvcf on the list of positions!
gatk GenotypeGVCFs \
	-R $ref \
	--include-non-variant-sites true \
	-V $gvcf \
	-L $variants \
	-O $vcf


