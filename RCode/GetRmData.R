library(XML)
library(dplyr)
library(httr)
library(rvest)


################### leave data ################################
numberOfRow=6550

ReqURL= "http://cdtsweb345d/ResourceManagement/Leave/GetCalenderGridData"
RefererURL="http://cdtsweb345d/ResourceManagement/Leave/LeaveCalender"
HostServer = "cdtsweb345d"
OriginServer = "http://cdtsweb345d"

Leve <- POST(ReqURL,
          authenticate(":", ":", "ntlm"),
          query = list(FromDate="01 Jan 2018", ToDate="25 Apr 2018",nd="1524628926883",rows=numberOfRow,page="1",sidx="ResourceId",sord="desc"),
          user_agent("Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36"),
          add_headers(`Referer`=RefererURL,
                      Connection = "keep-alive",
                      Host = HostServer,
                      Accept = "application/json, text/javascript, */*; q=0.01",
                      `Accept-Encoding` = "gzip, deflate",
                      Origin = OriginServer,
                      `X-Requested-With` = "XMLHttpRequest",
                      `Content-Type` = "application/x-www-form-urlencoded",
                      `Accept-Language`= "en-US,en;q=0.9,bn;q=0.8"))
content(Leve, "text")
jsonlite::fromJSON(content(Leve, "text"))

leaveData=jsonlite::fromJSON(content(Leve, "text"))$rows$cell

getwd()

length(leaveData)
str(leaveData)

LeveDataTbl=data.frame(matrix(unlist(leaveData), nrow=numberOfRow, byrow=T),stringsAsFactors=FALSE)
colnames(LeveDataTbl)=c("LevelId","EmployId","EmployName","LevelType","StartDate","EndDate","Days","Status")

head(LeveDataTbl)

write.table(LeveDataTbl,"leaveData.csv",sep = "|",row.names = F)

###########Resource data##################

numberOfResource=185
ReqURL1="http://cdtsweb345d/ResourceManagement/Resource/GetGridData"
RefererURL1="http://cdtsweb345d/ResourceManagement/Resource"
Resource <- POST(ReqURL1,
             authenticate(":", ":", "ntlm"),
             query = list(nd="1524633131903",rows=numberOfResource,page="1",sidx="Name",sord="asc"),
             user_agent("Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36"),
             add_headers(`Referer`=RefererURL1,
                         Connection = "keep-alive",
                         Host = HostServer,
                         Accept = "application/json, text/javascript, */*; q=0.01",
                         `Accept-Encoding` = "gzip, deflate",
                         Origin = OriginServer,
                         `X-Requested-With` = "XMLHttpRequest",
                         `Content-Type` = "application/x-www-form-urlencoded",
                         `Accept-Language`= "en-US,en;q=0.9,bn;q=0.8"))


content(Resource, "text")
jsonlite::fromJSON(content(Resource, "text"))

ResourceData=jsonlite::fromJSON(content(Resource, "text"))$rows$cell

ResourceDataTbl=data.frame(matrix(unlist(ResourceData), nrow=numberOfResource, byrow=T),stringsAsFactors=FALSE)

head(ResourceDataTbl)
colnames(ResourceDataTbl)=c("EmployId","EmployName","Team","ResourceManager","LineManager","Designation","ContactNumber","EmailId","JoingDate","DateOfBirth","Sex","CAddress","PAddress","BloodGroup","UserId","Rule","Status1","Status2")

ResourceDataTbl

write.table(ResourceDataTbl,"ResourceDataTbl.csv",sep = "|",row.names = F)


##############

colnames(LeveDataTbl)
colnames(ResourceDataTbl)

head(ResourceDataTbl[c(1,3,5,6,11,14)])

LeveDataFinal=merge(x=ResourceDataTbl[c(1,3,5,6,11,14)],y=LeveDataTbl,By="EmployId")

head(LeveDataFinal)

###### team analysis ####

"%w/o%" <- function(x, y) x[!x %in% y] #--  x without y
(1:10) %w/o% c(3,7,12)


unique(LeveDataFinal$LevelType)
GroupByManager <- filter(LeveDataFinal,!LevelType %in% c("I WAS NOT ABSENT" ,"OUT OF OFFICE FOR OFFICIAL WORK" ,"OFFICIAL TRAININGS/WORKSHOPS" ,"SPECIAL LEAVE","WORKING FROM HOME")
                         )
head(GroupByManager)
unique(GroupByManager$LineManager)

GroupByManager$LineManager[GroupByManager$LineManager=="Aftabul Islam"]="Shahnewaz"
GroupByManager$LineManager[GroupByManager$LineManager %in% c("Jakir Hussain" ,"Syed Noor Alam" , "Noor A Kadir")]="Arindam Deb"

GroupByManager <- group_by(GroupByManager,LineManager)

LevavePctByManager<-data.frame(summarise(GroupByManager,cnt=length(unique(EmployId)),LeaveSum=sum(as.numeric(Days))))

LevavePctByManager$LeavePerRes=LevavePctByManager$LeaveSum/LevavePctByManager$cnt

arrange(LevavePctByManager,desc(LeavePerRes))


GroupByResource <- filter(LeveDataFinal,!LevelType %in% c("I WAS NOT ABSENT" ,"OUT OF OFFICE FOR OFFICIAL WORK" ,"OFFICIAL TRAININGS/WORKSHOPS" ,"SPECIAL LEAVE","WORKING FROM HOME")
                          & LineManager!=EmployName
                         & EmployName %in% unique(GroupByManager$LineManager)
                         )


GroupByResource <- group_by(GroupByResource,EmployName)

LevavePctByResource<-data.frame(summarise(GroupByResource,cnt=length(unique(EmployId)),LeaveSum=sum(as.numeric(Days))))
LevavePctByResource$LeavePerRes=LevavePctByResource$LeaveSum/LevavePctByResource$cnt


LevavePctByResource=rename(LevavePctByResource,LineManager=EmployName)
LevavePctByManagerUdt= rbind(LevavePctByResource,LevavePctByManager) %>% group_by(LineManager) %>% summarise(cnt=sum(cnt),LeaveSum=sum(LeaveSum))
LevavePctByManagerUdt$LeavePerRes=LevavePctByManagerUdt$LeaveSum/LevavePctByManagerUdt$cnt
arrange(LevavePctByManagerUdt,desc(LeavePerRes))



## Per team analysis 

ManagersName="Shahnewaz"

GroupByResourceTeam=LeveDataFinal
GroupByResourceTeam$LineManager[GroupByResourceTeam$LineManager=="Aftabul Islam"]="Shahnewaz"
GroupByResourceTeam$LineManager[GroupByResourceTeam$LineManager %in% c("Jakir Hussain" ,"Syed Noor Alam" , "Noor A Kadir")]="Arindam Deb"

GroupByResourceTeam <- filter(GroupByResourceTeam, LineManager==ManagersName
                          | EmployName==ManagersName)

tail(GroupByResourceTeam)





