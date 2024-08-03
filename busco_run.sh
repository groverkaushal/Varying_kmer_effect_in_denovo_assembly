#!/bin/bash

mkdir -p BUSCO_summaries/abyss_kc2 BUSCO_summaries/abyss_kc3 BUSCO_summaries/velvet BUSCO_summaries/temp
cd BUSCO_summaries

for k in `seq 39 8 96`; do
	busco -i ./../abyss_outputs/k${k}-kc2/ecoli-scaffolds.fa -m genome -l enterobacterales_odb10 -c 20 -o k${k} --out_path ./abyss_kc2/
    cp ./abyss_kc2/k${k}/short_summary.specific.enterobacterales_odb10.*.txt ./temp/
done
python3 ./../busco_generate_plot.py -wd ./temp
mv ./temp/busco_figure.png ./../plots/busco_abyss_kc2.png



for k in `seq 39 8 96`; do
	busco -i ./../abyss_outputs/k${k}-kc3/ecoli-scaffolds.fa -m genome -l enterobacterales_odb10 -c 20 -o k${k} --out_path ./abyss_kc3/
    cp ./abyss_kc3/k${k}/short_summary.specific.enterobacterales_odb10.*.txt ./temp/
done
python3 ./../busco_generate_plot.py -wd ./temp
mv ./temp/busco_figure.png ./../plots/busco_abyss_kc3.png




for k in `seq 39 8 96`; do
	busco -i ./../velvet_outputs/k${k}/contigs.fa -m genome -l enterobacterales_odb10 -c 20 -o k${k} --out_path ./velvet/
    cp ./velvet/k${k}/short_summary.specific.enterobacterales_odb10.*.txt ./temp/
done
python3 ./../busco_generate_plot.py -wd ./temp
mv ./temp/busco_figure.png ./../plots/busco_velvet.png
