## Plotting penguin data ##
## Created by Jake Reichard ##
## Updated 9/13/2025

# Load Libraries ##

library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce) #color pallete that is beyonce based
library(ggthemes) #custom themes for graphing

#load data, this data is part of the package "penguins"

glimpse(penguins)

# could also look at it this way

str(penguins)
head(penguins)
tail(penguins)

## data analysis section ##

ggplot(data = penguins,
       mapping = aes(x=bill_depth_mm,
                     y=bill_length_mm))+
  geom_point()+
  geom_smooth(method = "lm")+ #adds a linear regression line
  labs(x= "Bill depth (mm)",
       y= "Bill length (mm)")

#group by species

ggplot(data = penguins,
       mapping = aes(x=bill_depth_mm,
                     y=bill_length_mm,
                     group = species,
                     colour = species))+ #group by species and add color to it
  geom_point()+
  geom_smooth(method = "lm")+ #adds a linear regression line
  labs(x= "Bill depth (mm)",
       y= "Bill length (mm)")+
  scale_color_viridis_d()

#playing with the scale

ggplot(data = penguins,
       mapping = aes(x=bill_depth_mm,
                     y=bill_length_mm,
                     group = species,
                     colour = species))+ #group by species and add color to it
  geom_point()+
  geom_smooth(method = "lm")+ #adds a linear regression line
  labs(x= "Bill depth (mm)",
       y= "Bill length (mm)")+
  scale_color_viridis_d()+
  scale_x_continuous(breaks = c(14,17,21), #makes it so that the x axis shows 14, 17, 21
                     labels = c("low","medium", "high"))+#add labels to the specific breaks
  scale_color_manual(values = beyonce_palette(29)) #manually set the colors

#flip axes

ggplot(data = penguins,
       mapping = aes(x=bill_depth_mm,
                     y=bill_length_mm,
                     group = species,
                     colour = species))+ #group by species and add color to it
  geom_point()+
  geom_smooth(method = "lm")+ #adds a linear regression line
  labs(x= "Bill depth (mm)",
       y= "Bill length (mm)")+
  scale_color_viridis_d()+
  scale_x_continuous(breaks = c(14,17,21), #makes it so that the x axis shows 14, 17, 21
                     labels = c("low","medium", "high"))+#add labels to the specific breaks
  scale_color_manual(values = beyonce_palette(2))+ #manually set the colors
  #coord_flip() #flip x and y axes
  #coord_fixed() #fixes the aspect ratio to 1:1
  theme_bw() + #changes the theme to black and white (the background of the graph)
  theme(axis.title = element_text(size = 20, # makes the titles size 20
                                  color = "red"), #makes title red
        panel.background = element_rect(fill = "linen"))  #changes the background color
  
ggsave(here("week_03/outputs/","penguin.png"),
       width = 7, height = 5) #in inches

#theme_classic() #removes the lines in the background
#theme_wsj() #makes it look like the wall street journal

#log transform

ggplot(diamonds,aes(carat,price))+
  geom_point() +
  coord_trans(x = "log10", y = "log10") #logs the axes
