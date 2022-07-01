#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=03:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --job-name=Trimm
#SBATCH --account jgoudet_barn_owl

# submission is accompanied by each element of uniq_prefix.list 
# like > awk '{print "sbatch 1.0_trim.slurm " $1 }' ../uniq_prefix.list | bash
prefix=${1}
cd ..

source /dcsrsoft/spack/bin/setup_dcsrsoft 
module load gcc
module load trimmomatic/0.39

#1.0 trimming
forward_in="$prefix"_R1.fq.gz
reverse_in="$prefix"_R2.fq.gz
forward_out_paired="$prefix"_R1_paired.fq.gz
forward_out_unpaired="$prefix"_R1_unpaired.fq.gz
reverse_out_paired="$prefix"_R2_paired.fq.gz
reverse_out_unpaired="$prefix"_R2_unpaired.fq.gz

trimmomatic PE -threads 4 -phred33 $forward_in $reverse_in \
$forward_out_paired $forward_out_unpaired \
$reverse_out_paired $reverse_out_unpaired \
MINLEN:70 \
ILLUMINACLIP:/software/UHTS/Analysis/trimmomatic/0.36/adapters/NexteraPE-PE.fa:2:30:10:3:"true"
# for Old-libraries without plexwell use TruSeq3-PE-2.fa
rm $forward_in $reverse_in $forward_out_unpaired $reverse_out_unpaired

