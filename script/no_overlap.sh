#!/bin/bash

#create non-overlapping features

#create random bed file
bedtools random -g hg19.genome -l 1000 -seed 31 > random.bed

#merge random features, so they don't overlap
bedtools sort -i random.bed | bedtools merge -i stdin > merged.bed

#obtain the complement
bedtools complement -i merged.bed -g hg19.genome > merged_comp.bed

#sanity check
#this should produce no output
intersectBed -a merged.bed -b merged_comp.bed

#work with a subset
bedtools sample -i merged.bed -n 50000 -seed 31 > merged_subset.bed
bedtools sample -i merged_comp.bed -n 50000 -seed 31 > merged_comp_subset.bed

#run the statistical tests
run_analysis.pl merged_subset.bed merged_comp_subset.bed

#moving results
mv *.pdf ../pdf
mv *.png ../image
mv *.out ../result
