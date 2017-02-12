## set current directory

setwd("C:/tanvir/Tutorial/")

### download data

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","MyData/exdata_household_power_consumption.zip")

### unzip data

zipF<- "MyData/exdata_household_power_consumption.zip"
outDir<-"MyData/exdata_household_power_consumption"
unzip(zipF,exdir=outDir)

### estimate memoroy size in R to load data

read

