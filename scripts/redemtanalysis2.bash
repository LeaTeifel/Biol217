#!/bin/bash
#SBATCH --job-name=reademption
#SBATCH --output=reademption.out
#SBATCH --error=reademption.out
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --qos=long
#SBATCH --time=0-05:00:00
#SBATCH --partition=all
#SBATCH --export=NONE
#SBATCH --reservation=biol217

source ~/.bashrc

#activating conda
module load miniconda3/4.7.12.1
conda activate /home/sunam226/.conda/envs/reademption
#for rna seq
reademption align -p 4 --poly_a_clipping --project_path READemption_analysis
reademption coverage -p 4 --project_path READemption_analysis
reademption gene_quanti -p 4 --features CDS,tRNA,rRNA --project_path READemption_analysis
reademption deseq -l InSPI2_R1.fa.bz2,InSPI2_R2.fa.bz2,LSP_R1.fa.bz2,LSP_R2.fa.bz2 -c InSPI2,InSPI2,LSP,LSP -r 1,2,1,2 --libs_by_species salmonella=InSPI2_R1,InSPI2_R2,LSP_R1,LSP_R2 --project_path READemption_analysis
#for plots
reademption viz_align --project_path READemption_analysis
reademption viz_gene_quanti --project_path READemption_analysis
reademption viz_deseq --project_path READemption_analysis
conda deactivate
jobinfo