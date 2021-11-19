# Data and methods for <i>PopMLST, a high-resolution method to detect pathogen strain-level diversity in clinical samples.</i>
![logo](/title.png)

The publication for this method is in press, and the citation will appear here shortly.
## Guide for Use
### Installation - Choose a Method:
This software has been tested on the Ubuntu Linux 20.04 operating system. It may be possible to adapt it for other operating systems. We provide two different methods you can use for installation.
#### Bioconda Method (preferred)
We assume Bioconda is already properly configured and working, per <a href="https://bioconda.github.io/user/install.html">the instructions</a>.

    $ conda create -y -n popmlst python=3.8 bioconductor-dada2=1.22.0 vsearch=2.14.0 blast=2.12.0 pandas=1.3.4 biopython=1.79 cutadapt=3.5 pigz=2.6 colorama=0.4.4
    $ conda activate popmlst
    $ sudo apt update && sudo apt install libtre5
    $ wget https://github.com/marade/PopMLST/raw/master/tre-python3.tar.gz && tar xzvf tre-python3.tar.gz && cd tre-python3/python3 && python3 setup.py install && cd ../../ && rm -rf tre-python*

#### Manual method
The following software dependencies were used for the paper. Other versions may work but have not been tested:
* Python 3.8.12
* Python libraries:
  * Biopython 1.79
  * Pandas 1.3.4
  * colorama 0.4.4
  * tre 0.8.0 (see below)
* Cutadapt 3.5
* VSEARCH 2.14.0
* pigz 2.6
* R 4.1.1
* DADA2 1.22.0

These are the versions used for the paper, though other versions may work.

The tre Python library hasn't been formally updated for Python 3.x, but community-contributed patches are available. For your convenience we provide a version of the tre library patched for Python 3.x. You can install it like this:

    $ wget https://github.com/marade/PopMLST/raw/master/tre-python3.tar.gz
    $ tar -xzvf tre-python3.tar.gz
    $ cd tre-python/python3
    $ python3 setup.py install

### Do Sequencing and Generate Fastq Files
We assume you have generated your sequencing data in roughly the manner described in the paper, using Illumina paired-end sequencing. We provide some example files for testing below.
### Prepare Fastq Files
This pipeline assumes your paired-end Fastq files are named like so:

    sampleX_1.fastq.gz sampleX_2.fastq.gz
    sampleY_1.fastq.gz sampleY_2.fastq.gz

### Run the Pipeline
Below are instructions for two simple runs using example data for Pseudomonas aeruginosa and Staphylococcus aureus.

    $ git clone https://github.com/marade/PopMLST.git
    $ cd PopMLST
    
    # run Pseudomonas data
    $ python3 ProcessAmpliconData data/Pa PA-cutadapt.tab PA-results
    $ Rscript DADA2-PA.R PA-results
    $ python3 ParseDADA2Tabs ./ DADA2-PA out.tab D2-PA-combined.tab
    $ python3 ParseDADA2Tab -f D2-PA-combined.tab PA-ref D2-PA-table.tab D2-PA-blast.tab
    $ python3 FilterDADA2Tab D2-PA-table.filt.tab D2-PA-table.filt2.tab
    $ python3 SortColNames D2-PA-table.filt2.tab D2-PA-table.filt.sorted.tab
    
    # run Staph data
    $ python3 ProcessAmpliconData data/Sa SA-cutadapt.tab SA-results
    $ Rscript DADA2-SA.R SA-results
    $ python3 ParseDADA2Tabs ./ DADA2-SA out.tab D2-SA-combined.tab
    $ python3 ParseDADA2Tab -f D2-SA-combined.tab SA-ref D2-SA-table.tab D2-SA-blast.tab
    $ python3 FilterDADA2Tab D2-SA-table.filt.tab D2-SA-table.filt2.tab
    $ python3 SortColNames D2-SA-table.filt2.tab D2-SA-table.filt.sorted.tab

          |acs_4                                                                                                                                                                                                                                                                                                                                                                                                 |acs_6                                                                                                                                                                                                                                                                                                                                                                                                 |aro_5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |aro_5*                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |aro_75                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |gua_11                                                                                                                                                                                                                                                                                                                                                                               |gua_16                                                                                                                                                                                                                                                                                                                                                                               |mut_12                                                                                                                                                                                                                                                                                                                                                                                                                                                    |mut_3                                                                                                                                                                                                                                                                                                                                                                                                                                                     |nuo_1                                                                                                                                                                                                                                                                                                                                                                         |nuo_4                                                                                                                                                                                                                                                                                                                                                                         |pps_23                                                                                                                                                                                                                                                                                                                                                                            |pps_6                                                                                                                                                                                                                                                                                                                                                                             |trp_1                                                                                                                                                                                                                                                                                                                                                                                                                                                      |trp_3
:---------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
LES100sub |0                                                                                                                                                                                                                                                                                                                                                                                                     |11264                                                                                                                                                                                                                                                                                                                                                                                                 |0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |17                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |19523                                                                                                                                                                                                                                                                                                                                                                                |0                                                                                                                                                                                                                                                                                                                                                                                    |0                                                                                                                                                                                                                                                                                                                                                                                                                                                         |8338                                                                                                                                                                                                                                                                                                                                                                                                                                                      |0                                                                                                                                                                                                                                                                                                                                                                             |19069                                                                                                                                                                                                                                                                                                                                                                         |21683                                                                                                                                                                                                                                                                                                                                                                             |0                                                                                                                                                                                                                                                                                                                                                                                 |6311                                                                                                                                                                                                                                                                                                                                                                                                                                                       |0
PaCont2sub|19879                                                                                                                                                                                                                                                                                                                                                                                                 |1572                                                                                                                                                                                                                                                                                                                                                                                                  |94                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |3402                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |1931                                                                                                                                                                                                                                                                                                                                                                                 |25718                                                                                                                                                                                                                                                                                                                                                                                |16812                                                                                                                                                                                                                                                                                                                                                                                                                                                     |1274                                                                                                                                                                                                                                                                                                                                                                                                                                                      |34964                                                                                                                                                                                                                                                                                                                                                                         |3880                                                                                                                                                                                                                                                                                                                                                                          |395                                                                                                                                                                                                                                                                                                                                                                               |4743                                                                                                                                                                                                                                                                                                                                                                              |567                                                                                                                                                                                                                                                                                                                                                                                                                                                        |5840
ASV       |GGCCCGTTGGCCAACGGCGCCACCACCATTCTGTTCGAGGGCGTACCGAACTACCCCGACGTGACCCGCGTGGCGAAGATCATCGACAAGCACAAGGTTAACATCCTCTACACCGCGCCGACCGCGATCCGCGCGATGATGGCCGAAGGCAAGGCGGCGGTGGCCGGTGCCGACGGTTCCAGCCTGCGTCTGCTCGGTTCGGTGGGCGAGCCGATCAACCCGGAAGCCTGGCAGTGGTACTACGAGACCGTCGGCCAGTCGCGCTGCCCGATCGTCGACACCTGGTGGCAGACCGAGACCGGCGCCTGCCTGATGACCCCGTTGCCGGGCGCCCATGCGATGAAGCCGGGCTCCGCGGCCAAGCCGTTCTTCGGCGTGGTCCCGGCGCTG|GGCCCGTTGGCCAACGGCGCCACCACCATTCTGTTCGAGGGCGTGCCGAACTACCCCGACGTGACCCGCGTGGCGAAAATCATCGACAAGCACAAGGTCAACATCCTCTACACCGCGCCGACCGCGATCCGCGCGATGATGGCCGAAGGCAAGGCGGCGGTGGCCGGTGCCGACGGTTCCAGCCTGCGTCTGCTCGGTTCGGTGGGCGAGCCGATCAACCCGGAAGCCTGGCAGTGGTACTACGAGACCGTCGGCCAGTCGCGCTGCCCGATCGTCGACACCTGGTGGCAGACCGAGACCGGCGCCTGCCTGATGACCCCGTTGCCGGGCGCCCATGCGATGAAGCCGGGCTCCGCGGCCAAGCCGTTCTTCGGCGTGGTCCCGGCGCTG|ATGTCACCGTGCCGTTCAAGGAAGAGGCCTATCGTCTGGTGGACGAGTTGAGCGAGCGGGCCACCCGGGCCGGGGCGGTGAACACCCTGATCCGCCTCGCCGACGGTCGCCTGCGCGGCGACAACACCGACGGCGCCGGCCTGCTGCGGGACCTGACGGCGAACGCCGGGGTCGAGCTGCGCGGCAAGCGGGTTCTCCTGCTCGGCGCCGGCGGTGCGGTGCGTGGGGTGCTCGAACCCTTCCTCGGCGAGTGCCCGGCGGAGTTGCTGATCGCCAACCGCACGGCGCGGAAGGCCGTGGACCTGGCCGAGCGGTTCGCCGACCTCGGCGCGGTGCACGGCTGCGGTTTCGCCGAGGTCGAAGGGCCTTTCGACCTGATCGTCAACGGCACCTCGGCCAGTCTTGCCGGCGACGTGCCGCCGCTGGCGCAGAGCGTGATCGAGCCCGGCCGTACCGTCTGCTACGACATGATGTATGCCAAGGAACCGACTGCCTTCA|ATGTCACCGTGCCGTTCAAGGAAGAGGCCTATCGTCTGGTGGACGAGTTGAGCGAGCGGGCCACCCGGGCCGGGGCGGTGAACACCCTGATCCGCCTCGCCGACGGTCGCCTGCGCGGCGACAACACCGACGGCGCCGGCCTGCTGCGGGACCTGACGGCGAACGCCGGGGTCGAGCTGCGCGGCAAGCGGGGTCTCCTGCTCGGCGCCGGCGGTGCGGTGCGTGGGGTGCTCGAACCCTTCCTCGGCGAGTGCCCGGCGGAGTTGCTGATCGCCAACCGCACGGCGCGGAAGGCCGTGGACCTGGCCGAGCGGTTCGCCGACCGCGGCGCGGTGCACGGCTGCGGTTTCGCCGAGGTCGAAGGGCCTTTCGACCTGATCGTCAACGGCACCTCGGCCAGTCTTGCCGGCGACGTGCCGCCGCTGGCGCAGAGCGTGATCGAGCCCGGCCGTACCGTCTGCTACGACATGATGTATGCCAAGGAACCGACTGCCTTCA|ATGTCACCGTGCCGTTCAAGGAAGAGGCCTATCGTCTGGTGGACGAATTGAGCGAGCGGGCCACCCGGGCCGGGGCGGTGAACACCCTGATCCGCCTGGCCGACGGTCGCCTGCGCGGCGACAACACCGACGGCGCGGGCTTGCTGCGGGACCTGACGGCGAACGCCGGGGTCGAGCTGCGCGGCAAGCGGGTTCTCCTGCTCGGCGCCGGCGGTGCGGTGCGCGGGGTGCTCGAACCCTTCCTCGGCGAGTGCCCGGCGGAGTTGCTGATCGCCAACCGCACGGCGCGGAAGGCCGTGGACCTGGCCGAGCGATTCGCCGATCTCGGCGCGGTGCGCGGCTGCGGTTTCGCCGAGGTCGAAGGGCCTTTCGACCTGGTCGTCAACGGCACCTCGGCCAGTCTTGCCGGCGACGTGCCGCCGCTGGCGCAGAGCGTGATCGAGCCCGGCCGTACCGTCTGCTACGACATGATGTATGCCAAGGAACCGACTGCCTTCA|CTGCTAGGCCTCTCCGGCGGCGTGGACTCCTCGGTGGTCGCCGCGCTGCTGCACAAGGCCATCGGCGACCAACTGACCTGCGTGTTCGTCGACAACGGCCTGCTGCGCCTGCACGAAGGCGACCAGGTGATGGCCATGTTCGCCGAGAACATGGGCGTGAAGGTGATCCGCGCCAACGCCGAGGACAAGTTCCTCGGCCGCCTGGCCGGCGTCGCCGACCCGGAAGAGAAGCGCAAGATCATCGGCCGCACCTTCATCGAAGTTTTCGACGAAGAAGCCACCAAGCTGCAGGACGTGAAGTTCCTCGCCCAGGGCACCATCTACCCCGACGTGATCGAGTCGGCCGGCGCCAAGACCGGCAAGGCCCACGTGA|CTGCTCGGCCTCTCCGGCGGCGTGGACTCCTCGGTGGTCGCCGCGCTGCTGCACAAGGCCATCGGCGACCAACTGACCTGCGTGTTCGTCGACAACGGCCTGCTGCGCCTGCACGAAGGCGACCAGGTGATGGCCATGTTCGCCGAGAACATGGGCGTGAAGGTGATCCGCGCCAACGCCGAGGACAAGTTCCTCGGCCGCCTGGCCGGCGTCGCCGATCCGGAAGAGAAGCGCAAGATCATCGGCCGCACCTTCATCGAAGTCTTCGACGAAGAAGCCACCAAGCTGCAGGACGTGAAGTTCCTCGCCCAGGGCACCATCTACCCCGACGTGATCGAGTCGGCCGGCGCCAAAACCGGCAAGGCCCACGTGA|CTGCAGGAAGTCATCAAGCGCCTGGCGCTGGCCCGTTTCGACGTGGCTTTCCACCTGCGCCACAACGGCAAGACCATCTTCGCCCTGCACGAGGCGCGAGACGAGCTGGCCCGCGCGCGCCGGGTCGGCGCGGTGTGCGGCCAGGCATTCCTCGAGCAGGCGCTGCCGATCGAGGTCGAGCGCAACGGCCTGCACCTGTGGGGCTGGGTCGGCTTGCCGACCTTCTCCCGCAGCCAGCCGGACCTGCAGTACTTCTATGTGAACGGGCGCATGGTGCGCGACAAGCTGGTCGCCCACGCGGTGCGCCAGGCTTATCGCGACGTGCTGTACAACGGCCGGCACCCGACCTTCGTGCTGTTCTTCGAAGTCGATCCGGCGGTGGTGGACGTCAACGTGCACCCGACCAAGCACGAAGTTCGCTTCCGTGACAGCCGGATGGTCC|CTGCAGGAGGTCATCAAGCGCCTGGCGCTGGCCCGCTTCGACGTGGCTTTCCACCTGCGCCACAACGGCAAGACCATCTTCGCCCTGCACGAGGCGCGAGACGAGCTGGCCCGCGCGCGCCGGGTCGGCGCGGTGTGCGGCCAGGCATTCCTCGAGCAGGCGCTGCCGATCGAGGTCGAGCGCAACGGCCTGCACCTGTGGGGCTGGGTCGGCTTGCCGACCTTCTCCCGCAGCCAGCCGGACCTGCAGTACTTCTATGTGAACGGGCGCATGGTGCGCGACAAGCTGGTCGCCCACGCGGTGCGCCAGGCTTATCGCGACGTGCTGTACAACGGCCGGCATCCGACCTTCGTGCTGTTCTTCGAAGTCGATCCGGCGGTGGTGGACGTCAACGTGCACCCGACCAAGCACGAAGTTCGCTTCCGTGACAGCCGGATGGTCC|ATGTTCCTCAACCTCGGCCCGAACCACCCGTCCGCCCACGGCGCGTTCCGCATCATCCTGCAACTGGACGGCGAGGAGATCATCGACTGCGTCCCGGAGATCGGCTACCACCACCGCGGCGCCGAGAAGATGGCCGAGCGCCAGTCCTGGCACAGTTTCATCCCCTACACCGACCGCATCGACTACCTCGGCGGGGTGATGAACAACCTGCCCTACGTACTCTCGGTGGAGAAGCTCGCCGGGATCAAGGTGCCGCAGCGGGTCGACGTGATCCGGATCATGATGGCGGAGTTCTTCCGTATCCTGAACCACCTGCTGTACCTGGGCACCTATATCCAGGACGTCGGCGCCATGACCCCGGTGTTC|ATGTTCCTCAACCTCGGCCCGAACCACCCGTCCGCCCACGGCGCGTTCCGCATCATCCTGCAACTGGACGGCGAGGAGATCATCGACTGCGTCCCGGAGATCGGCTACCACCACCGCGGCGCCGAGAAGATGGCCGAGCGCCAGTCCTGGCACAGTTTCATCCCCTACACCGACCGCATCGACTACCTCGGCGGGGTGATGAACAACCTGCCCTACGTACTCTCGGTGGAGAAGCTCGCCGGGATCAAGGTGCCCCAGCGGGTCGACGTGATCCGGATCATGATGGCGGAGTTCTTCCGTATCCTGAACCACCTGCTGTACCTGGGCACCTATATCCAGGACGTCGGCGCCATGACCCCGGTGTTC|CATCGTCCAGGCACGCCCGGAAACCGTGAAGAGCCGCGCCAGCGCCACGGTCATGGAGCGCTACCTGCTGAAAGAGAAGGGGACCGTCCTGGTGGAAGGGCGTGCCATCGGCCAGCGCATCGGTGCCGGTCCGGTCAAGGTGATCAACGACGTGTCGGAAATGGACAAGGTCCAACCGGGTGACGTCCTGGTCTCCGACATGACCGACCCGGACTGGGAGCCGGTGATGAAGCGCGCCAGCGCCATCGTCACCAACCGCGGCGGGCGTACCTGCCACGCGGCGATCATCGCTCGCGAACTGGGCATCCCGGCGGTGTTCGGTTGCGGCAACGCCACCCAGATCCTGCAGGATGGCCAGGGGGTGACCGTT|CATCGTCCAGGCACGCCCGGAAACCGTGAAGAGCCGCGCCAGCGCCACGGTCATGGAGCGCTACCTGCTGAAAGAGAAGGGGACCGTCCTGGTGGAAGGACGTGCCATCGGCCAGCGCATCGGTGCCGGTCCGGTCAAGGTGATCAACGACGTGTCGGAAATGGACAAGGTCCAACCGGGTGACGTCCTGGTCTCCGACATGACCGACCCGGACTGGGAGCCGGTGATGAAGCGCGCCAGCGCCATCGTCACCAACCGCGGCGGGCGTACCTGCCACGCGGCGATCATCGCTCGCGAACTGGGCATCCCGGCGGTGGTCGGTTGCGGCAACGCCACCCAGATCCTGCAGGATGGGCAGGGGGTGACCGTT|TGTCGTGGGCAGCTCGCCGGAGGTGCTGGTACGGGTCGAGGATGGCCTGGTGACGGTGCGCCCGATCGCCGGTACCCGTCCGCGCGGGATCAACGAAGAGGCCGACCTGGCGCTGGAGCAGGATCTGCTGTCGGACGCCAAGGAGATCGCCGAGCACCTGATGCTGATCGACCTGGGGCGCAACGACGTGGGGCGGGTGTCCGATATCGGCGCGGTGAAGGTCACCGAAAAAATGGTGATCGAACGTTACTCCAACGTCATGCACATCGTGTCCAACGTCACCGGGCAATTGCGCGAGGGGCTCAGCGCGATGGACGCGCTGCGGGCGATTCTGCCGGCGGGCACTCTATCCGGCGCGCCGAAGATCCGCGCCATGGAGATCATCGACGAGCTGGAGCCGGTCAAGCGTGGAGTCTACGGCGGCGCGGTCGGCTACCTGGCAT|TGTCGTGGGCAGCTCGCCGGAGGTGCTGGTACGGGTCGAGGATGGCCTGGTGACGGTGCGCCCGATCGCCGGTACCCGTCCGCGCGGGATCAACGAAGAGGCCGACCTGGCGCTGGAGCAGGATCTGCTGTCGGACGCCAAGGAGATCGCCGAGCACCTGATGCTGATCGACCTGGGGCGCAACGACGTGGGGCGGGTGTCCGACATCGGCGCGGTGAAGGTCACCGAAAAAATGGTGATCGAACGTTACTCCAACGTCATGCACATCGTGTCCAACGTCACCGGGCAATTGCGCGAGGGGCTCAGCGCGATGGACGCGCTGCGGGCGATCCTGCCGGCGGGTACGCTGTCCGGCGCGCCGAAGATCCGCGCCATGGAGATCATCGACGAGCTGGAGCCGGTCAAGCGTGGAGTCTACGGCGGCGCGGTCGGCTACCTGGCAT

Other stuff.
