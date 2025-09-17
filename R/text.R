#' Title
#'
#' @param text
#' @param dict
#' @param exclude
#'
#' @returns
#' @export
#'
#' @examples
detox_text <- function(text, dict, exclude) {
  if(is.na(text) || text == "" || text == "0") {
    return(NA_character_)
  }

  text_cleaned <- tolower(text)
  text_cleaned <- stringr::str_replace_all(text_cleaned,
                                           "[\\s(),+]+", ",")
  text_cleaned <- stringr::str_trim(text_cleaned, side = "left")
  text_cleaned <- stringr::str_trim(text_cleaned, side = "right")
  text_cleaned <- stringr::str_squish(text_cleaned)

  excluded_words <- paste0("\\b(",
                           paste(exclude, collapse = "|"),
                           ")\\b")
  words <- stringr::str_split(text_cleaned, ",")[[1]]
  words <- words[words != ""]
  words <- stringr::str_squish(words)
  words <- words[!stringr::str_detect(words, excluded_words)]

  corrected_words <- dict[words]
  corrected_words[is.na(corrected_words)] <- words[is.na(corrected_words)]
  cleaned_words_final <- corrected_words[!is.na(corrected_words)]
  sorted_words <- sort(unique(cleaned_words_final))

  stringr::str_c(sorted_words, collapse = ", ")
}
