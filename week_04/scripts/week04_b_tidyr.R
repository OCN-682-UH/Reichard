## Practice with tidy with biogeochemistry data from Hawaii ##
## Created by: Jake Reichard ##
## Updated on: 2025-09-17 ##

## Load Libraries ##
library(tidyverse)
library(here)

## Load Data ##
ChemData <- read.csv(here("week_04","data","chemicaldata_maunalua.csv"))
view(ChemData)
glimpse(ChemData)

#filter out na
ChemData_clean <- ChemData %>% 
      filter(complete.cases(.)) %>% #filters out everything that is not a complete row 

#separate data within a column
separate(col = Tide_time, #select the column Tide_time to break apart
         into = c("Tide","Time"), #new columns will be called Tide and Time
         sep = "_",  #separate at the _
         remove = F) %>%  #keep the original column Tide_time

#combine two columns together
unite(col = "Site_ZOne", #makes a new column that combines two other ones
      c(Site,Zone), #the two columns in the df that will be united
      sep = "_", #the thing that will separate the two data inputs
      remove = F) #keep the original column

#pivot data
ChemData_long <- ChemData_clean %>% 
  pivot_longer(cols = Temp_in:percent_sgd, #the columns that will be pivoted. The ones you are selecting
               names_to = "Bio_geo_chem", #the name of the new column that will have all the column names
               values_to = "Values") #new name of the new column that will have the values from the pivoted columns

#Calculate mean and variance for all variables
ChemData_long %>% 
  group_by(Bio_geo_chem, Site,Zone,Tide) %>%  #group by everything we want
  summarise(Param_means = mean(Values, na.rm = T), # calculate the mean and remove na
            Param_vars = var(Values, na.rm = T),#calculate the variance and remove na
            Param_sd = sd(Values, na.rm = T)) # calculate standard diviation and remove na

#create boxplots for every parameter
ChemData_long %>% 
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Bio_geo_chem, scales = "free") #frees all the scales when you have different value scales 

#pivot the data to wide
Chemdata_wide <- ChemData_long %>% 
  pivot_wider(names_from = Bio_geo_chem, #columns with the names of the values
              values_from = Values) #columns with the values

#Pivot the data longer
ChemData_clean <- ChemData %>% 
  drop_na() %>% 
  separate(col = Tide_time, #select this column to seperate
           into = c("Tide", "Time"), #New column names
           sep = "_", #seperate at the _
           remove = F) %>% #keep old column
pivot_longer(cols = Temp_in:percent_sgd, #from one column to the other that will be pivoted
             names_to = "Variables", #column names placed in this column
             values_to = "Values") %>% #this column is where values go
group_by(Variables, Site, Time) %>%  #group by these variables
  summarise(mean_vals = mean(Values, na.rm = T)) %>% #calculate the mean and remove na

  #pivot to wide to make it cleaner
  pivot_wider(names_from = Variables, #take the names in this column to make new column names
              values_from = mean_vals) %>%  #take the calculated means into the new columns

#export the data
write.csv(here("week_04","outputs","week04_b_tidyr_summary.csv"))
