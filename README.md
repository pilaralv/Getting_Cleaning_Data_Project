# Getting_Cleaning_Data_Project
## Setting working directory
`setwd("/Users/alvarezjerezp2/Desktop/coursera_r/")`

## Downloading necessary packages
`library(dplyr)`

## Reading in data
```
filename <- "project_2.zip"
if(!file.exists(filename)){
        file_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(file_URL, filename, method="curl")
}
```


## Creating and unzipping folder
```
if(!file.exists("UCI Har Dataset")){
        unzip(filename)
}
```

## Next we need to create the variables to go in our dataframe
```
features <- read.table("./UCI HAR Dataset/features.txt",col.names=c("number", "funcs"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code","activity"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$funcs)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$funcs)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")
```

## Then starting run_analysis.R
