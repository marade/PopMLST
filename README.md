# Data and methods for <i>PopMLST, a high-resolution method to detect pathogen strain-level diversity in clinical samples.</i>
![logo](/title.png)
## Guide for Use
### Installation - Choose a Method:
This software has been tested on the Linux operating system. It may be possible to adapt it for other operating systems. We provide two different installation methods you can use for installation.
#### Bioconda Method (preferred)
We assume Bioconda is already properly configured and working, per <a href="https://bioconda.github.io/user/install.html">the instuctions</a>.

    $ conda create -y -n popmlst python=3.8 bioconductor-dada2 vsearch=2.14.0 blast pandas biopython cutadapt pigz colorama
    $ conda activate popmlst
    $ wget https://github.com/marade/PopMLST/raw/master/tre-python3.tar.gz && tar xzvf tre-python3.tar.gz && cd tre-python3/python3 && python3 setup.py install && cd ../../ && rm -rf tre-python*

#### Manual method
The following software dependencies were used for the paper. Other versions may work but have not been tested:
* Python 3.8.5
* Python libraries:
  * Biopython 1.78
  * Pandas 1.2.5
  * colorama 0.4.3
  * tre 0.8.0 (see below)
* Cutadapt 3.2
* VSEARCH 2.15.2
* pigz 2.4
* R 4.0.4
* DADA2 1.18.0

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
Code blah blah...

    $ git clone https://github.com/marade/PopMLST.git
    $ cd PopMLST
    $ python3 ProcessAmpliconData PA-fq PA-cutadapt.tab PA-results
    $ Rscript DADA2-PA.R PA-results
    $ python3 ParseDADA2Tabs ./ DADA2-PA out.tab D2-PA-combined.tab
    $ python3 ParseDADA2Tab -f D2-PA-combined.tab PA-ref D2-PA-table.tab D2-PA-blast.tab
    $ python3 FilterDADA2Tab D2-PA-table.filt.tab D2-PA-table.filt2.tab
    $ python3 SortColNames D2-PA-table.filt2.tab D2-PA-table.filt.sorted.tab
    $ python3 ExtractPopMLSTStats PA-fq PA-results PA-stats.tab
    
Other stuff.
