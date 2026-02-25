library(tidyverse)
library(ggplot2)
library(here)

work_dir <- here()
raw_data <- read_csv(file.path(work_dir, "shopping", "data", "raw_data", "uci_shopping.csv"))

# Summing up durations
uci_data_summed <- raw_data %>%
  mutate(TotalDuration = Administrative_Duration + Informational_Duration + ProductRelated_Duration) %>%
  select(-c(Administrative_Duration, Informational_Duration, ProductRelated_Duration)) %>%
  filter(TotalDuration != 0) # filtering out total durations with 0

write.csv(uci_data_summed, file.path(work_dir, "shopping", "data", "intermediate_data", "01_uci_preprocessed.csv"),
          row.names = FALSE)


# TODO:
# - Create documentation of datasets using AI 
# - Possibly run some statistical analysis on samples of the datasets
