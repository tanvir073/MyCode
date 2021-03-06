#### Dimension Reduction

set.seed(12345)
par(mar=rep(0.2,4))

dataMatrix<-matrix(rnorm(400),nrow = 40)

image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])

heatmap(dataMatrix)

## add pattern to the data

set.seed(678910)

for (i in 1:40) {
  
  #coin flip
  coninFlip<-rbinom(1,size=1,prob = 0.5)
  
  #if coin is heads add a common pattern to that row
  if(coninFlip){
    dataMatrix[i,]<-dataMatrix[i,]+rep(c(0,3),each=5)
  }
  
  
}


par(mar=rep(0.2,4))
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])

par(mar=rep(0.2,4))
heatmap(dataMatrix)

hh<-hclust(dist(dataMatrix))

dataMatrixOrdered<-dataMatrix[hh$order,]
par(mfrow=c(1,3))
image(t(dataMatrixOrdered))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])

plot(rowMeans(dataMatrixOrdered),40:1, ,xlab="Row Mean",ylab = "Row",pch=19)
plot(colMeans(dataMatrixOrdered) ,xlab="Column",ylab = "Column Mean",pch=19)

## singular value decomposition



