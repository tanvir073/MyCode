## library(rvest)

library(jsonlite)
library(httr)

setwd("C:/tanvir/Tutorial/")

ini=721919
Job_detail_url=paste("http://jobs.bdjobs.com/jobdetails.asp?id=",ini-1,sep = "")
Job_detail_html=read_html(Job_detail_url)

com_name=Job_detail_html %>% html_node("#com_name")%>% html_text

job_title=Job_detail_html %>% html_node(".job-title")%>% html_text

Publish_On=Job_detail_html %>% html_node(".panel-body")%>% html_node("h4:nth-child(1)")%>%html_text
Deadline=Job_detail_html %>% html_node(".panel-body")%>% html_node("h4:nth-child(8)")%>%html_text

Summr_Info=Job_detail_html %>% html_node(".panel-body")%>% html_nodes("h4")%>%html_text

Job_Des=Job_detail_html %>% html_node("div.job_des")%>% html_node("ul")%>% html_nodes("li")%>%html_text
Job_Nat=Job_detail_html %>% html_node("div.job_nat")%>% html_node("p")%>%html_text
Edu_Req=Job_detail_html %>% html_node("div.edu_req")%>% html_node("ul")%>%html_text
Exp_Req=Job_detail_html %>% html_nodes("div.edu_req:eq(2)") html %>% html_nodes("ul")%>%html_text

Job_detail_html %>% html_nodes("div.edu_req:eq(2)") %>% html_nodes("ul")%>%html_text




