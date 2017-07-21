Title: "Module 1  Introduction to R - WeeK 4 Session 2 Questions - Logistic Regression & Decision Trees."
Author:"Doogan, C. (2017)."
Date:  "July 2017."


# We are going to cover three classification techniques.
# Remember that these are supervised learning algorithms so they reuqire us
# to split the data into a training and test set. We will go with a 80% training and 20% testing ratio.
install.packages("modelr")
install.packages("broom")
install.packages("lattice")
install.packages("corrplot")
library(tidyverse)  # data manipulation and visualization
library(modelr)     # provides easy pipeline modeling functions
library(broom)      # helps to tidy up model outputs
library(caret)      # for splitting the data
library(corrplot)   # plots correlation
library(dplyr)
library(rpart)
library(rpart.plot)

### Data Preperation
# Import data
poke<-read.csv("Pokemon.csv", header = T,stringsAsFactors = TRUE)
summary(poke)
head(poke)

# Challenge 1: Double check there is no na's
# Answer:
sum(is.na(poke))
# There should be no na's.

### Data division
# Challenge 1: Create test and train data
#
# (Type you answer here)
#
#
dim(train)
# 641 observations of 13 variables (80%).
dim(test)
# 159 observations of 13 variables (20%).

### Logistic Regression 
# We use the glm() function. The difference between glm() and the linear regression function lm()
# is that we have to pas the agrgumen family = binomial. This is becuase we are using catagorical variables and so R needs
# to know not to do a linear regression

# Create the first model
# This time, we are going to try and predict if type of pokemon is legendary based on their stats.
poke_glm_1 <- glm(Legendary~ HP + Attack + Defense + Sp..Atk + Sp..Def +Speed, family=binomial(link='logit'), data = poke_train)


### Assessing our model
# Deviance is analogous to the sum of squares calculations in linear regression and is a measure of
# the lack of fit to the data in a logistic regression model.The null deviance represents the difference between a model
# with only the intercept (which means �no predictors�) and a saturated model (a model with a theoretically perfect fit). 
# The goal is for the model deviance (noted as Residual deviance) to be lower; smaller values indicate better fit.
# In this respect, the null model provides a baseline upon which to compare predictor models.
summary(poke_glm_1)

# Assessing coefficients
# he coefficient estimates from logistic regression characterize the relationship between the predictor and response
# variable on a log-odds scale 
# Challenge 2: Get the coefficients of the model.
# Answer:
tidy(poke_glm_1)

# Here we see that the the log odds increase in chances of a pokemon beging legendary is between 0.0455 and 0.0178
# Depending on the variable/ 

# Challenge 2: Which of these estimates are statistically significant?
#
# (Type you answer here)
#
#

# Sometimes we check the statistical signifcance of the model by using an ANOVA( don't worry about knowning what this is for now).
anova(poke_glm_1, test = 'Chisq')
summary(poke_glm_1)
plot(poke_glm_1)

# We are not going to spend anymore time on logistic regression as the theory behind it is necessary to progress.

### Decision Trees
# To build our decision tree we use the rpart package.
# The formular to grow a tree is: rpart(formula, data=, method=,control=) where
# Where, formula: outcome ~ predictor1+predictor2+predictor3+ect.
# data:	specifies the data frame
# method:	"class" for a classification tree 
# OR "anova" for a regression tree
# control=	optional parameters for controlling tree growth.
# For example, control=rpart.control(minsplit=30, cp=0.001) requires that the minimum number of observations
# in a node be 30 before attempting a split and that a split must decrease the overall lack of fit by a factor
# of 0.001 (cost complexity factor) before being attempted.
poke_tree <- rpart(Legendary ~ Type.1 + Type.2 + HP + Attack + Defense + Sp..Atk + Sp..Def + Generation, data=poke_train, control=rpart.control(minsplit=2, cp=0))
rpart.plot(poke_tree)

## Model Assesment
# Calculate how many 'False's' were predicted as 'False' 
# corectly and how many 'Trues' were predicted as 'True' correctly.
prediction<-predict(poke_tree,newdata=poke_test,type="class")
table(prediction,poke_test$Legendary)
# This seems to have performed fairly well. 

# Now we create a confusion matrix
poke_tree.matrix <- confusionMatrix(prediction, poke_test$Legendary)
poke_tree.matrix
# This Decision Tree has an Accuracy of 93% 

# Challenge 3: We want to improved the accurracy. Create three new models and run diagnostics:
# 1. Remove the Attack variable
# 2. Remove the HP variable
# 3. Remove the Attack and HP variable
# Answer:
#
# (Type you answer here)
#
#

# We used minisplit in the above material. Minisplit makes the decision tree
# use all the data that would have otherwise been 'trimmed'. 

# Challenge 5: Remove minsplit from the code and get a decision tree for all viariables. 
# Answer:
poke_tree_4 <- rpart(Legendary ~ Type.1 + Type.2 + HP + Attack + Defense + Sp..Atk + Sp..Def + Generation, data=poke_train)
rpart.plot(poke_tree_4)

# Challenge 4: Check the confusion matric and the accuracy od this model. 
#
# (Type you answer here)
#
#

# Another way to plot these is through a simple denogram. 
plot(poke_tree_4, uniform = TRUE, main = 'Classification Tree for Legendary Pokemon')
text(poke_tree_4, use.n = TRUE, all =TRUE, cex = .8)

# This is all you will need to know to give you a boost in your upcoming units.

# Good luck!!!!!
