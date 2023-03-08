library(tidyverse)
library(RColorBrewer)
library(dplyr)
theme_set(theme_bw())
palete <- c("darkgrey","red")
fuckit<-c("grey50","#e41a1c","#377eb8","#4daf4a","#984ea3","#ff7f00","#a65628","#f781bf")
cbbPalette<-fuckit

d<-read_delim("/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-SNP-IDs/processed/idoverview.zeroadded",delim="\t",col_names=FALSE,comment="#")
names(d)<-c("condition","generation","replicate","start","end","key","frequency")

# check if present in base popoultion
# how many are present in two replicates

test<-d %>% group_by(key,replicate) %>% summarize(n=n())
multi<-test %>% group_by(key) %>% summarize(n=n())

# result we have 43 unique IDs
# one may be present in two replicates 828_2377      2


basepresent=c("828_2377")
d$basepresent<-ifelse(d$key %in% basepresent,T,F)


d$color<-0
d$key<-as.character(d$key) # important otherwise the tallying does not work

# subsets 
#cold<-subset(d,condition=="cold")
#hot<-subset(d,condition="hot")

vip<-subset(d,frequency>0.03)
d[d$key=="828_2377",]$color<-1
d[d$key=="878_1077",]$color<-2
#vip_cold<-subset(cold,frequency>0.03)
#cold[cold$key=="187_1967",]$color<-1

# get unique names of IDs
n_all<-names(table(d$key))


# process cold, Overview
dfc<-data.frame(key=n_all)
tmp<-as.numeric(unlist(strsplit(n_all,"_")))
m<-matrix(tmp,ncol=2,byrow=T)
dfc$start<-m[,1]
dfc$end<-m[,2]
dfc$leng<-dfc$end-dfc$start
dfc$color<-0
dfc$basepresent<-ifelse(dfc$key %in% basepresent,T,F)
dfc<-dfc[order(dfc$leng),]
dfc$num<-rev(1:dim(m)[1])
dfc$cond<-rep("all IDs",dim(m)[1])
dfc[dfc$key=="828_2377",]$color<-1
dfc[dfc$key=="878_1077",]$color<-2


#ov[ov$key=="808-2560",]$lwd<-1
#ov[ov$key=="819-2527",]$lwd<-1
vip<-data.frame(start=c(808,819),color=c(0,0), end=c(2560,2527),key=c("808-2560","819-2527"), leng=c(0,0),basepresent=c(F,F),num=c(1,7),cond=c("P","P") )
dfc<-rbind(dfc,vip)

dfc$color<-as.factor(dfc$color)
d$color<-as.factor(d$color)

#overv<-ggplot(nf,aes(x=position,y=num,group=num,color=color,linetype=basepresent))+geom_line()+facet_grid(condition ~ . ,scales="free_y", space="free_y")+
#     theme(legend.position="none",axis.title.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y = element_blank())+scale_colour_manual(values=cbbPalette)+
#     scale_linetype_manual(values=c("solid", "longdash"))

overview<-ggplot(dfc,aes(x = start, y = num, xend = end, yend = num,color=color,linetype=basepresent))+geom_segment(size=1)+
  theme(legend.position="none",axis.title.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y = element_blank())+
  scale_linetype_manual(values=c("solid", "longdash"))+scale_colour_manual(values=cbbPalette)+
  facet_grid(cond ~ . ,scales="free_y", space="free_y")+xlim(0,2907)

trajectory<-ggplot(d,aes(x=generation,y=frequency,group=key,color=color))+geom_line()+geom_point()+facet_grid(replicate~.,scales="free_x", space = "free_x")+theme(legend.position="none")+
    scale_colour_manual(values=cbbPalette)+ylab("frequency of internal deletion")
g<-plot_grid(overview, trajectory, labels = c('A', 'B'), label_size = 12,rel_widths = c(1, 2))
plot(g)


#pdf(file="/Users/rokofler/analysis/2021-Dere-Pele/analysis/2021-09-SNP-IDs/graphs/truncation_overview_defdirect.pdf",width = 8,height=5)

#plot(g)
#dev.off()



