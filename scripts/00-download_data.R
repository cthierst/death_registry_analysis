#### Preamble ####
# Purpose: Read in data from Open Data Toronto's statistics on death registration. Link: https://open.toronto.ca/dataset/death-registry-statistics/
# Author: Chloe Thierstein
# Email: chloe.thierstein@utoronto.ca
# Date: 23 January 2023
# Prerequisites: Need to know where to find the City of Toronto death registry data

#### workspace set-up ####
#### install.packages(tidyverse) #####
#### install.packages(janitor) #####

library(tidyverse)
library(janitor)

#### Read in Data ####
raw_death_registry_data <-
  read_csv(
    file = 
      "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/cba07a90-984b-42d2-9131-701c8c2a9788/resource/cc418325-b3d0-4afd-ae64-ccb9b71c549c/download/Death%20Registry%20Statistics%20Data.csv",
    show_col_types = FALSE,
    skip = 0
  )

write_csv(
  x = raw_death_registry_data,
  file = "death_registry.csv"
)

