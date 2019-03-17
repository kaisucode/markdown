#!/bin/bash

FIle_EXTENSION_TO_OBSERVE=$@

function block_for_change {
	inotifywait \
		-qe modify \
		$FIle_EXTENSION_TO_OBSERVE
	:
}

noExt=$@
fileExt=".pdf"
pdfFilename="${noExt: 0:-3}$fileExt"

while block_for_change | read event $FIle_EXTENSION_TO_OBSERVE; do
	pandoc --highlight=tango -f markdown -t html5 $@ > wkhtmltopdf -o $pdfFilename
	pkill -HUP mupdf
done
echo "end"

