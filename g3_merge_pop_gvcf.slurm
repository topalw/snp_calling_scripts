#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G
#SBATCH --job-name=PopMerge
#SBATCH --account jgoudet_barn_owl

# run for every interval like so: sbatch script file.list.for.interval.x x

cd ..
module load gcc gatk
module load openjdk/1.8.0_265-b01
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'
interval="snp_calling_scripts/contig_intervals/${2}_ss.list"

#ls *.gvcf.gz > tmp.list
# the -L might be redundant but I kept it because I run for 3 intervals and the split it into 10 so I needed it
gatk CombineGVCFs \
	-R $ref \
	-V ${1} \
	-L $interval \
	-O new_intervals/ref_panel_full_${2}.gvcf.gz

