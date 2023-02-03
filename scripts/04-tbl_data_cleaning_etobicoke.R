#### Preamble ####
# Purpose: Read in data from Open Data Toronto and clean the civic centre data from 2012 downloaded from Open Data Toronto's statistics on death registration.Link: https://open.toronto.ca/dataset/death-registry-statistics/
# Author: Chloe Thierstein
# Email: chloe.thierstein@utoronto.ca
# Date: 2 February 2023
# Prerequisites: Need to know where to find the City of Toronto death registry data

#### Creating Datasets for 5 Year Period by Month at Etobicoke Civic Centre ####

#### Repeat Process for Each Year (2016-2020) ####

#### 2016 ####
et_avg_num_deaths_by_month_2016 <-cleaned_death_registry_data |>
  filter(Year == "2016" | civic_centre == "Etobicoke") |> #filter for year and civic centre
  group_by(Month) |> #group by month
  summarize("Average # of Deaths Registered" = mean(death_licenses)) #find average of death licenses given out 

#### 2017 ####
et_avg_num_deaths_by_month_2017 <-cleaned_death_registry_data |>
  filter(Year == "2017" | civic_centre == "Etobicoke") |>
  group_by(Month) |> 
  summarize("Average # of Deaths Registered" = mean(death_licenses)) 

#### 2018 ####
et_avg_num_deaths_by_month_2018 <-cleaned_death_registry_data |>
  filter(Year == "2018" | civic_centre == "Etobicoke") |>
  group_by(Month) |> 
  summarize("Average # of Deaths Registered" = mean(death_licenses)) 

#### 2019 ####
et_avg_num_deaths_by_month_2019 <-cleaned_death_registry_data |>
  filter(Year == "2019" | civic_centre == "Etobicoke") |>
  group_by(Month) |> 
  summarize("Average # of Deaths Registered" = mean(death_licenses)) 

#### 2020 ####
et_avg_num_deaths_by_month_2020 <-cleaned_death_registry_data|>
  filter(Year == "2020" | civic_centre == "Etobicoke") |>
  group_by(Month) |> 
  summarize("Average # of Deaths Registered" = mean(death_licenses))



#### Combining Datasets for 5 Year Period by Month at Etobicoke Civic Centre ####

#### After 1st Instance (2016), Repeat 2nd Instance Process for Each Year (2017-2020) ####

#### 2016 ####
et_all_avg_num_deaths_by_month_data <- #new dataset
  et_avg_num_deaths_by_month_2016 |> #start with first dataset in this spot
  left_join(et_avg_num_deaths_by_month_2016, by = "Month") #use left_join() to combine dataset

#### 2017 ####
et_all_avg_num_deaths_by_month_data <- 
  et_all_avg_num_deaths_by_month_data |> #for second and all following datasets use "new" dataset in this position
  left_join(et_avg_num_deaths_by_month_2017, by = "Month")

#### 2018 ####
et_all_avg_num_deaths_by_month_data <- 
  et_all_avg_num_deaths_by_month_data |>
  left_join(et_avg_num_deaths_by_month_2018, by = "Month")

#### 2019 ####
et_all_avg_num_deaths_by_month_data <- 
  et_all_avg_num_deaths_by_month_data |>
  left_join(et_avg_num_deaths_by_month_2019, by = "Month")

#### 2020 ####
et_all_avg_num_deaths_by_month_data <-
  et_all_avg_num_deaths_by_month_data |>
  left_join(et_avg_num_deaths_by_month_2020, by = "Month") 

et_all_avg_num_deaths_by_month_data <- 
  et_all_avg_num_deaths_by_month_data |>
  select(
    "Month",
    "Average # of Deaths Registered.y",
    "Average # of Deaths Registered.x.x",
    "Average # of Deaths Registered.y.y",
    "Average # of Deaths Registered.x.x.x",
    "Average # of Deaths Registered.y.y.y"
  ) 

#### Creating a CSV File for Cleaned Data ####
write_csv(
  x = et_all_avg_num_deaths_by_month_data,
  file = "et_all_avg_num_deaths_by_month_data.csv"  #create cleaned data .csv file and store it in inputs folder
)