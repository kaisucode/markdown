#!/bin/bash

pandoc -f markdown -t html5 "README.md" > wkhtmltopdf -o "readme.pdf"

