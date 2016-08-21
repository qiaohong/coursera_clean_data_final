## STEP 0 ##
# prepare files - download and unzip
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "dataset.zip"
if (!file.exists(destfile)){
  download.file(url, destfile, method = "curl")
}
unzip(destfile)

## STEP 1 ##
# load and combine subject data from train and test sets
data_subject_train <- read.table(
  "./UCI HAR Dataset/train/subject_train.txt", 
  col.names = c("subject"))
data_subject_test <- read.table(
  "./UCI HAR Dataset/test/subject_test.txt", 
  col.names = c("subject"))
data_subject <- rbind(data_subject_train, data_subject_test) 
remove(data_subject_train, data_subject_test)

# load lables
data_label_train <- read.table(
  "./UCI HAR Dataset/train/y_train.txt", 
  col.names = c("label"))
data_label_test <- read.table(
  "./UCI HAR Dataset/test/y_test.txt", 
  col.names = c("label"))
data_label <- rbind(data_label_train, data_label_test) 
remove(data_label_train, data_label_test)

# load actual data points
data_x_train <- read.table(
  "./UCI HAR Dataset/train/x_train.txt", 
  col.names = data_feature$"feature.label")
data_x_test <- read.table(
  "./UCI HAR Dataset/test/x_test.txt",
  col.names = data_feature$"feature.label")
data_x <- rbind(data_x_train, data_x_test) 
remove(data_x_train, data_x_test)

## STEP 2 ##
# load feature lists
data_feature <- read.table(
  "./UCI HAR Dataset/features.txt", 
  col.names = c("feature.value", "feature.label")
)

# find mean and std measurements
filter <- grep("mean|std", data_feature$feature.label)

# filter on these
data_x_filtered <- data_x[, filter]

# combine subject, label and data points to one
data <- cbind(data_x_filtered, data_subject, data_label)
remove(data_x_filtered, data_x)

## STEP 3 ##
# address activity labels
data_activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                                   col.names=c("activity.n", "activity.label"))
data$label <- factor(data$label, 
                     levels = data_activity_labels$activity.n, 
                     labels = data_activity_labels$activity.label)

## STEP 4 ##
# reshape data
data_transformed <- melt(data, id = c("subject", "label"))
data_clean <- aggregate(
  data_transformed$value, 
  by=list(subject = data_transformed$subject, 
          label = data_transformed$label, 
          va = data_transformed$variable), 
  FUN=mean, ra.rm=TRUE)

# write result
write.table(data_clean, "clean_data_final_assignment.txt", row.name = FALSE)

# clean up
remove(data, data_transformed)