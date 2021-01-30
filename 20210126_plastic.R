# Load packages
library(tidyverse)
library(tidytuesdayR)

# Load data
tuesdata <- tidytuesdayR::tt_load('2021-01-26')
plastics <- tuesdata$plastics

# Wrangle the data
df_2020 <- plastics %>%
  
  # drop Grand Total rows, which double the counts
  filter(parent_company != 'Grand Total', year == 2020) %>%
  
  # drop columns we're not interested in for this analysis
  select(-volunteers, -num_events, -grand_total, -year) %>%
  
  # create a tidy table by lengthening
  pivot_longer(c(`empty`,`hdpe`,`ldpe`,`o`,`pet`,`pp`,`ps`,`pvc`),names_to = "type", values_to = "count")

# Exploratory plot
ggplot(df_2020) +
  geom_col(mapping = aes(x = type, y = count)) +
  facet_wrap(~ country)

# 