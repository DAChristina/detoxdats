# generate mock data
library(tidyverse)

set.seed(123)
nID <- 100
mock_data <- data.frame(
  id = paste0("ID_", 1:nID),
  dates = sample(
    c(
    # Proper ISO date
    as.character(Sys.Date() - sample(1:100, 1)),
    # Day/month/year format
    format(Sys.Date() - sample(1:100, 1), "%d/%m/%Y"),
    # Abbreviated month (English)
    format(Sys.Date() - sample(1:100, 1), "%b-%d-%Y"),
    # Excel serial number (random between 44000 ~ 46000 ≈ 2020–2026)
    as.character(sample(44000:46000, 1)),
    # Indonesian month name
    "9 agustus 2023",
    "20 juli 2023",
    # Other messy values
    "unknown",
    NA
  ), nID, replace = TRUE),
  area = rep(c("A","B","C","D"),
             each = nID/4),
  vaccination_status = rep(
    c("vaccinated","vaccinated","unvaccinated","unvaccinated"),
                           each = nID/4),
  age = sample(1:80, nID, replace = TRUE),
  gender = sample(c("M","F"),
                  nID,
                  replace = TRUE),
  economy = sample(c("low","middle","high",
                     "Low", "Middle", "Higg",
                     "lw", "mid"),
                   nID,
                   replace = TRUE,
                   prob = c(0.4, 0.4, 0.2,
                            0.2, 0.2, 0.1,
                            0.1, 0.1)),
  house_type = sample(c("brick","wood","mixed",
                        "straw", "Bamboo", "Brick",
                        "Wood", "wood, bamboo"),
                      nID,
                      replace = TRUE,
                      prob = c(0.4, 0.4, 0.2,
                               0.2, 0.2, 0.1,
                               0.1, 0.1)
  ),
  positive = rbinom(nID, 1, prob = 0.3),  # 30% prevalence
  antibiotics_name = sample(
    c(
      "Levofloxacin, metronidazole",
      "Aminophylin, Gentamicin",
      "Vicilin + gentamicin",
      "Aminophylin",
      "Metronidazole, ainophylin",
      "Gentamicin",
      "Amikasin, ceftazidime",
      "Gentamisin",
      "Gentamicin, Ceftazidime, amikasin",
      "Ceftazidime, Gentamicin, amikasin",
      "Vicilin + Gentamicin",
      "Metrinidazole",
      "Metronidazole",
      "amikasin",
      "",
      "meropenem, metronidazole, OAT (rifampisin, INH, Pirazinamid, Etambutol)",
      "OAT (rifampisin, INH, Pirazinamid, Etambutol)",
      "amikacin, cefoperazone sulbactam",
      "meropenem, vancomicin",
      "gentamicin, ceftazidime, amikacin",
      "vancomisin",
      "meropenem, vancomicin",
      "gentamicin, ceftazidime, amikacin"
    ),
    nID,
    replace = TRUE
  ),
  stringsAsFactors = FALSE
) %>%
  glimpse()

write.csv(mock_data, "tests/testthat/messy_data.csv",
          row.names = FALSE)
openxlsx::write.xlsx(mock_data, "tests/testthat/messy_data.xlsx",
                     rowNames = FALSE)
