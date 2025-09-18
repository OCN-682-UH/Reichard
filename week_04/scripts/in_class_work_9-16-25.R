## In class work 9/16/2025 ##
##Jake Reichard ##
## Date: 9/16/2025 ##

##Load libraries ##
library(palmerpenguins)
library(tidyverse)
library(here)

#look at data
glimpse(penguins)

data <- penguins # asign dataframe

## data analysis
filter(data, sex =="female")

#filter by the year 2008
filter(data, year == 2008)

#filter by penguins that are greater than 5,000g
filter(data, body_mass_g > 5000)

#collected either 2008 or 2009
filter(data, year == 2008 | year == 2009)

#are not from island of Dream
filter(data, island != "Dream")

#species adelie and gentoo
filter(data, species %in% c("Adelie", "Gentoo"))

#make new column for kg
data2 <- mutate(data, 
                body_mass_kg = body_mass_g/1000,
                bill_length_depth_mm = bill_length_mm/bill_depth_mm)

View(data2)

#create new column to add flipper length and body mass together
data3 <- mutate(data,
                flipper_length_body_mass = flipper_length_mm + body_mass_g)

#mutate and ifelse a new column where body mass is greater than 4000 is big
data4 <- mutate(data,
       big_or_small = ifelse(body_mass_g > 4000,"big","small"))

#calculate mean
penguins %>% 
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=T))

#mean and max bill length by island
penguins %>% 
  group_by(island) %>% 
  summarise(mean_bill_length = mean(bill_length_mm, na.rm =T),
            mean_bill_depth = mean(bill_depth_mm, na.rm=T))
#remove NA data for sex
penguins %>% 
  drop_na(sex) %>% 
  ggplot(aes(x= sex, y= flipper_length_mm))+
  geom_boxplot()
