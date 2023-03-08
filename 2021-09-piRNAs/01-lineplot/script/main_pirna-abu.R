library(tidyverse)
library(RColorBrewer)
library(plyr)
theme_set(theme_bw())
tresrep<-c("#e41a1c","#377eb8","#4daf4a")

t=read_delim("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-piRNAs/01-lineplot/data/pi_abudan.txt",delim="\t",col_names=FALSE,comment="#")
names(t)<-c("replicate","generation","tissue","count")
t$replicate<-as.factor(t$replicate)
t$tissue<-revalue(t$tissue, c("b"="whole bodies", "o"="ovaries"))
t$count<-t$count/1000

s<-ggplot()+geom_line(data=t,aes(x=generation,y=count,color=replicate),size=1)+
  geom_point(data=t,aes(x=generation,y=count,shape=tissue,color=replicate),size=2)+
  theme(strip.text=element_blank(),legend.position=c(0.2,0.9))+
#  geom_line(data=hot,aes(x=generation,y=u,color=replicate),linetype="dashed")+
  ylab("P-element piRNAs [ppk]")+scale_colour_manual(values=tresrep)+xlim(0,48)

plot(s)
postscript(file="/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-piRNAs/01-lineplot/graphs/pirnas.ps",width=5.95,height=2.5)
plot(s)
dev.off()