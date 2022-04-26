#### Preamble ####
# Purpose: Clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Bu Xu
# Data: Apr 18 2022
# Contact: bu.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!
# - Change these to yours
# Any other information needed?


#### Workspace setup ####
library(haven)
library(tidyverse)
library(rvest)
library(pdftools)
library(tibble)


#### data from 2012-13 ####

# Where the violence are from?(Persons committing physical violence to them)
# Other relative, other in-law, teacher, employer/someone at work, police/soldier are all 
# counted as other of all 1186 samples
commit_person <- tibble(
  person = c('current husband', 'former husband', 'father/stepfather', 'mother/stepmother', 
             'sister/brother', 'daughter/son', 'mother-in-law', 'father-in-law',
             'other'),
  percentage = c(79.4, 8.0, 7.0, 11.9, 5.6, 0.1, 6.5, 3.3, 12.9),
  population = c(942,  95, 83, 141, 66, 1, 77, 39, 153)
)


# forms of spousal violence
form_spousal_vio <- tibble(
  forms = c('push, shook, or threw things', 'slap', 'twist arm or pull hair', 
            'punch with fist or somthing could hurt her', 'kick, drag, beat',
            'try to choke her or burn her on purpose', 'threaten her or attack her with a weapon',
            'say or do something to humiliate her in front of others', 
            'threathern to hurt or harm her or someone she cared about',
            'insult her or make her feel bad about herself'),
  percent_last12 = c(10, 16, 7, 5, 3, 1, 1, 22, 4, 24),
  percent_ever = c(16, 25, 11, 9, 5, 2, 2, 26, 5, 27)
)


##Spousal violence background characteristics

# age distribution of women experienced spousal violence
age <- tibble(
  age = c('15-19', '20-24', '25-29', '30-39', '40-49'),
  emo_vio = c(24.8, 27.6,27.2,33.9,37.5),
  phy_vio = c(24.4,22.2,24.2,29.4,28.6),
  both = c(27.8,33.0,33.0,41.2,43.8), 
  population = c(133,617,703,1259,976)
)

total_num = 133+617+703+1259+976
per15_19 <- round(133/total_num, 3)
per20_24 <- round(617/total_num, 3)
per25_29 <- round(703/total_num, 3)
per30_39 <- round(1259/total_num, 3)
per40_49 <- round(976/total_num, 3)

# residence of the ever-married women who suffer from violence
resid <- tibble(
  residence = c('urban','rural'),
  population = c(1216, 2471)
)

# number of children living
number_childliving <- tibble(
  number = c('0', '1-2', '3-4', '5+'),
  emo_vio = c(19.7, 29.6, 30.3,42.1),
  phy_vio = c(15.3,25.4,27.6,32.5),
  both = c(22.6,34.7,39.3,48.4),
  population = c(458,1114,1039,1076)
)

# Education of the ever-married women
edu <- tibble(
  education = c('no education','primary','middle','secondary','higher'),
  emo_vio = c(36.5,33.3,28.9,23.0,16.3),
  phy_vio = c(31.1,28.0,26.8,16.6,10.5),
  both = c(43.5,40.3,36.5,26.3,19.8),
  population = c(2124,572,257,395,339)
)

# Marital status
marry <- tibble(
  marriage = c('married', 'divorced/seperated/widowed'),
  emo_vio = c(31.6,44.4),
  phy_vio = c(26.1,42.0),
  both = c(37.9,49.8),
  population = c(3518,169)
)

# regions difference on seeking help
regions <- tibble(
  region = c('Punjab','Sindh','Khyber Pakhtunkhwa','Balochistan','ICT Islamabad',
             'Gilgit Baltistan'),
  seek_help = c(50.4,23.3,16.4,16.9,29.2,32.5),
  never_seek_but_told = c(7.3,15.5,12.4,11.8,19.6, 9.5),
  never_seek_nor_told = c(40.6,58.9,66.8,66.4,46.8,58.0),
  population = c(611,209,290,68,5,3)
)


## Husbands' background characteristics
# education
edu_hus <- tibble(
  education = c('no education','primary','secondary','higher'),
  emo_vio = c(37.1,33.8,32.1,20.1),
  phy_vio = c(33.1,29.5,24.3,15.6),
  both = c(44.4,40.0,37.3,26.2), 
  numb_of_wom = c(1212,629,1234,600)
)

# Husband's alcohol consumption
alcohol <- tibble(
  alcohol_consum = c('does not drink','get drunk sometimes',
                     'get drunk very often'),
  emo_vio = c(30.5,58.5,69.4),
  phy_vio = c(24.8,58.8,71.1),
  both = c(36.8,69.2,71.6),
  num_of_wom = c(3486,72,107)
)

# spousal education difference
edu_diff <- tibble(
  education_diff = c('husband better educated','wife better educated',
                     'both equally educated','neither educated'),
  emo_vio = c(32.0,27.3,23.8,37.6),
  phy_vio = c(26.3,22.0,15.9,33.2),
  both = c(38.7,31.7,26.1,45.0),
  num_of_wom = c(1797,566,306,1007)
)

# spousal age difference
age_diff <- tibble(
  age_difference = c('wife older', 'same age', 'wife is 1-4 years younger',
                     'wife is 5-9 years younger', 'wife is 10+ years younder'),
  emo_vio = c(28.9,28.2,32.1,29.9,35.9),
  phy_vio = c(20.7,21.5,28.7,24.8,27.1),
  both = c(36.9,36.1,38.4,36.2,40.7),
  num_of_wom = c(282,210,1267,1146,607)
)

# Whether the father of wife beats her mother
father_beat <- tibble(
  whether_beat = c('women\'s father beat her mother', 'not beat'),
  emo_vio = c(54.2,26.4),
  phy_vio = c(57.5,18.3),
  noth = c(66.0,31.0),
  num_of_wom = c(763, 2729)
)

# women afraid of husband
afraid <- tibble(
  afraid = c('afraid most of the time','sometines afraid','never'),
  emo_vio = c(57.9,39.1,17.5),
  phy_vio = c(54.6,34.4,10.8),
  both = c(65.7,48.0,21.0),
  num_of_wom = c(554,1472,1646)
)


# experience of spousal violence by duration of marriage
exp_duration <- tibble(
  duration_of_marriage = c('<2 years','2-4 years','5-9 years','10+ years'),
  percent_no_vio = c(90.4,76.9,75.4,70.6),
  num_ever_married_once = c(318,440,674,2004)
)


# write out the tables
write_csv(commit_person, file = 'outputs/commit_person')
write_csv(form_spousal_vio, file = 'outputs/form_spousal_vio')
write_csv(age, file = 'outputs/age')
write_csv(resid, file = 'outputs/resid')
write_csv(number_childliving, file = 'outputs/number_childliving')
write_csv(edu, file = 'outputs/edu_wom')
write_csv(marry, file = 'outputs/marry')
write_csv(regions, file = 'outputs/regions_wom')
write_csv(edu_hus, file = 'outputs/edu_hus')
write_csv(alcohol, file = 'outputs/alcohol_hus')
write_csv(edu_diff, file = 'outputs/edu_diff')
write_csv(age_diff, file = 'outputs/age_diff')
write_csv(father_beat, file = 'outputs/father_beat')
write_csv(afraid, file = 'outputs/afraid')
write_csv(exp_duration, file = 'outputs/exp_duration') 


































         