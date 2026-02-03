library(here)
library(readr)
library(tidyverse)

# Importing 
work_dir <- here() 
raw_data <- read_csv(file.path(work_dir, "shopping", "data", "raw_data", "kaggle_shopping.csv"))

# Introducing censoring 
time_threshold <- 40 # threshold of TimeSpentOnWebsite to censor 

transformed_data <- raw_data %>%
  mutate(Event = ifelse(TimeSpentOnWebsite < 40 & PurchaseStatus == 1, 1, 0))

# Creating new data 
write.csv(transformed_data, file.path(work_dir, "shopping", "data", "intermediate_data", "01_kaggle_preprocessed.csv"))

