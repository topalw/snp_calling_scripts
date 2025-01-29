#!/bin/bash
#SBATCH --partition cpu
#SBATCH --mail-user alexandros.topaloudis@unil.ch
#SBATCH --mail-type ALL
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --job-name=BAM2CRAM
#SBATCH --account jgoudet_barn_owl
module load gcc
module load bwa/0.7.17
module load samtools/1.15.1

ref="/scratch/atopalou/5.new_genome/reference/owl_hap1_Chick.fa"

cram=`echo ${1} | sed 's/_markdup.bam/.cram/g'`

samtools view -@ 8 -T ${ref} -C -o /users/atopalou/work/2.NEW_ASSEMBLY/2.LM3_mapped_CRAMs/${cram} ${1}
