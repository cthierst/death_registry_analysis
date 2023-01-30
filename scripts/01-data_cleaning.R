#### Preamble ####
# Purpose: Read in data from Open Data Toronto and Clean the civic centre data downloaded from Open Data Toronto's statistics on death registration. Link: https://open.toronto.ca/dataset/death-registry-statistics/
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


#### Basic Cleaning ####
raw_death_registry_data <-
  read_csv(
    file = "death_registry.csv",
    show_col_types = FALSE
  )


#### Clean Names ####
cleaned_civic_centre_data_2012 <-
  clean_names(raw_death_registry_data)

head(cleaned_civic_centre_data_2012)

#### Simplifying Date #### 
cleaned_civic_centre_data_2012 <-
  cleaned_civic_centre_data_2012 |>
  separate(
    col = time_period,
    into = c("Year", "Month"),
    sep = "-"
  ) |>
  select(-Month) #remove month column as unnecessary


#### Selecting Relevant Rows ####
cleaned_civic_centre_data_2012 <- cleaned_civic_centre_data_2012[c(82:155),] #only keeping rows for 2012

#### Recoding Civic Centres to be more Meaningful ####
cleaned_civic_centre_data_2012 <- cleaned_civic_centre_data_2012 |> 
  mutate( 
    civic_centre = 
      recode( 
        civic_centre, 
        "ET" = "Etobicoke", 
        "NY" = "North York", 
        "SC" = "Scarborough", 
        "TO" = "Toronto", 
      ) 
  )


#### Selecting Relevant Columns####
cleaned_civic_centre_data_2012 <-
  cleaned_civic_centre_data_2012 |>
  select(
    death_licenses,
    civic_centre
  )







         