#!/bin/zsh

# read parameters
if [ $# -lt 3 ]
  # "$#" is number of parameters- here we test
   then
   echo "Usage $0 inputdir outdir refg"
exit 2
fi

set -o shwordsplit

source ~/.zshrc

# Files and folders
inputdir=$1
refg=$3
outdir=$2

samtools="/Volumes/Temp/Divya/Nanopore/Softwares/anaconda/bin/samtools"
bwa="/usr/local/bin/bwa"
threads=24
popte2="/Volumes/Temp/Divya/programs/popte2-v1.10.04.jar"


## the REFERENCE 
#refg="references/all_dros_species/dere_r105_popte2.fasta"

mkdir -p $outdir

bwa index $refg

# paths
for read1 in $inputdir/*_1.fq.gz
do
	# variables defined to store the ids of the files from the input directory
        
	read2=${read1%_1.fq.gz}
	read2=${read2}_2.fq.gz
	tmp=`basename $read1`
        readid=${tmp%_1.fq.gz}
        
	# mapping
	$bwa bwasw -t $threads $refg $read1 |samtools view -Sb - > $outdir/${readid}_1.bam
	$bwa bwasw -t $threads $refg $read2 |samtools view -Sb - > $outdir/${readid}_2.bam
	java -jar $popte2 se2pe --fastq1 $read1 --fastq2 $read2 --bam1  $outdir/${readid}_1.bam --bam2 $outdir/${readid}_2.bam --sort --output $outdir/$readid.sort.bam
 
done 
