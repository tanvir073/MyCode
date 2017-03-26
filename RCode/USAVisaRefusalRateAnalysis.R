#### USA visa refusal rate data analysis


setwd("C:/tanvir/Tutorial/")

#### 

## install.packages("pdftools")

library("pdftools")

library(stringr)

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



write.csv(RefusalRate,"RefusalRate.csv",row.names = F)

RefusalRate$Year

write(NumberOfPage$metadata,"sample.xml")





