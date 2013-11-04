# http://drunks-and-lampposts.com/2012/02/22/labelling-a-ggplot-scatterplot/
library(ggplot2)
library(directlabels)

n<-20
x<-runif(n)
y<-rnorm(n)
z<-as.character(1:n)
q<-qplot(x,y)+geom_point(aes(colour=z))
png('directlabels.png')
print(direct.label(q))
dev.off()