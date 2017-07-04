Title: "Module 1  Introduction to R - Week 1 Working with data summary."
Author: "Doogan, C.(2017)."
Date: "June 2017."

# Go ahead and run the followings, so you do not have to re-do everything previously.

# "Module 1  Introduction to R - Week 1 Working with Data Summary."
### Install packages
install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)

### Read data
ti_train<- read.csv("titanic_train_week1.csv",na.strings=c("NA","NaN", ""), header = TRUE, sep=",")
ti_test<- read.csv("titanic_test_week1.csv",na.strings=c("NA","NaN", ""), header = TRUE, sep = ",")

### Investigating the  data frame
# Train data
str(ti_train)
summary(ti_train)
# Test data
str(ti_train)
summary(ti_test)

### Resolving mismatched variable length
colnames_check <- colnames(ti_train) %in% colnames(ti_test) 
colnames(ti_train[colnames_check==FALSE])
# 'Survived' was printed, this means that survived is the missing variable in the test set. 

### Check for NA's
# training data
ti_train[!complete.cases(ti_train),]
ti_test[!complete.cases(ti_test),]

### Addressing 'Cabin' NA's
# training data
ti_train<- select(ti_train, -Cabin)
head(ti_train)
# testing data
ti_test<- select(ti_test, -Cabin)
head(ti_test)

### Addressing ' Age' NA's
# training data
ti_train$Age[is.na(ti_train$Age)] <- mean(ti_train$Age, na.rm = TRUE)
dplyr::filter(ti_train, is.na(Age))
# testing data
ti_test$Age[is.na(ti_test$Age)] <- mean(ti_test$Age, na.rm = TRUE)
dplyr::filter(ti_test, is.na(Age))

### Addressing ' Embarked' NA's
# training data
prop.table(table(ti_train$Embarked))
ti_train$Embarked <- replace(ti_train$Embarked, which(is.na(ti_train$Embarked)), 'S')
sum(is.na(ti_train$Embarked))
# testing data
prop.table(table(ti_test$Embarked))
ti_test$Embarked <- replace(ti_test$Embarked, which(is.na(ti_test$Embarked)), 'S')
sum(is.na(ti_test$Embarked))

### Addressing 'Fare' NA's
# testing data
ti_test$Fare[is.na(ti_test$Fare)] <- mean(ti_test$Fare, na.rm = TRUE)
dplyr::filter(ti_test, is.na(Fare))

# Now we will do some data exploration.....