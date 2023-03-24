#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --job-name=bcfconc
#SBATCH --account jgoudet_barn_owl
#SBATCH --mail-user alexandros.topaloudis@unil.ch
#SBATCH --mail-type FAIL

# Usage is .slurm path/to/BAM

module load gcc samtools

samtools index ${1}

