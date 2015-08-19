library(dplyr)

## "UCI Har Dataset" folder is in working directory; retrieve main Training and Test datasets 
Train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Test <- read.table("./UCI HAR Dataset/test/X_test.txt")
## Get vector of all features.txt variable names
variableNames <- read.table("./UCI HAR Dataset/features.txt") %>% subset(select = 2, drop = TRUE) %>% as.character

## Label columns of Training and Test datasets
names(Train) <- variableNames
names(Test) <- variableNames

## Add a trainOrTest column and code to mark the Train data as for the Train set. Add columns to to mark activity
## with y_train.txt, and subject_ID with subject_train.txt files.
Train <- cbind(trainOrTest = rep(0, times = nrow(Train)), Train)
Train <- cbind(activity = read.table("./UCI HAR Dataset/train/y_train.txt"), Train)
Train <- cbind(subjectID = read.table("./UCI HAR Dataset/train/subject_train.txt"), Train)

## Add a code to mark the Test data as for the Test set. Add columns for activity and subjectID labels for Test Data.    
Test <- cbind(trainOrTest = rep(1, times = nrow(Test)), Test)
Test <- cbind(activity = read.table("./UCI HAR Dataset/test/y_test.txt"), Test)
Test <- cbind(subjectID = read.table("./UCI HAR Dataset/test/subject_test.txt"), Test)

## Join the Training and Test Data together. Name the three added columns properly.
Data <- rbind(Train, Test)
names(Data)[1:3] <- c("subjectID", "activity", "trainOrTest")

## Drop all measurements that are not for the mean or std of a signal
N <- names(Data)
Data <- subset(Data, select = c(1:3, grep("mean[()]", N), grep("std[()]", N)) %>% sort)


## Factorize and give appropriate labels to the trainOrTest and activity variables
Data <- mutate(Data, trainOrTest = factor(trainOrTest, levels = 0:1, labels = c("train", "test")))
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt") %>% subset(select = 2, drop = TRUE) %>% as.character %>% tolower
Data <- mutate(Data, activity = factor(activity, levels = 1:6, labels = activityLabels))

## Make variable name modifications, including removing parentheses

names(Data) <- gsub("[()]", "", names(Data))
names(Data) <- gsub("-X", ".X", names(Data))
names(Data) <- gsub("-Y", ".Y", names(Data))
names(Data) <- gsub("-Z", ".Z", names(Data))
names(Data) <- gsub("Mag", "Magnitude", names(Data))
names(Data) <- gsub("-", "", names(Data))
names(Data) <- gsub("mean", "_Mean", names(Data))
names(Data) <- gsub("std", "_Std", names(Data))
names(Data) <- gsub("BodyBody", "Body", names(Data))
names(Data) <- gsub("BodyGyroJerk", "BodyAngularJerk", names(Data))
names(Data) <- gsub("BodyGyro", "BodyAngularVelocity", names(Data))
names(Data) <- gsub("AccJerk", "LinearJerk", names(Data))
names(Data) <- gsub("Acc", "LinearAcceleration", names(Data))



library(data.table)
Data.Table <- as.data.table(Data)
## data.table functionality utilized to group data by subjectID and activity, and apply "mean" to all the measurement
## variables for all the resulting groups. (As trainOrTest does not vary within subjectID, in effect the groups
## are defined by subjectID and activity combinations, with the same six values of trainOrTest given for each
## of the six rows of a given subjectID in the tidy dataset)
Tidy.Table <- Data.Table[, lapply(.SD, mean), by = .(subjectID, activity, trainOrTest)]

## write.table(Tidy.Table, file = "tidy.txt",  sep = "\t", row.names = FALSE)
## open tidy.txt file with Microsoft Excel instead of default text-editor program, for readable viewing,
## or read into RStudio (and then View "Tidy" object) with Tidy <- read.table("tidy.txt", header = TRUE)


