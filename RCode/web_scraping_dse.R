### set your directory where you wand to save your file
setwd("C:/tanvir/Tutorial/")

## install and load necessary packages
install.packages("rvest")
install.packages("stringr")
library(rvest)
library(stringr)

#### get DSE company listing page

DscCompURL="http://www.dsebd.org/company%20listing.php"

DscCompHTML=read_html(DscCompURL)

## get all web links from company listing page

Links=DscCompHTML %>% html_nodes("table td a")%>% html_attr(name = 'href')

## subseting links for company links
Links=Links[grep("displayCompany.php",Links)]

## blank data frame object to store company data

datafrm=data.frame()

## run loop for all company profile pages

for(l in 1:length(Links))
{
  companyURL=paste("http://www.dsebd.org/",Links[l],sep = "")
  
  ## print company url
  print(companyURL)
  ## get company profile page
  companyHTML=read_html(companyURL)
  
  ## retrive data
  
  Trading_Code=companyHTML %>% html_nodes(xpath="//b[contains(text(),'Trading Code')]/..")%>% html_text()
  
  TotalOut=companyHTML %>% html_nodes(xpath="//td[text() = 'Total No. of Outstanding Securities']/../td[2]") %>% html_text()
  
  Total_Outstanding_Sectis=as.integer(str_trim(gsub(",","",TotalOut)))
  
  tt=companyHTML %>% html_nodes(xpath="//td[contains(text(),'Share Holding Percentage')]/..") 
  
  for (i in 1:length(tt)) {
    data=tt[i] %>% html_nodes(xpath="descendant::td/font") %>%  html_text()
    As_on_Date=sub(' \r\n                  \t','',str_trim(data[1]))
    Sponsor=sub("Sponsor/Director:","",sub("\r\n\t\t\t\t\t\t","",data[2]))
    Govt=sub("Govt:","",sub("\r\n\t\t\t\t\t\t","",data[3])) 
    Institute=sub("Institute:","",sub("\r\n\t\t\t\t\t\t","",data[4])) 
    Foreign=sub("Foreign:","",sub("\r\n\t\t\t\t\t\t","",data[5])) 
    Public=sub("Public:","",sub("\r\n\t\t\t\t\t\t","",data[6])) 
    datafrm=rbind(datafrm,data.frame(Trading_Code,Total_Outstanding_Sectis,As_on_Date,Sponsor,Govt,Institute,Foreign,Public))
    
  }
  
}

## write csv file

write.table(x=datafrm,file='DSE.csv',sep=',',row.names = F,append = T)

