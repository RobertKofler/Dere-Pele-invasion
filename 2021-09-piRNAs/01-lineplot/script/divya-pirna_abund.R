library(ggplot2)
theme_set(theme_bw())

pi=read.table("/home/divya/Desktop/invasion/ere/piRNA/pi_abudan.txt")

pi$V2=as.numeric(gsub("G", "", pi$V2))
names(pi)[1]<-"replicate"
names(pi)[2]<-"generation"
names(pi)[3]<-"abundance"

pi_fig=ggplot(pi,aes(x=generation,y=abundance))+geom_line(aes(colour=replicate))+ ggtitle("piRNA abundance")+xlab("generation")+ylab("abundance")

png("pi_abundance.png", width = 30, height = 20, units = "cm", res = 100)
print(pi_fig)
dev.off()

postscript("pi_abundance.eps", family = "ArialMT", width = 30, height = 20)
print(pi_fig)
dev.off()


