## For loops ##

library(tidyverse)
library(here)

print(paste("The year is", 2000))

years <- c(2015:2021)

for (i in years){ #set up for the loop where i is the index
  print(paste("The year is", i)) #loop over i
}

#pre-allocate the space for the loop
#empty matrix that is as long as the years vector
year_date <- tibble(year = rep(NA, length(years)),
                    year_name = rep(NA, length(years)))

year_date

for(i in 1:length(years)){ #set up the loop
  year_date$year_name[i] <- paste("The year is", years [1])
  year_date$year[i] <- years[i] 
}

#give the path to the folder
CondPath <- here("week_13","data","cond_data")

#list all the files in that path with a specific pattern
#in this case we are looking for everything that has .csv

files <- dir(path = CondPath, pattern = "csv")

files

#making the df that the data will go into
cond_data <- tibble(file_name = rep(NA, length(files)),
                    mean_temp = rep(NA, length(files)),
                    mean_int = rep(NA, length(files)))
cond_data

raw_data <- read_csv(paste0(CondPath, "/",files[1])) #test reading in the file

head(raw_data)

mean_temp<-mean(raw_data$Temperature, na.rm = TRUE) # calculate a mean
mean_temp


for (i in 1:length(files)) {
  raw_data <- read_csv(paste0(CondPath, "/",files[1])) #test reading in the file
  
  #head(raw_data)
  cond_data$file_name[i] <- files[i]
  cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
  cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
  
}

cond_data

#using map function using purrr

1:10 %>% #vector that goes from 1 to 10
  map(rnorm, n = 15) %>%  #calculate 15 random numbers based on a normal distrubution
  map_dbl(mean) #calculate the mean. It is now a vector which is type

1:10 %>% # a vector from 1 to 10 (we are going to do this 10 times) %>% # the vector to iterate over
  map(rnorm, n = 15)  %>% # calculate 15 random numbers based on a normal distribution in a list 
  map_dbl(mean) # calculate the mean. It is now a vector which is type "double"

1:10 %>% # list 1:10
  map(function(x) rnorm(15, x)) %>% # make your own function
  map_dbl(mean)

files2 <- dir(path = CondPath, pattern = "csv", full.names = TRUE)

data<- files2 %>% 
  set_names() %>% #sets the id of each list to the file name
  map_df(read_csv, .id = "filename") %>%  #map everything to a dataframe and put the put the id in a column called filename
group_by(filename) %>% 
  summarise(mean_temp = mean(Temperature, na.rm =TRUE),
            mean_sal = mean(Salinity, na.rm = TRUE))
