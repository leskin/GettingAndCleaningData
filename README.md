This repository was setup for the Course Project for the Coursera Course: Getting and Cleaning Data

The purpose of the repository is to manipulate the original data from the Human Activity Recognition Using Smartphones Dataset[1]
Version 1.0, to extract each variable which measures the mean or standard deviation for each measurement, and to create a text file which contains the average of each variable for each activity and each subject.

A full description of the Human Activity Recognition Project is available at the University of California, Irving (UCI) website where the original data were obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The Human Activity Recognition Project data files for this Course Project were downloaded from the following URL, which was setup for the Coursera class:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In brief, the Human Activity Recognition Project collected data from the accelerometers within the Samsung Galaxy S smartphone for thirty subjects.  Each of the subjects were observed performing one of six activities:

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. STANDING
5. SITTING
6. LAYING


This repository contains the following files:

* README.md - This file
* CodeBook.md - Code book describing the variables contained in the samsungMeasurementAvgByActivityAndSubject.txt file
* samsungMeasurementAvgByActivityAndSubject.txt - a text file containing the average of each variable which measures the mean or standard deviation for each measurement, summarized for each activity and each subject
* run_analysis.R - An R script file which performs the following data wrangling tasks: 

    1. Read the various data files provided by the Human Activity Recognition project into separate data frames
    2. Clean up the variable names used by the Human Activity Recognition Project to describe the various measurements.  In particular, the characters "(", ")", "-"" or "." which were contained in the original variable names, but which can create problems in the R language, were removed or modified in the variable names as follows:
        + all empty pairs of parentheses "()" were removed
        + each individual opening parenthesis "(" was replaced by "\_between\_"
        + each individual closing parenthesis ")" was removed
        + each dash "-" was replaced with a period "."
        + each comma "," was replaced with "\_and\_"
    3. Add the activity (using descriptive names) and subject information as columns in the training data set
    4. Add the activity (using descriptive names) and subject information as columns in the test data set
    5. Merge the training and the test sets to create one master data set
    6. Extract only the measurements which pertain to the mean or standard deviation for each measurement. 
    7. From the data set in step 6, create a second, independent tidy data set with the average of each variable for each activity and each subject
    8. Export the data set with the average of each variable for each activity and each subject to the text file samsungMeasurementAvgByActivityAndSubject.txt



References:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012