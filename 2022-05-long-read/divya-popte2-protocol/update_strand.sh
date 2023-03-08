#!/usr/bin/bash


if [ $# -ne 3 ]
  # "$#" is number of parameters- here we test
  # whether it is not equal to two
   then
   echo "Usage $0 infolder outfolder bamfolder"
exit 2
fi



infolder=$1
outfolder=$2
bamfolder=$3


# paths
for i in $infolder/*.signatures
do
	date
        n=`basename $i`
	n=${n%.signatures}
	java  -jar ../programs/popte2-v1.10.04.jar updateStrand --signature $i  --output $outfolder/$n.signatures  --bam $bamfolder/$n.sort.bam --hier references/pelement.hier --map-qual 15 --max-disagreement 0.4
	date
done

