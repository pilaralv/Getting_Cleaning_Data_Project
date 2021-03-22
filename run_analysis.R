
# Starting run_analysis.R
# We need to merge our dataframes together based on the ones above
# Will merge the x's, y's, and subjects
x <- rbind(x_test, x_train)
y <- rbind(y_test,y_train)
subject <- rbind(subject_test,subject_train)
merged_data <- cbind(subject,x,y)

# Extracting only mean and std for variables
TidyData <- merged_data %>%
        select(subject,code,contains("mean"),contains("std"))

# Using descriptive activity names to name activitys in dataset
TidyData$code <- activities[TidyData$code, 2]

# Label the other variables
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# From this data, create a second TinyData dataset with the average for 
# each variable for each activity and each subject

second_data <- TidyData %>%
        group_by(subject,activity) %>%
        summarise_all(list(mean))
write.table(second_data, "final_data.txt", row.name=F)

