source ~/.zshrc 
script="/Users/rokofler/dev/te-tools/ere/smallRNA-lineplot-all.py"
inf="/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-piRNAs/raw-bam"
ouf="/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-piRNAs/01.2-lineplot-all/raw"



# Rep 1
samtools view $inf/dere_ovaries_R1G1_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G1 > $ouf/R1-G1.txt
samtools view $inf/dere_R1G5_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G5 > $ouf/R1-G5.txt
samtools view $inf/dere_ovaries_R1G10_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G10 > $ouf/R1-G10.txt
samtools view $inf/dere_R1G15_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G15 > $ouf/R1-G15.txt
samtools view $inf/dere_R1G20_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G20 > $ouf/R1-G20.txt
samtools view $inf/dere_R1G25_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G25 > $ouf/R1-G25.txt
samtools view $inf/dere_R1G30_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G30 > $ouf/R1-G30.txt
samtools view $inf/dere_ovaries_R1G35_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G35 > $ouf/R1-G35.txt
samtools view $inf/dere_R1G40_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G40 > $ouf/R1-G40.txt
samtools view $inf/dere_R4G45_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R1-G45 > $ouf/R1-G45.txt

# Rep 2
samtools view $inf/dere_ovaries_R2G1_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G1 > $ouf/R2-G1.txt
samtools view $inf/dere_R2G5_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G5 > $ouf/R2-G5.txt
samtools view $inf/dere_ovaries_R2G10_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G10 > $ouf/R2-G10.txt
samtools view $inf/dere_R2G15_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G15 > $ouf/R2-G15.txt
samtools view $inf/dere_R2G20_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G20 > $ouf/R2-G20.txt
samtools view $inf/dere_R2G25_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G25 > $ouf/R2-G25.txt
samtools view $inf/dere_R2G30_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G30 > $ouf/R2-G30.txt
samtools view $inf/dere_ovaries_R2G35_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G35 > $ouf/R2-G35.txt
samtools view $inf/dere_R2G40_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G40 > $ouf/R2-G40.txt
samtools view $inf/dere_R2G45_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R2-G45 > $ouf/R2-G45.txt


# Rep 4
samtools view $inf/dere_ovaries_R4G1_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G1 > $ouf/R4-G1.txt
samtools view $inf/dere_R4G5_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G5 > $ouf/R4-G5.txt
samtools view $inf/dere_ovaries_R4G10_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G10 > $ouf/R4-G10.txt
samtools view $inf/dere_R4G15_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G15 > $ouf/R4-G15.txt
samtools view $inf/dere_R4G20_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G20 > $ouf/R4-G20.txt
samtools view $inf/dere_R4G25_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G25 > $ouf/R4-G25.txt
samtools view $inf/dere_R4G30_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G30 > $ouf/R4-G30.txt
samtools view $inf/dere_ovaries_R4G35_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G35 > $ouf/R4-G35.txt
samtools view $inf/dere_R4G40_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G40 > $ouf/R4-G40.txt
samtools view $inf/dere_R4G45_trim_clean_sf_sorted.bam | python $script  --sam - --sample-id R4-G45 > $ouf/R4-G45.txt
