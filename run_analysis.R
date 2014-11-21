#we will use some additional libraries to perform the work
library(reshape2)

#some function definitions for repetitive tasks / abstractions

download_data <- function(url, destination = tempfile()) {
    download.file(url, destination, method='curl')    
    destination
}

read_data <- function(set, zipfile) {
    #Reading in the datasets
    X <- read.table(unz(zipfile, paste0("UCI HAR Dataset/", set, "/X_", set, ".txt")))
    Y <- read.table(unz(zipfile , paste0("UCI HAR Dataset/", set, "/y_", set, ".txt")))
    subject <- read.table(unz(zipfile, paste0("UCI HAR Dataset/", set, "/subject_", set, ".txt")))
    #merging and returning
    cbind(X, Y, subject)
}

########### Code with side effects starts here ###############################

##define some variables
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
tidy_file <- 'average-measurements-by-activity-subject.txt'
data_file <- 'measurements-by-activity-subject.txt'

#let's download and read-in the data
zipfile <- download_data(url)
train <- read_data("train", zipfile)
test <- read_data("test", zipfile)

#merge the test & training datasets together
data <- rbind(test, train)

#give nice names to columns
features <- read.table(unz(zipfile, 'UCI HAR Dataset/features.txt'), stringsAsFactors = FALSE)
names(data)[1:561] <- features$V2
names(data)[562:563] <- c("Activity", "Subject")

#Transform to narrow form, as it's easier to work with
data <- melt(data, id.vars=c("Activity", "Subject"))

#extract only the measurements that are means or stdev. of original measurements
#no other measurements are considered, as they would be further derivatives of the measurements,
#and not means/std of the original signals captured by smartphones
idx = which(
    grepl("mean()", data$variable, fixed = TRUE) | 
        grepl("std()", data$variable, fixed = TRUE)
)
subset <- data[idx, ]

#replace activity numbers with activity names
activities <- read.table(unz(zipfile, 'UCI HAR Dataset/activity_labels.txt'), stringsAsFactors = FALSE)
subset <- merge(activities, subset, by.x="V1", by.y="Activity")
subset$V2 <- tolower(subset$V2)
subset <- subset[, 2:ncol(subset)]

#Add descriptive variable names / factors / otherwise clean up data
names(subset) <- c("Activity", "Subject", "Measurement", "Value")
subset$Activity <- factor(subset$Activity)
subset$Subject <- factor(subset$Subject)
subset$Measurement <- factor(subset$Measurement)

#save the data
write.table(tidy, file=data_file, row.names=FALSE)

#create tidy dataset, which contains means of each mesurement for each subject and activity
tidy <- aggregate(Value ~ Activity+Subject+Measurement, data=subset, FUN=mean)
#save it to the working directory
write.table(tidy, file=tidy_file, row.names=FALSE)

