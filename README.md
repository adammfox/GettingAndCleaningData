#Getting and Cleaning Data Science Project

The file run_analysis.R will perform the five tasks that were given. The following 7 data files must be in the working directory.
* X_train.txt
* X_test.txt
* y_train.txt
* y_test.txt
* subject_train.txt
* subject_test.txt
* feature.txt

The run_analysis program begins by opening the train and test data and assigning the column names from the variable list in the features.txt file.  These two data sets are then merged.  Any column that does not involve the measurement of the mean or standard deviation of a quantity is then removed.  Finally, the column names are made lower case and the periods are removed following the conventions described in the Week 4 lectures.  

Columns are added to this new data frame containing the subject identification and activity for each row.  The activities are given descriptive names.

An empty matrix is then initialized to hold the average of each variable for each activity and each subject.  There are 180 rows (30 subjects times 6 activities) and the same number of columns as features that describe the mean or standard deviation of a quantity.  A nested for loop cycles through the 6 activities and 30 subjects.  At each loop a pipeline is built that selects the rows where a single activity and ID are measured, selects all columns except the activity and subjectID columns, and computes the column means.  These means are stored in the matrix.  

Finally, the matrix is converted to a data frame, column names are added, and the matrix is printed to file.  