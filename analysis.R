#install packages
source("http://bioconductor.org/biocLite.R")
biocLite('BiocUpgrade')
biocLite()
biocLite('rtracklayer')
biocLite("IRanges")
biocLite("GenomicRanges")
install.packages('gplots')
install.packages('GenometriCorr',repos='http://genometricorr.sourceforge.net/R/',type='source')

#load packages
library('GenometriCorr')
library("rtracklayer")

#load example files
refseq <- as(import(
  system.file("extdata","UCSCrefseqgenes_hg19.bed", package = "GenometriCorr")
  ),"RangedData")
cpgis <- as(import(
  system.file("extdata", "UCSCcpgis_hg19.bed", package = "GenometriCorr")
  ),"RangedData")

#define hg19
human.chrom.length <- c(249250621, 243199373, 198022430, 191154276, 180915260, 171115067,
                        159138663, 146364022, 141213431, 135534747,135006516, 133851895,
                        115169878, 107349540, 102531392, 90354753, 81195210, 78077248,
                        59128983, 63025520, 48129895, 51304566, 59373566, 155270560)
names(human.chrom.length) <- c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6",
                               "chr7", "chr8", "chr9", "chr10", "chr11", "chr12",
                               "chr13", "chr14", "chr15", "chr16", "chr17", "chr18",
                               "chr19", "chr20", "chr21", "chr22", "chrY", "chrX")

#visualise example BED files
VisualiseTwoIRanges(cpgis["chr1"]$ranges,
                    refseq["chr1"]$ranges,
                    nameA = "CpG Islands",
                    nameB = "RefSeq Genes",
                    chrom_length = human.chrom.length[["chr1"]],
                    title = "CpGIslands and RefGenes on chr1 of Hg19")

#define number of permutations
#100 is the default anyway
pn.area <- 100
pn.dist <- 100
pn.jacc <- 100
cpgi_to_genes <- GenometriCorrelation(cpgis, refseq, chromosomes.length = human.chrom.length,
                                      chromosomes.to.proceed = c("chr1", "chr2", "chr3"),
                                      ecdf.area.permut.number = pn.area,
                                      mean.distance.permut.number = pn.dist,
                                      jaccard.measure.permut.number = pn.jacc,
                                      keep.distributions = TRUE, showProgressBar = FALSE)

#create plot of results
graphical.report(cpgi_to_genes,
                 pdffile = "CpGi_to_RefSeq_chr1_picture.pdf",
                 show.chromosomes = c("chr1"),
                 show.all = FALSE)
visualize(cpgi_to_genes,
          pdffile = "CpGi_to_RefSeq_chr1_picture_vis.pdf",
          show.chromosomes = c("chr1"),
          show.all = FALSE)

#random example
a <- as(import('a.bed'),"RangedData")
b <- as(import('b.bed'), "RangedData")
c <- as(import('c.bed'), "RangedData")

#visualise random bed files
VisualiseTwoIRanges(a["chr1"]$ranges,
                    b["chr1"]$ranges,
                    nameA = "a.bed",
                    nameB = "b.bed",
                    chrom_length = human.chrom.length[["chr1"]],
                    title = "Features of of a.bed and b.bed on chromosome 1")

#perform the correlation test
a_vs_b <- GenometriCorrelation(a, b, chromosomes.length = human.chrom.length,
                               chromosomes.to.proceed = c("chr1", "chr2", "chr3"),
                               ecdf.area.permut.number = pn.area,
                               mean.distance.permut.number = pn.dist,
                               jaccard.measure.permut.number = pn.jacc,
                               keep.distributions = TRUE, showProgressBar = TRUE)

#plot results
graphical.report(a_vs_b, pdffile = "a_vs_b_chr1_picture.pdf",
                 show.chromosomes = c("chr1"),
                 show.all = FALSE)
visualize(a_vs_b, pdffile = "a_vs_b_chr1_picture_vis.pdf",
          show.chromosomes = c("chr1"),
          show.all = FALSE)

#perform correlation test for equal distance
a_vs_c <- GenometriCorrelation(a, c, chromosomes.length = human.chrom.length,
                               chromosomes.to.proceed = c("chr1", "chr2", "chr3"),
                               ecdf.area.permut.number = pn.area,
                               mean.distance.permut.number = pn.dist,
                               jaccard.measure.permut.number = pn.jacc,
                               keep.distributions = TRUE, showProgressBar = TRUE)

#plot results
graphical.report(a_vs_c, pdffile = "a_vs_c_chr1_picture.pdf",
                 show.chromosomes = c("chr1"),
                 show.all = FALSE)
visualize(a_vs_c, pdffile = "a_vs_c_chr1_picture_vis.pdf",
          show.chromosomes = c("chr1"),
          show.all = FALSE)