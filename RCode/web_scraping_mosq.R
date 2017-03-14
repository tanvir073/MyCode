## install.packages("rvest")

## library(rvest)

setwd("C:/tanvir/Tutorial/")

vignette("selectorgadget") 

mosq_html<-read_html("http://www.mosquedirectory.co.uk/mosques/england/london/harrow/wealdstone/Harrow-Central-Mosque-and-Masood-Islamic-Centre-Middlesex-Harrow/393")

data=mosq_html %>% html_node("#mosque_info_contents > table")  %>% html_table(fill=T)

table_data=data.frame(MosqID=1,AttributeName=data$X1[!is.na(data$X1)],AttributeValue=data$X2[!is.na(data$X1)])

write.table(x=table_data,file='web.csv',sep=',',row.names = F)



