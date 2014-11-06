#!/bin/bash

R --no-save < example.R

to_png.sh

#moving results
mv *.pdf ../pdf
mv *.png ../image
mv *.out ../result
