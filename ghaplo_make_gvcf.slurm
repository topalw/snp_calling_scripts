#!/bin/bash
#SBATCH --mail-user alexandros.topaloudis@unil.ch
#SBATCH --mail-type FAIL
#SBATCH --partition cpu
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --job-name=HaploGVCF
#SBATCH -o %x_%A_%a.stdout
#SBTACH -e %x_%A_%a.stderr
#SBATCH --export=NONE
#SBATCH --account jgoudet_barn_owl

#Load the modules
module load gcc gatk samtools bcftools
module load openjdk/1.8.0_265-b01 python

# RUN like sbatch ghaplo_make_gvcf.slurm path/to/interval path/to/bam" 

ref="/users/atopalou/scratch/5.new_genome/reference/owl_hap1_Chick.fa"

bam=${2}
interval=${1}
# make name that will be used for naming the output CARE ASSUMES FILES ARE X_interval.list
interval_name=`basename ${interval} | sed 's/_interval.list//g'`
# take base name of file to use for output
base=`basename ${bam}`
out=`echo ${bam}| sed 's/_markdup.bam//g'`_${interval_name}.gvcf.gz

gatk HaplotypeCaller \
	-R ${ref} \
	-I ${bam} \
	-L ${interval} \
	--pcr-indel-model NONE \
	-ERC GVCF \
	--sample-ploidy 1 \
	-O ${out}
