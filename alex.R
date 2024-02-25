library(tidyverse)
all_filenames <- list.files(path = "individual_csvs/", pattern="*.csv", full.names = TRUE)
all_data <- tibble()
for (this_filename in all_filenames){
  
  # read in files
  participant_data <- read_csv(this_filename, skip=3, lazy=FALSE, show_col_types = FALSE)
  participant_info <- read_csv(this_filename, n_max=1, show_col_types = FALSE) %>% select(-subjectGroup)
  
  all_data <- bind_cols(participant_data, participant_info)
  
}

write_csv(all_data, "combined_csvs/all_data.csv")

