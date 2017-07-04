---
Title: "Module 1  Introduction to R - Week 2 Session 1"
Author:"Doogan, C. & Gao, C.(2017)."
Date:  "June 2017."
---
  # This week we will be focusing on basic data exploration. However, we first need to learn about control flow. 
  # This is fundamental to most programming languages and allows us to make conditions. 
  # Since we have packages such as dyplr though, we don't need to know any more than the basics.
  
  ### Control Flow
  #### Conditional statements
  
  # Often when we're coding we want to control the flow of our actions. 
  # This can be done by setting actions to occur only if a condition or a set of conditions are met. 
  # There are several ways you can control flow in R. 
  # For conditional statements, the most commonly used approaches are if/if-else statement. 

# if (condition is true) {
# perform action
# }

# or

# if (condition is true) {
# perform action 1
# } else if{  # second if condition (optional)
# perform action 2 
# } else {  # that is, if the conditions are false,
# perform alternative action
# }


# Challenge 1: X is a random number generated from a normal distribution. Print X if x is over 7. 

x <- rnorm(1, mean = 5, sd = 5)


# (Type your code here)


# Challenge 2: Let's bring back the gapminder data, use an if() statement to print a suitable message reporting 
# whether there are any records from 2012 in the gapminder dataset. 

gapminder <- read.csv("gapminder-FiveYearData.csv")


# (Type your code here)


#### Repeating operations

# If you want to iterate over a set of values, 
# when the order of iteration is important, and perform the same operation on each, a for() loop will do the job.
# This is the most flexible of looping operations, but therefore also the hardest to use correctly. 
# Avoid using for() loops unless the order of iteration is important:
# i.e. the calculation at each iteration depends on the results of previous iterations.

# The basic structure of a for() loop is:

# for(iterator in set of values){
#   do a thing


# Challenge 3: Save all possible combinations of day and month in vector "Day" and "Month", 
# and save values in the DayMonth vector, i.e. "10 Jan", "15 Jan", "25 Jan".
# *hint* you would need to use the paste function.

Day<-c(10,15,25,30)
Month<-c("Jan", "Feb", "March","June" )
DayMonth <- c()


# your code: 



# **Note** One of the biggest things that trips up novices and experienced R users alike,
# is building a results object (vector, list, matrix, data frame) as your for loop progresses.
# Computers are terrible at handling this, so your calculations can very quickly slow to a crawl. 
# It's much better to define empty results object beforehand of the appropriate dimensions.
# So if you know the result will be stored in a matrix like above, create an empty matrix with 5 row and 5 columns,
# then at each iteration store the results in the appropriate location.

# Challenge 4: How could you change your code in the previous task to a non-growing way? 
# *hint* you can save results in a matrix first.


# your code:


# The while loop is a continuous looping function when the given logical condition is true. 
# If the logical condition is false, the loop is never executed. The structure of while loop is as follows:

# while(this condition is true){
# do a thing
# }


# Challenge 4: Print first 9 numbers between 5 and 55 that can be divided by 3. 


# your code:


# The repeat loop similar to the while loop, but it is made so that the expressions would be executed at least once.
# Also it requires you to explicitly break the loop. 

#example
i <- 2
repeat {
  print(i)
  i<-i^2
  if (i>1000) break
}

# Challenge 5: Are loops slow? Considering the following loop which finds whether the mean life expectancy of each country 
# is smaller or larger than 50 years.

t1 <- Sys.time()
thresholdValue <- 50
for( iCountry in unique(gapminder$country) ){
  tmp <- mean(subset(gapminder, country==iCountry)$lifeExp)
  if(tmp < thresholdValue){
    cat("Average Life Expectancy in", iCountry, "is less than", thresholdValue, "\n")
  }
  else{
    cat("Average Life Expectancy in", iCountry, "is greater than or equal to", thresholdValue, "\n")
  } # end if else condition
  rm(tmp)
} # end for loop
t2 <- Sys.time()
difftime(t2,t1)

# Challenge 6: Can you make the code runs faster? 
# *hint* use the vectorized alternative rather than a loop.

t1 <- Sys.time()


# (type your code here)


t2 <- Sys.time()
difftime(t2,t1)


### Function
# If we only had one data set to analyse, it would probably be faster to load the file into a spreadsheet and use that 
# to plot simple statistics. However, in reality, the data we work with can be updated periodically, 
# and we may want to re-run our analysis again or apply the code to other similar data set. In this case, 
# functions are very useful. 

# Functions gather a sequence of operations into a whole, preserving it for ongoing use. Functions provide:
# * a name we can remember and invoke it by
# * relief from the need to remember the individual operations
# * a defined set of inputs and expected outputs
# * rich connections to the larger programming environment

#### Defining a function
# To define a function, one has to :
# * specify input variables
# * default values for input variables (optional)
# * return value using the return() function or return with the value of the last evaluated expression

# Challenge 7: Define a function fahr_to_kelvin that converts temperatures from Kelvin to Celsius:


# (type your code here)


# The real power of functions comes from mixing, matching and combining them into ever large chunks to get the effect we want.
# Here is an example. If we have another function that converts Kelvin to Celsius:

fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}


# Challenge 8: Define a function to directly convert from Fahrenheit to Celsius using two existing functions.


# (type your code here)


# We can also define a function that directly operate on dataframes. Considering the following function for the gapminder data: 

calcGDP <- function(dat, year=NULL, country=NULL) {
  if(!is.null(year)) {
    dat <- dat[dat$year %in% year, ]
  }
  if (!is.null(country)) {
    dat <- dat[dat$country %in% country,]
  }
  dat$gdp <- dat$pop * dat$gdpPercap
  dat
}

# Challenge 9: What is the function trying to achieve? why does it include two additional arguments year and country? 
# why %in% operator is used not == operator.

# Challenge 10:  Will the following code change the gapminder data? 

calcGDP(gapminder, year=c(1977,2007),country="Australia")

#### Scoping rules

# The scoping rules is one of the most important features that one has to be aware of when writing functions. The scoping rules of a language determine how value is associated with a free variable in a function. R uses lexical scoping to look up symbol values based on how functions were nested when they were **created**, not how they are nested when they are **called**. This turns out to be particularly useful for simplifying statistical computations. Lexical scoping in R means that the values of free variables are first searched for in the environment in which the function was defined, and then continues down the sequence of parent environments to the top-level environment (workspace or namespace of a package). After the top-level environment, the search continues down the search list until we hit the empty environment.

# Considering the following code:

y <- 10
f <- function(x) {
  y <- 2
  k<-function(x){x*y}
  y^2 + g(x) +k(x)
}
g <- function(x){x*y}


# Challenge 11: Which environment is the function k defined? Which environment is the function g defined?
# What is the value of f(2)? Why?


# (type your code here)


# End session.

## Optional practice 

# You can continue to practice R by complete the following sections on swirl()

# * Logic
# * Functions

