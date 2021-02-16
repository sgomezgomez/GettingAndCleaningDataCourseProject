---
title: 'Getting and Cleaning Data Course Project'
author: 'Sebastian Gomez Gomez'
output: pdf_document
---

# Code Book
This code book describes the data by indicating all the variables and summaries calculated, as well as any other relevant information.

### Data sets - tidy_data_set
The first data set is the tidy_data_set:
```{r}
tidy_data_set
```
This data set was obtained by merging the training and test data sets for the 30 subjects evaluated.

Below you can find the list of fields and other relevant information:
```{r}
[1] "subject"                    
[2] "activity"                   
[3] "source"                     
[4] "tbodyacc-mean()-x"          
[5] "tbodyacc-mean()-y"          
[6] "tbodyacc-mean()-z"          
[7] "tbodyacc-std()-x"           
[8] "tbodyacc-std()-y"           
[9] "tbodyacc-std()-z"           
[10] "tgravityacc-mean()-x"       
[11] "tgravityacc-mean()-y"       
[12] "tgravityacc-mean()-z"       
[13] "tgravityacc-std()-x"        
[14] "tgravityacc-std()-y"        
[15] "tgravityacc-std()-z"        
[16] "tbodyaccjerk-mean()-x"      
[17] "tbodyaccjerk-mean()-y"      
[18] "tbodyaccjerk-mean()-z"      
[19] "tbodyaccjerk-std()-x"       
[20] "tbodyaccjerk-std()-y"       
[21] "tbodyaccjerk-std()-z"       
[22] "tbodygyro-mean()-x"         
[23] "tbodygyro-mean()-y"         
[24] "tbodygyro-mean()-z"         
[25] "tbodygyro-std()-x"          
[26] "tbodygyro-std()-y"          
[27] "tbodygyro-std()-z"          
[28] "tbodygyrojerk-mean()-x"     
[29] "tbodygyrojerk-mean()-y"     
[30] "tbodygyrojerk-mean()-z"
[31] "tbodygyrojerk-std()-x"      
[32] "tbodygyrojerk-std()-y"      
[33] "tbodygyrojerk-std()-z"      
[34] "tbodyaccmag-mean()"         
[35] "tbodyaccmag-std()"          
[36] "tgravityaccmag-mean()"      
[37] "tgravityaccmag-std()"       
[38] "tbodyaccjerkmag-mean()"     
[39] "tbodyaccjerkmag-std()"      
[40] "tbodygyromag-mean()"        
[41] "tbodygyromag-std()"         
[42] "tbodygyrojerkmag-mean()"    
[43] "tbodygyrojerkmag-std()"     
[44] "fbodyacc-mean()-x"          
[45] "fbodyacc-mean()-y"          
[46] "fbodyacc-mean()-z"          
[47] "fbodyacc-std()-x"           
[48] "fbodyacc-std()-y"           
[49] "fbodyacc-std()-z"           
[50] "fbodyaccjerk-mean()-x" 
[51] "fbodyaccjerk-mean()-y"      
[52] "fbodyaccjerk-mean()-z"      
[53] "fbodyaccjerk-std()-x"       
[54] "fbodyaccjerk-std()-y"       
[55] "fbodyaccjerk-std()-z"       
[56] "fbodygyro-mean()-x"         
[57] "fbodygyro-mean()-y"         
[58] "fbodygyro-mean()-z"         
[59] "fbodygyro-std()-x"          
[60] "fbodygyro-std()-y"          
[61] "fbodygyro-std()-z"          
[62] "fbodyaccmag-mean()"         
[63] "fbodyaccmag-std()"          
[64] "fbodybodyaccjerkmag-mean()" 
[65] "fbodybodyaccjerkmag-std()"  
[66] "fbodybodygyromag-mean()"    
[67] "fbodybodygyromag-std()"     
[68] "fbodybodygyrojerkmag-mean()"
[69] "fbodybodygyrojerkmag-std()"
```
Where:

* subject: Identifier of the subject who carried out the experiment. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

* activity: Activity label performed. Each subject performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist

* source: Source data set where the information was extracted from. Values can be "training" or "test" depending on the file the data was originated from.

* All other columns are explained as follows:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: mean(): Mean value, and std(): Standard deviation

#### Transformations and data cleaning: 
It is important to mention that data was initially downloaded from the following url into the working directory: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>. Once downloaded and unzipped, training and test data sets, labels and subject files were loaded into R objects. Then, those R objects containing the data were processed in order to:

* Extract or subset only those variables or columns containing  the mean() or standard deviation - std() signals

* Convert subject and other relevant columns from character to numeric for ordering and mean calculating purposes

* Identify the source file where the data was originally extrated from

* Activity codes replaced for their corresponding labels

* Provide descriptive names for each column in the tidy data set

### Data sets - summary_tidy_set
The second data set is the tidy_data_set:
```{r}
summary_tidy_set
```
This data set was obtained by calculating the average for each variable by subject, by activity.

Below you can find the list of fields and other relevant information:
```{r}
[1] "subject"                          
[2] "activity"                         
[3] "mean(tbodyacc-mean()-x)"          
[4] "mean(tbodyacc-mean()-y)"          
[5] "mean(tbodyacc-mean()-z)"          
[6] "mean(tbodyacc-std()-x)"           
[7] "mean(tbodyacc-std()-y)"           
[8] "mean(tbodyacc-std()-z)"           
[9] "mean(tgravityacc-mean()-x)"       
[10] "mean(tgravityacc-mean()-y)"       
[11] "mean(tgravityacc-mean()-z)"       
[12] "mean(tgravityacc-std()-x)"        
[13] "mean(tgravityacc-std()-y)"        
[14] "mean(tgravityacc-std()-z)"        
[15] "mean(tbodyaccjerk-mean()-x)"      
[16] "mean(tbodyaccjerk-mean()-y)"      
[17] "mean(tbodyaccjerk-mean()-z)"      
[18] "mean(tbodyaccjerk-std()-x)"       
[19] "mean(tbodyaccjerk-std()-y)"       
[20] "mean(tbodyaccjerk-std()-z)"
[21] "mean(tbodygyro-mean()-x)"         
[22] "mean(tbodygyro-mean()-y)"         
[23] "mean(tbodygyro-mean()-z)"         
[24] "mean(tbodygyro-std()-x)"          
[25] "mean(tbodygyro-std()-y)"          
[26] "mean(tbodygyro-std()-z)"          
[27] "mean(tbodygyrojerk-mean()-x)"     
[28] "mean(tbodygyrojerk-mean()-y)"     
[29] "mean(tbodygyrojerk-mean()-z)"     
[30] "mean(tbodygyrojerk-std()-x)"      
[31] "mean(tbodygyrojerk-std()-y)"      
[32] "mean(tbodygyrojerk-std()-z)"      
[33] "mean(tbodyaccmag-mean())"         
[34] "mean(tbodyaccmag-std())"          
[35] "mean(tgravityaccmag-mean())"      
[36] "mean(tgravityaccmag-std())"       
[37] "mean(tbodyaccjerkmag-mean())"     
[38] "mean(tbodyaccjerkmag-std())"      
[39] "mean(tbodygyromag-mean())"        
[40] "mean(tbodygyromag-std())"
[41] "mean(tbodygyrojerkmag-mean())"    
[42] "mean(tbodygyrojerkmag-std())"     
[43] "mean(fbodyacc-mean()-x)"          
[44] "mean(fbodyacc-mean()-y)"          
[45] "mean(fbodyacc-mean()-z)"          
[46] "mean(fbodyacc-std()-x)"           
[47] "mean(fbodyacc-std()-y)"           
[48] "mean(fbodyacc-std()-z)"           
[49] "mean(fbodyaccjerk-mean()-x)"      
[50] "mean(fbodyaccjerk-mean()-y)"      
[51] "mean(fbodyaccjerk-mean()-z)"      
[52] "mean(fbodyaccjerk-std()-x)"       
[53] "mean(fbodyaccjerk-std()-y)"       
[54] "mean(fbodyaccjerk-std()-z)"       
[55] "mean(fbodygyro-mean()-x)"         
[56] "mean(fbodygyro-mean()-y)"         
[57] "mean(fbodygyro-mean()-z)"         
[58] "mean(fbodygyro-std()-x)"          
[59] "mean(fbodygyro-std()-y)"          
[60] "mean(fbodygyro-std()-z)"          
[61] "mean(fbodyaccmag-mean())"         
[62] "mean(fbodyaccmag-std())"          
[63] "mean(fbodybodyaccjerkmag-mean())" 
[64] "mean(fbodybodyaccjerkmag-std())"  
[65] "mean(fbodybodygyromag-mean())"    
[66] "mean(fbodybodygyromag-std())"     
[67] "mean(fbodybodygyrojerkmag-mean())"
[68] "mean(fbodybodygyrojerkmag-std())"
```
Where all fields are a summarized average value, for each of the fields in the tidy_data_set, by subject and activity.


NOTE: All column names (except for subject and activity, which are the same as the ones in the tidy_data_set) have the following pattern: 'mean(' + ColumnName + ')'.

#### Transformations and data cleaning: 
In order to calculate this summarized dataset, a mean() operation was simultaneously applied to all variable columns via the sapply() command, by looping through each subject/activity combination possible.