#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --job-name=Trimm
#SBATCH --account jgoudet_barn_owl

# submission is accompanied by path of R1 file and an optional indicator of library preparation (nextera / truseq)
# for example $> sbatch 1.0.trim.slurm ../1.data/1.fq/ID_whatever_R1.fq.gz [nextera]
# resulting fq files are made where the input fq file is
# WATCH OUT - the way the renaming works is that R1 and R2 are changed to _paired / _unpaired 
# IF your directory contains these characters the code will fail 
# I suggest using directory ../1.data/1.fq or sth similar 

#mypath=`dirname ${file}`
module load trimmomatic fastqc 

# INPUT # 
forward_in=${1}
lib=${2:-nextera}

reverse_in=`echo ${1} | sed 's/R1/R2/g'`
forward_out_paired=`echo ${1} | sed 's/R1/R1_paired/g'` 
forward_out_unpaired=`echo ${1} | sed 's/R1/R1_unpaired/g'`
reverse_out_paired=`echo ${1} | sed 's/R1/R2_paired/g'`
reverse_out_unpaired=`echo ${1} | sed 's/R1/R2_unpaired/g'`

if [[ "$lib" == "truseq" ]]; then
	trimmomatic PE -threads 1 -phred33 $forward_in $reverse_in \
	$forward_out_paired $forward_out_unpaired \
	$reverse_out_paired $reverse_out_unpaired \
	ILLUMINACLIP:/software/UHTS/Analysis/trimmomatic/0.36/adapters/TruSeq3-PE-2.fa:2:30:10:3:"true"	\
	MINLEN:70 
else
	trimmomatic PE -threads 1 -phred33 $forward_in $reverse_in \
	$forward_out_paired $forward_out_unpaired \
	$reverse_out_paired $reverse_out_unpaired \
        ILLUMINACLIP:/software/UHTS/Analysis/trimmomatic/0.36/adapters/NexteraPE-PE.fa:2:30:10:3:"true" \
	MINLEN:70 
fi

# FASTQC quality control, the pre-trimmed fq are commented, if u want them uncomment
#fastqc ${forward_in} 
#fastqc ${reverse_in}
fastqc ${forward_out_paired}
fastqc ${reverse_out_paired}

#rm $forward_in $reverse_in $forward_out_unpaired $reverse_out_unpaired

