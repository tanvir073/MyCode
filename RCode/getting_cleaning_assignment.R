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

## load train and test data set and merge two data set

traindata<-read.table("MyData/UCI HAR Dataset/train/X_train.txt")
testdata<-read.table("MyData/UCI HAR Dataset/test/X_test.txt")
mergeddata<-rbind(traindata,testdata)

head(mergeddata,2)

## Extracts only the measurements on the mean and standard deviation for each measurement.

library(dplyr)
header<-read.table("MyData/UCI HAR Dataset/features.txt",sep = " ",as.is = c(1,2))

head(header)

header=gsub("__","_",gsub("__","_",gsub("[-,()]","_",header$V2)))

mergeddata_seleted_col<-mergeddata[grep("mean_|std_",header)]

# Uses descriptive activity names to name the activities in the data set

Labels_tr<-read.table("MyData/UCI HAR Dataset/train/y_train.txt",col.names = 'Labels_ID')
Labels_tst<-read.table("MyData/UCI HAR Dataset/test/y_test.txt",col.names = 'Labels_ID')
Labels=rbind(Labels_tr,Labels_tst)
Labels_Desc<-read.table("MyData/UCI HAR Dataset/activity_labels.txt",col.names = c('Labels_ID','Labels'))
Activity=merge(Labels,Labels_Desc)
mergeddata_seleted_col$Activity=Activity$Labels

# Appropriately labels the data set with descriptive variable names.

colnames(mergeddata_seleted_col)<- c(header[grep("mean_|std_",header)],"Activity")

head(mergeddata_seleted_col)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subject_tr<-read.table("MyData/UCI HAR Dataset/train/subject_train.txt",col.names = 'Subject')
subject_tst<-read.table("MyData/UCI HAR Dataset/test/subject_test.txt",col.names = 'Subject')
Subject=rbind(subject_tr,subject_tst)
mergeddata_seleted_col$Subject=Subject$Subject

grouped_data<-group_by(mergeddata_seleted_col,Activity,Subject)

tidy_data=summarise_all(grouped_data,mean)
tidy_data=as.data.frame(tidy_data)

head(tidy_data)



