library(tidyverse)

theme_set(theme_bw())
h<-read.table("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2022-05-long-read/raw-pirnacluster/ere-ovaries-bin500-mq1.bin")
whole<-read.table("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2022-05-long-read/raw-pirnacluster/old-whole-flies/ere-cluster-bin500-mq1.txt")


# contig_46	1000	1499	1	0.124653137064
# contig_47	15500	15999	1	0.124653137064

names(h)<-c("contig","start","end","rawcount","normcount")
names(whole)<-c("contig","start","end","rawcount","normcount")

g<-ggplot(h, aes(x=rawcount)) + geom_histogram()+xlim(0,50)

plot(g)

