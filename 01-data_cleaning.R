
#### Preamble ####
# Purpose: Read in data from Open Data Toronto and clean the civic centre data from 2012 downloaded from Open Data Toronto's statistics on death registration. Link: https://open.toronto.ca/dataset/death-registry-statistics/
# Author: Chloe Thierstein
# Email: chloe.thierstein@utoronto.ca
# Date: 23 January 2023
# Prerequisites: Need to know where to find the City of Toronto death registry data

#### workspace set-up ####
#### install.packages(tidyverse) ####
#### install.packages(janitor) ####
#### install.packages("knitr") ####

install.packages("RColorBrewer")
library("RColorBrewer")

library(knitr)
library(tidyverse)
library(janitor)




#### Clean Names ####
cleaned_death_registry_data <-
  clean_names(raw_death_registry_data)

head(cleaned_death_registry_data)


#### Simplifying Date #### 
cleaned_death_registry_data <-
  cleaned_death_registry_data |>
  separate(
    col = time_period,
    into = c("year", "month"),
    sep = "-"
  ) |>
  select(civic_centre, death_licenses, place_of_death, year, month)

#### Removing 2021-2022 rows ####
cleaned_death_registry_data <- cleaned_death_registry_data[-c(746:841), ] 

#### Recoding Months to be more Meaningful ####
cleaned_death_registry_data <- cleaned_death_registry_data |> 
  mutate( 
    month = 
      recode( 
        month, 
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

cleaned_death_registry_data <- cleaned_death_registry_data |>
  filter(!grepl('TO', civic_centre))

#### Ordering Months #####
cleaned_death_registry_data$month <- factor(cleaned_death_registry_data$month, levels=c("Jan", "Feb","Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))


############## Graphing ##################


#### Creating Graph ####
ggplot(data=cleaned_death_registry_data, aes(x = year, y = death_licenses)) +
  geom_bar(stat = "identity") +
  theme_minimal() + 
  labs(
    x = "Year",
    y = "Death Licenses"
  )



#### Creating Graph ####
ggplot(data=cleaned_death_registry_data, aes(x = month, y = death_licenses, fill = month)) +
  scale_fill_brewer(palette="Set3") + theme_minimal() +
  geom_bar(stat = "identity") +
  labs(
    x = "Month",
    y = "Death Licenses"
  ) 



#### Creating Graph ####
ggplot(data=cleaned_death_registry_data, aes(x = place_of_death, y = death_licenses, fill = place_of_death)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(
    x = "Place of Death",
    y = "Death Licenses"
  ) +
  scale_fill_brewer(palette="Set3")



#### Creating Graph ####
ggplot(data=cleaned_death_registry_data, aes(x = civic_centre, y = death_licenses, fill = year)) +
  geom_bar(stat = "identity") +
  theme_minimal() + 
  labs(
    x = "Civic Centre",
    y = "Death Licenses"
  )



