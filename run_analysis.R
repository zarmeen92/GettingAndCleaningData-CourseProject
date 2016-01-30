# Read activities
activities <- read.table("D://DataScience//Getting and Cleaning Data//data//getdata_projectfiles_UCI HAR Dataset//UCI HAR Dataset//activity_labels.txt")
names(activities) <- c("Label","Description")
#Read feature
features <- read.table("D://DataScience//Getting and Cleaning Data//data//getdata_projectfiles_UCI HAR Dataset//UCI HAR Dataset//features.txt")
names(features) <- c("Label","Description")
#Select features that are measuring Mean and Std
measured_features <- data.frame(Index = grep(".[Mm]ean|.std",features$Description),description = grep(".[Mm]ean|.std",features$Description,value = TRUE))
measured_features$description <- as.character(measured_features$description)
#Read train dataset
trainset <- read.table("D://DataScience//Getting and Cleaning Data//data//getdata_projectfiles_UCI HAR Dataset//UCI HAR Dataset//train//X_train.txt")[measured_features$Index]
train_activity <- read.table("D://DataScience//Getting and Cleaning Data//data//getdata_projectfiles_UCI HAR Dataset//UCI HAR Dataset//train//y_train.txt")
train_subject <- read.table("D://DataScience//Getting and Cleaning Data//data//getdata_projectfiles_UCI HAR Dataset//UCI HAR Dataset//train//subject_train.txt")
train <- cbind(train_subject,train_activity,trainset)
colnames(train) <- c("Subject","Activity",measured_features$description)

#Read test dataset
testset <- read.table("D://DataScience//Getting and Cleaning Data//data//getdata_projectfiles_UCI HAR Dataset//UCI HAR Dataset//test//X_test.txt")[measured_features$Index]
test_activity <- read.table("D://DataScience//Getting and Cleaning Data//data//getdata_projectfiles_UCI HAR Dataset//UCI HAR Dataset//test//y_test.txt")
test_subject <- read.table("D://DataScience//Getting and Cleaning Data//data//getdata_projectfiles_UCI HAR Dataset//UCI HAR Dataset//test//subject_test.txt")
test <- cbind(test_subject,test_activity,testset)
colnames(test) <- c("Subject","Activity",measured_features$description)

# Merge train and test dataset
totaldataset <- rbind(train,test)
# Convert into factors
totaldataset$Activity <- factor(totaldataset$Activity, levels = activities$Label, labels = activities$Description)
totaldataset$Subject <- as.factor(totaldataset$Subject)

melt_totaldataset <- melt(totaldataset, id = c("Subject", "Activity"))
mean_totaldataset <- dcast(melt_totaldataset, Subject + Activity ~ variable, mean)

write.table(mean_totaldataset, "tidy.txt", row.names = FALSE, quote = FALSE)