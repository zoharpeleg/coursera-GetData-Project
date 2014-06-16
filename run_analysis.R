## 
## The project data was downloaded and extracted to 
## "UCI HAR Dataset" folder under the R working directory
##
## "UCI HAR Dataset/test/x_test.txt" - Test set
## "UCI HAR Dataset/train/x_train.txt" - Training set
## "UCI HAR Dataset/test/y_test.txt" - Test activity codes
## "UCI HAR Dataset/train/y_train.txt" - Training activity codes
## "UCI HAR Dataset/test/subject_test.txt" - Test subject ID
## "UCI HAR Dataset/train/subject_train.txt" - Training subject ID
## "UCI HAR Dataset/activity_labels.txt" - Activity-name labels
## "UCI HAR Dataset/features.txt" - Column names for the x_test and x_train
##
## This script performs the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Getting the data from the internet
## fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## download.file(fileurl,"Dataset.zip")
## dateDownloaded<-date()
## unzip("Dataset.zip")

#Read and merge x_train and x_test
x<-rbind(read.table("UCI HAR Dataset/train/x_train.txt"),
         read.table("UCI HAR Dataset/test/x_test.txt"))

#Apply column names from features.txt
colnames(x)<-read.table("UCI HAR Dataset/features.txt")$V2

#extract columns with mean and std-dev (not including meanFreq)
x_std_mean<-x[,grepl("mean",colnames(x))
              &!grepl("meanFreq",colnames(x))
              |grepl("std",colnames(x))]

## Combine the train and test activity column and replace the values
## with meaningful activity names from activity_labels.txt

yact<-data.frame(factor(rbind
                (read.table("UCI HAR Dataset/train/y_train.txt"),
                 read.table("UCI HAR Dataset/test/y_test.txt"))$V1, 
                labels = as.character(read.table("UCI HAR Dataset/activity_labels.txt")$V2)))

## Set the column name
colnames(yact)<-"Activity"

## Combine the train and test Subject column
subject<-data.frame(rbind
                    (read.table("UCI HAR Dataset/train/subject_train.txt"), 
                     read.table("UCI HAR Dataset/test/subject_test.txt")))
## Set the column name
colnames(subject)<-"Subject"

## Merge the Subject, Activity and the x-subset into one dataframe
proj_dataset<-cbind(subject,yact,x_std_mean)

##write results to file
write.table(proj_dataset, file="proj_dataset.txt")

## create table of means of all columns per activity per subject:
## Split the results by subject and activity - 
## resulting with 180 tables, each one holding the observations
## for one activity of one person, 
## and apply the colMeans function on each column of each table,
## (except for the first two columns)
## could have done it for all 561 columns of the original data 
## but chosen to do it on the 66-column subset as in part 1, to save 
## memory and CPU. The concept would be the same.

mean_table<-t(as.data.frame(lapply(
        split(proj_dataset, list(proj_dataset$Subject,proj_dataset$Activity)),
        function(x) colMeans(x[,3:68]))))

## write results to file:
write.table(mean_table, file="mean_table.txt")

               
               
               
               