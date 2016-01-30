# GettingAndCleaningData-CourseProject

The R script run_analysis.R does following
  1. Read activities from UCI HAR Dataset//activity_labels.txt
  2. Read features UCI HAR Dataset//features.txt
  3. Select features that are measuring Mean and Std
  4. Read training dataset,only those columns that represents the required features 
  5. Read test dataset,only those columns that represents the required features
  6. Merge the two datasets
  7. Convert activities and subjects into factors
  8. Create a tidy dataset containing the average of each variable for each activity and each subject.


