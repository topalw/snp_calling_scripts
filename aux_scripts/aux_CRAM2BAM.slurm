#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=00:40:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --job-name=CRAM2BAM
#SBATCH --account jgoudet_barn_owl

module load gcc
module load samtools

ref="/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta"

bam=`basename ${1} .cram`".bam"

samtools view -@ 8 -T ${ref} -C -o ../1.data/3.old_bam/${bam} ${1}
