# Course Project for Coursera Data Science Specialization

The main purpose of this Course Project is cleaning the data taken from this source:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Dataset is taken from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It includes raw data taken from accelerometer on Samsung Galaxy S II devices.

This repo contains script run_analysis.R, which does the following:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Also repo includes:

* this README.md
* the code book (CodeBook.md) that describes the variables, the data, and all transformations performed
* tidy data set processed by script (result_averages.txt)