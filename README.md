# Varying_kmer_effect_in_denovo_assembly

## Overview

This project aims to observe the effect of selecting different kmer length parameter in 2 different de novo genome assembly tools. The denovo assembly tools used are Abyss and Velvet.
The workflow consists of the following steps:

1. **Fastq read file download using SRA-Toolkit**
2. **Quality Assessment with FASTQC**
3. **High Quality Read Filtering using Trimmomatic**
4. **De-novo Whole Genome Assembly using Abyss and Velvet with different kmer lengths**
5. **Comparative Analysis of Assembly Quality using a Python Script**


## Dataset

- **Dataset ID:** SRX23809475
- **SRA Run ID:** SRR28196086
- **Instrument:** Illumina MiSeq
- **Layout:** Paired
- **Organism:** E.coli
- **Total Bases:** 355.6 Mb
- **No. of reads:** 752,285 pair reads
- **Estimated Genome Size:** 5 Mb
- **Estimated Read Coverage:** 355.6/5 = 71X


## System Requirements

- Python 3
- Perl 5.32.1
- Conda

## Installing Dependencies

1. Create a virtual environment and install python dependincies:

   ```bash
   conda create -n grover python=3.9
   conda activate grover
   pip install -r requirements.txt
   ```

2. Install Trimmomatic:

   ```bash
   sudo apt-get install -y trimmomatic
   ```

3. Install FastQC:

   ```bash
   sudo apt -y install fastqc
   ```

4. Install Abyss:

   ```
   conda install -c bioconda -c conda-forge abyss
   ```

5. Install NGS QC Toolkit & Velvet:

   ```
   mkdir Pre-requisite_tools
   cd Pre-requisite_tools
   wget https://github.com/mjain-lab/NGSQCToolkit/archive/refs/tags/v2.3.tar.gz
   tar -xf v2.3.tar.gz

   wget https://github.com/dzerbino/velvet/archive/refs/tags/v1.2.10.tar.gz
   tar -xf v1.2.10.tar.gz
   cd velvet-1.2.10
   make
   cd ..
   ```

6. Install Busco:
   ```
   conda install -c conda-forge mamba
   mamba install -c conda-forge -c bioconda busco=5.7.1
   ```
<br></br>

## Workflow
### Quality Assessment

The first step involves evaluating the quality of the sample using FASTQC. Summary statistics obtained from FASTQC provide insights into various quality metrics, allowing us to identify any potential issues in the sequencing data.
Trimmomatic tool was used to trim the low quality ends and remove the low quality reads.

```
chmod +x preprocessing.sh
./preprocessing.sh
```

### De-novo Whole Genome Assembly

Following the quality assessment, we perform de-novo whole genome assembly using two different tools, each employing 8 distinct k-mer sizes. This approach allows for the evaluation of the assembly output, and observing the effectiveness of the k-mer sizes in reconstructing the genome. 
The 2 tools used were Abyss and velvet, both used for genome assembly.
```
chmod +x abyss_velvet_denovo_assembly.sh
./abyss_velvet_denovo_assembly.sh
```

### Analysis and Comparison

In the analysis, we compare various output features of the assembled scaffolds from each kmer length. The features compared were Total assembled Sequences, Total assembled bases, N50, N90, L50, Average assembled contig length, Minimum contig length, Max Length, No. of N nucleotides.
Furthermore, BUSCO analysis plots were made to access the completeness of the assembled genome.
```
python data_analysis.py
```

### Results

The results from this study, including quality assessment grpahs and assembly outputs, are generated in the plots directory. We infer from the plots that kmer length of 87 had the most complete assembly for the given dataset.


---

### Contact

For any questions or further information, please contact Kaushal Grover at kausha87_sit@jnu.ac.in.

---

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
