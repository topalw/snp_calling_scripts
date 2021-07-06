#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=24G
#SBATCH --job-name=map
#SBATCH --account jgoudet_barn_owl
cd ..
module load gcc
module load bwa
module load samtools

prefix=$1
in_forward="$prefix"_R1_paired.fq.gz
in_reverse="$prefix"_R2_paired.fq.gz
ref='/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta'
mapped="$prefix"_mapped.sam

bwa mem -M -t 12 $ref $in_forward $in_reverse > $mapped

file=$in_forward
individual=$(echo $file | awk -F"_" '{print $1}')
l1=`zcat $file | head -1`
ID=$(echo $l1 | awk -F":" '{print $2"."$3"."$4}')
BC=$(echo $l1 | awk -F":" '{print $10}')
SM=$individual
perf_lane_bam="$prefix"_perf.sam

samtools addreplacerg -r "ID:$ID" \
	-r "BC:$BC" \
	-r "CN:GTF" \
	-r "LB:$SM" \
	-r "PL:ILLUMINA" \
	-r "PM:HiSeq4000" \
	-r "SM:$SM" \
	-o $perf_lane_bam $mapped

rm $mapped
