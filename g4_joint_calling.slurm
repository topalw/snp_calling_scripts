#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=82G
#SBATCH --job-name=JointCall
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc gatk openjdk/1.8.0_265-b01 python
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta' 
#interval=snp_calling_scripts/contig_intervals/${2}_ss.list #make relative!

# make output name
out=`echo ${1} | sed -e "s/gvcf.gz/vcf.gz/g" ` #| sed -e "s/new_intervals/joint_calling/g"` <- if you need to change destination dir


# genotype population-merged gvcf for each interval
 gatk GenotypeGVCFs -R $ref -V $1 -O $out
