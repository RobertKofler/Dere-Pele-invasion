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
for i in $infolder/*.freqsignatures
do
	date
        n=`basename $i`
	n=${n%.freqsignatures}
	java  -jar ../programs/popte2-v1.10.04.jar filterSignatures --min-count 1 --max-otherte-count 1 --max-structvar-count 1 --input $i --output $outfolder/$n.signatures
	date
done

