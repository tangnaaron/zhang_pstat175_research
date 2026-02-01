library(here)
library(readr)
library(tidyverse)

# Importing 
work_dir <- here() 
kaggle_df <- read_csv(file.path(work_dir, "shopping", "data", "raw_data", "kaggle_shopping.csv"))

# 