## getting and cleaning data: assignment

# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
  
# Here are the data for the project:
  
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  

## download data 
setwd("C:/tanvir/Tutorial/")
##download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","data/Dataset.zip")

## test area

typeof(Labels)
str(Labels)
head(Labels)


## load train and test data set and merge two data set

traindata<-read.table("MyData/UCI HAR Dataset/train/X_train.txt")
Lavels<-read.table("MyData/UCI HAR Dataset/train/y_train.txt",col.names = 'Lavels')
traindata$DataType='Train'
traindata$Lavels=Lavels$Lavels
head(traindata,2)
testdata<-read.table("MyData/UCI HAR Dataset/test/X_test.txt")
testdata$DataType='Test'
Lavels<-read.table("MyData/UCI HAR Dataset/test/y_test.txt",col.names = 'Lavels')
testdata$Lavels=Lavels$Lavels
head(testdata,2)

mergeddata<-rbind(traindata,testdata)

head(mergeddata,2)

## Extracts only the measurements on the mean and standard deviation for each measurement.

library(dplyr)
header<-read.table("MyData/UCI HAR Dataset/features.txt",sep = " ",as.is = c(1,2))

head(header)

header=gsub("__","_",gsub("__","_",gsub("[-,()]","_",header$V2)))

header[grep("mean_|std_",header)]
grep("mean_|std_",header)

mergeddata1=mergeddata

x='tBodyAcc_mean_X'
header[x]
paste('V',1,sep='')
y=paste('rename(mergeddata1,',x,paste('=V',1,')',sep=''),sep = '')
y
eval(y)
eval(parse(text=y),envir = parent.frame(2))

head(mergeddata1[1])

head(rename(mergeddata1,tBodyAcc_mean_X=V1))

head(select(mergeddata1,x=matches("V1")))

mergeddata1[[paste('V',x,sep='')]]

mergeddata1[,colnames(paste('V',x,sep=''))]

mEx<-expression(y)
eval(mEx)














