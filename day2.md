# Day2 

this is the link for the script [link](https://github.com/AammarTufail/Bioinformatics_Master_Module2023/blob/main/Day-2/Tutorial_Day2.md)


# sBatch script 

submit script to cluster

#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=fastqc
#SBATCH -D ./
#SBATCH --output=/work_beegfs/sunam226/fastqc.out
#SBATCH --error=/work_beegfs/sunam226/fastqc.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#only changes in line 6,8,9

# copy from sunam226

```
cp -r /home/sunam226/Day2/0_raw_reads/ .
```
# load module miniconda
```
module load miniconda3/4.7.12.1
```

# activate anvio

```
conda activate /home/sunam226/.conda/envs/anvio
```



# fastqc
```
module load fastqc
```
```
cp /home/sunam235/anviscript /work_beegfs/sunam235/day2/0_raw_reads/
```


in anviscrpt : for i in *.gz; do fastqc $i -o fastqc_folder/; done

```
sbatch anviscript
```

html files open with firefox

# fastp
#copy anviscript-> new name fastp.sh
#command->
#sed replaces _r1 with _r2; i is for _r1

#in fastqc script:

#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=fastp
#SBATCH -D ./
#SBATCH --output=/work_beegfs/sunam235/fastp.out
#SBATCH --error=/work_beegfs/sunam235/fastp.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#only changes in line 6,8,9

module load miniconda3/4.7.12.1

conda activate anvio
conda activate /home/sunam226/.conda/envs/anvio


#fastqc
#module load fastqc
#cd /work_beegfs/sunam235/day2/0_raw_reads/
#for i in *.gz; do fastqc $i -o fastqc_folder/; done

#fastqc

cd /work_beegfs/sunam235/day2/0_raw_reads/
mkdir ../clean_reads
for i in `ls *_R1.fastq.gz`;
do
    second=`echo ${i} | sed 's/_R1/_R2/g'`
    fastp -i ${i} -I ${second} -R _report -o ../clean_reads/"${i}" -O ../clean_reads/"${second}" -t 6 -q 20

done


#in directory /day2/0_raw_reads
```
sbatch fastp.sh
```
# assembly

in directory 0_raw_reads

```
cp fastp.sh ../clean_reads/
```


change name ->assembly.sh

in assembly.sh

##!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --job-name=coassembly
#SBATCH -D ./
#SBATCH --output=/work_beegfs/sunam235/coassembly.out
#SBATCH --error=/work_beegfs/sunam235/coassembly.err
#SBATCH --partition=all
#SBATCH --reservation=biol217

#only changes in line 6,8,9

module load miniconda3/4.7.12.1

conda activate anvio
conda activate /home/sunam226/.conda/envs/anvio


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

#assembly
cd /work_beegfs/sunam235/day2/clean_reads

                                       
megahit -1 BGR_130527_R1.fastq.gz -1 BGR_130305_R1.fastq.gz -1 BGR_130708_R1.fastq.gz -2 BGR_130527_R2.fastq.gz -2 BGR_130305_R2.fastq.gz -2 BGR_130708_R2.fastq.gz --min-contig-len 1000 --presets meta-large -m 0.85 -o /work_beegfs/sunam235/day2/coassembly/ -t 20                      

#this prints the required resources into your logfile
jobinfo

#wait until tomorrow:)