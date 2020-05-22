########## Week 1 - Lecture Notes ##########

myfunction <- function() {
  x <- rnorm(100)
  print(x)
  mean(x)
}

second <- function(x) {
  x + rnorm(length(x))
}

## Missing Values - NaN is NA but NA is not NaN. NA's can have classes

x <- c(1, 2, NA, 20, 3)
is.na(x)
is.nan(x)

x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

## Data frame - stores tabular data. Every element of the list has to be of the same length. Unlike
## a matrix, each column (element) can be a different class. Special attributes, row.names - each
## row has a name. Created by calling read.table() or read.csv(). data.frame() builds a dataframe 
## from scratch.

x <- data.frame(foo = 1:4, bar = c(T, T, F, F))
x
nrow(x)
ncol(x)

## Names - R objects can have names! No name by default but can assign.

x <- 1:3
names(x)
names(x) <- c("foo", "bar", "norf")
x
names(x)

# Lists can also have names!
x <- list(a = 1, b = 2, c = 3)
x

#matrices can have names - dimnames()

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d"))
m

## Reading Tabular Data - text files that returns a 
# read.table()
# read.csv()
# Note: read.table reads in characters as factor as a default. This could be problematic for text
# analytics, so setting stringasfactor = FALSE may be desirable. Read.table returns a data frame
# Note read.table() is the same as read.csv() except that read.csv is comma deliminated by default


## Reading in Larger Tables
# READ THE HELP PAGE FOR read.table()!!
# Make sure enough RAM is allocated to store dataset
# Use the colClasses argument. set class to "numeric" makes R assume that all columns are numeric.
# This makes R run MUCH faster, often by x2!
# A quick and ditry way to figure out the classes of wach column is the following:
initial <- read.table("datatable.txt", nrows = 100)
classes <- sapply(initial, class)
tabAll <- read.table("datatable.txt", colClasses = classes)
#set nrows will not help R run faster but will help with memorty usage.

## Textual Data formats
#dput - can only be used on a single R object
y <- data.frame(a = 1, b = "a")
dput(y)
dput(y, file = "y.R")
new.y <- dget("y.R")
new.y
#dunp - similar to dput but can be applied to several objects
x <- "foo"
y <- data.frame(a = 1, b = "a")
dump(c("x", "y"), file = "data.R")
rm(x, y)
source("data.R")
y
x

#Reading lines of a text file - readLines()
con <- url("http://jhsph.edu", "r")
x <- readLines(con)
head(x)

##Subsetting objects in R
# [] - always returns an object of the same class as the original, can be used to select more than 
#      one element (there is one excption)
# [[]] - is used to extract elements of a list or a data frame, it can only be used to extract a 
#      single element and the class of the returned object will not necessarily be a list or 
#      data frame
# $ - is used to extract elements of a list or data frame by name, semantics are similar to that 
#     of [[]]
# Examples, numeric indexes
x <- c("a", "b", "c", "c", "d", "a")
x[1] # exctracts the first element of x 
x[2] # extracts the second element of x
x[1:4] # extracts the first four elements of x
#examples of logical index
x[x > "a"]
u <- x > "a"
x[u]

##Subsetting lists
x <- list(foo = 1:4, bar = 0.6)
x[1]    #list that contains 1 through 4
x[[1]]  #sequence of 1 through 4
x$foo

x$bar      #give element that is associate with the name "bar"
x[["bar"]] 
x["bar"]
#Note using the name is nice because you do not have to remember the numeric index

#extract multiple elements form a list
x <- list(foo = 1:4, ba = 0.6, baz = "hello")
x[c(1 ,3)] # returns list of foo and baz. Can't use [[]]
# but we can use[[]] for other things:
name <- "foo"
x[[name]]
x$name # element 'name' doesn't exist!
x$foo # element 'foo' does exist

# Subsetting nested elements of a list. The [[]] can take an integer sequence

x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1, 3)]]
x[[1]][[3]]
x[[c(2, 1)]]

## Subestting Matrices
x <- matrix(1:6, 2, 3)
x[1,2]
x[2,1]
# Indices can also be missing
x[1, ] #first row of matrix
x[, 2] #second column of matrix
# NOTE: by default, when a single element of a matrix is retrieved, it is returned as a vector of 
#length 1 rather than a 1x1 matrix. This behavior can be altered by setting drop = FALSE
x[1, 2]
x[1, 2, drop = FALSE]
x[1, ]
x[1, , drop = FALSE]

##Removing NA values
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
x[!bad]
#more complicated case from multiple elements
x <- c(1, 2, NA, 4, NA, 5, 6)
y <- c("a", "b", NA, "d", NA, "f", NA)
good <- complete.cases(x, y)
good
x[good]
y[good]
#example
airquality[1:6, ]
good <- complete.cases(airquality)
airquality[good, ][1:6, ]

########## Week 1 - Quiz ##########

x <- 4
class(x)

x <- c(4, TRUE)
class(x)

x <- 1:4
y <- 2:3
x+y

x <- c(3, 5, 1, 10, 12, 6)
x[x < 6] <- 0
x[x <= 5] <- 0
x[x %in% 1:5] <- 0


main_data <- read.csv("hw1_data.csv", header = TRUE)
main_data

names(main_data)
head(main_data, 2)
tail(main_data, 2)
View(main_data)

missing_ozone <- sum(is.na(main_data$Ozone))
mean_ozone <- mean(main_data$Ozone[!is.na(main_data$Ozone)])

complete_main <- complete.cases(main_data)
main <- main_data[complete_main,]
filter_ozone <- as.logical(main$Ozone > 31)
main <- main[filter_ozone,]
filter_temp <- as.logical(main$Temp > 90)
main<- main[filter_temp,]
mean(main$Solar.R)


filter_month <- as.logical(main_data$Month == 6)
main2 <- main_data[filter_month,]
mean(main2$Temp)

filter_month <- as.logical(main_data$Month == 5 & !is.na(main_data$Ozone))
main3 <- main_data[filter_month,]
max(main3$Ozone)



ozone <- main_data[,1]
complete_data <- main_data[is.na(main_data$Ozone)]
View(complete_data)
filter_data <- main_data[Ozone > 31]












