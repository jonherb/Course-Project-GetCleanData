# Course-Project-GetCleanData

The "run_analysis.R" script, with the "UCI HAR Dataset" folder in the working directory, joins together the training data and test data on the mean and standard deviation variables (all variables which originally had "mean()" or "std()" in them (see CodeBook.md for justifications of variable inclusions/exclusions). The final result of the script is a tidy dataset with each row giving the mean for all selected variables for the subjectID and activity combination for the row. Thus, the final dataset tidy in the wide form, with each column representing grouping variable or a mean value for one of the mean or std measurement variables, and each row representing the mean data for a single subject executing a single kind of activity.

The script first reads the main body of the training data (the unlabeled variable values) into an R dataframe (labeled "Train") It does the same for the test data, into the "Test" dataframe. Then it reads in a vector of the variableNames from the from the "features.txt" file, and labels the columns of the Train and Test dataframes with the variableNames.

Next, the script adds a column of zeroes to the Train dataframe. This is to preserve the information that the data came from the training set, before joining the Test and Train dataframes. After adding the column of zeroes, the script reads in the activity number labels for the training data, and adds this information as another column to the Train dataframe. Lastly for the Train dataframe, the script reads in and adds a column for the the subject ID labels.

The script then adds the corresponding same three columns to the Test dataframe (with a column of one's rather than zeroes to distinguish the test data from the training data, and the subjectID and activity number labels read in from the test data files).

Next, the script joins together the Train and Test dataframes with rbind, and gives the names "subjectID," "activity," and "trainOrTest" to the three added variables. 

Next, the script subsets the data to drop all measurement variables not containing "mean()" or "std()" in their names. (Note that the original list of variable names in "features.txt" has some duplicate names due to a mistaken failure to add -X, -Y, or -Z to a name; however, this step drops these duplicate names as well).

Next, the trainOrTest variable is converted into a factor, to label its levels as "train" or "test." Next, the activity name-labels are read in, and used to convert the activity variable to a factor, with name labels rather than number codes for each of the six activities.

Next, a series of gsub commands is used to clean up and modify the measurement variable names (see CodeBook for details on the changes and the new names).

Finally, the summarise_each function is used in conjunction with the group_by function to compute, for each subjectID, the means of all the measurement variables on each activity for all the subject's executions of the activity. The data is grouped by subjectID and activity (with trainOrtest also being given as a grouping variable, so that it's not treated as a measurement variable in the grouping; but as it does not vary within subjectID, the groups are fully defined by subjectID and activity).

The "tidy.txt" file output was produced by the command:

write.table(Tidy.Table, file = "tidy.txt",  sep = "\t", row.names = FALSE)

As the text file format does not provide easily viewable organization of the output, a tab separator was used in the write.table command so that if the the  is opened in Microsoft Excel rather than the default text editor program, columns will be clearly delineated, etc. Alternatively, if the file is in the working directory for R, it can be viewed with the commands

Tidy <- read.table("tidy.txt", header = TRUE)

View(Tidy)
