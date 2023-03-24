#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=06:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --job-name=bcfconc
#SBATCH --account jgoudet_barn_owl
#SBATCH --mail-user alexandros.topaloudis@unil.ch
#SBATCH --mail-type FAIL

# Usage is .slurm path/to/input_file_list path/to/output_file

module load gcc bcftools 

bcftools concat -O z -o ${2} --threads 4 -f ${1}
