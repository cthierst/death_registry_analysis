#### Preamble ####
# Purpose: Test data from Open Data Toronto's statistics on death registration. Link: https://open.toronto.ca/dataset/death-registry-statistics/
# include columns ID, Death Licenses, Civic Centre, Place of Death, Month (as placeholder for date)
# Author: Chloe Thierstein
# Email: chloe.thierstein@mail.utoronto.ca
# Date: 23 January 2023
# Prerequisites: Need to know where to find the City of Toronto death registry data

#### testing simulated data ####

#### test 1 #### 

simulated_data$"Civic Centre" |>
  unique() |>
  length() == 3

#### test 2 #### 

simulated_data$"Year" |> min() == 2016

#### test 3 ####

simulated_data$"Death Licenses" |> class() == "numeric"
