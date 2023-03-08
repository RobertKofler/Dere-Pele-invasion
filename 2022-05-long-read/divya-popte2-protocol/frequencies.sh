#!/usr/bin/bash


if [ $# -ne 3 ]
  # "$#" is number of parameters- here we test
  # whether it is not equal to two
   then
   echo "Usage $0 infolder outfolder ppileup"
exit 2
fi



infolder=$1
outfolder=$2
ppileup=$3

# paths
for i in $infolder/*.signatures
do
	date
        n=`basename $i`
	n=${n%.signatures}
	java  -jar ../programs/popte2-v1.10.04.jar frequency --ppileup  $ppileup/$n.ppileup.gz --signature $i --output $outfolder/$n.freqsignatures
	date
done

