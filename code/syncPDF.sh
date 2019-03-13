#!/bin/bash

FIle_EXTENSION_TO_OBSERVE="*.md"

function block_for_change {
  inotifywait \
    -qe modify,move,create,delete \
    $FIle_EXTENSION_TO_OBSERVE
	:
}

while block_for_change; do
	pandoc -f markdown -t html5 "README.md" > wkhtmltopdf -o "readme.pdf"
	pkill -HUP mupdf
done
echo "end"

