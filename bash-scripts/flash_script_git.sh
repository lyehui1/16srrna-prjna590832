#!/bin/bash

# Set the path to FLASH executable
FLASH="/Users/flash"

# Set path to input and output directories
INDIR="/Users/input/"
OUTDIR="/Users/output/"

#Set working directory
cd /Users/input

# Loop through all SRR files in the input directory
for i in ${INDIR}/*.fastq.gz 
	do
    		# Get the SRR number from the input file name
    		SRR=$(basename ${i} | cut -d '_' -f 1)
    		# Run FLASH on the input files and save the output files with the SRR number in the name
    		${FLASH} ${SRR}_1.fastq.gz ${SRR}_2.fastq.gz -o ${SRR} -d ${OUTDIR}/{SRR} -z --interleaved-output
done

