#!/usr/bin/bash


if [ $# -ne 2 ]
  # "$#" is number of parameters- here we test
  # whether it is not equal to two
   then
   echo "Usage $0 infolder outfolder"
exit 2
fi



infolder=$1
outfolder=$2


# paths
for i in $infolder/*.ppileup.gz
do
	date
        n=`basename $i`
	n=${n%.ppileup.gz}
	java -jar ../programs/popte2-v1.10.04.jar stat-coverage --ppileup $i --output $outfolder/$n.txt 
	date
done

