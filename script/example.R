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
                                      keep.distributions = TRUE, showProgressBar = TRUE)

sink('cpg_vs_refseq.out')
cpgi_to_genes
sink()

#create plot of results
graphical.report(cpgi_to_genes,
                 pdffile = "cpg_to_refseq_dist.pdf",
                 show.chromosomes = c("chr1"),
                 show.all = FALSE)

visualize(cpgi_to_genes,
          pdffile = "cpg_to_refseq_overlap.pdf",
          show.chromosomes = c("chr1"),
          show.all = FALSE)
