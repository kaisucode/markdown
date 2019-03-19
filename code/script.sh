#!/bin/bash

mdName=$@
fileExt=".pdf"
pdfFilename="${mdName: 0:-3}$fileExt"

pandoc --highlight=tango -f markdown -t html5 $@ > wkhtmltopdf -o $pdfFilename

mupdf $pdfFilename & . ~/Scripts/markdown/code/syncPDF.sh & nvim $@;
kill $(pgrep mupdf); 
# fg;
# pkill -f ~/Scripts/markdown/code/syncPDF.sh;

