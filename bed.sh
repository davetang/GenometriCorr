#!/bin/bash

mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A -e \
	"select chrom, size from hg19.chromInfo"  > hg19.genome

randomBed -seed 23 -l 1000 -n 50000 -g hg19.genome | sortBed > a.bed
randomBed -seed 31 -l 1000 -n 50000 -g hg19.genome | sortBed > b.bed
