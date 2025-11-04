library(tidyverse)

#create a random number df
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c= rnorm(10),
  d = rnorm(10)
)
#look at df
head(df)

#make a formula (value - min/(max - min))
df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)))

#now repeated
df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))

#function
rescale01 <- function(x) {
  value<-(x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE))
  return(value)
}

#example function

temp_c <- (temp_f - 32) * 5/9

f_to_c <- function(temp_f) {
temp_c <- (temp_f - 32) * 5/9
return(temp_c)
}

f_to_c(32)
f_to_c(212)

#another example

c_to_k <- function(temp_c){
  temp_k <- (temp_c + 273.15)
return(temp_k)
  }
c_to_k(20)

#making a plot into a function
library(palmerpenguins)
library(PNWColors) # for the PNW colo
# you may need to install the PNWColors library if you haven't used it yet
pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
  theme_bw()

#the function
myplot <- function(data, x, y){pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
ggplot(data, aes(x = {{x}}, y = {{y}}, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
  theme_bw()
}

#you can add more stuff after the function to add to the basic.
myplot(data = penguins, x = body_mass_g, y = bill_length_mm) +
  labs(x = "Body Mass"
       y= "Bill Length")

if (a > b) { #my question
  f <- 20 #if it is true give me answer 1
} else {
  f <- 10 # else give me answer 2
}

#if or else with plot
myplot<-function(data = penguins, x, y, lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  if(lines==TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      geom_smooth(method = "lm")+ # add a linear model
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
  else{
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+ #no geom_smooth
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
}

#run the function
myplot(data = penguins, x = body_mass_g, y = bill_length_mm, lines =F)
