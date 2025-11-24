## For loops HW Week 13 ##
## Created by Jake Reichard ##
## Date: 2025/11/24 ##

# load libraries #
library(tidyverse)
library(here)

tp_path <- here("week_13","data","homework")

#look for everything with a csv
files <- dir(path = tp_path, pattern = "csv", full.names = TRUE)

files

#make a df that the data will go into
tp_data <- tibble(file_name = rep(NA, length(files)),
                    mean_temp = rep(NA, length(files)),
                    sd_temp = rep(NA, length(files)),
                    mean_inten = rep(NA, length(files)),
                    sd_inten = rep(NA, length(files)))

raw_data <- read_csv(paste0(tp_path, "/",files[1])) #test reading in the file

#check data
head(raw_data)

mean_temp <- mean(raw_data$Temp.C, na.rm = TRUE)
sd_temp <- sd(raw_data$Temp.C, na.rm = TRUE)

for (i in 1:length(files)) {
  raw_data <- read_csv(paste0(tp_path, "/",files[i])) #test reading in the file
  
  #head(raw_data)
  tp_data$file_name[i] <- files[i]
  tp_data$mean_temp[i] <- mean(raw_data$Temp.C, na.rm =TRUE)
  tp_data$sd_temp[i] <- sd(raw_data$Temp.C, na.rm = TRUE)
  tp_data$mean_inten[i] <- mean(raw_data$Intensity.lux, na.rm =TRUE)
  tp_data$sd_inten[i] <- sd(raw_data$Intensity.lux, na.rm = TRUE)
  
}

tp_data

#using map function

tp_data_map <- files %>% 
  set_names() %>% #sets the id of each list to the file name
  map_df(read_csv, .id = "filename") %>%  #map everything to a dataframe and put the put the id in a column called filename
  group_by(filename) %>% 
  summarise(mean_temp = mean(Temp.C, na.rm =TRUE),
            sd_temp = sd(Temp.C, na.rm = TRUE),
            mean_inten = mean(Intensity.lux, na.rm = TRUE),
            sd_inten = sd(Intensity.lux, na.rm = TRUE))
  