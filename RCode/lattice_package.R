library(lattice)
library(datasets)

xyplot(Ozone~Wind,data=airquality)

airquality<-transform(airquality,Month=factor(Month))
xyplot(Ozone~Wind|Month,data=airquality,layout=c(5,1))
