# Data and methods for <i>PopMLST, a high-resolution method to detect pathogen strain-level diversity in clinical samples.</i>
![logo](/title.png)
## Guide for Use
### Prerequisites
This software has been tested on the Linux operating system. It may be possible to adapt operating systems. The following software dependencies are required:
* Python 3.x+
* Python libraries: 
* Cutadapt
### Do Sequencing and Generate Fastq Files
We assume you have generated your sequencing data in the manner described in the paper.
### Prepare Fastq Files
Blah blah.
### Install Prerequisites
Blah blah.
### Run the Pipeline
Code blah blah...

    AmpliconPipeline3 PA-fq PA-cutadapt.tab PA-results
    
    ParseDADA2Tabs ./ DADA2-SA out.tab D2-SA-combined.tab
    
    ParseDADA2Tab -f D2-SA-combined.tab SA-ref D2-SA-table.tab D2-SA-blast.tab
    
    FilterDADA2Tab D2-SA-table.filt.tab D2-SA-table.filt2.tab
    
    SortTabbyColName D2-SA-table.filt2.tab D2-SA-table.filt.sorted.tab
    
    ExtractPopMLSTStats PA-fq PA-results PA-stats.tab
    
Other stuff.
