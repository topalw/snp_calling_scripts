#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=48G
#SBATCH --job-name=HaplotypeCaller
#SBATCH --account jgoudet_barn_owl

### USAGE is sampleID [1,2,3] (which corresponds to interval) ###

cd ..
module load gcc gatk
module load openjdk/1.8.0_265-b01
sample="$1"/"$1"_markdup_bqsr.bam #input file mardup_bqsr.bam
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta' # reference path (make relative!)
interval="/users/atopalou/work/ref_genome_2020/contig_intervals/${2}.list" # reference subset path (make relative!)

#output = individual/individual_interval.gvcf.gz
# make individual gvcf
gatk HaplotypeCaller \
	-R $ref \
	-I $sample \
	-O "$1"/"$1"_"$2".gvcf.gz \
	-ERC GVCF \
	--pcr-indel-model NONE \
	-L $interval

