library(dplyr)

## identify the url where the zipped folder can be accessed
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## download the zip folder
download.file(Url, destfile = "./ucihar.zip")

## unzip the folder
unzip("ucihar.zip")

## load the training data including subject and activity label objects
subject_train <- tbl_df(read.table("./UCI HAR Dataset/train/subject_train.txt"))
X_train <- tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt"))
y_train <- tbl_df(read.table("./UCI HAR Dataset/train/y_train.txt"))

## load the test data including subject and activity label objects
subject_test <- tbl_df(read.table("./UCI HAR Dataset/test/subject_test.txt"))
X_test <- tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt"))
y_test <- tbl_df(read.table("./UCI HAR Dataset/test/y_test.txt"))

## load the activity labels and features as data tables
activity_labels <- tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE))
features <- tbl_df(read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE))

## add the training and test subject identifiers together 
subjectBind <- bind_rows(subject_train, subject_test)

## add the training and test activity identifiers together
activityBind <- bind_rows(y_train, y_test)

## (STEP 1) Merges the training and the test sets to create one data set
oneData <- bind_rows(X_train, X_test)

## (STEP 4)  labels the data set with descriptive variable names from the 561 features variables
names(oneData) <- features$V2

## (STEP 3) rename the columns in activity_labels with descriptive activity names
names(activity_labels) <- c("ActivityCode", "Activity")

oneDataSet <- bind_cols(subjectBind, activityBind, oneData) %>% ## binds the subject and activity identifiers to the data set
        rename("Subject" = V1) %>% #(STEP 4) renames subject columns with descriptive name
        rename("ActivityCode" = V11) %>% #(STEP 4) renames ActivityCode column with descriptive name
        left_join(activity_labels, by = "ActivityCode") %>% #(STEP 3) joins descriptive activity names to data set
        select(Activity, Subject, contains("mean"), contains("std")) #(STEP 2) Extracts only mean and std dev measurements

##(STEP 5) a tidy data set with the avg of each variable for each activity and each subject.
Act_Subj_Avgs <- group_by(oneDataSet, Activity, Subject) %>%
        summarize_all(mean) 

print(Act_Subj_Avgs)

write.table(Act_Subj_Avgs, file = "Activity-Subject_Averages.txt", row.names = FALSE)
