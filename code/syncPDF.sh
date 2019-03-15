#!/bin/bash

FIle_EXTENSION_TO_OBSERVE=$@

function block_for_change {
	inotifywait \
		-qe modify,move,create,delete \
		$FIle_EXTENSION_TO_OBSERVE
	:
}

noExt=$@
fileExt=".pdf"
pdfFilename="${noExt: 0:-3}$fileExt"

while block_for_change; do
	pandoc -f markdown -t html5 $@ > wkhtmltopdf -o $pdfFilename
	pkill -HUP mupdf
done
echo "end"

