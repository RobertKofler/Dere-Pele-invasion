library(tidyverse)
library(RColorBrewer)
library(plyr)
theme_set(theme_bw())
tresrep<-c("#e41a1c","#377eb8","#4daf4a")

t=read_delim("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-rpm_deviate/raw_dev/raw-data.txt",delim="\t",col_names=FALSE,comment="#")
names(t)<-c("sample","replicate","generation","count")
cold<-subset(t,sample=="Dsim-cold")
hot<-subset(t,sample=="Dsim-hot")
t<-subset(t,sample=="Dere")



s<-ggplot()+geom_line(data=t,aes(x=generation,y=count,group=replicate,color=sample),size=1,color="darkgrey")+
  theme(strip.text=element_blank(),legend.position=c(0.1,0.9))+
 geom_line(data=hot,aes(x=generation,y=count,group=replicate),linetype="dashed",color="red",size=1)+
  geom_line(data=cold,aes(x=generation,y=count,group=replicate),linetype="dashed",color="blue",size=1)+
  ylab("insertions per haploid genome")+scale_colour_manual(values=tresrep)+xlim(0,50)

plot(s)
postscript(file="/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-rpm_deviate/graphs/indyn-dsim.ps",width=7,height=5)
plot(s)
dev.off()