# 16srRNA-PRJNA590832

Here, I document steps I have used in an attempt to replicate to steps of a 16S rDNA amplicon sequencing analysis as described by [Wang et al. (2019)](https://www.nature.com/articles/s41598-019-56149-9), including preprocessing of data downloaded from the SRA. Actual steps and therefore results will likely differ from those used by the authors.

## Download and process SRA files

Download metadata of all reads uploaded by the authors to the [SRA](https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=590832) using RunSelector.

Once downloaded, remove the header of the file and print the first column containing the SRA numbers.

```
tail -n +2 SraRunTable.txt | cut -d ','  -f 1
```

## QC






<sub>
Hardware & OS specifications:
<br>Model: MacBook Air (13-inch, 2017)
<br>Operating System: MacOS Mojave v10.14.5
<br>CPU: 1.8 GHz Intel Core i5
<br>RAM: 8 GB 1600 MHz DDR3
<br>Storage: 121GB
</sub>
