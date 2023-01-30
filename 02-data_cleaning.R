#### Preamble ####
# Purpose: Clean the place of death data downloaded from Open Data Toronto's statistics on death registration. Link: https://open.toronto.ca/dataset/death-registry-statistics/
# Author: Chloe Thierstein
# Email: chloe.thierstein@utoronto.ca
# Date: 23 January 2023
# Prerequisites: Need to know where to find the City of Toronto death registry data

#### workspace set-up ####
#### install.packages(tidyverse) #####
#### install.packages(janitor) #####

library(tidyverse)
library(janitor)

#### Clean Names ####
cleaned_place_of_death_data_2012 <-
  clean_names(raw_death_registry_data)

head(cleaned_place_of_death_data_2012)

#### Simplifying Date #### 
cleaned_place_of_death_data_2012 <-
  cleaned_place_of_death_data_2012 |>
  separate(
    col = time_period,
    into = c("Year", "Month"),
    sep = "-"
  ) |>
  select(-Month) #remove month column as unnecessary

#### Selecting Relevant Rows ####
cleaned_place_of_death_data_2012 <- cleaned_place_of_death_data_2012[c(82:155),] #only keeping rows for 2012


#### Selecting Relevant Columns####
cleaned_place_of_death_data_2012 <-
  cleaned_place_of_death_data_2012 |>
  select(
    death_licenses,
    place_of_death
  )








