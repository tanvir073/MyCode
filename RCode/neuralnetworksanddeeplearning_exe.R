
sig=function(x){1/(1+exp(-x))}

prct=function(x){
  -4*x+3
}

prct(0)
prct(1)

x=seq(-10,10,0.01)

plot(x,sig(prct(x)))

sig(prct(x))

raw_weight=c(-10,-10,-10,-10,-10,-10,-10,-10,10,10
             ,-10,-10,-10,-10,10,10,10,10,-10,-10
             ,-10,-10,10,10,-10,-10,10,10,-10,-10
             ,-10,10,-10,10,-10,10,-10,10,-10,10)

# raw_weight_1=c(0,0,0,0,0,0,0,0,10,10
#              ,0,0,0,0,10,10,10,10,0,0
#              ,0,0,10,10,0,0,10,10,0,0
#              ,0,10,0,10,0,10,0,10,0,10)

weight=matrix(ncol = 10,nrow = 4)

weight[1,]=raw_weight[1:10]
weight[2,]=raw_weight[11:20]
weight[3,]=raw_weight[21:30]
weight[4,]=raw_weight[31:40]

# weight[1,]=raw_weight_1[1:10]
# weight[2,]=raw_weight_1[11:20]
# weight[3,]=raw_weight_1[21:30]
# weight[4,]=raw_weight_1[31:40]

weight

out5=matrix(c(0,0,0,0,0,1,0,0,0,0),ncol = 1)

new_out=sig(weight%*%out5)

sig(10)





