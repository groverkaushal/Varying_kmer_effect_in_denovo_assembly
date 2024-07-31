#!/bin/bash

### download SRA file and convert it to fastq
mkdir 1_fastq_reads
prefetch SRR28196086 --progress --output-directory ./1_fastq_reads/
vdb-validate ./1_fastq_reads/SRR28196086
fasterq-dump --split-files ./1_fastq_reads/SRR28196086/SRR28196086.sra -F fastq --outdir 1_fastq_reads/



## generate fastqc reports and filter HQ reads by trimmomatic
mkdir 2_HQ_filtered
fastqc ./1_fastq_reads/SRR28196086_1.fastq ./1_fastq_reads/SRR28196086_2.fastq --threads 4 --outdir ./2_HQ_filtered/
find ./2_HQ_filtered -type f -name '*.zip' -delete

TrimmomaticPE -threads 4 -phred33 -summary ./2_HQ_filtered/summary.txt ./1_fastq_reads/SRR28196086_1.fastq ./1_fastq_reads/SRR28196086_2.fastq -baseout ./2_HQ_filtered/output SLIDINGWINDOW:4:30 LEADING:30 TRAILING:30
fastqc ./2_HQ_filtered/output_1P ./2_HQ_filtered/output_2P --threads 4 --outdir ./2_HQ_filtered/
find ./2_HQ_filtered -type f -name '*.zip' -delete






