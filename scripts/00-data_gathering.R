#### Preamble ####
# Purpose: https://dhsprogram.com/pubs/pdf/FR290/FR290.pdf
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

# Read in the raw data. 
download.file(url = "https://dhsprogram.com/pubs/pdf/FR354/FR354.pdf", destfile = "2017_18.pdf")
Paki1718 <- pdf_text("2017_18.pdf")
Paki1718 <- tibble(raw_data = Paki1718)

download.file(url = "https://dhsprogram.com/pubs/pdf/FR290/FR290.pdf", destfile = "2012_13.pdf")
Paki1213 <- pdf_text("2012_13.pdf")
Paki1213 <- tibble(raw_data = Paki1213)

# Experience of physical violence
Paki1213_hus <- Paki1213 %>% 
  slice(256)

# Separate the rows
Paki1213_hus <- Paki1213_hus %>% 
  separate_rows(raw_data, sep = "\\n", convert = FALSE)

# Select needed rows
Paki1213_hus <- Paki1213_hus[c(8:11, 14,16,17,19:22,24:28,32:35,38:40,43:46,53:55),]

# Separate the states from the data
Paki1213_hus <- Paki1213_hus %>%  
  separate(col = raw_data, 
           into = c("chara", "data"), 
           sep = "\\s{13,}", 
           remove = FALSE,
           fill = "right")

# Separate the data based on spaces, squish spaces more than one into one
Paki1213_hus <- Paki1213_hus %>% 
  mutate(data = str_squish(data))