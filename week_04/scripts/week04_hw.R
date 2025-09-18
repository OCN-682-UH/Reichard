## Week 4 Homework ##
## Created by:Jake Reichard ##
## Last updated 9/17/2025 ##

## Load Libraries ##
library(palmerpenguins)
library(tidyverse)
library(NatParksPalettes) #colors based on National parks
library(here)


#look at data#
glimpse(penguins)

##Data analysis##

##Part 1##

# Mean of body mass without any NA by species
bm_species<- penguins %>% 
             group_by(species) %>% #group by species
             summarise(mean_body_mass = mean(body_mass_g, na.rm =T),  #name of new column (mean_body_mass) that is calculating the mean and removing na 
                        variance_body_mass = var(body_mass_g, na.rm=T)) #name of new column (variance_body_mass) that is calculating the variance and removing na

#mean of body mass without any NA by island
bm_island <- penguins %>% 
              group_by(island) %>%  #group by island
              summarise(mean_body_mass = mean(body_mass_g, na.rm =T),  #name of new column (mean_body_mass) that is calculating the mean and removing na 
                        variance_body_mass = var(body_mass_g, na.rm=T)) #name of new column (variance_body_mass) that is calculating the variance and removing na

#mean of body mass without NA by sex
bm_sex <- penguins %>%
          drop_na(sex) %>% #drop all na values in the sex column
          group_by(sex) %>% #group by sex
            summarise(mean_body_mass = mean(body_mass_g, na.rm =T),  #name of new column (mean_body_mass) that is calculating the mean and removing na
                      variance_body_mass = var(body_mass_g, na.rm=T)) #name of new column (variance_body_mass) that is calculating the variance and removing na

# Question 2

#log the biomass
log_pen <- penguins %>% 
  drop_na(sex) %>%  #drop all na values in the sex column
  filter(sex == "female") %>% #filter rows that only have female
  mutate(log_body_mass = log(body_mass_g)) %>% #create new column called and calculate log body_mass_g
  select(species,island,sex,log_body_mass) # select the columns speceis, sex, and log_body_mass


#plot the data
ggplot(log_pen, aes(x=species, y=log_body_mass, fill = species))+ 
  geom_boxplot(alpha = 0.6)+    #boxplot   
  scale_fill_manual(values = natparks.pals("Yellowstone", 3))+ # Use National park palette Yellowstone 
  geom_jitter(color= "black", size = 0.6)+ #plot raw data to show spread
  
  #edit figure theme
  theme_bw()+         #makes the background white
  theme(legend.position = "none",    #removes legend
        plot.title = element_text(size = 18))+
  
  #edit labels
  labs( x= "Penguin Species",
        y = "log body mass (g)",
        title = "Female Penguin Body Mass by Species",
        subtitle = "Body mass was logged",
        caption = " Data Source: Palmer Penguins")

#save plot
ggsave(here("week_04","outputs","week_04_hw_log_body_mass.jpg"),#where it will be saved
            width = 7, height = 5) #size in inches

