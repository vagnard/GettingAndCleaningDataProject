<<<<<<< HEAD
---
"README"
---
### Processing and merging raw data

Reading training data, test data and features and activity names

```r
trainData <- read.table("train\\X_train.txt")
trainLabels <- read.table("train\\y_train.txt")
trainSubjects <- read.table("train\\subject_train.txt")
testData <- read.table("test\\X_test.txt")
testLabels <- read.table("test\\y_test.txt")
testSubjects <- read.table("test\\subject_test.txt")
features <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt")
```
Assigning descriptive names to variables instead of "V1"

```r
names(trainLabels) <- "label"
names(trainSubjects) <- "subject"
```
Binding labels and subjects to main data table

```r
trainData <- cbind(trainData, trainLabels)
trainData <- cbind(trainData, trainSubjects)
```
Same code for test data

```r
names(testLabels) <- "label"
names(testSubjects) <- "subject"
testData <- cbind(testData, testLabels)
testData <- cbind(testData, testSubjects)
```

Merging two data tables

```r
data <- rbind(trainData, testData)
```
### Renaming

I made label and subject factors, so i can easily rename them and use with function group_by when i am going to create new data set.

```r
data$label = factor(data$label)
data$subject = factor(data$subject)
levels(data$label) <- activityLabels$V2
names(data) <- c(as.vector(features$V2), "label","subject")
```
### Extracting
NeededFeatures is a vector, which contains ids of variables which names contains substring "mean", "std", "label" or "subject".

```r
neededFeatures <- grep("mean|std|label|subject",names(data))
data <- data[,neededFeatures]
```
### Creating new data set
I used summarise_each function, which is same as summarise, but applying function to each variable in data set

```r
newDataSet <- data %>% 
              group_by(label, subject) %>% 
              summarise_each(funs(mean))
```
Writing new data to a file

```r
write.table(newDataSet, file = "finalData.txt", row.name = FALSE)
```
=======
# GettingAndCleaningDataProject
>>>>>>> edb2d734d4b1d3f6f3562d137f6eb6e6f5e50caa
