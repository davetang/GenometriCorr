#!/bin/bash

#create random bed file
bedtools random -g hg19.genome -l 1000 -seed 31 > random.bed

#merge random features, so they don't overlap
bedtools sort -i random.bed | bedtools merge -i stdin > merged.bed

#work with a subset
bedtools sample -i merged.bed -n 50000 -seed 31 > merged_subset.bed

#run the statistical tests
run_analysis.pl merged_subset.bed merged_subset.bed

to_png.sh

#moving results
mv *.pdf ../pdf
mv *.png ../image
mv *.out ../result

rm *.bed
