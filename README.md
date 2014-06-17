
The project data is downloaded and extracted to 
"UCI HAR Dataset" folder under the R working directory
resulting with the following files:
 
- "UCI HAR Dataset/test/x_test.txt" - Test set
- "UCI HAR Dataset/train/x_train.txt" - Training set
- "UCI HAR Dataset/test/y_test.txt" - Test activity codes
- "UCI HAR Dataset/train/y_train.txt" - Training activity codes
- "UCI HAR Dataset/test/subject_test.txt" - Test subject ID
- "UCI HAR Dataset/train/subject_train.txt" - Training subject ID
- "UCI HAR Dataset/activity_labels.txt" - Activity-name labels
- "UCI HAR Dataset/features.txt" - Column names for the x_test and x_train
 
The script performs the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


proj_dataset.txt
=================
 A single data frame of 10,299 x 68 containing:

- Subject column with the Train and Test subjects
- Activity column with the train+test activities, where the activity codes replaced
  with meaningful activity names as read from activity_labels.txt
- 66 features (out of the 651), which contain only features with mean or standard deviation 
  values from both train and test feature sets
- Column names that represent the actual variable names as read from features.txt

This is obtained by running the run_analysis.R script which performs the following:

1. Download the data from the internet and unzip it (commented out) 
2. Read and merge x_train and x_test using rbind() command
3. Apply column names from features.txt using colnames() command
4. Extract columns with mean and std-dev (not including meanFreq), using grepl()
5. Combine the train and test activity column and replace the values with 
   meaningful activity names using factor() and labels read from activity_labels.txt
6. Set the Activity column name
7. Combine the train and test Subject column 
8. Set the column name
9. Merge the Subject, Activity and the x-subset into one dataframe using cbind()
10. Write results to file "proj_dataset.txt"

mean_table.txt
==============
A 180x66 table that provides the average of each variable (of the 66 mean/std variables) 
for each activity and each subject (6 activities*30 subjects).

This was obtained via the following steps (all steps in one command):

1. Start with the proj_dataset data-frame obtained in part 1.
2. Split the data frame by Subject and Activity columns using split(). R
   esulting with a list of 180 data frames, one per activity and subject
3. Apply the colMean() function on each column of each table (except for the first 
   two columns, which are the subject and activity), using lapply().
4. Write results to file "mean_table.txt"


Note: Not clear if it should have done for all 561 columns of the original data set or 
only for the 66 columns of the target data set.  I have chosen to do it on the 66-column 
subset as in part 1, to save memory and CPU, while the concept would be the same. All is 
needed is to regenerate the combined data set without extracting the mean and std columns.
