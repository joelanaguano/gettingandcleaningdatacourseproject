# gettingandcleaningdatacourseproject
Repository for course project week 4 - Coursera: Getting and Cleaning data

The R script does the following: 

1. Downloads to R ids and descriptions for features being measured in experiment from file features.txt.
2. Independently loads complete data for train and test sets
3. Load the activity and feature info
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset
5. Loads both the training and test datasets, keeping only columns which reflect a mean or standard deviation
6. Merges the two datasets
7. Converts the activity and subject columns into factors
8. Creates a final tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair
