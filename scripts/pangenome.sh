#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=500M
#SBATCH --time=00:05:00
#SBATCH --job-name=pangenomedb
#SBATCH -D ./
#SBATCH --output=/work_beegfs/sunam235/Day6/03_pangenome/pangenomedb.out
#SBATCH --error=/work_beegfs/sunam235/Day6/03_pangenome/pangenomedb.out
#SBATCH --partition=all
#SBATCH --reservation=biol217


conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
cd /work_beegfs/sunam235/Day6/03_pangenome
anvi-gen-genomes-storage -e /work_beegfs/sunam235/Day6/03_pangenome/external-genomesnew.txt -o methano-GENOMES.db

anvi-pan-genome -g methano-GENOMES.db --project-name methanopangenome --num-threads 10

# provides information on resource requirements as stdout
jobinfo