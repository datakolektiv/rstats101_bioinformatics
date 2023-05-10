### ----------------------------------------------------------------------------
### --- DataKolektiv R STATS 101 for Bioinformatics
### --- Session 02. Introduction to R
### --- author: Goran S. Milovanović, Phd
### --- DataKolektiv, Chief Scientist/Owner
### --- DataKolektiv, 2023.
### --- script: rstats102_session01.R
### --- description: R programming 101
### --- license: GPL-3.0 license
### --- https://www.gnu.org/licenses/gpl-3.0.html
### ----------------------------------------------------------------------------

### ---------------------------------------------------------
### --- Setup
### ---------------------------------------------------------

### --- packages
library(tidyverse)

### --- directory tree

# - where am i?
getwd()

# - dir_tree
data_dir <- paste0(getwd(), "/_data/")
analytics_dir <- paste0(
  getwd(), "/_analytics/"
)
reporting_dir <- paste0(getwd(), "/_reporting/")
img_dir <- paste0(getwd(), "/_img/")

# - note: always use RStudio projects!
list.files(getwd())
list.files()

# - pick a directory in your local filesystem, and then:
store_course_dir <- getwd()
your_directory <- "/"
setwd(your_directory)
getwd()
# - you are now in "/"
# note: navigate back to the project directory and setwd() there
setwd(store_course_dir)

### ---------------------------------------------------------
### --- Atomic Vectors, Vectorization
### ---------------------------------------------------------

# - list all objects in the environment
ls()
a <- 10
ls()
rm(a)
ls

# - clear environment
rm(list = ls())
ls()

# - basic types and elementary built-in functions
print("Hello World!")
w1 <- "Hello"
w2 = "World"
print(c(w1, w2))

# - nope: print() is a function of one argument
print(w1, w2)

# - assignment
hw <- c(w1, w2)
hw[1]
hw[2]

# - what is c():
c(1, 2, 3)

# - a vector:
a <- c(1, 2, 3)
class(a)

# - however:
a <- 5
class(a)

# - everything in R are vectors
v1 <- c(1, 2, 3)
print(v1)
v2 <- c("a", "b", "c")
class(v2)
print(v2)
v3 <- c("a", 3.14, "c")
print(v3)

# - implicit type conversion (coercion)
class(v3)

# - access elements of a vector
v3[1]
v3[2]
class(v3)
v3[3]

# - implicit type conversion (coercion):
class(v3)

# - character class
class(v2)

# - character to numeric
v3 <- c("1", 2, "3.1415")
v3
class(v3)
v3num <- as.numeric(v3)
class(v3num)
v3num

# - vectorization
v1
v1 + 1

nv <- 1:10
nv1 <- 11:20
nv + nv1
nv^2
sqrt(4)
sqrt(nv)

# - recycling
v1
v1 + c(1, 2, 3, 4, 5, 6)
length(v1)
length(c(1, 2, 3, 4, 5, 6))

# - everything in R are functions
5 + 2
"+"(5, 2)
"+"(5, 2, 1)

# - look:
Reduce("+", c(5, 2, 1))
Reduce("+", c(5, 2, 1), accumulate = TRUE)

# - function composition:
"+"("+"(3, 2), 1)
paste0("Beograd ", paste0("je ", "prestonica."))

# - everything in R is (better: can be) functional programming

# - numbers
a <- 7
class(a)
a <- 3.14
class(a)
sqrt(a)

is.integer(4.14)
as.integer(3.14)
is.character(300)
as.character(300)

round(3.14, 1)

# - variance of a vector
v1 <- c(1, 7, 8, 2, 11, 14, 22)
# - length of v1
length(v1)
# - mean of v1
mean(v1)
# - iteration
sse <- numeric()
for (i in 1:length(v1)) {
  sse[i] <- v1[i] - mean(v1)
}
print(sse)
sse <- sse^2
sse <- sum(sse)
sse
# - degrees of freedom:
n <- length(v1) - 1
n
variance_v1 <- sse/n
variance_v1  
# - also:
var(v1)
# - standard deviation
sd_v1 <- sqrt(variance_v1)
sd_v1
sd(v1)
# - Ok, now without iteration:
sse <- sum((v1-mean(v1))^2)
sse
# - and thus:
var_v1 <- sum((v1-mean(v1))^2)/(length(v1)-1)
var_v1
var(v1)

# - missing values
v1 <- c(1, 7, 8, 2, 11, NA, 22)
var(v1)
var(v1, na.rm = TRUE)

# also:
sum(v1)
sum(v1, na.rm = TRUE)
mean(v1)
mean(v1, na.rm = TRUE)

# - finding things in vectors
v1 > 5
which(v1 > 5)
v1[v1 > 5]
w <- which(v1 > 5)
v1[w] <- NA
v1

# - head and tail
head(v1)
head(v1, 2)
tail(v1)
tail(v1, 2)

# - boolean in R
a <- TRUE
class(a)
v1 <- c(1, 7, 8, 2, 11, 14, 22)
find5 <- v1 > 5
class(find5)
find5

# - explicit type conversion
as.numeric(find5)

# - how many elements of v1 are larger than five
sum(as.numeric(find5))

# - implicit type conversion
sum(find5)
b <- FALSE

# - implicit type conversion
a + b

# - character in R
a <- "Paris"
class(a)
b <- "Belgrade"
a + b
paste(a, b)
paste0(a, b)
paste(a, b, sep = "")
paste(a, b, sep = " ")

# - function to work with character
substr(a, 1, 2)
substr(a, 4, 6)
a <- "This is a sentence in English"

# - split a string
strsplit(a, split = " ")
a_split <- strsplit(a, split=" ")
class(a_split)
length(a_split)
length(a_split[[1]])
a_split[[1]][6]

a <- "This is a sentence in English"
b <- "Ovo je recenica na srpskom"
recenice <- c(a, b)
recenice_split <- strsplit(recenice, split = " ")
class(recenice_split)

# This is a list in R
a_split <- strsplit(a, split = " ")
class(a_split)

# To access an element of a vector: "[" and "]"
text <- c("Paris", "Belgrade")
text[1]
text[2]

# To access an element of a list: "[[" and "]]"
a_split <- strsplit(a, split = " ")
a_split
length(a_split)
a_split
a_split[[1]]
class(a_split)
class(a_split[[1]])
a_split[[1]][1]
a_split[[1]][6]

# - length of a string
a <- "Paris"
length(a)
nchar(a)

# - is something found in a string
grepl("P", a)
grepl("Z", a)

# - replace something in a string
gsub("P", "Z", a, fixed = TRUE)
a <- gsub("P", "Z", a, fixed = TRUE)
grepl("Z", a)

# - elementary functions in R
sum2 <- function(x, y) {
  s <- x + y
  return(s)
}

sum2(10, 4)
sum2(10, 1)

# - more functions 
a <- list(name = c("George", "Maria"),
          age = c(48, 42))
b <- list(name = c("Marko", "Nataša"),
          age = c(51, 41))

cmp_couples <- function(l1, l2) {
  if (l1$age[1] > l2$age[1]) {
    output1 <- paste0(l1$name[1], " is older than ", l2$name[1])
  } else {
    output1 <- paste0(l1$name[1], " is not older than ", l2$name[1])
  }
  if (l1$age[2] > l2$age[2]) {
    output2 <- paste0(l1$name[2], " is older than ", l2$name[2])
  } else {
    output2 <- paste0(l1$name[2], " is not older than ", l2$name[2])
  }
  return(list(output1, output2))
}

cmp_couples(a, b)


# - lists
a <- list("Belgrade", 2022, TRUE)
class(a)
length(a)
a[[1]]
a[[2]]
a[[3]]
class(a[[1]])
class(a[[2]])
class(a[[3]])

# - apply a function over a list
lapply(a, class)

# - it would work for a vector too
v1 <- seq(1, 10, by = 1)
v1 <- 1:10
v1
plus_one <- function(x) {
  return(x+1)
}
lapply(v1, plus_one)
# - but the result is a list
class(lapply(v1, plus_one))

# - to unlist
unlist(lapply(v1, plus_one))
class(unlist(lapply(v1, plus_one)))

# - or use sapply
sapply(v1, plus_one)

# - combine functions: that is R programming
sum(sapply(v1, plus_one))

# - lists can be nested
a <- list()
a[[1]] <- list(5, 7)
a[[2]] <- list(1, 3)
print(a)
a[[1]]
a[[1]][[1]]
a[[2]][[2]]

# - lists can be named
a <- list(first = list(first = 1, second = 2),
          second = list(first = "a", second = "b"))
print(a)
a$first$first
a$first$second
a$second$first
a$second$second
names(a)
names(a$first)
names(a$first) <- c("prva", "druga")
names(a$first)
a

# - data.frame
num <- c(1, 2, 3, 4)
city <- c("Paris", "Belgrade", "NYC", "Tokyo")
timezone <- c("CET", "CET", "EDT", "JST")
population <- c(2.23, 1.4, 8.83, 14)
cities <- data.frame(no = num,
                     city = city,
                     tz = timezone,
                     pop = population)
cities
str(cities)
# - works for lists
str(a)
str(cities)
# - access columns
cities$city
cities$tz
cities$pop
class(cities$city)
class(cities$pop)
# - acess rows
cities[1, ]
cities[1:2, ]
cities[1:2, 1]
cities[1:2, 1:2]

# - subsetting data.frame

which(cities$pop > 3)
cities[which(cities$pop > 3), ]

cities$score <- c(1, 3, 4, 7)
dim(cities)[2]
cities$score <- NULL

head(cities, 2)
tail(cities, 2)
colnames(cities)
colnames(cities)[1]
colnames(cities)[1] <- "redni_broj"
colnames(cities)

cities[1:2, c('city', 'tz')]
cities[1:2, c('city', 'pop')]

cities[ , 'pop']

mean(cities[, 'pop'])
cities$pop

mean(cities$pop)

paste0("tz_", cities$tz)
cities$tz <- paste0("tz_", cities$tz)
cities
cities[1:3, c(2, 4)]

# - principle
cities[c(1, 2, 3), c(2, 4)]

cities[cities$pop > 1.5, c(2, 4)]

# - find a column by a name
colnames(cities)
cities[ , grepl("^pop", colnames(cities))]

# built-in data.frame to practice: mtcars
data(mtcars)
print(mtcars)
dim(mtcars)

head(mtcars, 2)
tail(mtcars, 5)

colnames(mtcars)

colnames(mtcars)[1]
rownames(mtcars)

mtcars[1:2, c('mpg', 'wt')]

mtcars[1:10, c('hp', 'gear')]

class(mtcars[, 'hp'])
class(mtcars[, c('hp', 'gear')])

mean(mtcars[, 'gear'])

mtcars$mpg
mean(mtcars$mpg)

paste0("tz_", mtcars$carb) # implicit type conversion

mtcars$carb <- paste0("carb_", mtcars$carb)
mtcars
mtcars[1:3, c(2, 4)]
# - principle
mtcars[c(1, 2, 3), c(2, 4)]
mtcars[mtcars$hp > 100, c(2, 4)]
# - find a column by a name
colnames(mtcars)
mtcars[, grepl("gear", colnames(mtcars))]
sd(mtcars[, grepl("gear", colnames(mtcars))])


nasa_lista <- list(grad = list(ime = "Beograd",
                               populacija = "1.4M"),
                   drzava = list(ime = "Srbija",
                                 populacija = "6.9M"))
nasa_lista$drzava$populacija
nasa_lista$drzava$ime

nasa_lista[[1]]$populacija

m = matrix(1:20, 
           nrow=4)

m = apply(m, 1, median)

m

### ------------------------------------------
### --- Control Flow
### ------------------------------------------

# - data_dir
data_dir <- paste0(getwd(), "/_data/")

# - elementary, dear Watson:
for (a in 1:10) print(a)

# - code blocks
for (i in 1:100) {
  print(sqrt(i))
}

# - function call in iterations
cities <- c('NYC', 'Belgrade', 'Rome', 'Berlin')
for (x in 1:length(cities)) {
  print(
    paste0("This is a large city: ", 
           cities[x])
  )
}

# - when to use for loops, and when not
numbers <- numeric()
for (i in 1:100) {
  numbers[i] <- i
}

# - it's a vectorized language, right?
numbers <- 1:100

# - look:
lF <- list.files(data_dir)
lF <- lF[grepl("data_chunk", lF)]
data_set <- lapply(paste0(data_dir, lF),
                   read.csv, header = T, stringsAsFactors = F)
data_set[[1]]
data_set[[2]]

# - slow with for loop:
# - list files
lF <- list.files(data_dir)
lF <- lF[grepl("data_chunk", lF)]
print(lF)
data_set <- list()
# - iterate:
for (i in 1:length(lF)) {
  data_set[[i]] <- read.csv(paste0(data_dir, lF[i]), 
                            header = T, 
                            stringsAsFactors = F)
}
data_set[[2]]

# - faster, if you plan the size of your
# - data structures:
# - list files
lF <- list.files(data_dir)
lF <- lF[grepl("data_chunk", lF)]
# - how many files?
num_files <- length(lF)
# - prepare a list to store the dataframes
data_set <- vector(mode = "list", length = num_files)
# - iterate:
for (i in 1:num_files) {
  data_set[[i]] <- read.csv(paste0(data_dir, lF[i]), 
                            header = T, 
                            stringsAsFactors = F)
}
data_set[[1]]

# - put them together w. functional Reduce()
data_set <- Reduce(rbind, data_set)

# - plan the size of your data structures
emptyList <- vector(mode = "list", length = 4)
emptyList

# - more loops: while
counter <- 0
while (counter <= 100) {
  counter <- counter + 1
  if (counter %% 10 == 0) {
    print(counter)
  }
}

a <- 1
repeat {
  a <- a + 1
  print(a)
  
  if (a > 90) break
}

# - decisions
num_rows <- dim(data_set)[1]
if (num_rows >= 10000) {
  print("data_set have more than 10,000 rows!")
} else {
  print("data_set is a very small dataset.")
}

# - nesting decisions
num_rows <- dim(data_set)[1]
num_cols <- dim(data_set)[2]
if (num_rows >= 100) {
  print("data_set have more than 100 rows!")
  if (num_cols > 10) {
    print("And it has more than ten columns!")
  } else {
    print("But it has less than ten columns!")
  }
} else {
  print("data_set is a very small dataset.")
  if (num_cols > 10) {
    print("And it has more than ten columns!")
  } else {
    print("But it has less than ten columns!")
  }
}

# - chain if... else
this_number <- 11
if (this_number > 10) {
  print("This number is less than ten...")
} else if (this_number < 5) {
  print("This number is less than five.")
}

# - switch
this_animal <- "dog"
switch(this_animal,
       "dog" = "It's a dog!",
       "elephant" = "It's an elephant!", 
       "cat" = "Meow!", 
       "tiger" = "A tiger? In Africa?")
this_animal <- 'cat'
switch(this_animal,
       dog = "It's a dog!",
       elephant = "It's an elephant!", 
       cat = "Meow!", 
       tiger = "A tiger? In Africa?")

# - code blocks in switch
some_expression = 'hey'
switch(some_expression, 
       hey = { 
         print(2 + 2)
         print('Hey!') 
       },
       hi = { 
         print(5 + 5)
         print('Hi!')
       },
       {
         print(6 * 3)
         print('Default case!')
       }
)

# - vectorized ifelse
ifelse(10 < 5, 
       "I do not understand basic arithmetics.", 
       "Ok I got at least that one right."
)
trues <- sample(c(TRUE, FALSE), 100, replace = TRUE)
print(trues)
ifelse(trues,
       print("Yes"),
       print("No")
)

rand_a <- runif(100, 0, 1)
ifelse(rand_a > .5, TRUE, FALSE)

### --- functional programming
# - functionals in R

# - lapply()
cities <- c("Paris", "Rome", "NYC", "Moscow", "Tokyo")
lapply(cities, function(x) {
  return(
    paste0("A big city: ", x)
  )
})
big_cities <- lapply(cities, function(x) {
  return(
    paste0("A big city: ", x)
  )
})
class(big_cities)
big_cities <- unlist(big_cities)
big_cities

# - or use sapply() instead:
sapply(cities, function(x) {
  return(
    paste0("A big city: ", x)
  )
})
big_cities <- sapply(cities, function(x) {
  return(
    paste0("A big city: ", x)
  )
})
class(big_cities)
big_cities
names(big_cities)
big_cities <- unname(big_cities)
big_cities

# - mapply
a <- 1:10
b <- 11:20
mapply("+", a, b)

v1 <- c(1, 2, 3, 4, 5)
v2 <- c(2, 4, 1, 2, 10)
mapply(max, v1, v2)

# - mapply() is to Map() what sapply() is to lapply()
Map(max, v1, v2)

# - apply, for matrices
mat <- matrix(1:9, nrow = 3)
print(mat)
apply(mat, 1, mean)
apply(mat, 2, var)

mat <- matrix(c(3, 1, 9, 3, 4, 1, 0, 0, 9), 
              ncol = 3)

# - Reduce
Reduce("+", 1:6)
Reduce("+", 1:6, accumulate = TRUE)

# - lapply() + Reduce()
data_dir <- paste0(getwd(), "/_data/")
lF <- list.files(data_dir)
lF <- lF[grepl("data_chunk", lF)]
lF

# - read all with lapply():
data <- lapply(lF, function(x) {
  read.csv(paste0(data_dir, x), 
           header = TRUE,
           check.names = FALSE,
           row.names = 1,
           stringsAsFactors = FALSE)
})
data[[1]]
data[[2]]
dataset <- Reduce(rbind, data)


### ------------------------------------------
### --- Tidyverse!
### ------------------------------------------

# install.packages("tidyverse")
library(tidyverse)

# - read listings.csv.gz for AirBnB
# - from: http://insideairbnb.com/get-the-data/
data_url <- 
  "http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2022-03-08/data/listings.csv.gz"
con <- gzcon(url(data_url))
txt <- readLines(con)
data_set <- read.csv(textConnection(txt))

str(data_set)

glimpse(data_set)

# - select
data_subset <- dplyr::select(data_set,
                             id,
                             name,
                             host_response_time)
table(data_subset$host_response_time)

data_set$host_response_time[data_set$host_response_time=="N/A"] <- NA

data_subset <- select(data_set, 
                      id, 
                      name, 
                      host_response_time)
table(data_subset$host_response_time)

hrt_table <- as.data.frame(
  table(data_subset$host_response_time)
)

hrt_table <- as.data.frame(
  table(data_set$host_response_time,
        data_set$host_is_superhost)
)

data_subset <- dplyr::select(data_set,
                             id,
                             name,
                             host_response_time)
data_subset <- dplyr::filter(data_subset,
                             host_response_time == "within an hour")
data_subset$host_response_time <- NULL

# pipe operator: %>% 
data_subset <- select(data_set, 
                      id, 
                      name, 
                      host_response_time) %>%
  filter(host_response_time == "within an hour")

data_subset <- data_set %>% 
  select(id,
         name,
         host_response_time) %>%
  filter(host_response_time == "within an hour")

# group_by and summarise
data_subset <- data_set %>% 
  select(host_response_time) %>%
  group_by(host_response_time) %>% 
  summarise(count = n())

data_subset <- data_set %>% 
  select(host_response_time, host_is_superhost) %>%
  group_by(host_response_time, host_is_superhost) %>% 
  summarise(count = n())

data_subset <- data_set %>% 
  select(host_response_time, host_is_superhost) %>%
  filter(!is.na(host_response_time) & !is.na(host_is_superhost)) %>% 
  group_by(host_response_time, host_is_superhost) %>% 
  summarise(count = n()) %>% 
  arrange(host_is_superhost, host_response_time)

# - {ggplot2} Intro

ggplot(data_subset, 
       aes(x = host_response_time, 
           y = count, 
           fill = host_is_superhost,
           color = host_is_superhost, 
           group = host_is_superhost)) +
  geom_point() + geom_path() + 
  ggtitle("AirBnB Hosts") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90)) + 
  theme(panel.border = element_blank()) + 
  theme(plot.title = element_text(hjust = .5))


data_subset <- data_set %>% 
  select(host_response_time, host_is_superhost) %>%
  filter(!is.na(host_response_time) & !is.na(host_is_superhost)) %>% 
  group_by(host_response_time, host_is_superhost) %>% 
  summarise(count = n()) %>% 
  group_by(host_is_superhost) %>% 
  mutate(percent = count/sum(count)*100) %>% 
  arrange(host_is_superhost, host_response_time)

ggplot(data_subset, 
       aes(x = host_response_time, 
           y = percent, 
           fill = host_is_superhost,
           color = host_is_superhost, 
           group = host_is_superhost)) +
  geom_point() + geom_path() + 
  ggtitle("AirBnB Hosts") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90)) + 
  theme(panel.border = element_blank()) + 
  theme(plot.title = element_text(hjust = .5))

