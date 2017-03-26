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


object.size(ee)

### read specific amount of data

a=read.csv(pipe('find /v "16/12/2006" C:\\tanvir\\Tutorial\\MyData\\exdata_household_power_consumption\\household_power_consumption.txt'),header = F)

#### read data

eltConsum=read.csv("MyData/exdata_household_power_consumption/household_power_consumption.txt",sep=';',header = T,stringsAsFactors = F)

## subsetting data

Datecondition=as.Date('2007-02-01',"%Y-%m-%d") <= as.Date(eltConsum$Date,"%d/%m/%Y") & as.Date(eltConsum$Date,"%d/%m/%Y") <= as.Date('2007-02-02',"%Y-%m-%d") 

eltConsum=eltConsum[Datecondition,]

eltConsum$DateTime=strptime(paste(eltConsum$Date,eltConsum$Time),"%d/%m/%Y %H:%M:%S",tz = "GMT")

##eltConsum$Date=as.Date(eltConsumFilt$Date,"%d/%m/%Y")

### make all plots

#### Plot1 for to show frequency distribution of Global Active Power

eltConsum$Global_active_power=as.numeric(eltConsum$Global_active_power)

##hist(eltConsum$Global_active_power,breaks = seq(0,8,0.5),col = 'RED',xlab = "Global Active Power(KW)",main = "Global Active Power",ylim = c(0,1200))

png(filename = "Data Science Specializetion/Exploratory Data Analysis/Assignment/img/Plot1.png", width = 480,height = 480)
hist(eltConsum$Global_active_power,breaks = seq(0,8,0.5),col = 'RED',xlab = "Global Active Power(KW)",main = "Global Active Power",ylim = c(0,1200))

##dev.copy(png,"Data Science Specializetion/Exploratory Data Analysis/Assignment/img/Plot1.png")

dev.off(2)
##graphics.off()

#### End Plot1

##### Plot2


png(filename = "Data Science Specializetion/Exploratory Data Analysis/Assignment/img/Plot2.png", width = 480,height = 480)

plot(eltConsum$DateTime,eltConsum$Global_active_power,type = 'l',ylab = "Global Active Power(KW)",xlab = "")

dev.off(2)
#### End Plot2

##### Plot3

png(filename = "Data Science Specializetion/Exploratory Data Analysis/Assignment/img/Plot3.png", width = 480,height = 480)

plot(eltConsum$DateTime,eltConsum$Sub_metering_1,type = "n",ylab = "Energy SUb metering",xlab = "",col="#696969")

lines(eltConsum$DateTime,eltConsum$Sub_metering_1,col="#696969")
lines(eltConsum$DateTime,eltConsum$Sub_metering_2,col="#FF0000")
lines(eltConsum$DateTime,eltConsum$Sub_metering_3,col="#4682B4")
legend("topright",lty=7, col = c("#696969", "#FF0000","#4682B4"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

dev.off(2)

#### End Plot3

#### Plot4

png(filename = "Data Science Specializetion/Exploratory Data Analysis/Assignment/img/Plot4.png", width = 480,height = 480)

par(mfrow = c(2, 2))


plot(eltConsum$DateTime,eltConsum$Global_active_power,type = 'l',ylab = "Global Active Power(KW)",xlab = "",cra=10)

plot(eltConsum$DateTime,eltConsum$Voltage,type = "l",ylab = "Voltage",xlab = "DateTime")


plot(eltConsum$DateTime,eltConsum$Sub_metering_1,type = "n",ylab = "Energy SUb metering",xlab = "",col="#696969")

lines(eltConsum$DateTime,eltConsum$Sub_metering_1,col="#696969")
lines(eltConsum$DateTime,eltConsum$Sub_metering_2,col="#FF0000")
lines(eltConsum$DateTime,eltConsum$Sub_metering_3,col="#4682B4")
legend("topright",lty=7, col = c("#696969", "#FF0000","#4682B4"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),bty="n")

plot(eltConsum$DateTime,eltConsum$Global_reactive_power,type = "l",ylab = "Global_reactive_power",xlab = "DateTime")
dev.off(2)

#### End Plot4  

