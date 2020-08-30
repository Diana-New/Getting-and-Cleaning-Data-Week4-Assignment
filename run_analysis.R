library(dplyr)
setwd("./downloads/UCI HAR Dataset")

# Read necessary documents in R
train_x <- read.table("./train/X_train.txt")
test_x <- read.table("./test/X_test.txt")
train_y <- read.table("./train/y_train.txt")
test_y <- read.table("./test/y_test.txt")

train_subject <- read.table("./train/subject_train.txt")
test_subject <- read.table("./test/subject_test.txt")

features <- read.table("./features.txt")
activity <- read.table("./activity_labels.txt")

# Check dimensions and first 5 lines of the data frames
dim(train_x)  # 7352x561
dim(test_x)  # 2947x561
dim(train_y) # 7352x1
dim(test_y) #2947x1
dim(train_subject) # 7352x1
dim(test_subject) # 2947x1
dim(features) # 561x2
dim(activity) # 6x2

head(train_x)
head(test_x)
head(train_y)
head(test_y)
head(train_subject)
head(test_subject)
head(features)
head(activity)

# Combine train_x & test_x, train_y & test_y, train_subject & test_subject
total_x <- rbind(train_x,test_x)
total_y <- rbind(train_y,test_y)
total_subject <- rbind(train_subject,test_subject)

# Check the dimensions
dim(total_x) # 10299x561
dim(total_y) # 10299x1
dim(total_subject) # 10299x1

# Assign the features to the column names of the df(total_x)
colnames(total_x) <- features$V2

# Extract data with column names containing only "...mean()..." or "...std()..."
total_x_ext <- total_x[,grep("*mean\\(\\)|std\\(\\)",colnames(total_x),ignore.case=F)]

# Check the dimension and col_names of total_x_ext
dim(total_x_ext) # 10299x66
names(total_x_ext)

# Assign the six kinds of activities to the df(total_y)
head(total_y)
head(activity)
total_y_labeled <- total_y %>% mutate(label=factor(total_y$V1,levels=activity$V1,labels=activity$V2))
tail(total_y_labeled)
dim(total_y_labeled) # 10299x2

# Combine the data frames of total_subject, total_y_labeled and total_x_ext
final_data <- cbind(total_subject,total_y_labeled,total_x_ext)
dim(final_data) # 10299x69
head(final_data)

# Rename column names of the df(final_data)
colnames(final_data)[1:2] <- c("subject","activity")
head(final_data)

# Calculate the average of each variable for each activity and each subject
total_mean <- final_data %>% group_by(subject,label) %>%
        summarise_all(funs(mean))
dim(total_mean) # 180x69

# Save the result in a new R-Script
write.table(total_mean,file="./total_mean.txt",row.names=F,col.names = T)

