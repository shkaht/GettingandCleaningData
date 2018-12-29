# Getting and Cleaning Data Final Assignment
This readme explains how the script works (in the order the operations are executed) and includes a code book describing the variables for the resulting output.

#How the script works

The dplyr library is loaded. 
The url identified in the assignment instructions that locates the zip file is named "Url"
The zip file is downloaded and unzipped to the current working directory
The training data, test data, activity labels, and features are all loaded at dplyr tables 

the training and test subject identifiers are bound together (STEP 1)
the training and test activity identifiers are bound together (STEP 1)
the training and test data sets are merged together to create one data set (STEP 1)
the data set is labelled with descriptive variable names from the 561 features variables (STEP 4) 
the columns in activity_labels are renamed with descriptive activity names (STEP 3)
using "piping" the following tasks are accomplished:
- binds the subject and activity identifiers to the data set
- renames subject columns with descriptive name (STEP 4) 
- renames ActivityCode column with descriptive name (STEP 4) 
- joins descriptive activity names to data set (STEP 3) 
- Extracts only mean and std dev measurements (STEP 2) 

Finally, a tidy data set with the avg of each variable for each activity and each subject using a pipe that groups by Activity and Subject, and then summarizes all variables my mean. (STEP 5)

The resulting data table (tibble) is printed to the console, and a text file is written to the working directory. 

#Code Book

Activity - descriptive text variable describing the activity performed: "Standing", "Sitting", "Laying", "Walking", "Walking_Downstairs", "Walking_Upstairs"

Subject - integer variable identifying the test subject with an integer value [1:30], the person who carried out the test. 

Signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

Variables in columns 3:55 are the mean variables. 
Variables in columns 56:88 are the standard deviation variables.

Each row represents a unique pair of activity and subject, and the value for each variable is the average of the readings for that activity-subject pair.   
