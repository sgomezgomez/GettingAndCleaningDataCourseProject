# GettingAndCleaningDataCourseProject
Coursera JHU - Data Science Specialization - Getting and Cleaning Data Course Project

This Rmarkdown document explains how the run_analysis.R script work. Below are the steps followed by such script:

Step 0
* dplyr and stringr R packages are installed and loaded. However, in case those packages are already installed, installation commands are skipped.
* The source files are downloaded from the provided url to the current working directlry. With this step, the script should work even if the files are not present in the working directory.
* Once downloaded, .zip file is unzipped and all its contained documents, and folder structure, extracted to the current working directory.

Step 1
* The appropriate data sets (training set, test set, training labels, test labels, training subjects, test subjects) are loaded from the text files into R objects using the read.fwf() or read.csv() commands, and then as dplyr objects using the as_tibble() function.
* Training and test data sets are merged into one single data set using the rbind() command.

Step 2
* Merged data set is filtered by selecting only those variables which contain mean() or std() measurements. In order to such columns, a regular expression was used on the variable names.

Step 3
* Activity values are replaced with the appropriate labels from the activity labels file by using the gsub() command.

Step 4
* All column names are set according to their corresponding variable name.
* With this steps, including all the previous ones, the tidy_data_set is created.

Step 5
* A new summary_tidy_set is created by looping through all the subject/activity. combinations available in the tidy_data_set. 
* The specific data for each of these combinations is obtained via the filter() and select() commands.
* The average values for all column are calculated using the sapply() function.
* Finally, all average values are merged into one single data set, which is then arranged/sorted, and exported to a txt file, as per the assignment instructions.