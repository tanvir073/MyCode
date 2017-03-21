## install.packages("rvest")

## library(rvest)

setwd("C:/tanvir/Tutorial/")

## vignette("selectorgadget") 

##### function to get mosque data table ### started


getMosqData=function(mosq_url){
  
  mosq_url=gsub( "[\n\r\t]","",mosq_url)
  mosq_html=NULL
  mosq_html=tryCatch(
    read_html(mosq_url)
    ,error=function(e){
      write.table(mosq_url,file='ErrorLink.csv',row.names = F,append = T,col.names = F)
    }
  )
  
  if(length(mosq_html)==0) table_data=NULL
  else {
    
    MosqName=mosq_html %>% html_node("td h1")  %>% html_text
    
    if(!is.na(MosqName)){
      data=mosq_html %>% html_node("#mosque_info_contents > table")  %>% html_table(fill=T)
      table_data=data.frame(MosqName,AttributeName=data$X1[!is.na(data$X1)],AttributeValue=data$X2[!is.na(data$X1)])
      
    }
    else {
      table_data=NULL
      write.table(mosq_url,file='ErrorLink.csv',row.names = F,append = T,col.names = F)
    }
    
  }
  
  table_data
  
}

#### url='http://www.mosquedirectory.co.uk/mosques/england/london/harrow/wealdstone/Harrow-Central-Mosque-and-Masood-Islamic-Centre-Middlesex-Harrow/393'

#### getMosqData(url)

##### function to get mosque data table ### ended


###### write mosque information to csv 

for(alpa in LETTERS)
{

  ## if(alpa<="W") next() #### For fix letter start
  
  mosq_link_page_url=paste("http://www.mosquedirectory.co.uk/browse-mosques/alphabet/letter/",alpa,"/",1,sep = "")
  
  mosq_link_page=read_html(mosq_link_page_url)
  
  mosq_link=mosq_link_page %>% html_node(paste("#search_data_results > ul > li:nth-child(",1,") > a"))  %>% html_attr(name = 'href')
  
  if(is.na(mosq_link)) next()
  
  for(i in 1:500)
  {
    mosq_link_page=read_html(paste("http://www.mosquedirectory.co.uk/browse-mosques/alphabet/letter/",alpa,"/",i,sep = ""))
    ##print(paste("http://www.mosquedirectory.co.uk/browse-mosques/alphabet/letter/",alpa,"/",i,sep = ""))
    mosq_link=mosq_link_page %>% html_node(paste("#search_data_results > ul > li:nth-child(",1,") > a"))  %>% html_attr(name = 'href')
    
    if(is.na(mosq_link)) break()
    
    mosq_data=NULL
    
    for(j in 1:500)
    {
      mosq_link=mosq_link_page %>% html_node(paste("#search_data_results > ul > li:nth-child(",j,") > a"))  %>% html_attr(name = 'href')
      
      if(is.na(mosq_link)) break()
      mosq_link=sub("../../../../..","http://www.mosquedirectory.co.uk",mosq_link)
      mosq_data=rbind(mosq_data,getMosqData(mosq_link))
      
    }
    if(length(mosq_data)!=0) write.table(x=mosq_data,file='web.csv',sep=',',row.names = F,append = T)
    
  }
  
}







