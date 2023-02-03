# Day 6
start with interactive interface

    srun --reservation=biol217 --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 /bin/bash


activate conda environment

    conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1


direct to folder 02_contigs-dbs in day6

start anvi'o interactive display


    anvi-display-contigs-stats *db



New terminal

    ssh -L 8060:localhost:8085 sunam235@caucluster-old.rz.uni-kiel.de
    ssh -L 8085:localhost:8085 node010


# Questions

- How do the MAGs compare in size and number of contigs to the full genome?
    - MAGSs are smaller than full genome approx 1/3-2/3 of full genome
    - MAGs have a higher numer of contigs, full genome: 1 contig, MAGs: >100 contigs
  - 
- Based on the contig numbers, sizes and number of marker genes (HMM hits), which two MAGs are the best and which is the worst?
    - best: Bin_13, Bin_8 (low number of contigs, N50 better than Bin_9)
    - worst: Bin_5 (highest number of contigs + highest difference in hmm hit to full genome, lowest N50)

create external genomes file

    anvi-script-gen-genomes-file --input-dir ../02_contigs-dbs -o /work_beegfs/sunam235/Day6/03_pangenome/external-genomes.txt 


check with cat or tail


>name    contigs_db_path
Methano_Bin1    /work_beegfs/sunam235/Day6/02_contigs-dbs/Bin1.db
Methano_Bin10   /work_beegfs/sunam235/Day6/02_contigs-dbs/Bin10.db
Methano_Bin13   /work_beegfs/sunam235/Day6/02_contigs-dbs/Bin13.db
Methano_Bin3    /work_beegfs/sunam235/Day6/02_contigs-dbs/Bin3.db
Methano_Bin5    /work_beegfs/sunam235/Day6/02_contigs-dbs/Bin5.db
Methano_Bin8    /work_beegfs/sunam235/Day6/02_contigs-dbs/Bin8.db
Methano_Bin9    /work_beegfs/sunam235/Day6/02_contigs-dbs/Bin9.db
Methano_Mflavescens     /work_beegfs/sunam235/Day6/02_contigs-dbs/Mflavescens.db 


estimate genome completeness

    anvi-estimate-genome-completeness -e external-genomes.txt > genome-completeness.txt

 >y-txt saves table of genome completement as textfile

 
 ![file](scripts/external-genomes-txt)

 completion >70% , redundancy < 10%
 
 remove bad bins -> move to bad_bin folder in 02_contigs_db

make new external genomes file txt without bad bins again

    anvi-script-gen-genomes-file --input-dir ../02_contigs-dbs -o /work_beegfs/sunam235/Day6/03_pangenome/external-genomesnew.txt 

create pangenome database

first genome storage database (Summary of bins), second pangenome database(clustering, alignment AA sequences, homogeneity)

- sbatch: ![file](scripts/pangenome.sh)

calculate genome similarity with ANI
- sbatch: ![file](scripts/ANI.sh)
    - programs: PAYANI-> low amount of genomes, high amount> fastani


Visualization

    srun --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 --reservation=biol217 --partition=all /bin/bash

    conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

    anvi-display-pan -p methanopangenome-PAN.db -g ../methano-GENOMES.db -P 8082
  P =own Port
  

        ssh -L 8060:localhost:8082 sunam235@caucluster-old.rz.uni-kiel.de 
        ssh -L 8082:localhost:8082 node010



# visualize in browser

tasks
- Remove combined homogeneity, functional homogeneity, geometric homogeneity, max num parsimonay, number of genes in gene cluster and number of genomes gene cluster has hits from the active view. Tip: Play with Height  
- Create a "Bin-highlight" including alls SCGs and name it accordingly.

- Cluster the genomes based on Frequency

Question: Based on the frequency clustering of genes, do you think all genomes are related? Why? yes but here are two clusteres that are closer related, full genome and bin 9 and the rest.

- Highlight your reference genome in one color, its closest relative in a similar one, and distict genomes in a third colour.
  
Question: How does the reference genome compare to its closest bin?
Bin9 and fullgenome approx 1/3 of genes similar, frequencies slightly different, GC- content same

- Go to Layers and remove Num gene clusters, Singeltons, Genes per kbp and Total length from view. Add ANI_percentage_identity to the view and play with the threshold.

Question: What ranges are used determine a prokaryotic species? How high can you go until you see changes in ANI? What does the ANI clustering tell you about genome relatedness? ANI species cut off 95%; changes : 0.7 Min; shows if 95% cutoff-> clustered buns related on species level



functional Profiling


- Using the Search Function, highlight all genes in the KEGG Module for Methanogenesis
- Create a new bin called "Methanogenesis" and store your search results in this bin.

Question: How are Methanogenesis genes distributed across the genome? across whole genome

![image](images/methanopangenome.svg)

# Functional/geometric homogeneity and their uses

- Using search parameters, find a gene which occurs:
    - in all genomes  
    - maximum of 1 times (Single copy gene) 
    - has a high variability in its functional homogeneity (max. 0.80)

This gene will be highly conserved, but has diversified in its AA make-up.

- Highlight the found genes on the interface. Inspect one of the gene-clusters more closely (Inspect gene-cluster).

Question: What observations can you make regarding the geometric homogeneity between all genomes and the functional homogeneity? genetic homogeneity higher in gene cluster than funct. homogeneity

![image](images/Screenshot%20from%202023-01-30%2015-48-01.png)

BlastKoala

Task: Check out the BlastKOALA Results for this Methanogen.

Reconstruct its pathways and check out what it can do.

Question: Can the organism do methanogenesis? Does it have genes similar to a bacterial secretion system? yes, 7:)