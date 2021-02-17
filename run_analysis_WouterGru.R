## 1. Download the Dataset

library(dplyr)

filename <- "Coursera_GCD_Project.zip"

if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method = "curl")
}

if (!file.exists("UCI HAR Dataset")){
        unzip(filename)
}

## Assign the collected raw Dataset to Data Frames

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/x_train.txt", col.names = features$functions)
y_train <- read.table ("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Merging the Raw Data into one Merged Datas Set

x_values <- rbind(x_train, x_test)
y_values <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, y_values, x_values)

## Extraction of only the Mean and Standard Deviation of Measurements

Tidy_Data <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

## Using Descriptive Activity Names 

Tidy_Data$code <- activities[Tidy_Data$code, 2]

## Create Appropriate Labels in the Data Set with Descriptive Variable Names

names(Tidy_Data)[2] = "activity"
names(Tidy_Data) <- gsub("Acc", "Accelerometer", names(Tidy_Data))
names(Tidy_Data) <- gsub("Gyro", "Gyroscope", names(Tidy_Data))
names(Tidy_Data) <- gsub("BodyBody", "Body", names(Tidy_Data))
names(Tidy_Data) <- gsub("Mag", "Magnitude", names(Tidy_Data))
names(Tidy_Data) <- gsub("^t", "Time", names(Tidy_Data))
names(Tidy_Data) <- gsub("^f", "Frequency", names(Tidy_Data))
names(Tidy_Data) <- gsub("tbody", "Timebody", names(Tidy_Data))
names(Tidy_Data) <- gsub("-mean()", "Mean", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data) <- gsub("-std()", "Standard Deviation", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data) <- gsub("-freq()", "Frequency", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data) <- gsub("angle", "Angle", names(Tidy_Data))
names(Tidy_Data) <- gsub("gravity", "Gravity", names(Tidy_Data))

## Creation of a Second, Independent Data Set

Final_Data <- Tidy_Data %>%
        group_by(subject, activity) %>%
        summarise_all(mean)
write.table(Final_Data, "final_data.txt", row.name = FALSE)