## In class work 9-23-25
##By: Jake Reichard

#Load libraries
library(tidyverse)
library(here)

#Load data
TPC_data <- read.csv(here("week_05","data","Topt_data.csv"))
EnviroData <- read.csv(here("week_05","data","site.characteristics.data.csv"))

#pivot wider to join data
EnviroData_wide <-EnviroData %>% 
  pivot_wider(names_from = parameter.measured,
              values_from = values)
#joining data
FullData_left <- left_join(TPC_data, EnviroData_wide) %>% 
relocate(where(is.numeric), .after = where(is.character))

#pivot longer
FullData_long <- FullData_left %>% 
  pivot_longer(cols = E:substrate.cover,
               names_to = "Parameters",
               values_to = "Values")
#calculate mean
FullData_summary <- FullData_long %>% 
  group_by(name,Parameters) %>% 
  
  summarise(Param_mean = mean(Values, na.rm = T),
            Param_var = var(Values, na.rm= T))  

#joins  
T1 <- tibble(Site.ID = c("A","B","C","D"),
             Temperature = c(14.1,16.7,15.3,12.8))
T2 <- tibble(Site.ID = c("A","B","D","E"),
             pH = c(7.3,7.8,8.1, 7.9))

left_join(T1, T2)  
right_join(T1,T2)
inner_join(T1,T2)
full_join(T1,T2)
semi_join(T1,T2)
#tells you what data is missing from the other df
anti_join(T1,T2)
