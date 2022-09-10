download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "dataset.zip")
unzip(zipfile = "dataset.zip", exdir = "./dataset")
library(dplyr)

#read all file

features <- read.table("dataset/UCI HAR Dataset/features.txt", col.names = c("num","features"))
activity <- read.table("dataset/UCI HAR Dataset/activity_labels.txt", col.names = c("activity", "type"))

subject_test <- read.table("dataset/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("dataset/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

X_test <- read.table("dataset/UCI HAR Dataset/test/X_test.txt", col.names = features$features)
X_train <- read.table("dataset/UCI HAR Dataset/train/X_train.txt", col.names = features$features)

y_test <- read.table("dataset/UCI HAR Dataset/test/y_test.txt", col.names = "activity")
y_train <- read.table("dataset/UCI HAR Dataset/train/y_train.txt", col.names = "activity")

#merge training data and test

merge_table <- cbind(rbind(subject_test, subject_train), rbind(X_test, X_train), rbind(y_test, y_train))

#extract the measurement of mean and standard deviation 

mean_and_std <- select(merge_table, subject, activity, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set
mean_and_std$activity <- activity[mean_and_std$activity, 2]

#Appropriately labels the data set with descriptive variable names


names(mean_and_std)<-gsub("Acc", "Accelerometer",
                          gsub("Gyro", "Gyroscope",
                               gsub("BodyBody", "Body",
                                    gsub("Mag", "Magnitude",
                                         gsub("^t", "Time",
                                              gsub("^f", "Frequency", 
                                                   gsub("tBody", "TimeBody",
                                                        gsub("-mean()", "Mean",
                                                             gsub("-std()", "STD",
                                                                  gsub("-freq()", "Frequency",
                                                                       gsub("angle", "Angle",
                                                                            gsub("gravity", "Gravity", 
                                                                                 names(mean_and_std), ignore.case = TRUE))))))))))))


#create a final table with the means of each variable for each subject

average <- mean_and_std %>% group_by(subject, activity)%>% summarize_each(funs(mean))







