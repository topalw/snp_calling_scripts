#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=48G
#SBATCH --job-name=mask
#SBATCH --account jgoudet_barn_owl
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=alexandros.topaloudis@unil.ch

module load gcc bwa
ref='~/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'

for f in x*.sam.gz; do cat ${f} >> all.sam.gz; done

gunzip -c all.sam.gz | ./seqbility-20091110/gen_raw_mask.pl > all_rawMask_100.fa

./seqbility-20091110/gen_mask -l 150 -r 0.5 all_rawMask_100.fa > all_mask_150_50.fa
./seqbility-20091110/gen_mask -l 150 -r 0.9 all_rawMask_100.fa > all_mask_150_90.fa
./seqbility-20091110/gen_mask -l 150 -r 0.95 all_rawMask_100.fa > all_mask_150_95.fa

