#### Preamble ####
# Purpose: Simulation
# Author: Bu Xu
# Data: Apr 18 2022
# Contact: bu.xu@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(haven)
library(tidyverse)
library(rvest)
library(pdftools)
library(tibble)

#### Simulate ####
set.seed(499)

simulated_data <- 
  tibble('living chilren' = sample( x = c(
    '0', '1-2', '3-4', '5+'),
    size = 3687, 
    replace = T
  ))
simulated_data

table(simulated_data)
write_csv(simulated_data, file = "outputs/simul.csv")