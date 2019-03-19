#!/bin/bash

mdName=$@
fileExt=".pdf"
pdfFilename="${mdName: 0:-3}$fileExt"

function block_for_change {
	inotifywait \
		-qe modify \
		$mdName
	:
}

function updatePDF {
	while block_for_change ; do
		pandoc --highlight=tango -f markdown -t html5 $@ > wkhtmltopdf -o $pdfFilename
		pkill -HUP mupdf
	done
}

if ! $( [ -f $@ ] ); then
	echo >> $@
fi 

pandoc --highlight=tango -f markdown -t html5 $@ > wkhtmltopdf -o $pdfFilename

mupdf $pdfFilename & 
updatePDF & 
nvim $@

kill $(pgrep mupdf) 
kill $!
# fg;

