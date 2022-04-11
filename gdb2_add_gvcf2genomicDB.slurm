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
#ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'
interval="/users/atopalou/work/ref_genome_2020/contig_intervals/${2}_ss.list"

gatk GenomicsDBImport \
	-V $1 \
	--genomicsdb-update-workspace-path ../genomic_DB_refpanel/genDB_${2} \
	--intervals ${interval}
