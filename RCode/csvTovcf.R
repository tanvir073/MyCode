## create vcf from csv

setwd("C:/Tanvir Ahmad/csvTovcf")

csvdata=read.csv("output1.csv",col.names = c("Name","Number"),colClasses = c("character", "character"))


head((csvdata))

order(csvdata$Name)

csvdata=csvdata[order(csvdata$Name),]


str1="BEGIN:VCARD
VERSION:3.0
PRODID:-//Apple Inc.//iOS 6.1.6//EN"

str2="REV:2013-03-21T11:00:12Z
END:VCARD"

csvdata$Name[2]==csvdata$Name[1]

for(i in 1:length(csvdata$Name))
{

  if(i>1 && csvdata$Name[i-1]==csvdata$Name[i]) {
    write(paste("TEL;type=CELL;type=VOICE:",csvdata$Number[i],sep = ""),"test.txt",append = T)
    } 
  else {
    write(str1,"test.txt",append = T)
    write(paste("N:",csvdata$Name[i],sep = ""),"test.txt",append = T)
    write(paste("FN:",csvdata$Name[i],sep = ""),"test.txt",append = T)
    write(paste("TEL;type=CELL;type=VOICE:",csvdata$Number[i],sep = ""),"test.txt",append = T)
  }

  if(i==length(csvdata$Name) || csvdata$Name[i]!=csvdata$Name[i+1]) write(str2,"test.txt",append = T)
}
