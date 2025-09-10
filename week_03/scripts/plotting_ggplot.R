### Week 3 Ploting data
### By: Jake Reichard
### Date:9/9/2025

#install data
install.packages("palmerpenguins")

#Load libraries
library(palmerpenguins)
library(tidyverse)
glimpse(penguins)

#plotting bill depth to bill length
ggplot(data=penguins, 
  mapping =  aes(x=bill_depth_mm, 
                 y=bill_length_mm, 
                 color=species,
                 shape = island))+ #anything that is directly related to data will be entered here
  
  geom_point()+ #puts the data points on the graph
  
  labs(title = "Bill depth and length", #chart title
       subtitle = "Dimensions for Adelle, Chinstrap, and Gentoo Penguins", #Chart sub title
       x= "Bill Depth in mm", #x axis title 
       y= "Bill Length in mm",#y axis title
       color= "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package")+ #add caption info
  scale_color_viridis_d() #makes it easier for colorblind people "d" is for discrete
