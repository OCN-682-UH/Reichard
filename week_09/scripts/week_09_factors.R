
#load libraries
library(tidyverse)
library(here)

#load data
income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')

glimpse(starwars)

star_counts <- starwars %>% 
  filter(!is.na(species)) %>% #remove NAs
  mutate(species = fct_lump(species, n=3)) %>% #if species is greater than 3 it will make it a factor if not it will be other
  count(species)


star_counts %>% 
  ggplot(aes(x = fct_reorder(species, n), y=n))+ #reorder the factor of species by n
  geom_col()

total_income <- income_mean %>% 
  group_by(year, income_quintile) %>% 
  summarise(income_dollars_sum = sum(income_dollars)) %>% 
  mutate(income_quintile = factor(income_quintile)) #make a factor

total_income %>% 
  ggplot(aes(x = year, income_dollars_sum, 
             color = fct_reorder2(income_quintile, year, income_dollars_sum)))+ #helps reorder so the ledgend makes sense,
           #will first look at year, then the end income dorllar sum.
  geom_line()+
    labs(color = "income quantile")

#set the specific order
x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec"))

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) %>%  # only keep species that have more than 3, keeps all the levels before filtering
droplevels() %>% #drop extra levels so it just shows the filter data
mutate(species = fct_recode(species, "Humanoid" = "Human")) #change the name of the levels