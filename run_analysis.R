## run_analysis.R
##
## This script does the following: 
## 0. Downloads the required data from the referenced urls
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 5, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
##
## Step 0 - Downloading files
## Loading library dependencies dplyr library
print('Step 0 - Downloading files')
dplyr_loaded <- require('dplyr')
if(!dplyr_loaded) {
        install.packages('dplyr')
        library(dplyr)
}
dplyr_loaded <- require('stringr')
if(!dplyr_loaded) {
        install.packages('stringr')
        library(stringr)
}
print('Packages installed and loaded')
## Downloading files
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'samsung_dataset.zip', method = 'curl')
print('Source files downloaded')
## Unzipping files
unzip('samsung_dataset.zip')
print('Source files unzipped')
##
## Step 1 - Merging training and test data
print('Step 1 - Merging training and test data')
## Loading training data set
training_set <- read.fwf('./UCI HAR Dataset/train/X_train.txt', header = FALSE, widths = replicate(561, 16)) 
training_set <- tibble::as_tibble(training_set)
print('Traning data set loaded')
## Loading test data set
test_set <- read.fwf('./UCI HAR Dataset/test/X_test.txt', header = FALSE, widths = replicate(561, 16)) 
test_set <- tibble::as_tibble(test_set)
print('Test data set loaded')
## Adding source column to training and test data sets
test_set <- mutate(test_set, source = 'test')
training_set <- mutate(training_set, source = 'training')
print('Source column added to test and training sets')
## Merging training and test sets
merged_set <- rbind(training_set, test_set)
print('Training and test sets combined into one')
rm(test_set)
rm(training_set)
print('Original training and test sets removed')
## Loading training subjects set
training_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt', header = FALSE)
training_subject <- tibble::as_tibble(training_subject)
print('Traning subjects set loaded')
## Loading test subjects set
test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE)
test_subject <- tibble::as_tibble(test_subject)
print('Test subjects set loaded')
## Merging training and test subjects sets
merged_subject <- rbind(training_subject, test_subject)
print('Training and test subject sets combined')
rm(test_subject)
rm(training_subject)
print('Training and test subjects sets removed')
## Loading training data set labels
training_labels <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE)
training_labels <- tibble::as_tibble(training_labels)
print('Traning labels loaded')
## Loading test data set labels
test_labels <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE)
test_labels <- tibble::as_tibble(test_labels)
print('Test labels loaded')
## Merging training and test label sets
merged_labels <- rbind(training_labels, test_labels)
print('Training and test subject label sets combined')
rm(test_labels)
rm(training_labels)
print('Training and test subjects label sets removed')
##
## Step 2 - Extracting mean and standard deviation for each measurement
## Loading variable names
print('Step 2 - Extracting mean and standard deviation for each measurement')
set_variable_names <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
set_variable_names <- tibble::as_tibble(set_variable_names)
print('Variable names loaded')
## Identifying mean() and std() variables to extract
variables_extract <- which(grepl('mean\\(|std\\(', set_variable_names$V2))
variables_extract <- set_variable_names[variables_extract, ]
variables_extract <- tibble::as_tibble(variables_extract)
variables_extract <- mutate(variables_extract, V3 = paste0('V', V1))
print('Relevant variable names identified')
## Filtering merged set by extracting the relevant columns
filtered_set <- select(merged_set, c(source, variables_extract$V3))
print('Relevant columns extracted to a filtered data set')
rm(merged_set)
print('Merged set removed')
##
## Step 3 - Setting descriptive activity names to working data set
print('Step 3 - Setting descriptive activity names to working data set')
## Adding label activity to filtered set
names(merged_subject) <- 'subject'
names(merged_labels) <- 'activity'
filtered_set <- cbind(merged_subject, merged_labels, filtered_set)
## Loading label/activity name
activity_labels <- read.csv('./UCI HAR Dataset/activity_labels.txt', header = FALSE, sep = ' ')
activity_labels <- tibble::as_tibble(activity_labels)
print('Activity labels loaded')
## Loop to change label set values to be more descriptive
for(i in 1:nrow(activity_labels)) {
        filtered_set <- mutate(filtered_set, activity = gsub(activity_labels[i,1], tolower(activity_labels[i,2]), activity))
}
print('Activity values reset')
##
## Step 4 - Labeling filtered data set with descriptive variable names
print('Step 4 - Labeling filtered data set with descriptive variable names')
names(filtered_set) <- c('subject', 'activity', 'source', tolower(variables_extract$V2))
tidy_data_set <- filtered_set
rm(filtered_set)
print('Tidy data set variable names set to descriptive names')
##
## Step 5 - Creating a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
print('Step 5 - Creating a second tidy data set with the average of each variable for each activity and each subject')
## Creating empty dplyr data frame 
summary_tidy_set <- tibble::as_tibble()
subjects <- unique(tidy_data_set$subject)
activities <- unique(tidy_data_set$activity)
## Looping through each subject and activity to obtain the average of all columns
for(i in 1:length(subjects)) {
       for(j in 1:length(activities)) {
               ## Creating a subset of tidy data set for the specific subject/activity combination 
               values <- filter(tidy_data_set, subject == subjects[i] & activity == activities[j])
               values <- select(values, -c('subject', 'activity', 'source'))
               ## Applying mean function to all columns of subset
               mean_vector <- sapply(values, mean)
               summary_tidy_set <- rbind(summary_tidy_set, c(subject = subjects[i], activity = activities[j], mean_vector))
               
       }
}
## Renaming resulting summary tidy data set columns
custom_column_names <- paste0('mean(', tolower(variables_extract$V2), ')')
names(summary_tidy_set) <- c('subject', 'activity', custom_column_names)
print('Summary tidy data set created')
rm(activity_labels, activities, subjects, set_variable_names, merged_labels, merged_subject, values)
print('Temporary objects removed')
## Saving summary tidy data set as text file as per instructions
summary_tidy_set$subject <- as.numeric(summary_tidy_set$subject)
summary_tidy_set <- arrange(summary_tidy_set, subject, activity)
write.table(summary_tidy_set, 'summary_tidy_set.txt', row.name = FALSE)
print('Summary tidy data set exported as a txt file')