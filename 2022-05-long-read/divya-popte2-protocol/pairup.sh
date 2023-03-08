#!/usr/bin/bash


if [ $# -ne 3 ]
  # "$#" is number of parameters- here we test
  # whether it is not equal to two
   then
   echo "Usage $0 infolder outfolder reference"
exit 2
fi



infolder=$1
outfolder=$2
reference=$3

# paths
for i in $infolder/*.signatures
do
	date
        n=`basename $i`
	n=${n%.signatures}
	java  -jar ../programs/popte2-v1.10.04.jar pairupSignatures --signature $i --ref-genome $reference  --hier references/pelement.hier --output $outfolder/$n.txt
	date
done

