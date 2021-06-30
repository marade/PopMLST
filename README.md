# Data and methods for <i>PopMLST, a high-resolution method to detect pathogen strain-level diversity in clinical samples.</i>
![logo](/title.png)
## Guide for Use
### Prerequisites
This software has been tested on the Linux operating system. It may be possible to adapt it for other operating systems. The following software dependencies are required:
* Python 3.6.9
* Python libraries: Biopython 1.76, Pandas 1.0.1, colorama 0.3.7, tre 0.8.0
* Cutadapt 2.8
* VSEARCH 2.14.2
* pigz 2.4
* R 3.6.2
* DADA2 1.14

These are the versions used for the paper, though other versions of the dependencies may work.

The tre Python library hasn't been formally updated for Python 3.x, but community contributed patches have solved the problem. For your convenience we provide a version the tre library patched for Python 3.x. You can install it like this:

    wget https://github.com/marade/PopMLST.git

### Do Sequencing and Generate Fastq Files
We assume you have generated your sequencing data in roughly the manner described in the paper.
### Prepare Fastq Files
This pipeline assumes your paired-end Fastq files are named like so:

    sampleX_1.fastq.gz sampleX_2.fastq.gz
    sampleY_1.fastq.gz sampleY_2.fastq.gz

### Run the Pipeline
Code blah blah...

    git clone https://github.com/marade/PopMLST.git
    
    cd PopMLST
    
    python2 AmpliconPipeline3 PA-fq PA-cutadapt.tab PA-results
    
    python2 ParseDADA2Tabs ./ DADA2-PA out.tab D2-PA-combined.tab
    
    python2 ParseDADA2Tab -f D2-PA-combined.tab PA-ref D2-PA-table.tab D2-PA-blast.tab
    
    python2 FilterDADA2Tab D2-PA-table.filt.tab D2-PA-table.filt2.tab
    
    python2 SortTabbyColName D2-PA-table.filt2.tab D2-PA-table.filt.sorted.tab
    
    python2 ExtractPopMLSTStats PA-fq PA-results PA-stats.tab
    
Other stuff.
