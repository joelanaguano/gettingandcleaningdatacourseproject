## Downloading data
if(!file.exists("./projectdata")){dir.create("./projectdata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./projectdata/Dataset.zip",method="curl")

## Unizip
unzip(zipfile="./projectdata/Dataset.zip",exdir="./projectdata")
path <- file.path("./projectdata" , "UCI HAR Dataset")

## Reading the data

## Activity
ActivityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)
## Subject
SubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)
SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
##Features
FeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
Featuresnames <- read.table(file.path(path, "features.txt"),head=FALSE)

## 1: Merges the training and the test sets to create one data set.

Activity <- rbind(ActivityTrain, ActivityTest )
Subject <- rbind(SubjectTrain, SubjectTest)
names(Activity) <- "Activity"
names(Subject) <- "Subject"

Features <- rbind(FeaturesTrain, FeaturesTest)
names(Features) <- Featuresnames$V2

Data <- cbind(Subject, Activity)
Data <- cbind(Features, Data)
Data

## 2: Extracts only the measurements on the mean and standard deviation for each measurement.

library(dplyr)
Data <- Data %>%select(Subject, Activity, contains("mean"), contains("std"))

str(Data)

## 3: Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)
Data$Activity <- activityLabels[Data$Activity,2]
str(Data)

## 4: Appropriately labels the data set with descriptive variable names.

names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("tBody", "TimeBody", names(Data))
names(Data)<-gsub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-std()", "STD", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data)<-gsub("angle", "Angle", names(Data))
names(Data)<-gsub("gravity", "Gravity", names(Data))


## 5: From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.

tidyData <- Data %>%
  group_by(Subject, Activity) %>%
  summarise_all(list(mean))

write.table(tidyData, "tidyData.txt", row.name=FALSE)
