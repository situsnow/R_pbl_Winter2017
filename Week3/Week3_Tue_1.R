Title: "Module 2 Introduction to R - Week 3 Session 1 Questions."
Author: "Doogan, C.(2017)."
Date: "June 2017."

library(ggplot2)
library(dplyr)
install.packages("scales")
install.packages("xlsx")
install.packages("reshape2")
install.packages("lubridate")
install.packages("ggthemes")
install.packages("gridExtra")

# We are using the diamonds data set that is inbuilt for R.h
head(diamonds)


# Challenge 1: How many observations are in the data set?


# (Type your code here)
dim(diamonds)[1]
nrow(diamonds)

# Challenge 2: How many variables are in the data set?


# (Type your code here)
dim(diamonds)[2]
ncol(diamonds)
# Challenge 3: How many ordered factors are in the set?


# (Type your code here)
str(diamonds)

# Challenge 4: What letter represents the best color for a diamonds?


# (Type your code here)
levels(diamonds$color)
help(diamonds)

# Challenge 5: Create a histogram of the price of all the diamonds in the diamond data set.


# (Type your code here)


# challenge 6: Describe the shape and center of the price distribution. 
# Include summary statistics like the mean and median. 


# (Type your code here)
mean(diamonds$price)
median(diamonds$price)
summary(diamonds$price)

# Challenge 7: Have a go at explaining the dirstibution and summary stats of the histogram.


# (Type your code here)


# Challenge 8: How many diamonds cost less than $500?
# * Hint* Use dplyr functions


# (Type your code here)


# Challenge 9:How many diamonds cost less than $250?


# (Type your code here)


# Challenge 10: How many diamonds cost more than $15,000?


# (Type your code here)


# Challenge 10:Explore the largest peak in the
# price histogram you created earlier.
# Try limiting the x-axis, altering the bin width,
# and setting different breaks on the x-axis.


# (Type your code here)


# Challenge 11:  Break out the histogram of diamond prices by cut.
# You should have five histograms in separate
# panels on your resulting plot.
# * Hint* Use the facet_grid to do this "facet_grid(cut~.)"


# (Type your code here)


# Challenge 12: Which cut has the highest priced diamond?
# Premium
# by(diamonds$price, diamonds$cut, max)
# by(diamonds$price, diamonds$cut, min)
# by(diamonds$price, diamonds$cut, median)


# (Type your code here)

# End Session
# Source http://fch808.github.io/Data-Analysis-with-R-Exercises.html