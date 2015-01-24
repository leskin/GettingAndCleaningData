#
# This R script file is part of the Course Project for the Getting and Cleaning Data Coursera Course
#
# The purpose of the script file is to manipulate the original data from the Human Activity Recognition Using Smartphones Dataset[1] Version 1.0, 
# to extract each variable which measures the mean or standard deviation for each measurement, 
# and to create a text file which contains the average of each variable for each activity and each subject.
#
# The data files for the Course Project were downloaded from the following URL, which was setup for this class:
#
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# References:
#
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
# Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
# International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
#
#
# Course Project Assignment Summary:
#
# You should create one R script called run_analysis.R that does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
#
#
# This script file code assumes that the working directory in RStudio is set to the
# directory in which the Coursera data zip file was extracted.
#
#
# Begin by reading in the various .txt data files into separate data frames in R
#
samsungActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
table(samsungActivityLabels)
length(samsungActivityLabels[,1])
samsungFeatures <- read.table("UCI HAR Dataset/features.txt")
table(samsungFeatures)
length(samsungFeatures[,1])
samsungSubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
table(samsungSubjectTest)
length(samsungSubjectTest[,1])
samsungXTest <- read.table("UCI HAR Dataset/test/X_test.txt")
table(samsungXTest)
length(samsungXTest[,1])
samsungYTest <- read.table("UCI HAR Dataset/test/y_test.txt")
table(samsungYTest)
length(samsungYTest[,1])
samsungSubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
table(samsungSubjectTrain)
length(samsungSubjectTrain[,1])
samsungXTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
table(samsungXTrain)
length(samsungXTrain[,1])
samsungYTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
table(samsungYTrain)
length(samsungYTrain[,1])

#
# then, we clean up the feature (measurement) names so they are well-behaved in R
#
# We clean up the measurement names by removing the paired parentheses,
# replacing single parentheses or commas with an appropriate descriptive alternative,
# and replacing a dash with a period
#
featureNames <- samsungFeatures$V2
featureNames <- gsub("()","",featureNames,fixed=TRUE)
featureNames
featureNames <- gsub("(","_between_",featureNames,fixed=TRUE)
featureNames
featureNames <- gsub(")","",featureNames,fixed=TRUE)
featureNames
featureNames <- gsub("-",".",featureNames,fixed=TRUE)
featureNames
featureNames <- gsub(",","_and_",featureNames,fixed=TRUE)
featureNames

# and then we set the feature names as the names for the columns for the training data set and the test data set

samsungTrain <- setNames(samsungXTrain, featureNames)
samsungTest <- setNames(samsungXTest, featureNames)

# Next we add the activity as a column for the training and test data sets

samsungTrain <- cbind(activity=factor(samsungYTrain$V1, labels=samsungActivityLabels$V2), samsungTrain)
samsungTest <- cbind(activity=factor(samsungYTest$V1, labels=samsungActivityLabels$V2), samsungTest)

# and finally we add the subject as a column for the training and test data sets

samsungTrain <- cbind(subject=samsungSubjectTrain$V1, samsungTrain)
samsungTest <- cbind(subject=samsungSubjectTest$V1, samsungTest)

# We now merge the training and test data sets

samsungTotal <- rbind(samsungTrain, samsungTest)

# and look at a summary of the new data frame structure

str(samsungTotal)
summary(samsungTotal)

# Next we subset out only the columns that are a mean measurement (contain mean in the name) or standard deviation measurement (contain std in the name)

samsungMeanStdTotal <- samsungTotal[,grepl("mean", names(samsungTotal)) | grepl("Mean", names(samsungTotal)) | grepl("std", names(samsungTotal)) | names(samsungTotal) == "activity" | names(samsungTotal) == "subject"]
str(samsungMeanStdTotal)
summary(samsungMeanStdTotal)

# and we use the dplyr package to calculate the average for each measurement for each activity for each subject
# and place the results in a new tidy data frame

library(dplyr)
samsungMeasurementAvgBySubjectAndActivity <- samsungMeanStdTotal %>% group_by(subject,activity) %>% summarise_each(funs(mean))

# lastly, the new tidy data frame with the averages for each activity for each subject are exported to a .txt file 

write.table(samsungMeasurementAvgBySubjectAndActivity, file = "samsungMeasurementAvgBySubjectAndActivity.txt", row.name=FALSE)
