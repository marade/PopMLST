library(dada2)

args <- commandArgs(trailingOnly = TRUE) # returns only arguments after --args
path <- args[1]
if (is.na(path)) {
    message("Please provide directory command line argument.")
    quit()
}

filtpath <- file.path(path, "filtered")

d <- data.frame(
  genes <- c("arcC", "aroE", "glpF", "gmk", "pta", "tpi", "yqi"),
  mins <- c(435, 453, 450, 417, 468, 402, 507),
  maxs <- c(522, 456, 478, 420, 474, 402, 516))

for(i in seq_len(nrow(d))) {
    message(paste("====", d[i,1], "===="))
    output <- paste0("DADA2-SA-", d[i,1], "-out.tab")
    fns <- list.files(path, pattern=paste0("_", d[i,1], ".merged.fastq.gz"))
    numsamps = length(fns)
    message(paste("number of samples:", numsamps))
    sampcomp = numsamps %/% 3
    #if (!(sampcomp >= 12)) {
    #    sampcomp = 12
    #}
    message(paste("ignoreNNegatives:", sampcomp))
    head(fns)

    # filter and trim
    # for amplicon sequencing, leave out truncLen
    message("Filtering and trimming...")
    out <- filterAndTrim(file.path(path, fns), file.path(filtpath, fns),
        maxN=0, minLen=d[i,2], rm.phix=TRUE, maxEE=20.0,
        compress=TRUE, multithread=TRUE, verbose=TRUE)
    head(out)

    # learn error rates
    message("Learning error rates...")
    filts <- list.files(filtpath, pattern=paste0("_", d[i,1],
        ".merged.fastq.gz"), full.names=TRUE)
    sample.names <- sapply(strsplit(basename(filts), "[.]"), `[`, 1)
    names(filts) <- sample.names
    set.seed(100)
    err <- learnErrors(filts, nbases=2e8, multithread=TRUE,
        randomize=TRUE, verbose=TRUE)
    #print(err)
    #plotErrors(err, nominalQ=TRUE)

    # dereplication
    message("Dereplicating and inferring sequence variants...")
    dds <- vector("list", length(sample.names))
    names(dds) <- sample.names
    #for (sam in sample.names) {
    #    cat("Processing:", sam, "\n")
    #    derep <- derepFastq(filts[[sam]], verbose=TRUE)
    #    dds[[sam]] <- dada(derep, err=err, multithread=TRUE,
    #        selfConsist=TRUE, verbose=TRUE, pool=TRUE)
    #}
    derep <- derepFastq(filts, verbose=TRUE)
    dds <- dada(derep, err=err, multithread=TRUE,
        selfConsist=TRUE, verbose=TRUE, pool=FALSE)
    dds[[1]]

    # construct an amplicon sequence variant table (ASV) table
    message("Making sequence table...")
    seqtab <- makeSequenceTable(dds)
    # Inspect distribution of sequence lengths
    table(nchar(getSequences(seqtab)))

    # remove chimeras
    message("Removing chimeras...")
    #seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus",
    #    minFoldParentOverAbundance=1.5, minParentAbundance=8,
    #    allowOneOff=TRUE, minOneOffParentDistance=3, maxShift=16,
    #    ignoreNNegatives=sampcomp, minSampleFraction=0.7,
    #    multithread=TRUE, verbose=TRUE)
    seqtab.nochim <- removeBimeraDenovo(seqtab, method="per-sample",
        minFoldParentOverAbundance=1.0, minParentAbundance=8,
        allowOneOff=TRUE, minOneOffParentDistance=1, maxShift=16,
        multithread=TRUE, verbose=TRUE)
    dim(seqtab.nochim)
    message("Fraction kept:")
    sum(seqtab.nochim)/sum(seqtab)

    message("Writing output...")
    message(output)
    write.table(seqtab.nochim, file=output, col.names=NA, quote=FALSE, sep='\t')
}

