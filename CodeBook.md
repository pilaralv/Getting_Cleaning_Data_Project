These are the variables used to clean and arrange the data.
1. Merges the training and the test sets to create one data set
  - `features`: reading in the features.txt file in UCI HAR Dataset folder. Added column names "number" and "funcs". 
              561 obs. of 2 variables
  - `activities`: reading in the activity_labels.txt file in UCI HAR Dataset folder. Added column names "code" and "activity"
              6 obs. of 2 variables
  - `subject_test`: reading in the subject_tests.txt file in UCI HAR Dataset/test folder. Added column name "subject"
              2947 obs. of 1 variable
  - `x_test`: reading in the X_test.txt file in UCI HAR Dataset/test folder. Added column name from features$funcs
              2947 obs. of 561 variables
  - `y_test`: reading in the Y_test.txt file in UCI HAR Dataset/test folder. Added column name from "code"
              2947 obs. of 1 variable
  - `subject_train`: reading in the subject_train.txt file in UCI HAR Dataset/train folder. Added column name "subject"
              7352 obs. of 1 variable
  - `x_train`: reading in the X_train.txt file in UCI HAR Dataset/train folder. Added column name from features$funcs
              7352 obs. of 561 variables
  - `y_train`: reading in the Y_train.txt file in UCI HAR Dataset/train folder. Added column name from "code"
              7352 obs. of 1 variable
  
  
  - `x`: `rbind` `x_test` and `x_train`
              10299 obs. of 561 variables
  - `y`: `rbind` `y_test` and `y_train`
              10299 obs. of 1 variable
  - `subject`: `rbind` `subject_test` and `subject_train`
              10299 obs. of 1 variable
   
   - `merged_data`: `cbind` `x`, `y`, and `subject`
              10299 obs. of 563 variables

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

  - `TidyData`: taking `merged_data` and selecting by "mean" and "std"
              10299 obs. of 88 variables
              
3. Uses descriptive activity names to name the activities in the data set
  - `TidyData$code`. Replaced numbers in this column with activity names from `activities` dataset above.
  
4. Appropriately labels the data set with descriptive variable names. 

   - `TidyData` code column renamed to activities
   - Acc to Accelerometer
   - Gyro to Gyroscope
   - BodyBody to Body
   - Mag to Magnitude
   - f to Frequency
   - t to Time
   - tBody to TimeBody
   - -mean() to Mean
   - -std() to STD
   - -freq() to Frequency
   - angle to Angle
   - gravity to Gravity
   
   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   - `second_data` summarizes `TidyData` and exported to `final_data.txt`
              180 obs. of 88 variables
