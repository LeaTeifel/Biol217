getwd() #get path
setwd() #set path I want to work in

#create folders ---------section-----------------
dir.create('data') #create folder
dir.create('data/raw_data') #create folder inside folder


#excel sheet is dataframe in R

#define variable
x = 2+2 
x <-2+2 #better, always use this
#dont use words reserved for R as variable ->google

#Datatype important for plots
#logical operator >;< ->TRUE or FALSE

x <- 5
class(x) #numeric

x <- "Hello World" #character ,inside "" called string statistics:categorical
class(x) 

x <- TRUE #logical
class(x) 

x <- 1+2i #complex
class(x) 

x <- charToRaw("Hello World") #raw stores files differently->change into sth else differen, without compression
class(x) 

x <- data.frame(matrix(1:6, nrow = 2, ncol = 3)) #data.frame ->function
class(x) 

# == means = x=y means define variable



#build in data.frames
data()
data("iris")
View(iris) # viwe whole dataframe in table

class (iris$Sepal.Length) #run 1 column

plot(iris)
boxplot(data = iris, x = iris$Petal.Length)#boxplot only needs x value
boxplot(data = iris,iris$Petal.Length~iris$Species) #plot of all species


# CRAN repository basic packages for R, not bioinf.-> other repo
#install packages, right bottom window-> packages-> install ggplot2 or->

#plotting----------------------------
#install.packages("ggplot2") #only need to install once
library(ggplot2)
install.packages(c('readxl','plotly')) #install several packages
install.packages("tidyverse")
library("tidyverse")

#ggplot2

ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length, fill = Species)) + geom_boxplot()

#where which kind of plot andrew abela chart guide
# 2 numeric variables
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Sepal.Length, col = Species)) + geom_point()
#fill inside colour, col outline colour
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Sepal.Length, shape = Species)) + geom_point()
#shape triangle,dot etc; 
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Sepal.Length, size = Petal.Width)) + geom_point()
#size of dots according to petal.width
#?ggplot help function

#saving a plot

plot1 <-ggplot(data = iris, mapping = aes(x = Petal.Length, y = Sepal.Length, col = Species)) + geom_point()
plot1 + ggsave('plot1.pdf',plot1)
#define outline of plot
plot1 + ggsave('plot1_2.tiff',height = 6, width = 8, units = 'in', dpi = 300, compression = 'lzw')
# compression of tiff file
#export as svg not in command line (package missing)
# variables->columns, observations->row

library(tidyr)
df<-(iris$Sepal.Length, iris)
spread(iris, Species, Petal.Length) #error

#Question: how to change table from wide to long and long to short for Iris

#see if data is normally distributed
hist(iris$Sepal.Length)
hist(iris$Sepal.Width)
hist(iris$Petal.Length)
hist(iris$Petal.Width)

#normalditributed->parametric data

boxplot(iris$Sepal.Width)

#homogeneity test
#purpose of study
#comparison of 2 variables: t-test
#unpaired t test compare 2 different variables
# 2 sample t-test (eb before and after treatment)

data("ChickWeight")
View (ChickWeight)

#plotting ChickWeight

ggplot(data = ChickWeight,mapping =aes( x = Time,y= weight, col = Chick)) +geom_point()


ggplot(ChickWeight, aes(y=weight, x=Chick, fill = Diet)) +
  geom_bar(stat="identity")

ggplot(ChickWeight, aes(x=Time, y=weight, fill = Diet)) +
  geom_bar(stat="identity")
library(ggplot2)

ggplot(ChickWeight, aes(fill=Diet, y=weight, x=Time)) +
  geom_bar(position='dodge', stat='identity') +
  ggtitle('Weight over Time') +
  xlab('Time') +
  ylab('Weight') +
 
#
ggplot(iris,aes(Species,Petal.Length))+ geom_boxplot()+
  facet_wrap(~Species)

library(readr)
# install on linus , dependecies = TRUE
#setrepositories ->run code for bioinformatics-> all repos needed

