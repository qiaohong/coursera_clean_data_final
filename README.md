# Final assignment for Getting and Cleaning Data Course in Coursera Data Science Specilization (JHU)

## Please refer to run_analysis.R file for the code

## Assignment Request
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Step 0
Download and unzip data. If dataset.zip does not exist in working directory, then download the file from the given url
Unzip files

## Step 1
Merge training and test sets. There are 3 files from each set to merge
1. Subject file. 
* One column only, indicating the id of the subject
* Read files as data_subject_train and data_subject_test. Then use rbind to combine the two tables
* Then clean up the environment by removing objects no longer in use
2. Activity label file.
* Also one column only, indicating the type of activity but in numeric value
* We will translate the numeric value into meaningful labels a bit later
* Same steps, load two table, rbind to combine them, then clean up
3. Actual data
* Big files! It can take a while to read the .txt
* After loading two (big) tables, use rbind like before. And clean up.

## Step 2
Filter on measurements that are mean or std. Drop the rest
1. Map out the feature/measurement names from features.txt
2. Use grep to find measurements that contain "mean" or "std" in its names. Store the result in filter vector
3. filter data by the filter.
4. Now combine filtered measurements to subject and activity labels using cbind

## Step 3
1. Load activity_labels.txt
2. Use factor() to map labels to the dataset

## Step 4
1. First we need to reshape data. From one measurement per column to one column for all measurement values and one for measurement names
2. Then use aggregate() to calculate the mean for the measurements
3. Write data out using write.table()
