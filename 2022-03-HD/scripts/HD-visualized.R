library(tidyverse)
library(RColorBrewer)
library(plyr)
theme_set(theme_bw())
tresrep<-c("#e41a1c","#377eb8","#4daf4a")

# Annotation
t<-read.table("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2022-03-HD/raw/rawdata.txt")
# R1	1	28	3	2	10.6
# R2	1	28	2	1	6.5
names(t)<-c("rep","time","sheit1","sheit2","sheit3","GD")



s<-ggplot(data=t,aes(x=time,y=GD,color=rep))+geom_line(size=1)+geom_point()+
  theme(strip.text=element_blank(),legend.position=c(0.1,0.9))+geom_hline(yintercept=14.3,linetype="dashed")+
  geom_hline(yintercept=3.4,linetype="dashed")+
  ylab("GD [%]")+scale_colour_manual(values=tresrep)+xlab("generations")

plot(s)
postscript(file="/Users/rokofler/analysis/2021-Dere-Pele/analysis/2022-03-HD/graphs/godys.ps",width=5.95,height=3.3)
plot(s)
dev.off()
