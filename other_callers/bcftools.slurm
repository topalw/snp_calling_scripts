#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --job-name=BCF_SNP
#SBATCH --account jgoudet_barn_owl
#SBATCH -o OUT/%x_%A.stdout
#SBTACH -e OUT/%x_%A.stderr

# run with listofBAMs_file.txt and Super-Scaffold 
# Z ss should be handled separately due to ploidy 

module load bcftools htslib 

bams=${1}
SS=${2:-Super-Scaffold_1}
REF="/users/atopalou/work/ref_genome_2020/Tyto_reference_Jan2020.fasta"

ulimit -n 3000

bcftools mpileup -B -q 20 -Q 20 -a "INFO/AD,AD,DP" -f ${REF} -t ${SS} -Ou -b ${bams} | bcftools call -V indels -mv -Ou | bcftools view -m2 -M2 | bcftools filter -e 'QUAL<20' | bcftools filter -e 'F_MISSING>0.2' | bcftools query -f "%CHROM\t%POS\t%REF\t%ALT"> ${SS}.pos.txt

#tabix ${SS}_call.vcf.gz
