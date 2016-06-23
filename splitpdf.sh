#!/bin/bash

file=$1
pagesper=$2

number=$(pdfinfo -- "$file" 2> /dev/null | awk '$1 == "Pages:" {print $2}')
count=$((number / pagesper))
filename=${file%.pdf}

counter=0
while [ "$count" -gt "$counter" ]; do 
  start=$((counter*pagesper + 1));
  end=$((start + pagesper - 1));

  counterstring=$(printf %d "$counter")
  counterstring=$((counterstring + 1))
  pdftk "$file" cat "${start}-${end}" output "${counterstring}-${filename}.pdf"

  counter=$((counter + 1))
done
