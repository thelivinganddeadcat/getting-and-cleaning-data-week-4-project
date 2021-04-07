# Run_analysis.R
# Author: Angelo Mathis
# Date: April 2021
# Project: Getting and Cleaning Data Course Project
# 
# Data set: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Data collected from 30 volunteers with accelerometers and gyroscopes with a smartphone
# (Samsung Galaxy S II) on the waist The obtained dataset has been randomly partitioned into 2 sets,
# where 70% of the volunteers was selected for generating the training data and 30% the test data.
#
# Purpose of the script:
# 1. Merge the training and the test sets to create one data set
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names
# 5. From the data set in step 4, create a second, independent tidy data set with the average of 
#     each variable for each activity and each subject
#
# Preparation
# install dyplr and tidr libraries

library(dplyr)
library(tidyr)

#set the working directory where the data are located
setwd("~/angelodata/project_R/datasciencecoursera/ProgrammingAssignement3_UCI_HAR/UCI HAR Dataset")

# Obtain the data
# note: data have been manually downloaded into the working directory

features <- read.table('./features.txt',header=FALSE)
activity_labels <- read.table('./activity_labels.txt',header=FALSE)
xTrain <- read.table('./train/X_train.txt',header=FALSE)
yTrain <- read.table('./train/Y_train.txt',header=FALSE)
sTrain <- read.table('./train/subject_train.txt',header=FALSE)
xTest <- read.table('./test/X_test.txt',header=FALSE)
yTest <- read.table('./test/Y_test.txt',header=FALSE)
sTest <- read.table('./test/subject_test.txt',header=FALSE)

# name the colums
colnames(activity_labels) <- c("activity_id", "activity_type")
colnames(features) <- c("feature_id”, ”feature_type")
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activity_id"
colnames(sTrain) <- "subject_id"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activity_id"
colnames(sTest) <- "subject_id"

# Task 1: merge Test and Train data
All_test <-cbind(xTest,yTest,sTest)
All_train<-cbind(xTrain,yTrain,sTrain)
All_data<-rbind(All_test,All_train)

# Task 2: extract only the colums containg mean and std deviation
# This is done identifying first the columns that are containing the word mean and std in a vector and
# then using the vector to select these column only
# We keep as well the subject and the activity colums

a <- colnames(All_data)
Selected_colums <- All_data[,(grepl("subject_id",a)| grepl("activity_id",a)|grepl("mean",a)|grepl("Mean",a)|grepl("std",a))==TRUE]

Selected_colums <- All_data[,(grepl("subject_id",a)| grepl("activity",a)|grepl("mean",a)|grepl("Mean",a)|grepl("std",a))==TRUE]

# Task 3: Use descriptive activity names to name the activities in the data set
# the activity name is the filed activity_type in activity_labels

Selected_with_labels <- merge(Selected_colums,activity_labels,by = "activity_id")

# Task 4: Appropriately label the data set with descriptive variable names
# This has already been done before merging the tables (see #name the colums)

# Task 5: create a second tidy data set with the average of each variable for each activity and each subject
#aggregate for all variables different from activity_id (column1), subject_id (last -1 column) and activity_type (last column) --> 2:ncol(Selected_with_labels)-2
Second_data <- aggregate(Selected_with_labels[,2:ncol(Selected_with_labels)-2], by=list(Activity = Selected_with_labels$activity_type , Subject = Selected_with_labels$subject_id), mean)

#export the data
write.table(Second_data, file = "output_tidydata.txt",row.name=FALSE,sep='\t')
