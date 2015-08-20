# CodeBook for Variables in Tidy Dataset Produced by "run_analysis.R"

## Selected Variables
From the original set of variables, all variables ending with "mean()" or "std()" were selected. These refer to the mean or standard deviation of a movement value (linear acceleration, angular velocity, or jerk) computed on a raw signal. Variables ending with "meanFreq()" are not means for a movement measurement value. They refer to "weighted averages of the frequency components" of a signal (as described in the features_info file). Thus they are a different kind of variable than a mean value of the signal, and were therefore excluded. In addition, the features info document refers to five additional vectors ("gravityMean," "tBodyAccMean," "tBodyAccJerkMean," "tBodyGyroMean," and "tBodyGyroJerkMean"). These refer to averaged vectors rather than values averaged over a vector, and in fact are used only as inputs for the angle variables. Thus, variables which have these mean vectors as input are not mean variables, but angle variables, and thus are excluded from the tidy dataset.

In the tidy data output, for each subject, the mean of the variable (mean or standard deviation on a vector for linear acceleration, angular velocity, or jerk) is taken for each activity.

As described in the original features info file, variables beginning with "t" refer to those computed on time domain signals, and variables beginning with "f" refer to those computed on frequency domain signals (from a Fast Fourier Transform). Also, as in the original variable names, variables with "Body" in their names refer to those computed on body signals, and those with "Gravity" in them refer to variables computed on gravity signals. In addition, in the original features list there were mistaken occurrences of "BodyBody" rather than "Body" in some of the variable names (i.e., in the feature_info descriptions, only single occurrences of "Body" in variable names ever occur). Thus, all occurrences of "BodyBody" were corrected to "Body." 

Variable names were also changed to label the measurement signal, rather than the instrument (accelerometer or gyroscope). This is intended to be a clearer and more direct way of describing the variables (i.e., by more "processed" labels, rather than by labels that are more tied to the raw instruments). Thus, as accelerometer signals measure either linear acceleration or linear jerk, occcurences of "Acc" (without "Jerk") in the variable names were changed to "LinearAcceleration," and occurrences of "AccJerk" were changed to "LinearJerk."  Similarly, for gyroscope signals, variable names that had "Gyro" (without "Jerk") in them had this changed to "AngularVelocity," and variable names with "GyroJerk" in them had this changed to "AngularJerk."  

Rather than a hyphen proceeded by an uncapitalized variable name ("-mean()" or "-std()"), in the tidy dataset the variable name is preceded by an underscore, and capitalized ("_Mean" or "_Std"). Also, the parentheses following the variable name is removed, in order to make the variable name legal for R syntax. Variables for X, Y, or Z directional components of a signal now end with .X .Y or .Z (changed from ending with a hyphen preceding the axis label). For variable names denoting combined 3-dimensional signal magnitudes, "Magnitude" is now spelled out (changed from "Mag").
 
As noted in the original README file, all variables are normalized to fall in [-1, 1]. This means that all raw measurement units are eliminated (i.e., variable values are in deviation units rather than raw measurement units). 

## Variable Descriptions
- subjectID :  Label for the subject whose variables on an executed action are indicated in the row.

- activity : The name of a given executed activity. Each subject executed each activity multiple times. The tidy dataset shows the values of the mean and std variables for each subject, averaged separately for the subject across each activity. The activity names were taken from the original activity_labels list, with a slight modification into lowercase. The activity names (rather than a number code) are provided as the values, and thus the activity variable can take one of the following six values:
  - walking
  - walking_upstairs
  - walking_downstairs
  - sitting
  - standing
  - laying

- trainOrTest : This column was added to mark whether the data in a given row come from the Training Dataset or the Test Dataset (as the tidy dataset joins these two sub-datasets together). In the study from which the data come from, the data for each subject were randomly assigned to Training or Test. Thus in the tidy dataset, the six rows for any given subject (corresponding to the six activities) each get the same value for trainOrTest. This variable thus takes on one of two values for each subject, as listed below, to label the data as Training versus Test data, respectively:
  - train
  - test

- _Mean and _Std variables : The tidy dataset has 66 total measurement variables (33 _Mean and 33 _Std variables). These correspond to, for each subjectID, the means of the _Mean or _Std variables (i.e., the means of the mean or standard deviation on a linear acceleration, angular velocity, or jerk signal) across multiple executions by the subject of a given activity. Modifications to the original variable names are as noted in the "Selected Variables" section. As the variable values are normalized to fall in [-1, 1], there are no measurement units.

Below is a list of the variable name stems in the features_info.txt file, and what they have been changed to based on the modifications noted above.

|     Old Name            |         New Name                        |
|-------------------------|-----------------------------------------|
|  tBodyAcc-XYZ           |  tBodyLinearAcceleration.XYZ            |
|  tGravityAcc-XYZ        |  tGravityLinearAcceleration.XYZ         |
|  tBodyAccJerk-XYZ       |  tBodyLinearJerk.XYZ                    |
|  tBodyGyro-XYZ          |  tBodyAngularVelocity.XYZ               |
|  tBodyGyroJerk-XYZ      |  tBodyAngularJerk.XYZ                   |
|  tBodyAccMag            |  tBodyLinearAccelerationMagnitude       |
|  tGravityAccMag         |  tGravityLinearAccelerationMagnitude    |
|  tBodyAccJerkMag        |  tBodyLinearJerkMagnitude               |
|  tBodyGyroMag           |  tBodyAngularVelocityMagnitude          |
|  tBodyGyroJerkMag       |  tBodyAngularJerkMagnitude              |
|  fBodyAcc-XYZ           |  fBodyLinearAcceleration.XYZ            |
|  fBodyAccJerk-XYZ       |  fBodyLinearJerk.XYZ                    |
|  fBodyGyro-XYZ          |  fBodyAngularVelocity.XYZ               |
|  fBodyAccMag            |  fBodyLinearAccelerationMagnitude       |
|  fBodyAccJerkMag        |  fBodyLinearJerkMagnitude               |
|  fBodyGyroMag           |  fBodyAngularVelocityMagnitude          |
|  fBodyGyroJerkMag       |  fBodyAngularJerkMagnitude              |

Following the variable name groupings in the original features_info.txt file, below are the modified variable names as described above, and a description of each signal (with bracketed elements representing name-component alternatives for different variable names).

- tBodyLinearAcceleration[_Mean *or* _Std][.X *or* .Y *or* .Z] : Time domain body linear acceleration signal [mean *or* standard deviation] along the [X *or* Y *or* Z] axis

- tGravityLinearAcceleration[_Mean *or* _Std][.X *or* .Y *or* .Z] : Time domain gravity linear acceleration signal [mean *or* standard deviation] along the [X *or* Y *or* Z] axis

- tBodyLinearJerk[_Mean *or* _Std][.X *or* .Y *or* .Z] : Time domain body linear jerk signal [mean *or* standard deviation] along the [X *or* Y *or* Z] axis

- tBodyAngularVelocity[_Mean *or* _Std][.X *or* .Y *or* .Z] : Time domain body angular velocity signal [mean *or* standard deviation] along the [X *or* Y *or* Z] axis

- tBodyAngularJerk[_Mean *or* _Std][.X *or* .Y *or* .Z] : Time domain body angular jerk signal [mean *or* standard deviation] along the [X *or* Y *or* Z] axis

- tBodyLinearAccelerationMagnitude[_Mean *or* _Std] : Time domain body linear acceleration combined 3-dimensional signal magnitude [mean *or* standard deviation]

- tGravityLinearAccelerationMagnitude[_Mean *or* _Std] : Time domain gravity linear acceleration combined 3-dimensional signal magnitude [mean *or* standard deviation]

- tBodyLinearJerkMagnitude[_Mean *or* _Std] : Time domain body linear jerk combined 3-dimensional signal magnitude [mean *or* standard deviation]

- tBodyAngularVelocityMagnitude[_Mean *or* _Std] : Time domain body  angular velocity combined 3-dimensional signal magnitude [mean *or* standard deviation]

- tBodyAngularJerkMagnitude[_Mean *or* _Std] : Time domain body angular jerk combined 3-dimensional signal magnitude [mean *or* standard deviation]

- fBodyLinearAcceleration[_Mean *or* _Std][.X *or* .Y *or* .Z] : Frequency domain body linear acceleration signal [mean *or* standard deviation] along the [X *or* Y *or* Z] axis

- fBodyLinearJerk[_Mean *or* _Std][.X *or* .Y *or* .Z] : Frequency domain body linear jerk signal [mean *or* standard deviation] along the [X *or* Y *or* Z] axis

- fBodyAngularVelocity[_Mean *or* _Std][.X *or* .Y *or* .Z] : Frequency domain body angular velocity signal [mean *or* standard deviation] along the [X *or* Y *or* Z] axis

- fBodyLinearAccelerationMagnitude[_Mean *or* _Std] : Frequency domain body linear acceleration combined 3-dimensional signal magnitude [mean *or* standard deviation]

- fBodyLinearJerkMagnitude[_Mean *or* _Std] : Frequency domain body linear jerk combined 3-dimensional signal magnitude [mean *or* standard deviation]

- fBodyAngularVelocityMagnitude[_Mean *or* _Std] : Frequency domain body angular velocity combined 3-dimensional signal magnitude [mean *or* standard deviation]

- fBodyAngularJerkMagnitude[_Mean *or* _Std] : Frequency domain body angular jerk combined 3-dimensional signal magnitude [mean *or* standard deviation]
