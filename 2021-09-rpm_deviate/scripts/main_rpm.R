library(tidyverse)
library(RColorBrewer)
library(plyr)
theme_set(theme_bw())
tresrep<-c("#e41a1c","#377eb8","#4daf4a")

t=read_delim("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-rpm_deviate/raw_rpm/ere_rpm_popte2_final.txt",delim="\t",col_names=FALSE,comment="#")
names(t)<-c("replicate","generation","count")
t$replicate<-as.factor(t$replicate)


s<-ggplot()+geom_line(data=t,aes(x=generation,y=count,color=replicate),size=1)+
  # geom_point(data=cold,aes(x=generation,y=u,color=replicate),size=ls)+
  theme(strip.text=element_blank(),legend.position=c(0.1,0.9))+
#  geom_line(data=hot,aes(x=generation,y=u,color=replicate),linetype="dashed")+
  ylab("insertions per hap. genome")+scale_colour_manual(values=tresrep)

plot(s)
postscript(file="/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-rpm_deviate/graphs/indyn_rpm.ps",width=6,height=3)
plot(s)
dev.off()