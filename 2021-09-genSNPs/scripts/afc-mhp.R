library(ggplot2)
library(gridExtra)
theme_set(theme_bw())
palete <- c("darkgrey","red")

d<-read.table("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-genomic-SNPs/snps/mindist0.1")
#contig_8	101031	T,A	R4	0.117647058824	base 26:0,14:0	R1 26:0,25:0,25:0,26:0,32:0,23:0	R2 35:0,32:0,32:0,32:0,22:0,39:0	R4 29:0,38:0,24:0,20:0,15:2,15:2
#contig_8	116583	G,A	R4	0.153846153846	base 17:0,11:0	R1 31:0,30:0,22:0,30:0,19:0,20:0	R2 43:0,26:0,21:0,26:0,17:0,27:0	R4 22:0,27:0,29:0,20:0,11:2,11:2
names(d)<-c("chromosome","position","crap","replicate","afc","crap2","crap3","crap4","crap5")
#d<-subset(d,chromosome=="X" |chromosome=="2L"|chromosome=="2R"|chromosome=="3L"|chromosome=="3R"|chromosome=="4")






p<- ggplot(d,aes(x=position,y=afc))+geom_point()+facet_grid(replicate~chromosome, scales="free_x", space = "free_x")+
  scale_y_continuous(name="allele frequency change")+
  scale_colour_manual(values=palete)+theme(legend.position="none")
plot(p)
