#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G
#SBATCH --job-name=PopMerge
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc gatk
module load openjdk/1.8.0_265-b01
# USAGE is .slurm path/to/file.list (or path/to/gvcf) interval_names
#ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'
interval="contig_intervals/${2}_ss.list"

mkdir ../genomic_DB_refpanel/genDB_${2}

gatk GenomicsDBImport \
	-V ${1} \
	--genomicsdb-workspace-path ../genomic_DB_refpanel/genDB_${2} \
	--intervals ${interval} 
