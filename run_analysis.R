library(readr)
library(dplyr)

# import data

"x_train" <- read.table("x_train.txt", header = FALSE, sep = "")
"y_train" <- read.table("y_train.txt", header = FALSE, sep = "")
"x_test" <- read.table("x_test.txt", header = FALSE, sep = "")
"y_test" <- read.table("y_test.txt", header = FALSE, sep = "")
"activity_labels" <- read.table("activity_labels.txt", header = FALSE, sep = "")

## Merges the training and the test sets to create one data set.

names(activity_labels) <- c("Activity_code", "Activity_label")  # labelling name

names(y_train) <- "Activity_code"                               # Naming variable in "y_train" 

"train_data" <- data.frame(y_train, x_train)                    # merge "y_train" and "x_train"

train_data <- merge(activity_labels, train_data, by = "Activity_code", all.y = TRUE)

names(y_test) <- "Activity_code"                                # Naming variable in "y_test"

"test_data" <- data.frame(y_test, x_test)                       # merge "y_test" and "x_test"

test_data <- merge(activity_labels, test_data, by = "Activity_code", all.y = TRUE)

"all_data" <- rbind(train_data, test_data)                      # merge train data and test data

View(all_data)

# Extracts only the measurements on the mean and standard deviation for each measurement.

"tidy_data" <- reshape2::dcast(data = all_data, all_data$Activity_code + all_data$Activity_label ~ ., fun.aggregate = mean)
names(tidy_data) <- c("Activity code", "Activity label", "Mean")

# export data 

write.table(tidy_data, file = "tidy_data.txt")
