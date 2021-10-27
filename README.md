# snp_calling
Scripts for snp calling

The pipeline is 
1. Get scripts folder inside the your working directory (ex. data/scripts). 
2. Copy file links into a file in working directory and run locally `<0.0_getfix.sh link_file_name>`
3. Submit 1.0_trim.slurm like so `<awk '{print "sbatch 1.0_trim.slurm " $1}' ../uniq_prefix.list | bash >`
4. Submit 1.1_map.slurm like so `<awk '{print "sbatch 1.1_map.slurm " $1}' ../uniq_prefix.list | bash >`
5. Now for the merge you no longer run / unique lane but per sample so `<awk '{print "sbatch 1.2_mergeBAMs.slurm " $1}' ../uniq_samples.list | bash >`
6. Now you have MarkedDuplicated bam files for each individual and you can choose to produce the individual gvcf with g1_make_gvcf.slurm like so
`<sbatch g1_make_gvcf.slurm sample_name [1.list/2.list/3.list] >` for each list of genomic intervals in the reference/contig_intervals folder
7. Then gather the 3 gvcf intervals with g2 as `<sbatch g2_gather_intervals.slurm sample_name>` 
8. You can now either genotype a set of known snps with g0 or merge multiple samples and do a joint calling with g3 and g4
