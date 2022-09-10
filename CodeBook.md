This file contains all details relating to all steps for getting tidy data from the raw data downloading from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
1-First, the script in run_analysis.R began on downloading the file and unzipping it
2-After it loads the dplyr package
3-to read all files in the folder, we use the function read.table() and give the appropriate names foe each column with the argument col.names and assign it to a variable
4-The data was merged with the function rbind() for the test data and train data and rbind() for different features, we assign it in merged_data variable
5-It selects among the column of merged_data all we need: subject, activity and all column names that contains the string"mean" and "std" and assign it to a variable named mean_and_std
6-the values in column mean_and_std$activity belong to the range 1 to 6 and was changed to activity names: 
1 : WALKING
2 : WALKING_UPSTAIRS
3 : WALKING_DOWNSTAIRS
4 : SITTING
5 : STANDING
6 : LAYING
7-Appropriately labels the data set with descriptive variable names using gsub() function
8- to get a second  new data named average, we group mean_and_std by subject and activity with group_by() function and get all mean with summurize_each() functions 
