#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=48G
#SBATCH --job-name=map
#SBATCH --account jgoudet_barn_owl
cd ..
module load gcc
module load bwa
module load samtools

# run like awk '{print "sbatch 1.1_map.slurm " $1}' ../uniq_prefix.list | bash

# MAPPING
prefix=$1
in_forward="$prefix"_R1_paired.fq.gz
in_reverse="$prefix"_R2_paired.fq.gz
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'
mapped="$prefix"_mapped.sam

bwa mem -M -t 12 $ref $in_forward $in_reverse > $mapped

# this is not exactly optimized in storage space since it needs the sam file to read line1
# maybe there is a way to optimize storage by only using bam and then samtools view | head -n 1 ... TO DO
# add RG and make bam
file=$in_forward
individual=$(echo $file | awk -F"_" '{print $1}')
l1=`zcat $file | head -1`
ID=$(echo $l1 | awk -F":" '{print $2"."$3"."$4}')
BC=$(echo $l1 | awk -F":" '{print $10}')
SM=$individual
perf_lane_bam="$prefix"_perf.bam

samtools addreplacerg -r "ID:$ID" \
	-r "BC:$BC" \
	-r "CN:GTF" \
	-r "LB:$SM" \
	-r "PL:ILLUMINA" \
	-r "PM:NovaSeq6000" \
	-r "SM:$SM" \
	$mapped | samtools sort -o $perf_lane_bam -O bam

rm $mapped
