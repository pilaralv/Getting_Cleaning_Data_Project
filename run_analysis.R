# Setting working directory
setwd("/Users/alvarezjerezp2/Desktop/coursera_r/")

# Downloading necessary packages
library(dplyr)

# Reading in data
filename <- "project_2.zip"
if(!file.exists(filename)){
        file_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(file_URL, filename, method="curl")
}

# Creating and unzipping folder
if(!file.exists("UCI Har Dataset")){
        unzip(filename)
}

# Next we need to create the variables to go in our dataframe
features <- read.table("./UCI HAR Dataset/features.txt",col.names=c("number", "funcs"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code","activity"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$funcs)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$funcs)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")

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

