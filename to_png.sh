#!/bin/bash

for file in `ls *.pdf`;
   do echo $file;
   base=`basename $file .pdf`
   convert -density 300 $file -resize 50% $base.png
done
