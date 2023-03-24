#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=48G
#SBATCH --job-name=FreeBayes
#SBATCH --account jgoudet_barn_owl

module load gcc freebayes samtools
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'
founders_vcf='/users/atopalou/work/all_CH_joint_calling/filtering/founders_merged_5.vcf.gz'
sample=$1
bam=../"$1"/"$1"_markeddup.bam
out=../"$1"/"$1"_freebayes.vcf

freebayes -f $ref -@ $founders_vcf $bam > $out
