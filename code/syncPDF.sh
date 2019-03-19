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

while block_for_change ; do
	pandoc --highlight=tango -f markdown -t html5 $mdName > wkhtmltopdf -o $pdfFilename
	pkill -HUP mupdf
done
echo "end"

