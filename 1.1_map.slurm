#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=14G
#SBATCH --job-name=map
#SBATCH --account jgoudet_barn_owl

module load bwa gatk openjdk python samtools

# SUBMIT script with the relative path to the trimmed R1 files ex $>  sbatch 1.1.map.slurm ../1.data/1.fq/ID1_whatever_R1.fq.gz 
# WATCH OUT - the way the renaming works is that R1 is changed to R2
# IF your directory contains 'R1' the code will fail
# I suggest using directory ../1.data/1.fq or sth similar

# parameter 
in_forward=${1}
# make reverse name by changing R1 to R2 
in_reverse=`echo $in_forward | sed 's/R1/R2/g'`
#individual name
individual=$(basename ${in_forward} | awk -F "_" '{print $1}')
# make bam directory if it doesnt exist 
if [ ! -e ../1.data/2.bam ] 
then 
	mkdir -p ../1.data/2.bam
fi 
# output will be there 
outbam=../1.data/2.bam/${individual}.bam # OUT

# reference - 
ref=/work/FAC/FBM/DEE/jgoudet/barn_owl/Common/ref_genome_2020/Tyto_reference_Jan2020.fasta
# prep RG line for bam 
l1=`zcat $in_forward | head -1` 
ID=$(echo $l1 | awk -F":" '{print $2"."$3"."$4}')
BC=$(echo $l1 | awk -F":" '{print $10}')
# triple pipe where we map, add @RG and then sort into a bam file
bwa mem -M -t 12 $ref $in_forward $in_reverse |\
samtools addreplacerg -r "ID:$ID" \
        -r "BC:$BC" \
        -r "CN:GTF" \
        -r "LB:$individual" \
        -r "PL:ILLUMINA" \
        -r "PM:NovaSeqX" \
        -r "SM:$individual" \
	-@ 12 - |\
samtools sort -@ 12 -o $outbam -O bam - 

# markduplicates
# output 
output=../1.data/2.bam/${individual}_markdup.bam
gatk --java-options  "-Xmx14G" MarkDuplicatesSpark -I ${outbam} -O ${output}

