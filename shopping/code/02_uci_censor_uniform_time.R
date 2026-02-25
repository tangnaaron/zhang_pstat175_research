library(tidyverse)
library(ggplot2)
library(here)

work_dir <- here()
uci_data <- read_csv(file.path(work_dir, "shopping", "data", "intermediate_data", "01_uci_preprocessed.csv"))

# Introducing censorship with uniform time across columns
set.seed(123)
time_threshold <- runif(1, min = 10, max = 1800) # time threshold is between 30 and 60 min

uci_transformed <- uci_data_summed %>%
  mutate(TimeThreshold = time_threshold, # one time threshold across the columns 
         CensorTime = ifelse(TotalDuration >= time_threshold, time_threshold, TotalDuration), # time with censoring
         Censor = ifelse(TotalDuration >= time_threshold, 1, 0)) # censor indicator

# Visualizing censorship
ggplot(data = uci_transformed, mapping = aes(x = rownames(uci_transformed), y = TotalDuration)) +
  geom_bar(stat = 'identity', aes(color = Censor)) +
  geom_hline(yintercept = time_threshold, color = "red") +
  coord_flip(ylim = c(0, time_threshold + 100)) +
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

write.csv(uci_transformed, file.path(work_dir, "shopping", "data", "intermediate_data", "02_uci_uniform_censor.csv"),
          row.names = FALSE)


