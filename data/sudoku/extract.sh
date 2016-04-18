#!/bin/sh

for line in `grep description $1`;do
	echo % sudoku
	echo $line | sed -e 's/.*data":\[/,/g' -e 's/\]\]>.*/,/g' -e 's/\[//g' -e 's/\]//g' -e 's/,[0-9],/,.,/g' -e 's/,[0-9],/,.,/g' -e 's/[0-9]\([0-9]\)/\1/g' -e 's/^,//' -e 's/,$//' -e 's/\(.\{53\}\),/\1\n-------+-------+-------\n/g' -e 's/\(.,.,.,.,.,.,.,.,.\),/\1\n/g' -e 's/\(.,.,.\),/\1 |/g' -e 's/\(.\),\(.\),\(.\)/ \1 \2 \3/g'
done


