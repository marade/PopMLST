# Data and methods for <i>PopMLST, a high-resolution method to detect pathogen strain-level diversity in clinical samples.</i>
![logo](/title.png)
## Guide for Use
### Prerequisites
This software has been tested on the Linux operating system. It may be possible to adapt it for other operating systems. The following software dependencies are required:
* Python 3.8.2
* Python libraries: Biopython 1.76, Pandas 1.0.24, colorama 0.3.7, tre 0.8.0
* Cutadapt 2.8
* VSEARCH 2.14.2
* pigz 2.4
* R 4.0.2
* DADA2 1.14

These are the versions used for the paper, though other versions of the dependencies may work.

The tre Python library hasn't been formally updated for Python 3.x, but community contributed patches have solved the problem. For your convenience we provide a version the tre library patched for Python 3.x. You can install it like this:

    $ wget https://github.com/marade/PopMLST/raw/master/tre-python3.tar.gz
    $ tar -xzvf tre-python3.tar.gz
    $ cd tre-python/python3
    $ python3 setup.py install

### Do Sequencing and Generate Fastq Files
We assume you have generated your sequencing data in roughly the manner described in the paper.
### Prepare Fastq Files
This pipeline assumes your paired-end Fastq files are named like so:

    sampleX_1.fastq.gz sampleX_2.fastq.gz
    sampleY_1.fastq.gz sampleY_2.fastq.gz

### Run the Pipeline
Code blah blah...

    $ git clone https://github.com/marade/PopMLST.git
    $ cd PopMLST
    $ python3 AmpliconPipeline3 PA-fq PA-cutadapt.tab PA-results
    $ Rscript DADA2-PA-y3.R PA-results
    $ python3 ParseDADA2Tabs ./ DADA2-PA out.tab D2-PA-combined.tab
    $ python3 ParseDADA2Tab -f D2-PA-combined.tab PA-ref D2-PA-table.tab D2-PA-blast.tab
    $ python3 FilterDADA2Tab D2-PA-table.filt.tab D2-PA-table.filt2.tab
    $ python3 SortTabbyColName D2-PA-table.filt2.tab D2-PA-table.filt.sorted.tab
    $ python3 ExtractPopMLSTStats PA-fq PA-results PA-stats.tab
    
Other stuff.
