#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=binsummary
#SBATCH -D ./
#SBATCH --output=/work_beegfs/sunam235/Day5/5_anvio_profiles/binsummary.out
#SBATCH --error=/work_beegfs/sunam235/Day5/5_anvio_profiles/binsummary.out
#SBATCH --partition=all
#SBATCH --reservation=biol217

# only changes in line 6,8,9

module load miniconda3/4.7.12.1

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


#anvi-script-reformat-fasta final.contigs.fa -o /work_beegfs/sunam235/day3/4_mapping/contigs.anvio.fa --min-len 1000 --simplify-names --report-file name_conversion.txt

#step1
#bowtie2-build /work_beegfs/sunam235/day3/4_mapping/contigs.anvio.fa /work_beegfs/sunam235/day3/4_mapping/contigs.anvio.fa.index

#step2 

#cd /work_beegfs/sunam235/day3/2_fastp

#bowtie2 --very-fast -x /work_beegfs/sunam235/day3/4_mapping/contigs.anvio.fa.index -1 /work_beegfs/sunam235/day3/fastp/.fastq.gz -2 /PATH/TO/sample1_R2_clean.fastq.gz -S SAMPLE.sam
#loop
#for i in `ls *_R1.fastq.gz`;
#do 
 #  second=`echo ${i} | sed 's/_R1/_R2/g'`
  #bowtie2 --very-fast -x /work_beegfs/sunam235/day3/4_mapping/contigs.anvio.fa.index -1  ${i} -2 ${second} -S /work_beegfs/sunam235/day3/4_mapping/"$i".sam 
#done

#for i in `ls *mapped_R1.fastq.gz`;
#do
  #  second=`echo ${i} | sed 's/_R1/_R2/g'`
 #   bowtie2 --very-fast -x index -1 ${i} -2 ${second} -S "$i".sam 
#done

#samtool loop

#module load samtools

#
#for i in *.sam; do samtools view -bS $i > "$i".bam; done

conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

#cd /work_beegfs/sunam235/day3/5_anvio-profiles

#anvi-gen-contigs-database -f contigs.anvio.fa -o /work_beegfs/sunam235/day3/5_anvio-profiles/contigs.db -n 'biol217'

#anvi-run-hmms -c contigs.db

#sort and index bam files

#cd /work_beegfs/sunam235/day3/4_mapping
#for i in *.bam; do anvi-init-bam $i -o /work_beegfs/sunam235/day3/5_anvio-profiles/"$i".sorted.bam; done
#this prints the required resources into your logfile


#cd /work_beegfs/sunam235/day3/5_anvio-profiles/
#mkdir /work_beegfs/sunam235/day3/5_anvio-profiles/profiling/

#for i in `ls *.sorted.bam | cut -d "." -f 1`; do anvi-profile -i "$i".sam.bam.sorted.bam -c contigs.db -o /work_beegfs/sunam235/day3/5_anvio-profiles/profiling/”$i”; done

#anvi-merge /work_beegfs/sunam235/day3/5_anvio-profiles/profiling/BGR_130305/PROFILE.db /work_beegfs/sunam235/day3/5_anvio-profiles/profiling/BGR_130527/PROFILE.db /work_beegfs/sunam235/day3/5_anvio-profiles/profiling/BGR_130708/PROFILE.db -o /work_beegfs/sunam235/day3/5_anvio-profiles/merged_profiles -c /work_beegfs/sunam235/day3/5_anvio-profiles/contigs.db --enforce-hierarchical-clustering


cd /work_beegfs/sunam235/Day5/
#metabat2
#anvi-cluster-contigs -p merged_profiles/PROFILE.db -c /work_beegfs/sunam235/day3/5_anvio-profiles/contigs.db -C METABAT --driver metabat2 --just-do-it --log-file log-metabat2

#anvi-summarize -p merged_profiles/PROFILE.db -c /work_beegfs/sunam235/day3/5_anvio-profiles/contigs.db -o SUMMARY_METABAT -C METABAT
#concoct
#anvi-cluster-contigs -p PROFILE.db -c /work_beegfs/sunam235/day3/5_anvio-profiles/contigs.db -C consolidated_bins --driver dastool -T 20 --search-engine diamond -S METABAT,CONCOCT --log-file log_consolidation_of_bins --just-do-it

#anvi-summarize -p PROFILE.db -c /work_beegfs/sunam235/day3/5_anvio-profiles/contigs.db -o /work_beegfs/sunam235/day3/5_anvio-profiles/merged_profiles/SUMMARY_consolidated_bins -C consolidated_bins

anvi-summarize -c /work_beegfs/sunam235/Day5/contigs.db -p /work_beegfs/sunam235/Day5/5_anvio_profiles/merged_profiles/PROFILE.db -C consolidated_bins -o /work_beegfs/sunam235/Day5/5_anvio_profiles/summaryunrefined --just-do-it

jobinfo

