#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=00:30:00
#SBATCH --job-name=grabfiles
#SBATCH -D ./
#SBATCH --output=/work_beegfs/sunam235/day7/grabfiles.out
#SBATCH --error=/work_beegfs/sunam235/day7/grabfiles.out
#SBATCH --partition=all
#SBATCH --reservation=biol217

# only changes in line 6,8,9

module load miniconda3/4.7.12.1

#conda activate /home/sunam226/.conda/envs/grabseq

cd /work_beegfs/sunam235/day7/fastq

#grabseqs -t 4 -m metadata.csv SRR4018516
#grabseqs -t 4 -m metadata.csv SRR4018515
#grabseqs -t 4 -m metadata.csv SRR4018514
#grabseqs -t 4 -m metadata.csv SRR4018517
fasterq-dump SRR4018516
fasterq-dump SRR4018515
fasterq-dump SRR4018514
fasterq-dump SRR4018517

jobinfo


