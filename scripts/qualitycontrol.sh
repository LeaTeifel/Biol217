#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=00:30:00
#SBATCH --job-name=qcontrol
#SBATCH -D ./
#SBATCH --output=/work_beegfs/sunam235/day7/fastq/fastqc.out
#SBATCH --error=/work_beegfs/sunam235/day7/fastq/fastqc.out
#SBATCH --partition=all
#SBATCH --reservation=biol217

# only changes in line 6,8,9

module load miniconda3/4.7.12.1

module load fastqc

conda activate /home/sunam226/.conda/envs/grabseq

cd /work_beegfs/sunam235/day7/fastq

for i in *.fastq; do fastqc -t 4 -o ./fastqc $i; done



jobinfo


