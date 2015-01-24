## Working directory is a folder called "Course Project" in which the "UCI HAR Dataset" folder is contained

library(dplyr)

### Subset the "features" data frame to include only the mean() and std() variables
##  for each signal. Note that this exludes other means calculated on variables like angle()
##  that are already derived from the signals.

features <- read.table("./UCI HAR Dataset/features.txt")

means <- grep("mean()", levels(features$V2), value=TRUE, fixed=TRUE)

std <- grep("std", levels(features$V2), value=TRUE)

subset.features <- filter(features, V2 %in% means==TRUE | V2 %in% std==TRUE)

## V1 of subset.features provides the index position for the means and standard deviations
## of each signal measured. V2 provides the associated variable name.


######  Extract means and standard deviations from training & test data. ########

X.train <- read.table("./UCI HAR Dataset/train/X_train.txt")

subset.train <- select(X.train, subset.features$V1)

X.test <- read.table("./UCI HAR Dataset/test/X_test.txt")

subset.test <- select(X.test, subset.features$V1)

######## LABEL ACTIVITIES #########

activity.labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

Y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")

activities.train <- data.frame(factor(Y.train$V1, labels=activity.labels))

Y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")

activities.test <- data.frame(factor(Y.test$V1, labels=activity.labels))

######## CREATE LABELED TRAINING and test DATASETs #########

names(subset.train) <- subset.features$V2

names(subset.test) <- subset.features$V2

####### Add subject ID column & activity column to training and test data

subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(subject.train) <- c("subject.id")
names(activities.train) <- c("activity")

subset.train <- mutate(subset.train, subject.train$subject.id, activities.train$activity)

colnames(subset.train)[67] <- "subject.id"
colnames(subset.train)[68] <- "activity"

subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(subject.test) <- c("subject.id")
names(activities.test) <- c("activity")

subset.test <- mutate(subset.test, subject.test$subject.id, activities.test$activity)

colnames(subset.test)[67] <- "subject.id"
colnames(subset.test)[68] <- "activity"

#### MERGE TRAINING AND TEST DATA

full.data <- rbind(subset.test, subset.train)


### Creates a data set with the average of each variable for each activity and each subject.

group.means <- aggregate(full.data, by=list(full.data$subject.id, full.data$activity), FUN=mean, na.rm=TRUE)

group.means$subject.id <- NULL

group.means$activity <- NULL

colnames(group.means)[1] <- "subject"

colnames(group.means)[2] <- "activity"

write.table(group.means, file="./group_means.txt", row.name=FALSE)

