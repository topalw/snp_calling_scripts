#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=100G
#SBATCH --job-name=map
#SBATCH --account jgoudet_barn_owl
#SBATCH --mail-user topalei@gmail.com
#SBATCH --mail-type FAIL

cd ..
mkdir oct_tmp
module load gcc
module load miniconda3/4.9.2

father=$1
mother=$2
kid=$3
ref='~/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'

~/venv/bin/octopus -R $ref -I "$1"/"$1".bam "$2"/"$2".bam "$3"/"$3".bam \
	-M "$2" -F "$1" \
	--sequence-error-model PCR-free.HiSeq-4000 \
	--threads 36 \
	--denovos-only \
	--target-working-memory 86Gb \
	--temp-directory-prefix oct_tmp \
	-o "$3"_denovo.bcf

