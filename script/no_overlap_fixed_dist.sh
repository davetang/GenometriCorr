#!/bin/bash

#create non-overlapping features that are a fixed distance away

#segment each hg19 chromosome into 100,000 parts
bedtools makewindows -g hg19.genome -n 100000 > 100000_window.bed

#print every 10th line
cat 100000_window.bed | perl -nle 'print if $. % 10 == 0' > 100000_window_10th.bed

#create another bed file with features 3kb away from the windows
cat 100000_window_10th.bed | awk '{OFS="\t"; print $1, $2+3000, $3+3000}' > 100000_window_10th_3kb.bed

#create BED file at the extremities of hg19
cat hg19.genome | grep -v "chrom" | awk '{OFS="\t"; print $1,$2,$2+1000000}' > hg19_end.bed

#remove cases that extend outside of the chromosomes
intersectBed -a 100000_window_10th_3kb.bed -b hg19_end.bed -v > blah
mv -f blah 100000_window_10th_3kb.bed

#sanity check
intersectBed -a 100000_window_10th.bed -b 100000_window_10th_3kb.bed

#run statistical tests
run_analysis.pl 100000_window_10th.bed 100000_window_10th_3kb.bed

to_png.sh

#moving results
mv *.pdf ../pdf
mv *.png ../image
mv *.out ../result

rm *.bed
