#### Preamble ####
# Purpose: Simulate data from Open Data Toronto's statistics on death registration. Link: https://open.toronto.ca/dataset/death-registry-statistics/
# include columns ID, Death Licenses, Civic Centre, Place of Death, Month (as placeholder for date)
# Author: Chloe Thierstein
# Email: chloe.thierstein@mail.utoronto.ca
# Date: 23 January 2023
# Prerequisites: Need to know where to find the City of Toronto death registry data



library(tibble)


simulated_data <-
  tibble(
    "ID" = 1:841,
    "Death Licenses" = runif(n = 841, min = 1, max = 1000),
    "Civic Centre" = sample(
      x = c(
        "Etobicoke",
        "North York",
        "Scarborough",
        "Toronto"
     ),
     size = 841,
     replace = TRUE
    ),
    "Place of Death" = sample(
      x = c(
        "Toronto",
        "Outside of City Limits"
      ),
      size = 841,
      replace = TRUE
    ),
    "Month" = sample(
      x = c(
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
      ),
      size = 841,
      replace = TRUE
  )
)
simulated_data
