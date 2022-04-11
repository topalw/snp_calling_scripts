#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --job-name=makeBED
#SBATCH --account jgoudet_barn_owl

module load gcc python/2.7.18

python2 bedFromMaskedFasta.py all_mask_150_50.fa > all_mask_150_50.bed
python2 bedFromMaskedFasta.py all_mask_150_90.fa > all_mask_150_90.bed
python2 bedFromMaskedFasta.py all_mask_150_95.fa > all_mask_150_95.bed

