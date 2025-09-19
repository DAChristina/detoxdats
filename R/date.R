#' Title
#'
#' @param column_dates
#'
#' @returns
#' @export
#'
#' @examples
detox_dates <- function(column_dates) {
  out <- rep(as.Date(NA), length(column_dates))

  # fix unknowns & NAs
  na_unknowns <- is.na(column_dates) | column_dates %in% c("unknown",
                                                           "",
                                                           "tidak")
  out[na_unknowns] <- as.Date(NA)


  # fix excel date
  is_excel <- grepl("^[0-9]+$", column_dates)
  out[is_excel] <- as.Date(as.numeric(column_dates[is_excel]),
                           origin = "1899-12-30")

  # fix dd/mm/yyyy format
  is_ddmmyyyy <- grepl("^\\d{2}/\\d{2}/\\d{4}$", column_dates)
  out[is_ddmmyyyy] <- lubridate::dmy(column_dates[is_ddmmyyyy])

  # yyyy-mm-dd
  is_iso <- grepl("^\\d{4}-\\d{2}-\\d{2}$", column_dates)
  out[is_iso] <- as.Date(column_dates[is_iso])

  # %b-dd-yyyy format
  is_mdy_format <- grepl("^[A-Za-z]{3}-\\d{2}-\\d{4}$", column_dates)
  out[is_mdy_format] <- lubridate::mdy(column_dates[is_mdy_format])

  # dd-%b-2025 format
  is_mdy_format <- grepl("^\\d{2}-[A-Za-z]{3}-\\d{4}$", column_dates)
  out[is_mdy_format] <- lubridate::mdy(column_dates[is_mdy_format])

  # Indonesian to english
  is_id_months <- grepl("januari|februari|maret|april|mei|juni|juli|agustus|september|oktober|november|desember",
                        column_dates, ignore.case = TRUE)
  if (any(is_id_months)) {
    clean_x <- column_dates[is_id_months]
    clean_x <- gsub("januari", "January", clean_x, ignore.case = TRUE)
    clean_x <- gsub("februari", "February", clean_x, ignore.case = TRUE)
    clean_x <- gsub("maret", "March", clean_x, ignore.case = TRUE)
    clean_x <- gsub("april", "April", clean_x, ignore.case = TRUE)
    clean_x <- gsub("mei", "May", clean_x, ignore.case = TRUE)
    clean_x <- gsub("juni", "June", clean_x, ignore.case = TRUE)
    clean_x <- gsub("juli", "July", clean_x, ignore.case = TRUE)
    clean_x <- gsub("agustus", "August", clean_x, ignore.case = TRUE)
    clean_x <- gsub("september", "September", clean_x, ignore.case = TRUE)
    clean_x <- gsub("oktober", "October", clean_x, ignore.case = TRUE)
    clean_x <- gsub("november", "November", clean_x, ignore.case = TRUE)
    clean_x <- gsub("desember", "December", clean_x, ignore.case = TRUE)

    out[is_id_months] <- suppressWarnings(lubridate::dmy(clean_x))
  }

  return(out)
}
