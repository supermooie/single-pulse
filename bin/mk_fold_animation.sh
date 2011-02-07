#!/bin/bash

#this bash script is designed to make animations of pulsar folding
#the num_fold argument is the maximum number of pulses to fold
#stepsize specifies how many of the intermediate folds to skip
#inbetween each frame of the animation
#this script uses the ImageMagic convert program as well as
#the programs: foldbin, normalize, build_plot

#output file will be <infile>.gif

#check there were enough arguments
if [[ $# < 4 ]]; then
	echo "Arguments are: infile, period, num_fold, outfile, stepsize"
	exit
fi

#we need to print the digits in 001, 002 ... 100 format so that they are in
#the correct order when listed using ls
#here i work out the number of 0's to prepend
pad=`echo "import math; print int(math.log($3)/math.log(10) + 1)" | python`


echo "Folding..."
nr=`./foldbin $1 $2 ../session/$4.tmp.txt $3 $5`

echo "Normalizing..."
./normalize `ls ../session/$4.tmp.txt*`


echo "Drawing graphs..."
for i in `seq 0 $((nr - 1))`; do
	python build_plot.py ../session/$4.tmp.txt$i ../session/$4.tmp`printf "%0\`echo $pad\`d" $i`.gif 0 0 0 1 "Number of pulses folded:$(($i * $5+1))" just_plot
done

echo "Making the animation..."
rm -f ../session/$4.gif
convert -resize 320x240 -delay 60 -loop 0 ../session/$4*.gif ../session/$4.gif
rm ../session/$4.tmp* #remove the temporary files
