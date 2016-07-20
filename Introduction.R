# Jason Mohabir
# Data Analysis for the Life Sciences
# 07/20/2016

# setting the working directory
setwd("~/Google Drive/Rockefeller/data_analysis_for_life/")

# removing objects from R environment
rm(list = ls())

# Introduction
# - Possible to measure all +20,000 human genes at once
# - Learn p-values through high through put analysis

?install.packages
help("install.packages")

## This is a comment 

install.packages("rafalib")
install.packages("downloader")

library(rafalib)
library(downloader)

getwd()

# Option 1 is to manually navigate
dat <- read.csv("data/femaleMiceWeights.csv")

# Option 2 is to download from within R
library(downloader) ##use install.packages to install
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extd\
ata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv"
download(url, destfile=filename)

# Option 3 is to use GitHub which does not vet packages
install.packages("devtools")
library(devtools)
install_github("genomicsclass/dagdata")

dir <- system.file(package="dagdata") #extracts the location of package
list.files(dir)

list.files(file.path(dir,"extdata")) #external data is in this directory

filename <- file.path(dir,"extdata/femaleMiceWeights.csv")
dat <- read.csv(filename)

print(dat)

# 1. Read in the file femaleMiceWeights.csv and report the body weight of the mouse in the
# exact name of the column containing the weights.

print(dat$Bodyweight)

# 2. The [ and ] symbols can be used to extract specific rows and specific columns of the table.
# What is the entry in the 12th row and second column?

print(dat[12,2])

# 3. You should have learned how to use the $ character to extract a column from a table and
# return it as a vector. Use $ to extract the weight column and report the weight of the mouse
# in the 11th row.

print(dat$Bodyweight[11])

# 4. The length function returns the number of elements in a vector. How many mice are
# included in our dataset?

length(dat$Bodyweight)

# 5. To create a vector with the numbers 3 to 7, we can use seq(3,7) or, because they are
# consecutive, 3:7. View the data and determine what rows are associated with the high fat
# or hf diet. Then use the mean function to compute the average weight of these mice.

tempV <- seq(3:7)

print(mean(dat$Bodyweight[tempV]))

# 6. One of the functions we will be using often is sample. Read the help file for sample using
# ?sample. Now take a random sample of size 1 from the numbers 13 to 24 and report back
# the weight of the mouse represented by that row. Make sure to type set.seed(1) to ensure
# that everybody gets the same answer.

set.seed(1)

?sample

dat[sample(13:24,1),]$Bodyweight

# Brief Introduction to dplyr
filename <- "data/femaleMiceWeights.csv"
dat <- read.csv(filename)
View(dat) #In R Studio use View(dat)

library(dplyr)
chow <- filter(dat, Diet=="chow") #keep only the ones with chow diet
View(chow)

chowVals <- select(chow,Bodyweight)
View(chowVals)

# dplyr allows you to perform consecutive tasks by using a "pipe"
# %>% denotes a pipe 

chowVals <- filter(dat, Diet=="chow") %>% select(Bodyweight)

# dplyr retains class

class(dat)
class(chowVals)

chowVals <- filter(dat, Diet=="chow") %>% select(Bodyweight) %>% unlist
class( chowVals )

# with out dplyr
chowVals <- dat[ dat$Diet=="chow", colnames(dat)=="Bodyweight"]

# Exercises


# 1. Read in the msleep_ggplot2.csv file with the function read.csv and use the function class
# to determine what type of object is returned.

filename <- file.path(dir,"extdata/msleep_ggplot2.csv")
dat <- read.csv(filename)

class(dat)

# 2. Now use the filter function to select only the primates. How many animals in the table are
# primates? Hint: the nrow function gives you the number of rows of a data frame or matrix.

primates <- filter(dat,order =="primates")

# 3. What is the class of the object you obtain after subsetting the table to only include primates?
# 4. Now use the select function to extract the sleep (total) for the primates. What class is this
# object? Hint: use %>% to pipe the results of the filter function to select.
# 5. Now we want to calculate the average amount of sleep for primates (the average of the
# numbers computed above). One challenge is that the mean function requires a vector so, if
# we simply apply it to the output above, we get an error. Look at the help file for unlist and
# use it to compute the desired average.
# 6. For the last exercise, we could also use the dplyr summarize function. We have not introduced
# this function, but you can read the help file and repeat exercise 5, this time using just filter
# and summarize to get the answer.
