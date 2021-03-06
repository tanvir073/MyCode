

library(ggplot2)

##### qplot: quick plot

##### scattter plot

str(mpg)

qplot(displ,hwy,data=mpg)

##### scattter plot seperate by color for sub group

qplot(displ,hwy,data=mpg,color=drv)

##### scattter plot and joining the poits
qplot(displ,hwy,data=mpg,color=drv,geom = c("point","line"))
##### scattter plot with smooth line
qplot(displ,hwy,data=mpg,color=drv,geom = c("point","smooth"))

qplot(displ,hwy,data=mpg,color=drv,geom = c("point","smooth"))+geom_smooth(method = 'lm')
##### Histogram
qplot(hwy,data=mpg,fill=drv)
##### multi plot using facets
qplot(displ,hwy,data=mpg,facets = .~drv)
qplot(displ,hwy,data=mpg,facets = drv~.)
qplot(hwy,data=mpg,facets = drv~.,binwidth=2)

qplot(displ,hwy,data=mpg,color=drv,geom = c("point","smooth"))+geom_smooth(method = 'lm')
qplot(displ,hwy,data=mpg)+geom_smooth(method = 'lm')

##### low level Ploting with ggplot i.e. step by step ploting in ggplot

## create ggplot object
g=ggplot(data=mpg,mapping=aes(displ,hwy))

str(g)
summary(g)

print(g)

g_scatter=g+geom_point()

print(g_scatter)
## or 
g+geom_point()

g+geom_point(color="blue",size=4,alpha=1/2)+facet_grid(drv~.)

g+geom_point(color="blue",size=4,aes(alpha=1/cyl))+facet_grid(drv~.)+labs(alpha="Cylinders")
g+geom_point(color="blue",size=4,aes(alpha=1/cyl))+facet_grid(drv~.)+labs(alpha="Cylinders")

g+geom_point(aes(color=cyl),size=4,alpha=1/2)+facet_grid(drv~.)
g+geom_point(aes(color=cyl),size=4,alpha=1/2)+facet_grid(drv~.)+labs(color="Cylinders")
g+geom_point(aes(color=cyl),size=4,alpha=1/2)+facet_grid(drv~.)+labs(color="Cylinders")+scale_colour_gradient(low = "blue", high = "white") 
g+geom_point(aes(color=cyl),size=4,alpha=1/2)+facet_grid(drv~.)+labs(color="Cylinders")+scale_colour_gradient(low = "red", high = "green") 

#### change them 

g+geom_point(aes(color=cyl),size=4,alpha=1/2)+facet_grid(drv~.)+labs(color="Cylinders")+theme_dark()
g+geom_point(aes(color=cyl),size=4,alpha=1/2)+facet_grid(drv~.)+labs(color="Cylinders")+theme_linedraw(base_family="Times")
             
#### Axis Limits

#using basic plot
testdat<-data.frame(x=1:100,y=rnorm(100))
testdat[50,2]<-100
plot(testdat$x,testdat$y,type = "l",ylim = c(-3,3))

# using ggplot
g<-ggplot(testdat,aes(x=x,y=y))
g+geom_line()
g+geom_line()+ylim(-3,3)
g+geom_line()+coord_cartesian(ylim = c(-3,3))


str(mpg)

cutpoints=quantile(mpg$hwy,seq(0,1,length=4),na.rm = T)
cut(mpg$hwy,cutpoints)


