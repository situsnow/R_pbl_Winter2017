Title: "Module 1  Introduction to R -  Week 1 Working with Data 1.1"
Author: "Doogan, C.(2017)."
Date: "June 2017."

# In this section we will be working with data to get an understanding of how to working with data in R.
# We are using data sets that are similar to the level of difficulty you will be using in your MDS units.
# Although a few different data sets are going to be seen in the program course work,
# the primary data set we will be working with is the Titanic Survival set.

# The Titanic: Machine Learning for Disaster is a much-used dataset for beginners. It can be downloaded here 
# https://www.kaggle.com/c/titanic


# You can download the titanic training data set from Moodle. It is called 'titanic_train_week1.csv'.
# You also need the titanic testing data set from Moodle. It is called 'titanic_test_week.csv'.


### Read data

# To read a csv file, you can use read.csv() and read.table() function from your local computer.

ti_train<- read.csv("titanic_train_week1.csv")

### Investigating the  data frame

# The first thing we always do is check out what the data looks like. This can be done with str() or summary():
# str() gives the basic internal structure and summary() gives the basic statistics needed if we were are going to start 
# building models (which we will be doing in MDS units).

str(ti_train)
summary(ti_train)

# Sometimes looking at the first few observations can be insightful.
head(ti_train,3) 

# And looking at the last few as well
tail(ti_train, 3)

# Discussion: Remembering that str(ti_train) said there were 891 observations of 12 variable,
# what is the length of the ti_train dataset, and why?

length(ti_train) #12, there are 12 variables. A data frame is a list of vectors and factors,
# so length() returns a number of elements (columns) in the list.

# Since this is a data frame; we should check the dimensions using dim()

dim(ti_train) # 891 observations and 12 variables, just what str() told us. 

### Importing the testing data. Again, you will need to download this from Moodle. 

ti_test<- read.csv("titanic_test_week1.csv")

# Get and overview of the data as you did for the training data.Use whatever tools you found the most helpful.
summary(ti_test)
length(ti_test) # 418 Observations and 11 variables

# We have found our first problem with this data! 
# The training data has 12 variables, and the test data has 11 variables. We need to know why.

# Discussion: Why is this going to be problematic?
# When we go to test any models we build, 
# there will be potential problems with models running due to the variable numbers not matching.

# To fix this we should check that the column names are the same in both the training and testing data sets.
# You will start to see that a lot of exploring data is heuristic. 

colnames_check <- colnames(ti_train) %in% colnames(ti_test) 
colnames(ti_train[colnames_check==FALSE])

# 'Survived' was printed, this means that survived is the missing variable in the test set. 
# This is fine, we don't want that variable there since that is exactly what we want to predict. 

# End Session