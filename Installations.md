# Installations

## 0. Prerequisits.

You have your machine in front of you, and that machine is running any of the following operative systems:

- Windows 10 (later versions are fine too)
- Linux Ubuntu/Debian
- macOS

## 1. Install R

In case of any problems during the installation of R and RStudio, get in touch with Goran S. Milovanovic on Slack.

**NOTE.** Please take care to install **the latest available versions**. At the time of this writing, those were:

- Programming language R: R-4.3.0, available [here for Windows](https://cran.r-project.org/bin/windows/base/), [here for Mac](https://cran.r-project.org/bin/macosx/), and [here for Linux](https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html).
- RStudio Desktop: RStudio Desktop version 2023.03.0+386, available [here](https://posit.co/download/rstudio-desktop/).
- Please follow the instructions provided here:

[Earth Data Analytics Online Certificate, Lesson 1. Install & Set Up R and RStudio on Your Computer](https://www.earthdatascience.org/courses/earth-analytics/document-your-science/setup-r-rstudio/)

Essentially, there are two installation steps:

- install R (the programming language)
- install RStudio (your IDE, i.e. your working environment, where you write code, inspect data, etc.)

- For Windows users: [Video Instructions](https://www.youtube.com/watch?v=9-RrkJQQYqY)
- For Mac users: [Video Instructions](https://www.youtube.com/watch?v=Y20P3u3c_1c)
- For Linux users:
   - [Install R Instructions](https://www.digitalocean.com/community/tutorials/how-to-install-r-on-ubuntu-18-04-quickstart)
   - [Install RStudio Instructions](https://linuxconfig.org/how-to-install-rstudio-on-ubuntu-20-04-focal-fossa-linux)

## 2. Organization

It is of essential importance to keep your files and folders neatly organized. 

That is not important only to be able to follow this course: all successful Data Scientists suffer a bit from something similar to OCD (Obsessive compulsive disorder) when it comes to organizing their data and code into directories and code repositories.

For each new step that I make in Data Science, for each new project, my approach to organization is the following:

I start a new directory which bears the project name (NOTE. Avoid using empty spaces, " ", in naming your files and directories!);
In that directory, I make three new directories:

- `_data` - where I intend to keep the raw data,
- `_analytics` - where I intend to keep the processed data,
- `_results` - where I intend to keep the outputs of my work, and
- `_img` - where I intend to keep any images that were produced in the course of my work in the project.

I suggest that, at least in the beginning, you use the same schema to organize your directories. Later on you can decide upon the exact form of organization that you find to be most suitable to you.

**Working with RStudio projects**

Seriously, all code should be kept under RStudio projects.

This [video](https://www.youtube.com/watch?v=WyrJmJWgPiU) explains how to start and maintain a project under RStudio Dekstop. 

**R Packages**

Once done with the installations, please open your RStudio Desktop, and in the console type:

`install.packages("tidyverse")`

`install.packages("ggrepel")`

`install.packages("glmnet")`


That will bring some important R packages to your R installation.