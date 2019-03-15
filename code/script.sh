
noExt=$@
fileExt=".pdf"
pdfFilename="${noExt: 0:-3}$fileExt"
mupdf $pdfFilename & . ~/Desktop/2k19/markdown/code/syncPDF.sh & nvim $@; kill $(pgrep mupdf); 

