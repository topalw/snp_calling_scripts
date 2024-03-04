#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --job-name=HaplotypeCaller
#SBATCH --account jgoudet_barn_owl

## USAGE is sbatch g1_make_gvcf.slurm sampleID [1,2....10] (which corresponds to interval) ###
## 

cd ..
module load gcc gatk
module load openjdk/1.8.0_265-b01 python
sample="$1"/"$1"_markdup_bqsr.bam #input file mardup_bqsr.bam CARE FOR NAMING

ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta' # reference path
interval="snp_calling_scripts/contig_intervals/${2}_ss.list" # reference subset path 

#output = individual/individual_interval.gvcf.gz
# make individual gvcf
gatk HaplotypeCaller \
	-R $ref \
	-I $sample \
	-O "$1"/"$1"_"$2".gvcf.gz \
	-ERC GVCF \
	--pcr-indel-model NONE \
	-L $interval

