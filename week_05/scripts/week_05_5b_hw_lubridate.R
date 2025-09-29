## Title: Week 5b Lubridate ##
## Created by: Jake Reichard ##
## Last edited: 2025/09/26 ##

#Load libraries #
library(tidyverse)
library(here)
library(lubridate)
library(viridis)

#make a date df
datetimes <- c("02/24/2021 22:22:20",
               "02/25/2021 11:11:11",
               "02/26/2021 8:10:20")
#what format the date is in
datetimes <- mdy_hms(datetimes)

#tells you what months are in the df
month(datetimes, label = T)

#can change time if it was set at the wrong timezone
datetimes + hours(4) 

#can add round to the nearest minute
round_date(datetimes, "minute")

#load in data
condat <- read.csv(here("week_05","data","CondData.csv"))
depthhdat <- read.csv(here("week_05","data","DepthData.csv"))

#format the date to be ymd_hs
condat$date <- mdy_hms(condat$date) 
depthhdat$date <- ymd_hms(depthhdat$date)

#round cond data to the nearest 10 seconds
condat <- condat %>% 
  mutate(rounded_date = round_date(date, "10 second")) 

#join data that only has matching data so there is no na
joined_dat <- condat %>% 
  inner_join(depthhdat, by = c("rounded_date" ="date")) #joining with the rounded date column

#mean of depth temperature and salinity by min
dat_summary_min <- joined_dat %>%
  mutate( minute =floor_date(date, "minute")) %>% 
  group_by(minute) %>% 
  summarise( temp_mean = mean(Temperature, na.rm =T),
             sal_mean = mean(Salinity, na.rm =T),
             depth_mean = mean(Depth, na.rm =T),
             .groups = "drop")

#pivot to longer to graph multiple variable across time
dat_sum_long <- dat_summary_min %>% 
  pivot_longer(cols = temp_mean:depth_mean,
               names_to = "Variables",
               values_to = "Values")

#make cleaner labels for figure, will insert it into facet wrap 
variable_labels <- c(temp_mean = "Temperature (°C)",
  sal_mean = "Salinity (PSU)",
  depth_mean = "Depth (m)")

#make a plot that plots temp, sal, and depth over time
  ggplot(dat_sum_long, aes(x = minute, y = Values, color = Variables)) +
  geom_line() +
  geom_point(alpha = 0.7)+
  facet_wrap(~ Variables, scales ="free_y", ncol = 1, #makes each scale to each variables y values
             labeller = labeller(Variables = variable_labels)) +
  
  #make labels and titles 
  labs(title = "Temperature, Salinity, and Depth Over Time",
         subtitle = "Variables are averaged at one minute intervals",
         caption =  "Data sources:Location -Maunalua Bay, Silbiger et al. 2020 ",
       x = "Time", 
       y = "") +
  theme_bw()+
  theme(legend.position = "none") 
  
  #save plot
  ggsave(here("week_05","outputs","Temp,Sal, Depth over time.png"),
         )
  #export data
  dat_summary_min %>% 
    write.csv(here("week_05","outputs","dat_summary_minute.csv"))

   

  