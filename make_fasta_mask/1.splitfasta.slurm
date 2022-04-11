#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=48G
#SBATCH --job-name=splitF
#SBATCH --account jgoudet_barn_owl

module load gcc 

./seqbility-20091110/splitfa ~/work/ref_genome_2020/Tyto_reference_Jan2020.fasta 150 | split -l 20000000 


