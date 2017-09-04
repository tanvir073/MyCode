

#sets your working directory
setwd("C:/tanvir/Tutorial/MyCode/RCode")

library(jsonlite)
library(httr)


## options(guiToolkit="tcltk") 
consKey <- "QuSyF1FthVA7v9DSAdKq0d3ws"
consSecret<-"vxvVeLPjNvGy23xg2b5XIhupLuavufCtcjpqHUpTeE6vO5pAJY"
token<-"899967360186163200-XcHrbjLqJkNRBPkMilpelqXwLOnh4Sr"
tokenSecret<-"NsMuAHPzaRC1jQlKldjl0E2S3YVDORiCLq3MEidlxXrH6"

# start the authorisation process
myapp = oauth_app("twitter", key=consKey, secret=consSecret)

# sign using token and token secret
sig = sign_oauth1.0(myapp, token=token, token_secret=tokenSecret)

searchOn="Dr."
pageCount=30
### geo filter for New York city with 
geo="&geocode=-40.785091,-73.968285,30km"

userInfo=NULL

for(i in 1:pageCount)
{
  ## url for json request 
  url<-paste("https://api.twitter.com/1.1/users/search.json?q=",searchOn,"&page=",i,"&count=10",geo,sep = "")
  
  ## json respons as list
  search_user=GET(url, sig)
  
  json1 = content(search_user)
  json2 = jsonlite::fromJSON(toJSON(json1),simplifyVector =T)
  
  ## to convart as data frame
  temuser=NULL
  
  for (nm in names(json2)) {
    
    temuser=cbind(temuser,unlist(json2[,nm]))
    
  }
  
  
  colnames(temuser)=names(json2)
  temuser=data.frame(temuser,stringsAsFactors = F)
  
  userInfo=rbind(userInfo,temuser)
  
}

head(userInfo,4)

userInfo$name
userInfo$location
