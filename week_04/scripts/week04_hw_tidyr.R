## Homework with tidy with biogeochemistry data from Hawaii ##
## Created by: Jake Reichard ##
## Updated on: 2025-09-20 ##

## Load Libraries ##
library(tidyverse)
library(ggExtra)
library(here)

##Load in data
chem_data <- read.csv(here("week_04","data","chemicaldata_maunalua.csv"))

#remove all na
chem_data_clean <- chem_data %>% 
  drop_na() %>% 
  
#Separate columns
  separate(col = Tide_time, #column that will be separated
           into = c("Tide", "Time"), #new column names
           sep = "_", #where to split them
           remove = F)#keep the old column

#pivot longer
  chem_data_long <- chem_data_clean %>% 
 pivot_longer(cols = NN:percent_sgd, #Columns that will be pivoted
              names_to = "Variables", #new column name where old columns names will go
              values_to = "Values") #where all values will go.

#remove unwanted columns
  chem_data_long_select <- chem_data_long %>% 
    select(-Temp_in:-Silicate) %>%  #remove columns from Temp in to Silicate
  
#calculate stats
  group_by(Variables, Site, Season) %>%  #group by these columns
    summarise(mean_vals = mean(Values, na.rm = T))  #calculate the means
  
  #pivot to wider to look cleaner
  chem_data_summary <- chem_data_long_select %>% 
    pivot_wider(names_from = Variables, #take the names from this to make new column names
              values_from = mean_vals) %>%  #take the values from the means and put in new columns
#export csv
  write.csv(here("week_04","outputs","hw_chem_data_summary.csv"))
    

#plot data
  transform_chem_data <- chem_data_clean %>% 
    mutate(log_sgd = log(percent_sgd)) #add a new column that logs percent_sgd
  
  #make a plot
  p <- ggplot(transform_chem_data, aes(x = log_sgd , y = Salinity , color = Tide)) +
        geom_point() + #create a scatter plot
    theme_bw()+ #make background white
    
    #label for everything
    labs( x= "Log percent SGD",
         y = "Salinity",
         title = "Percent Submarine Groundwater Discharge (SGD) vs Salinity",
         subtitle = "SGD was logged",
         caption = " Data Source: Location -Maunalua Bay, Silbiger et al. 2020 ")
  
  #add a density plot along the margins    
  final_plot <- ggMarginal(p, type = "density",
                           fill = "lightblue",
                           alpha = 0.7)
#look at the plot
  print(final_plot)  
  
  #save the plot      
  ggsave(here("week_04","outputs","week_04_hw_tidyr_SGD_vs_Sal.jpeg"),
         plot = final_plot, #have to tell it which plot to use
         width = 10, height = 6,
         dpi = 300)
  