#!/bin/bash

for file in `ls *.pdf`;
   do echo $file;
   base=`basename $file .pdf`
   convert -density 300 $file -resize 50% $base.png
done

for file in `ls *.png`;
   do echo $file;
   base=`basename $file .png`
   convert -flatten $file ${base}_2.png
   mv -f ${base}_2.png $file
done
