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
  getwd(), 
  "/_analytics/"
)
reporting_dir <- paste0(getwd(), "/_reporting/")
img_dir <- paste0(getwd(), "/_img/")

# - note: always use RStudio projects!
list.files(getwd())
list.files()

list.files(data_dir)

### ---------------------------------------------------------
### --- Chi-Square Distribution and Test
### ---------------------------------------------------------

# - Theory: say X follows a Standard Normal Distribution N(0,1). 
# - Take k = 3 such variables, square them, sum up the squares, 
# - and repeat the experiment 100,000 times.

stdNormals3 <- sapply(seq(1, 100000), function(x) {
  sum((rnorm(3, mean = 1, sd = 1))^2)
})

# - Q: How are these sums of standard normal distributions distributed?
# set plot parameters
hist(stdNormals3, 50, main = "k = 3",
     xlab = "Sums of squared Gaussians",
     ylab = "Frequency",
     col = "steelblue")

# - Repeat for k = 30:
stdNormals30 <- sapply(seq(1,100000), function(x) {
  sum((rnorm(30, mean = 1, sd = 1))^2)
})
hist(stdNormals30, 50, main = "k = 30",
     xlab = "Sums of squared Gaussians",
     ylab = "Frequency",
     col = "steelblue")

# - Here it is: 
# - the sum of squared IID random variables - each of them distributed as 
# - N(0,1) - follows a Chi-Square distribution.

par(mfrow = c(1, 2))
curve(dchisq(x, 3), 
      from = 0, to = 40, 
      main = "k = 3", 
      col = "blue",
      xlab = "x", ylab = "Density")
curve(dchisq(x, 30), 
      from = 0, to = 120, 
      main = "k = 30", 
      col = "blue",
      xlab = "x", ylab = "Density")

# - The Chi-Square test
n <- 100

# Step 1: Population parameters (probabilities)
populationP <- c(.5, .3, .2)
expectedCounts <- n * populationP
expectedCounts

# Step 2: Sampling
# random draw from a multinomial distribution of three events:
sample <- as.numeric(rmultinom(1, 100, prob = populationP))
sample
# Step 3: Chi-Square Statistic:
chiSq <- sum(((sample - expectedCounts)^2)/expectedCounts)
print(paste0("The chi-Square statistic is: ", chiSq))
df <- 3 - 1 # k == 3 == number of events
print(paste0("Degrees of freedom: ", df))
sig <- pchisq(chiSq, df, lower.tail = F) # upper tail
print(paste0("Type I Error probability is: ", sig))
print(paste0("Type I Error < .05: ", sig < .05))

# random draw from a multinomial distribution of three events:
populationP <- c(.3, .3, .4)
sample <- as.numeric(rmultinom(1, 100, prob = populationP))
sample

# Step 3: Chi-Square Statistic:
expectedCounts <- populationP * 100
chiSq <- sum(((sample - expectedCounts)^2)/expectedCounts)
print(paste0("The chi-Square statistic is: ", chiSq))
df <- 3 - 1 # k == 3 == number of events
print(paste0("Degrees of freedom: ", df))
sig <- pchisq(chiSq, df, lower.tail = F) # upper tail
print(paste0("Type I Error probability is: ", sig))
print(paste0("Type I Error < .05: ", sig < .05))

# R chisq.test() function
chisq.test(x = sample, 
           y = populationP)


### ---------------------------------------------------------
### --- t-test
### ---------------------------------------------------------

### --- NOTEBOOK rstats101_session04_ttest.html

### ---------------------------------------------------------
### --- Exploratory Data Analysis (EDA)
### ---------------------------------------------------------

# - data: mtcars
data(mtcars)
head(mtcars)

# - dimensionality:
print(paste0("mtcars has ", 
             dim(mtcars)[1], 
             " rows and ", 
             dim(mtcars)[2], 
             " columns."))

# - basic statistics
summary(mtcars)
mean(mtcars$qsec)
median(mtcars$qsec)
min(mtcars$qsec)
max(mtcars$qsec)

# - range
range(mtcars$qsec)
rangeQsec <- abs(Reduce("-", range(mtcars$qsec)))
print(rangeQsec)

quantile(mtcars$qsec, probs = .25)
quantile(mtcars$qsec, probs = c(.25, .5, .75))

# - boxplot
boxplot(mtcars$qsec,
        horizontal = TRUE, 
        xlab="qsec",
        col = "darkorange",
        main = "Boxplot: qsec")

# - The thick line in the box stands where the median of the mtcars$qsec 
# - is found. The box is bounded by Q1 (25%) from the left and Q3 (75%) 
# - from the right. The width of the box thus equates the IQR - 
# - Interquartile Range - which is the difference between Q3 and Q1: 
# - IQR = Q3 - Q1. What about the length of the whiskers, and why is there 
# - that lonely point to the right marked? That needs some discussion:

## NOTE: Boxplot "fences" and outlier detection
## -----------------------------------------
# Boxplot in R recognizes as outliers those data points that are found beyond OUTTER fences
# Source: http://www.itl.nist.gov/div898/handbook/prc/section1/prc16.htm
# Q3 = 75 percentile, Q1 = 25 percentile
Q3 <- quantile(mtcars$qsec, .75)
Q3

Q1 <- quantile(mtcars$qsec, .25)
Q1

# IQ = Q3 - Q1; Interquartile range
IQR <- unname(Q3 - Q1)
IQR

# - The definitions of the fences used in R are:

# - Lower inner fence: Q1 - 1.5*IQR
# - Upper inner fence: Q3 + 1.5*IQR
# - Lower outer fence: Q1 - 3*IQR
# - Upper outer fence: Q3 + 3*IQR
# - A point beyond an inner fence on either side is considered a mild outlier
# - A point beyond an outer fence is considered an extreme outlier
# - Now, let’s find out about the outlier to the right of the boxplot’s 
# - whiskers in our plot:

lif <- Q1 - 1.5*IQR
uif <- Q3 + 1.5*IQR
lof <- Q1 - 3*IQR
uof <- Q3 + 3*IQR
mtcars$qsec[mtcars$qsec > uif]

mtcars$qsec[mtcars$qsec > uof]

boxplot(mtcars[ , c('mpg', 'disp', 'hp', 'drat', 'wt', 'qsec')], 
        horizontal = FALSE, 
        xlab="qsec",
        ylab = "value",
        col = "darkorange",
        main = "Boxplot: qsec")

# - But the variables seem to be on different scales. 
# - What can often help in situations like this one is to 
# - use logarithmic scaling:

boxplot(mtcars[ , c('mpg', 'disp', 'hp', 'drat', 'wt', 'qsec')], 
        horizontal = FALSE, 
        xlab="qsec",
        ylab = "log(value)",
        log = "y",
        col = "indianred",
        main = "Boxplot: qsec")

# - While even base R offers great means to visualize data, 
# - {ggplot2} is the industrial standard data visualization 
# - package and it is definitely way, way better. We will now 
# - begin our study of the anatomy of a ggplot2 plot using our boxplot as an example.

# - In order to produce a boxplot with ggplot2, mtcars first need to be 
# - transformed from the wide data representation format into a long data 
# - representation format:

mtcars$id <- 1:dim(mtcars)[1]
mtcarsPlot <- mtcars %>%
  select(id, mpg, disp, hp, drat, wt, qsec) %>% 
  pivot_longer(cols = -id,
               names_to = "Measurement",
               values_to = "Value")
head(mtcarsPlot, 30)

# - ggplot2 boxplot
ggplot(data = mtcarsPlot, 
       aes(x = Measurement, 
           y = Value, 
           fill = Measurement)) + 
  geom_boxplot() + 
  ggtitle("mtcars boxplot") + 
  theme_bw() + 
  theme(panel.border = element_blank()) + 
  theme(plot.title = element_text(hjust = .5))

# - ggplot2 scatterplot
ggplot(data = mtcars, 
       aes(x = hp, 
           y = qsec)) + 
  geom_point(size = 2, color = "cadetblue3") +
  ggtitle("mtcars: hp vs. qsec") + 
  theme(panel.border = element_blank()) + 
  theme(plot.title = element_text(hjust = .5))

# - ggplot2 scatterplot + regression line
ggplot(data = mtcars, 
       aes(x = hp, 
           y = qsec)) + 
  geom_smooth(method = "lm", size = .25, color = "cadetblue3") + 
  geom_point(size = 2, color = "cadetblue3") +
  ggtitle("mtcars: hp vs. qsec") + 
  theme(panel.border = element_blank()) + 
  theme(plot.title = element_text(hjust = .5))

# - # - ggplot2 scatterplot + regression line + labels
mtcarsPlot <- mtcars %>% 
  select(hp, qsec)
mtcarsPlot$label <- paste0("(", 
                           mtcarsPlot$hp, ", ", 
                           mtcarsPlot$qsec, 
                           ")")
ggplot(data = mtcarsPlot, 
       aes(x = hp, 
           y = qsec, 
           label = label)) + 
  geom_smooth(method = "lm", size = .25, color = "cadetblue3") + 
  geom_point(size = 2, color = "cadetblue3") +
  geom_text(size = 2) + 
  ggtitle("mtcars: hp vs. qsec") + 
  theme(panel.border = element_blank()) + 
  theme(plot.title = element_text(hjust = .5))

# - ggrepel for labels
library(ggrepel)
mtcarsPlot <- mtcars %>% 
  select(hp, qsec)
mtcarsPlot$label <- paste0("(", 
                           mtcarsPlot$hp, ", ", 
                           mtcarsPlot$qsec, 
                           ")")
ggplot(data = mtcarsPlot, 
       aes(x = hp, 
           y = qsec, 
           label = label)) + 
  geom_smooth(method = "lm", size = .25, color = "cadetblue3") + 
  geom_point(size = 1.5, color = "cadetblue3") +
  geom_text_repel(size = 2) + 
  ggtitle("mtcars: hp vs. qsec") + 
  theme(panel.border = element_blank()) + 
  theme(plot.title = element_text(hjust = .5))

# - Distributions and histograms
mtcarsPlot <- mtcars %>% 
  select(cyl) %>% 
  group_by(cyl) %>% 
  summarise(count = n())
mtcarsPlot

ggplot(data = mtcarsPlot, 
       aes(x = cyl, 
           y = count)) + 
  geom_bar(stat = "identity", fill = "cadetblue4", width = .5) + 
  ggtitle("Number of cylinders across the models found in mtcars") +
  theme(panel.border = element_blank()) + 
  theme(plot.title = element_text(hjust = .5))

# - continuous case (probability density)
ggplot(mtcars, 
       aes(x = hp, 
           fill = cyl, 
           group = cyl)) + 
  geom_density(alpha = .15, color = "black") + 
  ggtitle("Distrubutions of hp across cyl") + 
  xlab('hp') + 
  ylab('Density') + 
  theme_bw() + 
  theme(panel.border = element_blank()) +
  theme(plot.title = element_text(hjust = .5))

mtcars$cyl <- as.factor(mtcars$cyl)
ggplot(mtcars, 
       aes(x = hp, 
           fill = cyl, 
           group = cyl)) + 
  geom_density(alpha = .15, color = "black") + 
  ggtitle("Distrubutions of hp across cyl") + 
  xlab('hp') + 
  ylab('Density') + 
  theme_bw() + 
  theme(panel.border = element_blank()) +
  theme(plot.title = element_text(hjust = .5))

ggplot(mtcars, 
       aes(x = hp)) + 
  geom_density(alpha = .15, color = "black", fill = "darkorange") + 
  ggtitle("Distrubution of hp in mtcars") + 
  xlab('hp') + 
  ylab('Density') + 
  theme_bw() + 
  theme(panel.border = element_blank()) +
  theme(plot.title = element_text(hjust = .5))

# - Cross-Tabulations and Aggregations
distribution <- 
  mtcars %>% 
  select(cyl, gear, qsec) %>% 
  group_by(cyl, gear) %>% 
  summarise(meanQsec = mean(qsec))
print(distribution)

ggplot(distribution, 
       aes(x = cyl, 
           y = gear, 
           size = meanQsec, 
           label = meanQsec)) + 
  geom_point(color = "cadetblue3") +
  ggtitle("Mean qsec across cyl and gear in mtcars") + 
  geom_text_repel(size = 3) + 
  theme_bw() + 
  theme(panel.border = element_blank()) +
  theme(plot.title = element_text(hjust = .5))

ggplot(distribution, 
       aes(x = gear, 
           y = meanQsec, 
           label = meanQsec)) + 
  geom_bar(stat = "identity", 
           color = "black", 
           fill = "darkorange") +
  facet_wrap(~cyl) + 
  ggtitle("Mean qsec across cyl and gear in mtcars") + 
  geom_text_repel(size = 3) + 
  theme_bw() + 
  theme(panel.border = element_blank()) +
  theme(plot.title = element_text(hjust = .5))

# - Checking if a variable has a normal distribution
data(iris)
# The Kolmogorov-Smirnov Test
ksSLength <- ks.test(iris$Sepal.Length,
                     "pnorm",
                     mean(iris$Sepal.Length),
                     sd(iris$Sepal.Length),
                     alternative = "two.sided",
                     exact = NULL)

ksSLength

ggplot(iris,
       aes(x = Sepal.Length)) + 
  geom_histogram(binwidth = .25, fill = "darkorange", color = "black") + 
  theme_bw() + 
  theme(panel.border = element_blank())

swPLength <- shapiro.test(iris$Sepal.Length)
swPLength

qqnorm(iris$Sepal.Length, pch = 1, frame = FALSE)
qqline(iris$Sepal.Length, col = "darkblue", lwd = 2)


