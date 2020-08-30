# Getting-and-Cleaning-Data-Week4-Assignment
The final project of the "Getting and Cleaning Data" course
Raw data are:
1) unlabeled training datasets x and y 
2) unlabeled testing datasets x and y
3) 2 sets of subject labels for training and training data
4) 1 set of features for the measurement
5) a set of activity labels containing 6 activities conducted in the experiment

Procedure:
1) Download the zip-data and unzip it
2) Set the right working directory in R-Studio
3) Read all the necessary datasets using read.table()
4) Combining the training and testing datasets using rbind()
5) Give descriptive column names to the x dataset by assigning the features to the col_names of x dataset
6) Extract the requested subsets containing only the mean and standard deviation for each measurement
7) Add the activity labels to the y dataset using factor()
8) Combine the data frames columnwise with the order subject, activity & activity_labels, and measurements containing mean and standard deviation
9) Group the data by subject and activity_labels, calculate the average of each variable using summarise_all()
10) Save the result to a new R-script
11) Save the whole R-script
