#Getting and Cleaning Data Science Project

##Description of Algorithm

The file run_analysis.R will perform the five tasks that were given. The following 7 data files must be in the working directory.
* X_train.txt
* X_test.txt
* y_train.txt
* y_test.txt
* subject_train.txt
* subject_test.txt
* feature.txt

The run_analysis program begins by opening the train and test data and assigning the column names from the variable list in the features.txt file.  These two data sets are then merged.  Any column that does not involve the measurement of the mean or standard deviation of a quantity is then removed.  Finally, the column names are made lower case and all punctuation is removed following the conventions described in the Week 4 lectures.  

Columns are added to this new data frame containing the subject identification and activity for each row.  The activities are given descriptive names.  The data frame is then grouped by the activity and subject id and the mean of the columns within these groups is computed.  The data frame containing these means is then written to file.  

##Code Book
* activity: a description of the type of activity being done
* id: the subject ID 
* All remaining features are derived from the original dataset.  Note that the column names have been made lowercase and all punctuation has been removed.  So, for example, the “tbodyaccmeanx” column contains the mean of the “tBodyAcc-mean()-X” restricted to the measurement with the specified subject ID and activity.  See “features_info.txt” for details on these columns
