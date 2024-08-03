#!/bin/bash

### abyss assembly with varying kmer parameters
mkdir abyss_outputs
cd abyss_outputs

kmer_start=39
kmer_step=8
kmer_end=152

for kc in 2 3; do
	for k in `seq $kmer_start $kmer_step $kmer_end`; do
		mkdir k${k}-kc${kc}
		abyss-pe -C k${k}-kc${kc} name=ecoli B=2G k=$k kc=$kc in='./../../2_HQ_filtered/output_1P  ./../../2_HQ_filtered/output_2P'
		abyss-fac ./k${k}-kc${kc}/ecoli-unitigs.fa ./k${k}-kc${kc}/ecoli-contigs.fa ./k${k}-kc${kc}/ecoli-scaffolds.fa > ./k${k}-kc${kc}/abyss-fac_stat
		perl ./../Pre-requisite_tools/NGSQCToolkit-2.3/Statistics/N50Stat.pl -i ./k${k}-kc${kc}/ecoli-unitigs.fa
		perl ./../Pre-requisite_tools/NGSQCToolkit-2.3/Statistics/N50Stat.pl -i ./k${k}-kc${kc}/ecoli-contigs.fa
		perl ./../Pre-requisite_tools/NGSQCToolkit-2.3/Statistics/N50Stat.pl -i ./k${k}-kc${kc}/ecoli-scaffolds.fa
	done
done
cd ..


### velvet assembly with varying kmer parameters
mkdir velvet_outputs
cd velvet_outputs


for k in `seq $kmer_start $kmer_step $kmer_end`; do
	mkdir k${k}
	./../Pre-requisite_tools/velvet-1.2.10/velveth ./k${k}/ ${k} -create_binary -shortPaired -fastq -separate ./../2_HQ_filtered/output_1P ./../2_HQ_filtered/output_2P
	./../Pre-requisite_tools/velvet-1.2.10/velvetg ./k${k}/ -exp_cov auto
	abyss-fac ./k${k}/contigs.fa > ./k${k}/abyss-fac_stat
	perl ./../Pre-requisite_tools/NGSQCToolkit-2.3/Statistics/N50Stat.pl -i ./k${k}/contigs.fa
done
cd ..


mkdir plots
