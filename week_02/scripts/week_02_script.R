### This is my first script. I am learning how to import data
## Created by: Jake Reichard
## created on September 7th 2025
######################################################

###Libraries###

library(tidyverse)
library(here)

### Read in data
weight_data<- read.csv(here("week_02","data","weightdata.csv"))

### data analysis ###
head(weight_data) # Looks at the top 6 lines of dataframe
tail(weight_data) # Looks at the bottom 6 lines
view(weight_data) # Looks at the whole dateframe
