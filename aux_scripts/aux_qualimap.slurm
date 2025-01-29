#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --job-name=qualimap
#SBATCH --account jgoudet_barn_owl
module load gcc
module load qualimap

FILE=${1}
myPATH=`dirname $FILE`
SAMPLE=`basename $FILE _sorted.bam`
# check if dir exists else make it
if [ ! -e ${myPATH}/stats/${SAMPLE} ]
then
        mkdir ${myPATH}/stats/${SAMPLE}
fi
# make qualimap report 

qualimap bamqc -bam ${FILE} -gff ../0.lists/LG_scaffs.bed -nw 1000 \
-outdir ${myPATH}/stats/${SAMPLE} -nt 4 \
-outformat PDF:HTML --java-mem-size=24G 

