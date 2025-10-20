library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate) #animation
library(magick) #for images
library(palmerpenguins)

#plot 1
p1 <- penguins %>% 
  ggplot(aes(x= body_mass_g, y = bill_length_mm, color = species))+
  geom_point()

p2 <- penguins %>% 
  ggplot(aes( x= sex, y= body_mass_g, color = species)) +
  geom_jitter( width = 0.2)
p2

#using patchwork you just add two plots together
p1 + p2

#group the legends
p1 + p2 +
  plot_layout(guides = "collect")+
  plot_annotation(tag_levels = "A")

#top and bottom layout
p1/p2 +
  plot_layout(guides = "collect")+
  plot_annotation(tag_levels = "A")

view(mtcars)

ggplot(mtcars, aes(x = wt, y = mpg, label = rownames(mtcars)))+
  geom_text_repel() + #creates a text label at the xy point and make sure they don't overlap
  #geom_label_repel() #makes a box around the label 
  geom_point(color = "red")


#animation
animation <- penguins %>% 
  ggplot(aes(x= body_mass_g, y = bill_length_mm, color = species))+
  geom_point()+
  transition_states(
    year, #what you are animating by
    transition_length = 2, #how long for each transiton (seconds)
    state_length = 1 ) + #how long of a pause at each state
  ease_aes("sine-in-out") + #how it moves from one state to another, linear is default
  labs(title = "Year: {closest_state}") # year label won't change, {} is what will change in each state.
  anim_save(here("week_08","outputs","penguins_animation.gif"), animation)
  
#advanced image processing
penplot <- image_read("week_08","data","download.jpg")
  
pengplot <- penguins %>% 
  ggplot(aes(x= body_mass_g, y = bill_length_mm, color = species))+
  geom_point()

ggsave(here("week_08","outputs","penguinplot.png"),pengplot)

#have to load in pictures before putting together
penplot <- image_read(here("week_08", "outputs", "penguinplot.png"))
penimage <- image_read(here("week_08","data","download.jpg"))

out <- image_composite(penplot, penimage, offset = "+70 + 30")
out
