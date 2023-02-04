
#### Preamble ####
# Purpose: Clean data from Open Data Toronto and clean the civic centre data from 2012 downloaded from Open Data Toronto's statistics on death registration.Link: https://open.toronto.ca/dataset/death-registry-statistics/
# Author: Chloe Thierstein
# Email: chloe.thierstein@utoronto.ca
# Date: 23 January 2023
# Prerequisites: Need to know where to find the City of Toronto death registry data

#### Workspace Set-up ####

#### Need to Install These Packages to Run Script ####
#### install.packages("tidyverse") ####
#### install.packages("opendatatoronto") ####
#### install.packages("janitor") ####
#### install.packages("ggplot2") ####
#### install.packages("knitr") ####
#### install.packages("RColorBrewer") ####
#### install.packages("kableExtra") ####
#### install.packages("patchwork") ####
#### install.packages("readr") ####
#### install.packages("here") ####

#### Loading in Libraries ####
library(tidyverse)
library(opendatatoronto)
library(janitor)
library(ggplot2)
library(dplyr)
library(knitr)
library(RColorBrewer)
library(kableExtra)
library(patchwork)
library(readr)
library(here)

#### Data Cleaning ####

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

#### Removing 2011-2015 and 2021-2023 Data for Relevance ####
cleaned_death_registry_data <- cleaned_death_registry_data[-c(1:371,746:847), ] 

#### Recoding Months to be More Meaningful ####
cleaned_death_registry_data <- cleaned_death_registry_data |> 
  mutate( 
    Month = 
      recode( 
        Month, #abbreviated months to better fit graphs withotu losing meaning
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

#### Recoding Civic Centres to be More Meaningful ####
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

#### Filtering Out "Toronto" Civic Centre from Data Due to Missing Data ####
cleaned_death_registry_data <- cleaned_death_registry_data |>
  filter(!grepl('TO', civic_centre))

#### Turning Years Into Factor ####
cleaned_death_registry_data$Year <- as.factor(cleaned_death_registry_data$Year)

#### Ordering Months #####
cleaned_death_registry_data$Month <- factor(cleaned_death_registry_data$Month, levels=c("Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

#### Creating a CSV File for Cleaned Data ####
write_csv(
  x = cleaned_death_registry_data,
  file = "cleaned_death_registry.csv"  #create cleaned data .csv file and store it in inputs folder
)

