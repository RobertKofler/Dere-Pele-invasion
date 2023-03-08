library(ggplot2)
library(gridExtra)

# To use for fills, add
ls=0.8
grey<-c("#a1a1a1","#5e5e5e","#3c3c3c")
cbbPalette <- grey

theme_set(theme_bw())
t<-read_delim("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-rpm_deviate/raw-u/ere_deviate_trate.txt",delim="\t",col_names=FALSE,comment="#")

names(t)<-c("replicate","generation","u")
tresrep<-c("#e41a1c","#377eb8","#4daf4a")




#minspeed<-min(cold$u)
#maxspeed<-max(hot$u)
s<-ggplot()+geom_line(data=t,aes(x=generation,y=u,color=replicate),size=1)+
  theme(strip.text=element_blank(),legend.position="none")+
  ylab("u")+scale_colour_manual(values=tresrep)
# +scale_colour_manual(values=cbbPalette)+




# +scale_y_continuous(breaks=c(0,0.1,0.2))
# scale_y_continuous(breaks=c(0,0.1,0.2),limits=c(minspeed,maxspeed))

#aes(x = 5, y = 30, xend = 3.5, yend = 25),
# s<-ggplot()+geom_segment(data=hot,aes(x=generation,xend=generation+10,y=u,yend=u,color=replicate))
#  geom_line(size=ls)+geom_point()+
#  theme(strip.text=element_blank(),legend.position="none")+scale_colour_manual(values=cbbPalette)+
#  ylab("u")+scale_y_continuous(breaks=c(0,0.1,0.2),limits=c(minspeed,maxspeed))

plot(s)
postscript(file="/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-rpm_deviate/graphs/transrate.ps",width=6,height=1.45)
plot(s)

dev.off()