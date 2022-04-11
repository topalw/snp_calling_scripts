
1. get seqbillity from http://lh3lh3.users.sourceforge.net/download/seqbility-20091110.tar.bz2 with wget and cd; make
3. make sure the ref path is correct and that the modules are loaded correctly lol 
3. begin by splitting fasta into 150 k-mers and splitting the file into chunks of x length  

>sbatch 1.splitfasta.slurm 

4. then map every resulting file back to reference 

>for f in x*; do
>>sbatch 2.map_intervals.slurm $f 
>done


5. then merge alignments and create mask 

>sbatch 3.make_mask.slurm 


6. finally run the python script to turn the mask in bed

>python2 bedFromMaskedFasta.py all_mask_150_90.fa > all_mask_150_90.bed
