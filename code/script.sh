
noExt=$@
fileExt=".pdf"
pdfFilename="${noExt: 0:-3}$fileExt"

# if ! $( [ -f $pdfFilename ] ); then
#   if ! $( [ -f $@ ] ); then
#     echo >> $@
#   fi
#   pandoc --highlight=tango -f markdown -t html5 $@ > wkhtmltopdf -o $pdfFilename
# fi
pandoc --highlight=tango -f markdown -t html5 $@ > wkhtmltopdf -o $pdfFilename

mupdf $pdfFilename & . ~/Scripts/markdown/code/syncPDF.sh & nvim $@;
kill $(pgrep mupdf); 
# fg;
# pkill -f ~/Scripts/markdown/code/syncPDF.sh;

