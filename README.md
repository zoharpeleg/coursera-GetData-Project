
The project data is downloaded and extracted to 
"UCI HAR Dataset" folder under the R working directory
resulting with the following files:
 
"UCI HAR Dataset/test/x_test.txt" - Test set
"UCI HAR Dataset/train/x_train.txt" - Training set
"UCI HAR Dataset/test/y_test.txt" - Test activity codes
"UCI HAR Dataset/train/y_train.txt" - Training activity codes
"UCI HAR Dataset/test/subject_test.txt" - Test subject ID
"UCI HAR Dataset/train/subject_train.txt" - Training subject ID
"UCI HAR Dataset/activity_labels.txt" - Activity-name labels
"UCI HAR Dataset/features.txt" - Column names for the x_test and x_train
 
The script performs the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The actual steps:
- Getting the data from the internet


Read and merge x_train and x_test using rbind


Apply column names from features.txt


extract columns with mean and std-dev (not including meanFreq)


Combine the train and test activity column and replace the values
with meaningful activity names from activity_labels.txt
Set the column name


Combine the train and test Subject column
Set the column name


Merge the Subject, Activity and the x-subset into one dataframe using cbind

write results to file "proj_dataset.txt"

create table of means of all columns per activity per subject:
Split the results by subject and activity - 
resulting with 180 tables, each one holding the observations
for one activity of one person, 
and apply the colMeans function on each column of each table,
(except for the first two columns)
could have done it for all 561 columns of the original data 
but chosen to do it on the 66-column subset as in part 1, to save 
memory and CPU. The concept would be the same.

write results to file "mean_table.txt"