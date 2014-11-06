#!/bin/bash

randomBed -seed 23 -l 1000 -n 50000 -g hg19.genome | sortBed > a.bed
randomBed -seed 31 -l 1000 -n 50000 -g hg19.genome | sortBed > b.bed

run_analysis.pl a.bed b.bed

to_png.sh

#moving results
mv *.pdf ../pdf
mv *.png ../image
mv *.out ../result
