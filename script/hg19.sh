#!/bin/bash

#filter out unassembled chromosomes, random chromosomes, and the mitochrondrial chromosome
mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A -e "select chrom, size from hg19.chromInfo" | grep -v "_" | grep -v "chrM" > hg19.genome
