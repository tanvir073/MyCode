#### USA visa refusal rate data analysis


setwd("C:/tanvir/Tutorial/")

#### 

## install.packages("pdftools")

library("pdftools")

library(stringr)
library(dplyr)

#### read data from PDF

RefusalRate=NULL

FileDir="MyData/USVisaRefusalRate/"
AllFiles=list.files(path = FileDir, pattern = "^FY")


for (file in AllFiles) {
  
  PdfTxt <- pdf_text(paste(FileDir,file,sep = ""))
  NumberOfPage=pdf_info(paste(FileDir,file,sep = ""))$pages

  for (pg in 1:NumberOfPage) {
    
    
    Year=sub("FY","20",substr(file,1,4))
    my_page=PdfTxt[pg]
    
    
    RawTable=my_page %>% str_split("\n")%>% .[[1]]
    
    DataStart=grep("RATE\r",RawTable)+1
    
    for (i in DataStart:length(RawTable)) {
      
      if(regexpr(pattern ='%\r',RawTable[i])<=0) break()
      RateStr=min(data.frame(str_locate_all(RawTable[i],"[0-9]")[1])[1])
      RateEnd=max(data.frame(str_locate_all(RawTable[i],"[0-9]")[1])[2])
      
      Country=str_trim( substr(RawTable[i],1,RateStr-1))
      Rate=substr(RawTable[i],RateStr,RateEnd) 
      RefusalRate=rbind(RefusalRate,data.frame(Year=Year,Country=as.character(Country),Rate=as.numeric(Rate)))
    }
  }
  
}

## RefusalRate$Country=toupper(RefusalRate$Country)

write.csv(unique(toupper(RefusalRate$Country)),"MyData/USVisaRefusalRate/OnlyCountry.csv",row.names = F)

## write.csv(RefusalRate,"MyData/USVisaRefusalRate/RefusalRate.csv",row.names = F)

### Plot data
## install.packages("RInside")
## install.packages("plotly")
## install.packages("yaml")
library(plotly)
library(RInside)
library(yaml)

## install.packages("rvest")

## library(rvest)

CountryURL="https://developers.google.com/public-data/docs/canonical/countries_csv"

CountryHTML=read_html(CountryURL)

CountryTableList=CountryHTML %>% html_nodes(xpath='//*/table[1]') %>% html_table()

CountryTable=CountryTableList[[1]]

write.csv(CountryTable,"MyData/USVisaRefusalRate/Country.csv")

CountryList=read.csv("MyData/USVisaRefusalRate/CountryTable.csv")

head(CountryList)
tail(CountryList)

CountryList$Country[CountryList$Country=='']=CountryList$Country_name[CountryList$Country=='']

MRefusalRate=merge(RefusalRate,CountryList[,c(1:5)])

tail(MRefusalRate,3)
head(MRefusalRate,3)

write.csv(MRefusalRate,"MyData/USVisaRefusalRate/MRefusalRate.csv")

g <- list(
  scope = 'world',
  showland = TRUE,
  landcolor = toRGB("gray95")
)

Yr="2014"

YMRefusalRate=MRefusalRate[MRefusalRate$Year==Yr,]

plot_geo(YMRefusalRate, lat = ~Latitude, lon = ~Longitude) %>%
  add_markers(
    text = ~paste(Country, paste("Refusal Rate:", Rate), sep = "<br />"),
    color = ~Rate, symbol = I("square"), size = I(8), hoverinfo = "text"
  ) %>%
  colorbar(title = paste("USA Visa Refusal Rate",paste("Year-",Yr), sep = "<br />")) %>%
  layout(
    title = 'USA Visa Refusal Rate Per Country<br />(Hover for Rate)', geo = g
  )



