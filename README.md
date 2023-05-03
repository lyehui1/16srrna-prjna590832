# 16srRNA-PRJNA590832

Here, I document steps I have used in an attempt to replicate to steps of a 16S rDNA amplicon sequencing analysis as described by [Wang et al. (2019)](https://www.nature.com/articles/s41598-019-56149-9), including preprocessing of data downloaded from the SRA. Actual steps and therefore results will likely differ from those used by the authors.

## Download and process SRA files

Metadata of all reads uploaded by the authors to the [SRA](https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=590832) using RunSelector were downloaded.

Once downloaded, the header of the file was removed, and the first column containing the SRA numbers was printed.

```
#Save the SRA accession provided in SraRunTable.txt
VAR=$(tail -n +2 SraRunTable.txt | cut -d ','  -f 1)

for i in ${VAR}
	do
		#Check if file with the same name as the accession already exists
		if [ -f ${i}.fastq.gz ]; then
		echo "${i} already downloaded"
		else
			echo "(o) Downloading SRA entry: ${i}" 
			#downloading SRA entry, zip and send to input folder
			fastq-dump --split-files --gzip ${i} >> /Users/${i}.fastq.gz
			echo "(o) Done downloading ${i}"
	fi
done
```

## Remove adapter sequences and merge paired-end reads using FLASH

[FLASH]((https://bioweb.pasteur.fr/packages/pack@FLASH@1.2.11)) version used: 1.2.11

```

# Set path to input and output directories
INDIR="/Users/input/"
OUTDIR="/Users/output/"

# Loop through all SRR files in the input directory
for i in ${INDIR}/*.fastq.gz 
	do
    		# Get the SRR number from the input file name
    		SRR=$(basename ${i} | cut -d '_' -f 1)
    		# Run FLASH on the input files and save the output files with the SRR number in the name
    		flash ${SRR}_1.fastq.gz ${SRR}_2.fastq.gz -o ${SRR} -d ${OUTDIR}/{SRR} -z --interleaved-output
done
```

## Quality control

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


## Remove chimeric sequences using USEARCH

[USEARCH](https://drive5.com/usearch/) version used: v11, 32-bit 

Reference database for the 16S gene was downloaded from [SILVA](https://www.arb-silva.de/download/arb-files/).
<br> Specifically, the .fasta.gz file for the small subunit (SSU), Ref NR 99 was downloaded and gunzipped. 

The USEARCH manual recommends [reducing database size](http://www.drive5.com/usearch/manual/reducing_memory.html) via clustering or splitting to reduce memory usage. Due to hardware and software constraints, clustering was carried out on the database using USEARCH's [cluster_fast](https://drive5.com/usearch/manual/cmd_cluster_fast.html) command.

```
-cluster_fast SILVA_138.1_SSURef_NR99_tax_silva.fasta -id 0.9 -centroids nr.fasta -uc clusters.uc
```

Chimera removal is then carried out:

```

# Loop through all existing SRR files in the input directory
for i in ${INDIR}/*.fastq
	do
                # Extract SRR number from the input file name
                SRR=$(basename ${i} | cut -d '.' -f 1)
                # Run uchime on the input files and save the output files with the SRR number in the name
                usearch -uchime2_ref ${SRR}.extendedFrags.fastq -db nr.fasta -mode high_confidence -strand plus --notmatched "${SRR}_output.fa"
done
```



<sub>
Hardware & OS specifications:
<br>Model: MacBook Air (13-inch, 2017)
<br>Operating System: MacOS Mojave v10.14.5
<br>CPU: 1.8 GHz Intel Core i5
<br>RAM: 8 GB 1600 MHz DDR3
<br>Storage: 121GB
</sub>
