## library(rvest)

setwd("C:/tanvir/Tutorial/")

date()

for(i in 1:50){
  
  AddData=NULL
  
  link_page_url=paste("https://bikroy.com/en/ads?page=",i,sep = "")
  link_page_html=read_html(link_page_url)
  for (j in 1:40) {
    
    add_url=link_page_html %>% html_node(paste(".ui-item:nth-child(",j,") a",sep=""))  %>% html_attr(name = 'href') ### mobile number
    
    if(is.na(add_url)) break()
    
    add_url=paste("https://bikroy.com",add_url,sep = "")
    
    add_html=read_html(add_url)
    
    Name=add_html %>% html_node(".poster")  %>% html_text ### name
    MobileNumber=add_html %>% html_node(".clearfix")  %>% html_text ### mobile number
    Product=add_html %>% html_node("h1")  %>% html_text ### product
    ItemCategory1=add_html %>% html_node(".ui-crumb:nth-child(2) a")  %>% html_text ## ItemCategory1
    ItemCategory2=add_html %>% html_node(".ui-crumb:nth-child(3) a")  %>% html_text ## ItemCategory2
    Adress=add_html %>% html_node(".ui-crumb:nth-child(3) span")  %>% html_text ## Adress
    Price=add_html %>% html_node(".ui-price-tag")  %>% html_text ## Price
    AddDate=add_html %>% html_node(".date")  %>% html_text ## AddDate
    
    NewData=data.frame(Name=Name,MobileNumber=MobileNumber,Adress=Adress,AddDate=AddDate,ItemCategory1=ItemCategory1,ItemCategory2=ItemCategory2,Product=Product,AddUrl=add_url,AddPageNum=i,AddNum=j)
    AddData=rbind(NewData,AddData)
    
  }
  write.table(x=AddData,file='bikroyweb.csv',sep=',',row.names = F,append = T)
}
date()


