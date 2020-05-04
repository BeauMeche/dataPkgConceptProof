## code to prepare `pnas_data.RData` dataset goes here

# for those interested, the cleaned code for 
# 'enos_train' is produced by the script located at:

  # https://github.com/davidkane9/gov.1005.data/blob/master/data-raw/enos_2016.R

library(tidyverse)
library(usethis)

x <- read_csv("data-raw/pnas_data.csv",
              col_types = cols(
                .default = col_double(),
                treated_unit = col_character(),
                t.time = col_character(),
                assignment = col_character(),
                line.y = col_character(),
                station = col_character(),
                train = col_character(),
                time = col_time(format = ""),
                time.treatment = col_character()
              ))  %>% 
  
  # ignoring warning message as X1 is not selected
  
  select(numberim.x, Remain.x, Englishlan.x,
         numberim.y, Remain.y, Englishlan.y,
         treatment, liberal, republican, age,
         male, income.new, citizen) %>% 
  
  # Create an overall measure of attitude change. Positive means becoming more
  # conservative. Should we normalize this number? Should we allow for an NA in
  # one or two of the three questions? We only lose 8 of the 123 observations
  # right now. But could rescue three of these if we allowed number_diff to be
  # NA. Only 5 are truly NAs, meaning the person did not answer any ogf the
  # three questions on the second survey.
  # - D. Kane
  
  mutate(att_start = numberim.x + Remain.x + Englishlan.x,
         att_end = numberim.y + Remain.y + Englishlan.y,
         att_chg = att_end - att_start) %>% 

# Remove redundencies.

  select(- starts_with("numberim")) %>%
  select(- starts_with("Remain")) %>%
  select(- starts_with("Englishlan")) %>% 
  
  # todo: there may be room for NA imputation here
  
  # drop_na(att_chg) %>% 
  
  rename(income = income.new) %>% 
  
  mutate(treatment.2 = ifelse(treatment == 1, "Treated", "Control")) %>%
  mutate(treatment.2 = factor(treatment.2, levels = c("Treated", "Control"))) %>%
  
  select(-treatment) %>%
  rename(treatment = treatment.2) %>%
  
  select(male, liberal, republican, age, income,
         treatment, att_start, att_end, att_chg, citizen)

# todo: figure out what the citizen code is, 
# dataverse presently inconclusive
  
  

# usethis::use_data(train_data.RData, overwrite = TRUE)
