#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=600M
#SBATCH --time=00:02:00
#SBATCH --job-name=ANI
#SBATCH -D ./
#SBATCH --output=/work_beegfs/sunam235/Day6/03_pangenome/ANI.out
#SBATCH --error=/work_beegfs/sunam235/Day6/03_pangenome/ANI.out
#SBATCH --partition=all
#SBATCH --reservation=biol217


conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
cd /work_beegfs/sunam235/Day6/03_pangenome

anvi-compute-genome-similarity --external-genomes external-genomesnew.txt --program pyANI --output-dir ./ANI --num-threads 10 --pan-db methanopangenome/methanopangenome-PAN.db
#anvi-gen-genomes-storage -e /work_beegfs/sunam235/Day6/03_pangenome/external-genomesnew.txt -o methano-GENOMES.db

#anvi-pan-genome -g methano-GENOMES.db --project-name methanopangenome --num-threads 10

# provides information on resource requirements as stdout
jobinfo