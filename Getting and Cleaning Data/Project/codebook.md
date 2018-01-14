# Code Book

## Dataset description

Full details can be found in README.md or on the Coursera website.

### Prelims
1.  The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years;
2.  Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist;
3.  Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz;

## Features Overview

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
>
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).
>
>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).
>
>These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

## Data Cleaning and Transformation
As per requirements of the project, the following operations were performed to transform the data:

1.  The training and the test sets have been merged to form a single data set;
2.  Only the measurements of mean and standard deviation were kept used;
3.  Descriptive variable names were used to increase readability;
4.  A tidy data set was generated.

## Variables Overview
| Variable Name      | Description                                                                                                                                     | Value                                                                                |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| Subject            | A number denoting the test subject                                                                                                              | 1 - 30                                                                               |
| Activity           | A String denoting the type of activity                                                                                                          | "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING" |
| Data Partition     | A String denoting  whether value is from test or train data set                                                                                 | "test", "train"                                                                      |
| tBodyAcc.mean.X    | A decimal number denoting mean measurement of body acceleration signal in the X axis                                                            | numeric                                                                              |
| tGravityAcc.mean.X | A decimal number denoting mean measurement of gravityMean acceleration signal in the X axis                                                     | numeric                                                                              |
| ...                | Feature variables have been transformed from '()' format such as 'tBodyAcc-mean()-X' to 'tBodyAcc.mean.X' and should be rather self explanatory | numeric                                                                              |
