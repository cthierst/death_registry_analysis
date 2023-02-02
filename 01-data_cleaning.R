
#### Preamble ####
# Purpose: Read in data from Open Data Toronto and clean the civic centre data from 2012 downloaded from Open Data Toronto's statistics on death registration.Link: https://open.toronto.ca/dataset/death-registry-statistics/
# Author: Chloe Thierstein
# Email: chloe.thierstein@utoronto.ca
# Date: 23 January 2023
# Prerequisites: Need to know where to find the City of Toronto death registry data

#| include: false

#### Workspace Set-up ####

#### install.packages(tidyverse) ####
#### install.packages(janitor) ####
#### install.packages(ggplot2) ####
#### install.packages("knitr") ####
#### install.packages("RColorBrewer") ####
#### install.packages("kableExtra") ####

library(tidyverse)
library(opendatatoronto)
library(janitor)
library(ggplot2)
library(dplyr)
library(knitr)
library(RColorBrewer)
library(kableExtra)


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


#### Clean Names ####
cleaned_death_registry_data <-
  clean_names(raw_death_registry_data)


#### Simplifying Date #### 
cleaned_death_registry_data <-
  cleaned_death_registry_data |>
  separate(
    col = time_period,
    into = c("Year", "Month"),
    sep = "-"
  ) |>
  select(civic_centre, death_licenses, place_of_death, Year, Month)

#### Removing 2021-2023 data ####
cleaned_death_registry_data <- cleaned_death_registry_data[-c(1:371,746:847), ] 


#### Recoding Months to be more Meaningful ####
cleaned_death_registry_data <- cleaned_death_registry_data |> 
  mutate( 
    Month = 
      recode( 
        Month, 
        "01" = "Jan", 
        "02" = "Feb", 
        "03" = "Mar",
        "04" = "Apr",
        "05" = "May",
        "06" = "Jun",
        "07" = "Jul",
        "08" = "Aug",
        "09" = "Sep",
        "10" = "Oct",
        "11" = "Nov",
        "12" = "Dec"
      ) 
  )


#### Recoding Civic Centres to be more Meaningful ####
cleaned_death_registry_data <- cleaned_death_registry_data |> 
  mutate( 
    civic_centre = 
      recode( 
        civic_centre, 
        "ET" = "Etobicoke", 
        "NY" = "North York", 
        "SC" = "Scarborough", 
      ) 
  )

#### ordering months #####
cleaned_death_registry_data$Month <- factor(cleaned_death_registry_data$Month, levels=c("Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))


#### filtering out toronto civic centre from data ####
cleaned_death_registry_data <- cleaned_death_registry_data |>
  filter(!grepl('TO', civic_centre))

#### creating a CSV file for cleaned data ####
write_csv(
  x = cleaned_death_registry_data,
  file = "cleaned_death_registry.csv"
)

