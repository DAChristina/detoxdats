# load data
library(tidyverse)
devtools::load_all()

messy_data <- read.csv("data/messy_data.csv") %>%
  dplyr::select(id, area, dates) %>%
  dplyr::bind_rows(
    data.frame(
      id = paste0("ID_", 1:8),
      area = rep(c("A","B","C","D"),
                 each = 8/4),
      dates = rep(c("44525", "44526", "20 juli 2023", "30 juli 2023"),
                  each = 8/4)
    )
  ) %>%
  glimpse()

# test duplicates ##############################################################
detoxdats::check_duplicate(df = messy_data,
                           column_id = id,
                           other_iden = dates) # NULL/other column


# clean up dates ###############################################################
messy_data <- read.csv("data/messy_data.csv") %>%
  dplyr::mutate(
    clean_dates = detoxdats::detox_dates(dates)
  ) %>%
  # view() %>%
  glimpse()


# clean up values ##############################################################
library(fuzzyjoin)

# not sure if fuzzyjoin (with Levenshtein or any other distance is suitable)
# I'd like to generate new dictionary (python style) to manually fix typos
valid_categories <- data.frame(
  economy_ref = c("low", "middle", "high")
)

messy_data2 <- messy_data %>%
  dplyr::select(id, economy) %>%
  fuzzyjoin::stringdist_left_join(valid_categories,
                                  by = c("economy" = "economy_ref"),
                                  method = "lv",
                                  max_dist = 2) %>%   # max allowed edit distance
  mutate(economy_clean = coalesce(economy_ref, economy)) %>%
  # view() %>%
  glimpse()













