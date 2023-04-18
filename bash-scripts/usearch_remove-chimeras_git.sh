#!/bin/bash

# Set the path to usearch executable
USEARCH="/Users/usearch11.0.667_i86osx32"

# Set path to database file
DB="/Users/silvadb/nr.fasta"

# Set working directory
cd /Users/input

# Loop through all existing SRR files in the input directory
for i in ${INDIR}/*.fastq
	do
                # Extract SRR number from the input file name
                SRR=$(basename ${i} | cut -d '.' -f 1)
                # Run uchime on the input files and save the output files with the SRR number in the name
                ${USEARCH} -uchime2_ref ${SRR}.extendedFrags.fastq -db ${DB} -mode high_confidence -strand plus --notmatched "${SRR}_output.fa"
done




