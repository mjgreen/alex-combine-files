library(tidyverse)
all_filenames <- list.files(path = "individual_csvs/", pattern="*.csv", full.names = TRUE)
forms = tibble()
tests = tibble()
for (this_filename in all_filenames){

  # read in files
  participant_info <- read_csv(this_filename, n_max=1, show_col_types = FALSE)
  participant_data <- read_csv(this_filename, skip=3, lazy=FALSE, show_col_types = FALSE)
  
  # separate off form trials
  this_form <- participant_data %>% filter(type == "form") %>% select(-subjectGroup) %>% dplyr::select_if(~!all(is.na(.)))
  this_form <- bind_cols(participant_info, this_form)
  forms <- forms %>% bind_rows(this_form)
  write_csv(forms, "combined_csvs/form_trials.csv")
  
  # separate off test trials
  this_test <- participant_data %>% filter(type == "test") %>% select(-subjectGroup) %>% dplyr::select_if(~!all(is.na(.)))
  this_test <- bind_cols(participant_info, this_test)
  tests <- tests %>% bind_rows(this_test)
  write_csv(tests, "combined_csvs/test_trials.csv")
  
}
