library(dada2)

path <- "~/MLST-clinical-combined/SA-results"
filtpath <- file.path(path, "filtered")

genes <- c("arcC", "aroE", "glpF", "gmk", "pta", "tpi", "yqi")

for (gene in genes) {
    message(paste("====", gene, "===="))
    output <- paste0("~/MLST-clinical-combined/DADA2-SA-", gene, "-out.tab")
    fns <- list.files(path, pattern=paste0("_", gene, ".merged.fastq.gz"))
    head(fns)

    # filter and trim
    # for amplicon sequencing, leave out truncLen
    message("Filtering and trimming...")
    out <- filterAndTrim(file.path(path, fns), file.path(filtpath, fns),
        maxN=0, minLen=400, maxLen=520, rm.phix=TRUE, maxEE=20.0,
        compress=TRUE, multithread=TRUE, verbose=TRUE)
    head(out)

    # learn error rates
    message("Learning error rates...")
    filts <- list.files(filtpath, pattern=paste0("_", gene,
        ".merged.fastq.gz"), full.names=TRUE)
    sample.names <- sapply(strsplit(basename(filts), "[.]"), `[`, 1)
    names(filts) <- sample.names
    set.seed(100)
    err <- learnErrors(filts, nbases = 1e8, multithread=TRUE,
        randomize=TRUE, verbose=TRUE)
    #plotErrors(err, nominalQ=TRUE)

    # dereplication
    message("Dereplicating and inferring sequence variants...")
    dds <- vector("list", length(sample.names))
    names(dds) <- sample.names
    for (sam in sample.names) {
        cat("Processing:", sam, "\n")
        derep <- derepFastq(filts[[sam]], verbose=TRUE)
        dds[[sam]] <- dada(derep, err=err, multithread=TRUE,
            selfConsist=TRUE, verbose=TRUE)
    }
    dds[[1]]

    # construct an amplicon sequence variant table (ASV) table
    message("Making sequence table...")
    seqtab <- makeSequenceTable(dds)
    # Inspect distribution of sequence lengths
    table(nchar(getSequences(seqtab)))

    # remove chimeras
    message("Removing chimeras...")
    seqtab.nochim <- removeBimeraDenovo(seqtab, method="per-sample",
        minFoldParentOverAbundance = 1.4, minParentAbundance = 8,
        allowOneOff = FALSE, minOneOffParentDistance = 4, maxShift = 16,
        multithread=TRUE, verbose=TRUE)
    dim(seqtab.nochim)
    message("Fraction kept:")
    sum(seqtab.nochim)/sum(seqtab)

    message("Writing output...")
    message(output)
    write.table(seqtab.nochim, file=output, col.names=NA, quote=FALSE, sep='\t')
}

