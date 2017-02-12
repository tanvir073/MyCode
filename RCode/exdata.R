setwd("C:/tanvir/Tutorial/")
##download.file("http://aqsdr1.epa.gov/aqsweb/aqstmp/airdata/hourly_44201_2014.zip","MyData/hourly_44201_2014.zip")
library(dplyr)
library(readr)
ozone <- read.csv("MyData/hourly_44201_2014/hourly_44201_2014.csv",stringsAsFactors = F)
names(ozone) <- make.names(names(ozone))

head(ozone)
ozone1=ozone

names(ozone1) <- gsub('\\.','_',names(ozone1))

head(ozone1)

## to get idea without unpacking it
dim(ozone)
str(ozone)

## Look at the top and the bottom of your data

head(ozone)
tail(ozone)

head(ozone[, c(6:7, 10)])
tail(ozone[, c(6:7, 10)])

## Check your "n"s
table(ozone$Time.Local)

filter(ozone, Time.Local == "13:14") %>% select(State.Name, County.Name, Date.Local,Time.Local, Sample.Measurement)
select(ozone, State.Name) %>% unique %>% nrow
select(ozone, State.Name) %>% unique
unique(ozone$State.Name)

## Validate with at least one external data source (U.S. has national ambient air quality standards, and for ozone, the current
## standard2 set in 2008 is that the "annual fourth-highest daily maximum 8-hr concentration, averaged over 3 years" 
## should not exceed 0.075 parts per million (ppm), i.e. 8-hour average concentration should not be too much higher than 0.075 ppm)

summary(ozone$Sample.Measurement)

quantile(ozone$Sample.Measurement, seq(0, 1, 0.1))


## Try the easy solution first

ranking<-group_by(ozone,State.Name,County.Name)%>%summarise(ozone=mean(Sample.Measurement))%>%as.data.frame%>%arrange(desc(ozone))
head(ranking,10)
tail(ranking,10)
filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>% nrow
filter(ozone, State.Name == "Colorado" & County.Name == "Clear Creek") %>% nrow
filter(ozone, State.Name == "Puerto Rico" & County.Name == "Catano") %>% nrow

ozone <- mutate(ozone, Date.Local = as.Date(Date.Local))

filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>% mutate(month=factor(months(Date.Local),levels=month.name))%>%group_by(month)%>%summarize(ozone = mean(Sample.Measurement))
filter(ozone, State.Name == "Puerto Rico" & County.Name == "Catano") %>% mutate(month=factor(months(Date.Local),levels=month.name))%>%group_by(month)%>%summarize(ozone = mean(Sample.Measurement))
filter(ozone, State.Name == "Oklahoma" & County.Name == "Caddo") %>% mutate(month=factor(months(Date.Local),levels=month.name))%>%group_by(month)%>%summarize(ozone = mean(Sample.Measurement))

##  Challenge your solution

mutate(ozone,month=factor(months(Date.Local),levels=month.name))%>%group_by(State.Name,County.Name,month)%>%summarize(ozone = mean(Sample.Measurement))%>%as.data.frame

