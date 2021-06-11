#!/bin/sh

# requires spell to be installed

usage="$0 file"

file=${1:? "Usage: $usage"}

lang=en_UK

exclude="Crownstone"

while read p; do
	exclude="$exclude|$p|${p}s"
done < exclude.txt

cat "$file" | aspell list -H --lang=$lang | egrep -v -w -i $exclude
