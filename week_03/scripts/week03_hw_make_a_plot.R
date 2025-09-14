## Plotting penguin data ##
## Created by Jake Reichard ##
## Updated 9/13/2025

## Load Libraries ##

library(palmerpenguins)
library(tidyverse)
library(here)

## Look at the data ##
glimpse(penguins)

## plotting data ##

ggplot(data = penguins, 
       mapping =aes(x= species, 
                    y=bill_length_mm, 
                    fill=species))+ #assigning data to axes
    geom_violin(alpha = 0.2)+ #making a violin plot that is transparent 
    geom_boxplot( alpha= 0.5, width=0.1)+ #box plot within violin to show distribution
    
    theme_bw()+ #makes the background white
    scale_fill_viridis_d()+ #makes the fill colorblind friendly
    scale_color_viridis_d()+ #makes the outline color colorblind friendly
    
    coord_flip()+ #flip axes to make it easier to read
    
    scale_y_continuous(breaks = seq(20,60,10))+ #create the breaks for y axis
  
    theme(legend.position = "none", #removed the legend
        plot.title = element_text(size = 18))+ #make the title bigger 
  
  #Editing labels for the figure
  labs(x = "Species",
       caption = "Data Source: Palmer Penguins Package", #identify data source
       y = "Bill Length (mm)",
       title = expression(bold("Bill length across three penguis species")), #bold the text 
       subtitle = "Across three island: Biscoe, Dream, Torgersen")

## exporting data as PNG file ##

ggsave(here("week_03","outputs", "week03_hw_bill_L_by_species.png"), #telling it where to save
            width = 7, height = 5) #size in inches
  
