## This R script implements converting raw input data on
## Human Activity Recognition using Smartphones data set
## into tidy data set

# change the working directory if needed
setwd("~/Dropbox/Research")

library(data.table)
library(plyr)

# we assume that dataset is unpacked in current directory
data_path <- file.path("UCI HAR Dataset")
train_set <- file.path(data_path, "train")
test_set <- file.path(data_path, "test")

# merging training and test data for labels
y_train <- fread(file.path(train_set, "y_train.txt"))
y_test <- fread(file.path(test_set, "y_test.txt"))
y_data <- rbind(y_train, y_test)

# merging training and test data for input sets
x_train <- data.table(read.table(file.path(train_set, "X_train.txt")))
x_test <- data.table(read.table(file.path(test_set, "X_test.txt")))
x_data <- rbind(x_train, x_test)

# loading features
d_features <- fread(file.path(data_path, "features.txt"))
setnames(d_features, names(d_features), c("FeatureId", "FeatureName"))

# according to task, we need only mean() and std() features
d_features <- d_features[grepl("-(mean|std)\\(\\)", FeatureName)]
d_features$FeatureV <- d_features[, paste0("V", FeatureId)]
x_data <- x_data[, c(key(x_data), d_features$FeatureV), with=FALSE]

# setting proper names for features in dataset
setnames(
  x_data,
  names(x_data),
  d_features[d_features$FeatureV %in% names(x_data)][["FeatureName"]]
)

d_labels <- fread(file.path(data_path, "activity_labels.txt"))
setnames(d_labels, "V2", "ActivityName")

setnames(y_data, "V1", "Activity")

# setting proper names for activities in labels
y_data$Activity <- d_labels[y_data$Activity,]$ActivityName

# merging train and test data for subjects
s_train <- fread(file.path(train_set, "subject_train.txt"))
s_test <- fread(file.path(test_set, "subject_test.txt"))
s_data <- rbind(s_train, s_test)
setnames(s_data, "V1", "Subject")

# merging all data into one dataframe
full_df <- cbind(x_data, y_data, s_data)

# calculating resulting averages (means)
result_avgs <- ddply(full_df, .(Subject, Activity), function(x) colMeans(x[, 1:66]))

write.table(result_avgs, "result_averages.txt", row.name=F)