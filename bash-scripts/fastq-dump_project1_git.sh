#!/bin/bash

#Set working directory
cd /Users/

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



