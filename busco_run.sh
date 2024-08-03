#!/bin/bash

mkdir -p BUSCO_summaries/abyss_kc2 BUSCO_summaries/abyss_kc3 BUSCO_summaries/velvet BUSCO_summaries/temp
cd BUSCO_summaries

kmer_start=39
kmer_step=8
kmer_end=152



for k in `seq $kmer_start $kmer_step $kmer_end`; do
	busco -i ./../abyss_outputs/k${k}-kc2/ecoli-scaffolds.fa -m genome -l enterobacterales_odb10 -c 20 -o k${k} --out_path ./abyss_kc2/
    cp ./abyss_kc2/k${k}/short_summary.specific.enterobacterales_odb10.*.txt ./temp/
done
python3 ./../busco_generate_plot.py -wd ./temp
mv ./temp/busco_figure.png ./../plots/busco_abyss_kc2.png



for k in `seq $kmer_start $kmer_step $kmer_end`; do
	busco -i ./../abyss_outputs/k${k}-kc3/ecoli-scaffolds.fa -m genome -l enterobacterales_odb10 -c 20 -o k${k} --out_path ./abyss_kc3/
    cp ./abyss_kc3/k${k}/short_summary.specific.enterobacterales_odb10.*.txt ./temp/
done
python3 ./../busco_generate_plot.py -wd ./temp
mv ./temp/busco_figure.png ./../plots/busco_abyss_kc3.png




for k in `seq $kmer_start $kmer_step $kmer_end`; do	
	busco -i ./../velvet_outputs/k${k}/contigs.fa -m genome -l enterobacterales_odb10 -c 20 -o k${k} --out_path ./velvet/
    cp ./velvet/k${k}/short_summary.specific.enterobacterales_odb10.*.txt ./temp/
done
python3 ./../busco_generate_plot.py -wd ./temp
mv ./temp/busco_figure.png ./../plots/busco_velvet.png

