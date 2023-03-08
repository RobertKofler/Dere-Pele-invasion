library(tidyverse)
library(RColorBrewer)
library(plyr)
theme_set(theme_bw())
tresrep<-c("#e41a1c","#377eb8","#4daf4a")

t=read_delim("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-piRNAs/01-lineplot/raw/line-forr.txt",delim="\t",col_names=FALSE,comment="#")
names(t)<-c("replicate","generation","te","smallRNA","count")
t$tissue<-"whole bodies"
t[t$generation==1 | t$generation==10 |t$generation==35,]$tissue<-"ovary"
t$replicate<-as.factor(t$replicate)
#t<-subset(t,smallRNA=="piRNA")
ymax<-max(t$count)

s<-ggplot()+geom_line(data=t,aes(x=generation,y=count,color=replicate,linetype=smallRNA),size=1)+
  geom_point(data=t,aes(x=generation,y=count,color=replicate),size=2)+ # shape=tissue
  geom_vline(xintercept = 1, linetype="dotted", color = "black", size=0.5)+
  geom_vline(xintercept = 10, linetype="dotted", color = "black", size=0.5)+
  geom_vline(xintercept = 35, linetype="dotted", color = "black", size=0.5)+
  theme(strip.text=element_blank(),legend.position=c(0.2,0.9))+
#  geom_line(data=hot,aes(x=generation,y=u,color=replicate),linetype="dashed")+
  ylab("P-element small RNAs [ppm]")+scale_colour_manual(values=tresrep)+xlim(1,48)

plot(s)
pdf(file="/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-piRNAs/01-lineplot/graphs/pi-sirnas.pdf",width=6.2,height=3)
plot(s)
dev.off()