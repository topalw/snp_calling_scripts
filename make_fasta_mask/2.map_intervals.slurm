#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=48G
#SBATCH --job-name=splitF
#SBATCH --account jgoudet_barn_owl
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alexandros.topaloudis@unil.ch

# submit with for f in x*; do ./script.slurm $f; done
module load gcc bwa
ref='~/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'

bwa aln -R 1000000 -O 3 -E 3 ${ref} ${1} > ${1}.sai
bwa samse ${ref} ${1}.sai ${1} | gzip -c > ${1}.sam.gz 

