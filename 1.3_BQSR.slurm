#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=05:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --job-name=BQSR
#SBATCH --account jgoudet_barn_owl

cd ..
module load gcc samtools gatk openjdk/1.8.0_265-b01 python 

#This is run / sample name when samples are in directories after 1.2 ... 
#care to give it the correct truthset... to improve input

bam="$1"/"$1"_markdup.bam
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'
truth='/users/atopalou/work/truth_set.vcf.gz'
table1="$1"/"$1"_recal_1.table
table2="$1"/"$1"_recal_2.table
output="$1"/"$1"_markdup_bqsr.bam

gatk BaseRecalibrator \
	-I $bam \
	-R $ref \
	--known-sites $truth \
	-O $table1

gatk ApplyBQSR \
	-I $bam \
	-R $ref \
	--bqsr-recal-file $table1 \
	-O $output

gatk BaseRecalibrator \
	-I $output \
	-R $ref \
	--known-sites $truth \
	-O $table2

gatk AnalyzeCovariates \
	-before $table1 \
	-after $table2 \
	-plots "$1"/"$1"_bqsr.pdf
