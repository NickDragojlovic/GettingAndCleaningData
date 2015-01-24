# GettingAndCleaningData
Procedure for creating the output dataset.

## Working directory is a folder called "Course Project" in which the "UCI HAR Dataset" folder is contained

1) Subset the "features" data frame to include only the mean() and std() variables for each signal. Note that this exludes other means calculated on variables like angle() that are already derived from the signals.

2) V1 of new data frame subset.features provides the index position for the means and standard deviations of each signal measured. V2 provides the associated variable name.

3) Extract means and standard deviations from training & test data by a) downloading X.train and X.test datasets, and b) selecting only the columns numbers contained in subset.features$V1 (which correspond to the means and standard deviations).

4) Turn the activities vectors into factor variables, applying appropriate labels to the levels.

5) Label the variables in the training and test data by applying the subset.features$V2 factor to the names() functions for each of the data frames.

6) Use mutate() function to add the activities (now labeled) and subject ID vectors to both test and training data frames.

7) append the training data to the test data using the rbind() function on the two data frames.

8) Use the aggregate() function and its "by" argument to calculate means of each variable for each subject performing each activity. Given 30 subjects and 6 activities, this results in a new data frame with 180 observations.

9) Write this data frame to a .txt file using the write.table() function.
