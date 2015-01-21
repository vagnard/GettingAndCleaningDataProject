trainData <- read.table("train\\X_train.txt")
trainLabels <- read.table("train\\y_train.txt")
trainSubjects <- read.table("train\\subject_train.txt")
names(trainLabels) <- "label"
names(trainSubjects) <- "subject"
trainData <- cbind(trainData, trainLabels)
trainData <- cbind(trainData, trainSubjects)

testData <- read.table("test\\X_test.txt")
testLabels <- read.table("test\\y_test.txt")
testSubjects <- read.table("test\\subject_test.txt")
names(testLabels) <- "label"
names(testSubjects) <- "subject"
testData <- cbind(testData, testLabels)
testData <- cbind(testData, testSubjects)

features <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt")

data <- rbind(trainData, testData)

data$label = factor(data$label)
data$subject = factor(data$subject)
levels(data$label) <- activityLabels$V2

names(data) <- c(as.vector(features$V2), "label","subject")
neededFeatures <- grep("mean|std|label|subject",names(data))
data <- data[,neededFeatures]
newDataSet <- data %>% 
              group_by(label, subject) %>% 
              summarise_each(funs(mean))
write.table(newDataSet, file = "finalData.txt", row.name = FALSE)