#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=64G
#SBATCH --job-name=map
#SBATCH --account jgoudet_barn_owl
#SBATCH --mail-user topalei@gmail.com
#SBATCH --mail-type FAIL

cd ..
mkdir oct_tmp
module load gcc
module load miniconda3/4.9.2

ref='~/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'

~/venv/bin/octopus -R $ref -I "$1"/"$1".bam \
	--sequence-error-model PCR-free.HiSeq-4000 \
	--threads 24 \
	--target-working-memory 52Gb \
	--temp-directory-prefix oct_tmp \
	-o "$1".bcf

