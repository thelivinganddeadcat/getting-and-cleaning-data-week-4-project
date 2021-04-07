---
title: "Codebook"
author: "Angelo Mathis"
date: "4/7/2021"
output: html_document
---
CodeBook Description
This document is a codebook that describes the data, the variables, the calculations and all transformations and work that I did to clean up the provided data.


# The study information
Data collected from 30 volunteers with accelerometers and gyroscopes with a smartphone (Samsung Galaxy S II) on the waist. The obtained dataset has been randomly partitioned into 2 sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured
# The Data Source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data includes following files:
•	'features.txt'  name of all collected indicators
•	'activity_labels.txt'  list of the 6 perfromed activities
•	'subject_train.txt'  mapping of the train measurement to the subjects
•	'x_train.txt'  measurement used for training
•	'y_train.txt'  mapping to measurement to an activity for training
•	'subject_test.txt'  mapping of the test measurement to the subjects
•	'x_test.txt'  measurement used for test
•	'y_test.txt'  mapping to measurement to an activity for testing

# Obtain the data
data have been manually downloaded into the working directory

dataframes have been created with the read.table function and have been saved in objects with names that can be mapped to the original files:
Train data: xTrain, yTrain
Test data: xTest, yTest
Subject data: sTrain, sTest
Activity_labels
features

# Prepare the data
Colum names for the measured data have been obtained by the feature table. All other have been set in a tidy a logical form, in order to merge the data afterward._
colnames(activity_labels) <- c("activity_id", "activity_type")
colnames(features) <- c("feature_id”, ”feature_type")
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activity_id"
colnames(sTrain) <- "subject_id"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activity_id"
colnames(sTest) <- "subject_id"

# Task 1: merge Test and Train data
First all test data have been binded as column together
Same for the train data
Finally the test data have been merged per line with the train data

Output object: All_data

# Task 2: extract only the colums containg mean and std deviation
This is done identifying first the columns that are containing the word mean and std in a vector and
then using the vector to select these column only
We keep as well the subject and the activity colums

A vector with all colum names has been created, in order then to select with grep commnds the mean and std columns

Output object: Selected_colums

# Task 3: Use descriptive activity names to name the activities in the data set
the activity name is the filed activity_type in activity_labels
The activity name has been added with a merge on “activity_id”

# Task 4: Appropriately label the data set with descriptive variable names
This has already been done before merging the tables (see #name the colums)

# Task 5: create a second tidy data set with the average of each variable for each activity and each subject
aggregate for all variables different from activity_id (column1), subject:id (last -1 column) and activity_type (last column)  2:ncol(Selected_with_labels)-2

