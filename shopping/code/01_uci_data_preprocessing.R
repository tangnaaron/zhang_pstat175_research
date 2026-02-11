library(tidyverse)
library(ggplot2)

work_dir <- here()
raw_data <- read_csv(file.path(work_dir, "shopping", "data", "raw_data", "uci_shopping.csv"))

# Summing up durations
uci_data_summed <- raw_data %>%
  mutate(TotalDuration = Administrative_Duration + Informational_Duration + ProductRelated_Duration)

# Introducing censoring 
time_threshold <- runif(1, min = 1800, max = 3600) # time threshold is between 30 and 60 min

uci_transformed <- uci_data_summed %>%
  mutate(TimeThreshold = time_threshold,
         Censor = ifelse(TotalDuration > time_threshold, 1, 0))


# Visualizing censorship
ggplot(data = uci_transformed, mapping = aes(x = rownames(uci_transformed), y = TotalDuration)) +
  geom_bar(stat = 'identity') +
  geom_hline(yintercept = time_threshold, color = "red") +
  coord_flip(ylim = c(0, 4000)) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  ) +
  labs(
    x = "Observations",
    y = "Total Duration"
  )

uci_transformed %>%
  group_by(Censor) %>%
  summarize(n = n())
