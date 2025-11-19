

library(tidyverse) # to show model output
library(here)
library(palmerpenguins)
library(broom) # for clean model output
library(performance) 
library(modelsummary) # to show model output
library(tidymodels) # for tidy models

#linear model of Bill depth
Peng_mod<-lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)

check_model(Peng_mod)
anova(Peng_mod)

#summary gives you the effect size
summary(Peng_mod)

coeffs <- tidy(Peng_mod) #just tidy 
results <- glance(Peng_mod) #gives all the info from the model
results

resid_fitted <- augment(Peng_mod) #gives the fitted and resid for every observation good for plotting


Peng_mod_noX<-lm(bill_length_mm ~ bill_depth_mm, data = penguins)
#Make a list of models and name them
models<-list("Model with interaction" = Peng_mod,
             "Model with no interaction" = Peng_mod_noX)
#Save the results as a .docx
modelsummary(models, output = here("Week_13","outputs","table.docx"))

models <- penguins %>% 
  ungroup() %>% 
  nest(.by = species) %>% #nest all the data by species
  mutate(fit = map(data, ~lm(bill_length_mm ~ body_mass_g, data = .))) # . make it go up one level


results <- models %>% 
  mutate(coeffs = map(fit, tidy),
         modelresults = map(fit, glance)) %>% 
  select(species, coeffs, modelresults) %>% 
  unnest()


