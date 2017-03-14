## set current directory

setwd("C:/tanvir/Tutorial/")

### download data

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","MyData/exdata_household_power_consumption.zip")

### unzip data

zipF<- "MyData/exdata_household_power_consumption.zip"
outDir<-"MyData/exdata_household_power_consumption"
unzip(zipF,exdir=outDir)

### estimate memoroy size in R to load data
read.csv("MyData/exdata_household_power_consumption/household_power_consumption.txt",sep=';', nrow=10)
top.size <- object.size(read.csv("MyData/exdata_household_power_consumption/household_power_consumption.txt", nrow=1000))
txt=system('find /c ";" C:\\tanvir\\Tutorial\\MyData\\exdata_household_power_consumption\\household_power_consumption.txt', intern=T)
lines <- as.numeric(substr(txt[2],regexpr(': ',txt[2])+2,nchar(txt[2])))
size.estimate <- lines / 1000 * top.size

eltConsum=read.csv("MyData/exdata_household_power_consumption/household_power_consumption.txt",sep=';',header = T)
object.size(ee)

### read specific amount of data

a=read.csv(pipe('find /v "16/12/2006" C:\\tanvir\\Tutorial\\MyData\\exdata_household_power_consumption\\household_power_consumption.txt'),header = F)

#### data cleaning 

head(eltConsum,5)

eltConsum$DateTime=strptime(paste(eltConsum$Date,eltConsum$Time),"%d/%m/%Y %H:%M:%S")

### make all plots


### proper legend and axis  

