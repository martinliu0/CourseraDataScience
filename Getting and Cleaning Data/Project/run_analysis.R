#check and load packages
packages <- c("data.table", "dplyr", "magrittr")
check_packages <- function(...){
  lapply(list(...), function(p){
    if(! p %in% installed.packages()){
      install.packages(p)
      require(p,character.only =TRUE)
    }
  })
}

check_packages(packages)

#download data files into working directory
data_dir <- "UCI HAR Dataset"
wd <-  getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "Dataset.zip"
if (!file.exists(wd)) {dir.create(wd)}
download.file(url, file.path(wd, file))
unzip(file)
stopifnot(file.exists(data_dir))

#read file function
read_data <- function(fname,...){
  file.path(...,fname) %>% fread()
}
download_dir <- paste(getwd(), "/CourseraDataScience/Getting and Cleaning Data/UCI HAR Dataset", sep="")

#labeling data table functions
label_activity <- function(dt){
  names(dt) <- "Activity"
  dt[, Activity := activity_labels[Activity, 2]]
  dt
}

label_data_var <- function(dt){
  names(dt) <- make.names(features[,gsub("[()]", "", V2)], unique=T)
  dt
}

add_subject_var <- function(dt){
  names(dt) <- "Subject"
  dt
}
#read in general data
activity_labels <- read_data("activity_labels.txt", download_dir)
features <- read_data("features.txt", download_dir)


# read in test data
test_data <- read_data("X_test.txt", download_dir) %>% label_data_var()                                   #dim() -> [1] 2947  561
test_activity <- read_data("y_test.txt", download_dir) %>% label_activity()                               #dim() -> [1] 2947    1
test_subject <- read_data("subject_test.txt", download_dir) %>% add_subject_var()                         #dim() -> [1] 2947    1

# read in train data
train_data <- read_data("X_train.txt", download_dir) %>% label_data_var()                                     #dim() -> [1] 2947  561
train_activity <- read_data("y_train.txt", download_dir) %>% label_activity()                             #dim() -> [1] 2947    1
train_subject <- read_data("subject_train.txt", download_dir) %>% add_subject_var()                       #dim() -> [1] 2947    1

# add partitions (train v.s. test)
test_partition <- data.table(rep("test", nrow(test_data)))
train_partition <- data.table(rep("train", nrow(train_data)))
names(test_partition) <- "Data Partition"
names(train_partition) <- "Data Partition"

# combining testing and training data
combined_data <- rbind(
                    cbind(test_subject, test_activity,test_partition,test_data),
                    cbind(train_subject, train_activity,train_partition,train_data)
                 ) %>% select(
                   one_of("Subject", "Activity","Data Partition"),
                   matches("mean|std")
                 )
# tidy data set with averages of each variable

tidy_data <- melt.data.table(combined_data, id.vars=c("Subject", "Activity","Data Partition")) %>% dcast.data.table(Subject + Activity +`Data Partition` ~ variable, mean)

write.table(tidy_data, file = "tidy_data.csv", sep = ",", row.names = F)

# test_data <- cbind(subject_test, activity_labels[y_train[,V1],2], X_test)
# names(test_data) <- c("subject", "activity", as.character(features[,2]))
# test_data <- test_data[, .SD, .SDcols = names(test_data) %like% "subject|activity|mean|std"]
# test_data[, "data type" := rep("test", .N)]
# setcolorder(test_data, c(c("subject","data type","activity" ), setdiff(names(test_data), c("subject","data type","activity" ))))
#
# train_data <- cbind(subject_train, activity_labels[y_train[,V1],2], X_train)
# names(train_data) <- c("subject", "activity", as.character(features[,2]))
# train_data <- train_data[, .SD, .SDcols = names(train_data) %like% "subject|activity|mean|std"]
# train_data[, "data type" := rep("train", .N)]
# setcolorder(train_data, c(c("subject","data type","activity" ), setdiff(?names(train_data), c("subject","data type","activity" ))))
#
# if (identical(names(test_data), names(train_data))) data <- rbind(test_data, train_data)
