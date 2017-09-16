library(rvest)

library(dplyr)
library(httr)

setwd("C:/tanvir/Tutorial/")


f_add_row<-function(total=NULL,new=NULL){
  
  if(length(new)>0 && ncol(new)>1) rbind(total,new)
  else total
  
}

f_html_node<-function(html_body,html_nod,..){
  if(is.na(html_node(html_body,html_nod))) read_html('<head>\n<meta name="viewport" content="width=device-width, initial-scale=1"></head>')
  else html_node(html_body,html_nod)
}
f_html_nodes<-function(html_body,html_nod,..){
  if(is.na(html_nodes(html_body,html_nod))) read_html('<head>\n<meta name="viewport" content="width=device-width, initial-scale=1"></head>')
  else html_nodes(html_body,html_nod)
}


Base_Info_Total=NULL
Summr_Info_Total=NULL
Job_Des_Total=NULL
Edu_Req_Total=NULL
Exp_Req_Total=NULL
Job_Req_Total=NULL
Salary_Rng_Total=NULL
Other_Ben_Total=NULL
Com_Info_Total=NULL


Job_detail_html=NULL

ini=253032 ## min number

for (ini in seq(from=723330,to=722127,by = -1)){
  
  Job_detail_url=paste("http://jobs.bdjobs.com/jobdetails.asp?id=",ini,sep = "")
  Job_detail_html=read_html(Job_detail_url)
  
  com_name=Job_detail_html %>% html_node("#com_name")%>% html_text
  if(length(com_name)==0|is.na(com_name)) next
  
  job_title=Job_detail_html %>% html_node(".job-title")%>% html_text
  
  
  Publish_On=Job_detail_html %>% html_node(".panel-body")%>% html_node("h4:nth-child(1)")%>%html_text
  Deadline=Job_detail_html %>% html_node(".panel-body")%>% html_node("h4:nth-child(7)")%>%html_text
  
  Summr_Info=Job_detail_html %>% html_node(".panel-body")%>% html_nodes("h4")%>%html_text
  
  Job_Des=Job_detail_html %>% html_node("div.job_des")%>% html_node("ul")%>% html_nodes("li")%>%html_text
  if(length(Job_Des)==0) Job_Des=Job_detail_html %>% html_node("div.job_des")%>% html_node("ul")%>%html_text
  Job_Nat=Job_detail_html %>% html_node("div.job_nat")%>% html_node("p")%>%html_text
  Edu_Req=Job_detail_html %>% f_html_node("div.edu_req")%>% f_html_node("ul")%>% html_nodes("li")%>%html_text
  if(length(Edu_Req)==0) Edu_Req=Job_detail_html %>% f_html_node("div.edu_req")%>% f_html_node("ul")%>%html_text
  Exp_Req=tryCatch(Job_detail_html %>% f_html_nodes("div.edu_req")%>%.[[2]]%>% f_html_node("ul")%>% html_nodes("li")%>%html_text,error = function(e) NULL)
  if(length(Exp_Req)==0) Exp_Req=tryCatch(Job_detail_html %>% f_html_nodes("div.edu_req")%>%.[[2]]%>% f_html_node("ul")%>%html_text, error = function(e) NULL)
  Job_Req=Job_detail_html %>% f_html_node("div.job_req")%>% f_html_node("ul")%>% html_nodes("li")%>%html_text
  if(length(Job_Req)==0) Job_Req=Job_detail_html %>% f_html_node("div.job_req")%>% f_html_node("ul")%>%html_text
  
  Job_Loc=Job_detail_html %>% f_html_node("div.job_loc")%>% html_node("p")%>%html_text
  
  
  Salary_Rng=Job_detail_html %>% f_html_node("div.salary_range")%>% f_html_node("ul")%>%html_nodes("li")%>%html_text
  if(length(Salary_Rng)==0) Salary_Rng=Job_detail_html %>% f_html_node("div.salary_range")%>% html_node("ul")%>%html_text
  
  Other_Ben=Job_detail_html %>% f_html_node("div.oth_ben")%>% f_html_node("ul")%>%html_nodes("li")%>%html_text
  if(length(Other_Ben)==0) Other_Ben=Job_detail_html %>% f_html_node("div.oth_ben")%>% html_node("ul")%>%html_text

  
  Com_Info=Job_detail_html %>% f_html_node("div.information")%>%html_nodes("span")%>%html_text
  
  
  Base_Info_Total=f_add_row(Base_Info_Total,cbind(Job_ID=ini,Job_detail_url,Job_Title=job_title,Company=com_name,Job_Nat=Job_Nat,Job_Location=Job_Loc))
  Summr_Info_Total=f_add_row(Summr_Info_Total,cbind(Job_ID=ini,Summr_Info=Summr_Info))
  Job_Des_Total=f_add_row(Job_Des_Total,cbind(Job_ID=ini,Job_Des=Job_Des))
  Edu_Req_Total=f_add_row(Edu_Req_Total,cbind(Job_ID=ini,Edu_Req=Edu_Req))
  Exp_Req_Total=f_add_row(Exp_Req_Total,cbind(Job_ID=ini,Exp_Req=Exp_Req))
  Job_Req_Total=f_add_row(Job_Req_Total,cbind(Job_ID=ini,Job_Req=Job_Req))
  Salary_Rng_Total=f_add_row(Salary_Rng_Total,cbind(Job_ID=ini,Salary_Rng=Salary_Rng))
  Other_Ben_Total=f_add_row(Other_Ben_Total,cbind(Job_ID=ini,Other_Ben=Other_Ben))
  Com_Info_Total=f_add_row(Com_Info_Total,cbind(Job_ID=ini,Com_Info=Com_Info))
  
  
}

varName=c("Base_Info_Total","Summr_Info_Total","Job_Des_Total","Edu_Req_Total","Exp_Req_Total","Job_Req_Total","Salary_Rng_Total","Other_Ben_Total","Com_Info_Total")



for (variable in varName) {
  eval(parse(text =paste0("write.table(",variable,",'Mydata/bdjobs/",variable,".csv',sep = '|',row.names = F)")))
}



Base_Info_Total
Summr_Info_Total
Job_Des_Total
Edu_Req_Total
Exp_Req_Total
Job_Req_Total
Salary_Rng_Total
Other_Ben_Total
Com_Info_Total

a=NULL
b=data.frame(tt="r",pp='k')

bind_rows(a,b)

bind_cols(sources %>%parse_source()) %>%suppressWarnings()
