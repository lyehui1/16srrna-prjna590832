# 16srRNA-PRJNA590832

Here, I document steps I have used in an attempt to replicate to steps of a 16S rDNA amplicon sequencing analysis as described by [Wang et al. (2019)](https://www.nature.com/articles/s41598-019-56149-9), including preprocessing of data downloaded from the SRA. Actual steps and therefore results will likely differ from those used by the authors.

## Download and process SRA files

Metadata of all reads uploaded by the authors to the [SRA](https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=590832) using RunSelector were downloaded.

Once downloaded, remove the header of the file and print the first column containing the SRA numbers.

```
tail -n +2 SraRunTable.txt | cut -d ','  -f 1
```

## Run FLASH

Used to remove adapter sequences and merge paired-end reads. 
FLASH version used: [1.2.11](https://bioweb.pasteur.fr/packages/pack@FLASH@1.2.11)

```
for i in ${INDIR}/*.fastq.gz 
	do
    		SRR=$(basename ${i} | cut -d '_' -f 1)
    		${FLASH} ${SRR}_1.fastq.gz ${SRR}_2.fastq.gz -o ${SRR} -d ${OUTDIR}/{SRR} -z --interleaved-output
done
```

## QC

MultiQC was run in a Conda environment.

```
conda create -n runqc
```
```
conda activate runqc
```
```
conda install multiqc
```
MultiQC report summary before FLASH run:
![](https://user-images.githubusercontent.com/43180979/235857699-5e183356-1243-4546-8bb6-4c9bbe44e9c8.png)

MultiQC report summary after FLASH run:
![image](https://user-images.githubusercontent.com/43180979/235857864-5e648996-df2a-49a4-95db-5e93f3dd33be.png)




<sub>
Hardware & OS specifications:
<br>Model: MacBook Air (13-inch, 2017)
<br>Operating System: MacOS Mojave v10.14.5
<br>CPU: 1.8 GHz Intel Core i5
<br>RAM: 8 GB 1600 MHz DDR3
<br>Storage: 121GB
</sub>
