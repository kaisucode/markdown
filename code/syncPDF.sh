#!/bin/bash

FIle_EXTENSION_TO_OBSERVE="*.md"

function block_for_change {
  inotifywait \
    -qe modify,move,create,delete \
    $FIle_EXTENSION_TO_OBSERVE
	
	echo "File changed on $(date +"%Y-%m-%d %T")"
}

while block_for_change; do
	echo "Updating pdf..."
	pandoc -f markdown -t html5 "README.md" > wkhtmltopdf -o "readme.pdf"
	pkill -HUP mupdf
	# kill -1 mupdf
done
echo "end"

