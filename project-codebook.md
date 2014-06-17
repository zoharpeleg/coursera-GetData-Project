Introduction:
=============
This project demonstrates the collection and processing of raw data from the source data set, 
and creation of tidy data at the target data set

About the source data set:
============================
The source data is �Human Activity Recognition Using Smartphones Data Set� downloaded 
from the UCI Machine Learning Repository.
The data was collected from the accelerometers of the Samsung Galaxy S smartphones.

Data Set Information:
=====================
The experiments have been carried out with a group of 30 volunteers. Each person performed 
six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, it captured 3-axial linear acceleration and 
3-axial angular velocity at a constant rate of 50Hz. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers 
(21) was selected for generating the training data and 30% (9) the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed and then sampled in 
fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). A vector of 
features was obtained by calculating variables from the time and frequency domain.

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body 
  acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment. 

The first two data elements (Triaxial acceleration and Triaxial Angular velocity), includes 
the raw samples (128 samples per signal), which were used for creating the 561-feature vector, 
and therefore they are no longer needed for further analysis, and are not part of this project 
dataset.


Feature Selection 
=================
The features selected for this database come from the accelerometer and gyroscope 3-axial raw 
signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured 
at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass 
Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration 
signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) 
using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk 
signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional 
signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, 
tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, 
fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to 
indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between two vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on 
the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

In total, there are 561 variables in each vector.
The training data set contains 7352 vectors, from 21 subjects.
The test data set contains 2947 vectors from 9 subjects.

 
Source data files:
==================

X_test.txt		Test feature set 		2947 records of 561 variables    
y_test.txt		Test activities (1:6)		2947 records of 1 column
subject_test.txt	Test subject IDs (9 of 1:30)	2947 records of 1 column	
X_train.txt		Train feature set 		7352 records of 561 variables     
y_train.txt		Train activities (1:6)		7352 records of 1 column
subject_train.txt	Train subject IDs (21 of 1:30) 	7352 records of 1 column
activity_labels.txt	Activity labels			6x2	
features.txt		Feature-vector variable names	561x2		

Target Data files
=================

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


