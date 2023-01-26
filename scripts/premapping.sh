#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=premapping
#SBATCH -D ./
#SBATCH --output=/work_beegfs/sunam235/day3/4_mapping/premapping.out
#SBATCH --error=/work_beegfs/sunam235/day3/4_mapping/premapping.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

# only changes in line 6,8,9

#module load miniconda3/4.7.12.1

#conda activate anvio
#conda activate /home/sunam226/.conda/envs/anvio


#fastqc
#module load fastqc
#cd /work_beegfs/sunam235/day2/0_raw_reads/
#for i in *.gz; do fastqc $i -o fastqc_folder/; done

#fastqc

#cd /work_beegfs/sunam235/day2/0_raw_reads/
#mkdir ../clean_reads
#for i in `ls *_R1.fastq.gz`;
#do
 #   second=`echo ${i} | sed 's/_R1/_R2/g'`
  #  fastp -i ${i} -I ${second} -R _report -o ../clean_reads/"${i}" -O ../clean_reads/"${second}" -t 6 -q 20

#done

# assembly
#cd /work_beegfs/sunam235/day2/clean_reads

                                       
#megahit -1 BGR_130527_R1.fastq.gz -1 BGR_130305_R1.fastq.gz -1 BGR_130708_R1.fastq.gz -2 BGR_130527_R2.fastq.gz -2 BGR_130305_R2.fastq.gz -2 BGR_130708_R2.fastq.gz --min-contig-len 1000 --presets meta-large -m 0.85 -o /work_beegfs/sunam235/day2/coassembly/ -t 20                      

#metaquast
#cd /work_beegfs/sunam235/day3/3_coassembly
#metaquast -t 6 -o /work_beegfs/sunam235/day3/3_metaquast -m 500 final.contigs.fa


anvi-script-reformat-fasta final.contigs.fa -o /work_beegfs/sunam235/day3/4_mapping/contigs.anvio.fa --min-len 1000 --simplify-names --report-file name_conversion.txt
#this prints the required resources into your logfile
jobinfo


  