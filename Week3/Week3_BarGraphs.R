Title: "Module 2  Introduction to R -  Week 3 ggplot2 Bar graphs"
Author: "Doogan, C.(2017)."
Date: "June 2017."

# This week we are going to go through more ggplot2 uses  with example of when to use each of these tools. 
# The following is bar graphing example from 'The R Cookbook' chang, W. (2016).

### Bar and line graphs
library(ggplot2)
install.packages("reshape2")
library(reshape2)

# In these examples, the height of the bar will represent the value in a column of the data frame.
# This is done by using stat="identity" instead of the default, stat="bin".

# These are the variable mappings used here:
# time: x-axis and sometimes color fill
# total_bill: y-axis

### Very basic bar graph
ggplot(data=dat, aes(x=time, y=total_bill)) + geom_bar(stat="identity")


# Map the time of day to different fill colors
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) + geom_bar(stat="identity")
# This would have the same result as above
# ggplot(data=dat, aes(x=time, y=total_bill)) +
# geom_bar(aes(fill=time), stat="identity")


# Add a black outline
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) + geom_bar(colour="black", stat="identity")


# No legend, since the information is redundant
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) + geom_bar(colour="black", stat="identity") + guides(fill=FALSE)

# Add title, narrower bars, fill color, and change axis labels
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) +geom_bar(colour="black", fill="#DD8888", width=.8, stat="identity") +  guides(fill=FALSE) + xlab("Time of day") + ylab("Total bill") + ggtitle("Average bill for 2 people")

### Bar graphs of counts
# Look at fist several rows
head(tips)
#>   total_bill  tip    sex smoker day   time size
#> 1      16.99 1.01 Female     No Sun Dinner    2
#> 2      10.34 1.66   Male     No Sun Dinner    3
#> 3      21.01 3.50   Male     No Sun Dinner    3
#> 4      23.68 3.31   Male     No Sun Dinner    2
#> 5      24.59 3.61 Female     No Sun Dinner    4
#> 6      25.29 4.71   Male     No Sun Dinner    4

# Bar graph of counts
ggplot(data=tips, aes(x=day)) + geom_bar(stat="count")
## Equivalent to this, since stat="bin" is the default:
# ggplot(data=tips, aes(x=day)) +
#    geom_bar()

### Line graphs
# or line graphs, the data points must be grouped so that it knows which points to connect. 
# In this case, it is simple � all points should be connected, so group=1. When more variables are used and multiple
# lines are drawn, the grouping for lines is usually done by variable (this is seen in later examples).

# # Basic line graph
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) + geom_line()
## This would have the same result as above
# ggplot(data=dat, aes(x=time, y=total_bill)) +
#     geom_line(aes(group=1))

# Add points
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) + geom_line() + geom_point()

# Change color of both line and points
# Change line type and point type, and use thicker line and larger points
# Change points to circles with white fill
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) + geom_line(colour="red", linetype="dashed", size=1.5) + geom_point(colour="red", size=4, shape=21, fill="white")

# Change the y-range to go from 0 to the maximum value in the total_bill column,
# and change axis labels
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) + geom_line() +geom_point() + expand_limits(y=0) + xlab("Time of day") + ylab("Total bill") + ggtitle("Average bill for 2 people")

### Graphs with more variables
dat1 <- data.frame( sex = factor(c("Female","Female","Male","Male")), time = factor(c("Lunch","Dinner","Lunch","Dinner"), levels=c("Lunch","Dinner")), total_bill = c(13.53, 16.81, 16.24, 17.42))
dat1
#>      sex   time total_bill
#> 1 Female  Lunch      13.53
#> 2 Female Dinner      16.81
#> 3   Male  Lunch      16.24
#> 4   Male Dinner      17.42

### Bar Graphs
# Stacked bar graph -- this is probably not what you want
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity")

# Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity", position=position_dodge())

ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity", position=position_dodge(), colour="black")

# Change colors
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) + geom_bar(stat="identity", position=position_dodge(), colour="black") + scale_fill_manual(values=c("#999999", "#E69F00"))

# It�s easy to change which variable is mapped the x-axis and which is mapped to the fill.

# Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
ggplot(data=dat1, aes(x=sex, y=total_bill, fill=time)) + geom_bar(stat="identity", position=position_dodge(), colour="black")

# These are the variable mappings used here:
# time: x-axis
# sex: line color
# total_bill: y-axis.
# To draw multiple lines, the points must be grouped by a variable; otherwise all points will be connected by a single line. 
# In this case, we want them to be grouped by sex.

# Basic line graph with points
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex)) + geom_line() + geom_point()

# Map sex to color
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex, colour=sex)) + geom_line() + geom_point()

# Map sex to different point shape, and use larger points
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex, shape=sex)) + geom_line() + geom_point()


# Use thicker lines and larger points, and hollow white-filled points
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex, shape=sex)) +  geom_line(size=1.5) +  geom_point(size=3, fill="white") + scale_shape_manual(values=c(22,21))

# It�s easy to change which variable is mapped the x-axis and which is mapped to the color or shape.
ggplot(data=dat1, aes(x=sex, y=total_bill, group=time, shape=time, color=time)) + geom_line() + geom_point()

### With a numeric x-axis
# When the variable on the x-axis is numeric, it is sometimes useful to treat it as continuous, and sometimes useful to 
# treat it as categorical. In this data set, the dose is a numeric variable with values 0.5, 1.0, and 2.0.
# It might be useful to treat these values as equal categories when making a graph.

datn <- read.table(header=TRUE, text='
                   supp dose length
                   OJ  0.5  13.23
                   OJ  1.0  22.70
                   OJ  2.0  26.06
                   VC  0.5   7.98
                   VC  1.0  16.77
                   VC  2.0  26.14
                   ')

### With x-axis treated as continuous
# A simple graph might put dose on the x-axis as a numeric value. 
# It is possible to make a line graph this way, but not a bar graph.

ggplot(data=datn, aes(x=dose, y=length, group=supp, colour=supp)) + geom_line() + geom_point()

### With x-axis treated as categorical

# If you wish to treat it as a categorical variable instead of a numeric one, 
# it must be converted to a factor. This can be done by modifying the data frame, 
# or by changing the specification of the graph.

# Copy the data frame and convert dose to a factor
datn2 <- datn
datn2$dose <- factor(datn2$dose)
ggplot(data=datn2, aes(x=dose, y=length, group=supp, colour=supp)) + geom_line() + geom_point()

# Use the original data frame, but put factor() directly in the plot specification
ggplot(data=datn, aes(x=factor(dose), y=length, group=supp, colour=supp)) + geom_line() + geom_point()

### It is also possible to make a bar graph when the variable is treated as categorical rather than numeric.

# Use datn2 from above
ggplot(data=datn2, aes(x=dose, y=length, fill=supp)) +  geom_bar(stat="identity", position=position_dodge())

# Use the original data frame, but put factor() directly in the plot specification
ggplot(data=datn, aes(x=factor(dose), y=length, fill=supp)) + geom_bar(stat="identity", position=position_dodge())