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
detox_singletext <- function(text, dict, exclude = NULL){
  vapply(text, function(x){
    if(is.na(x) || x == "" || x == "0") return(NA_character_)

    x_clean <- tolower(x)
    x_clean <- stringr::str_trim(x_clean)

    if(!is.null(exclude) && x_clean %in% exclude){
      return(x_clean)
    }

    # dict reference
    corrected <- dict[x_clean]
    if(is.na(corrected)){
      return(x_clean)
    }else{
      return(corrected)
    }
  }, character(1))
}


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
detox_multitext <- function(text, dict, exclude = NULL){
  out <- ifelse(is.na(text) | text == "" | text == "0",
                NA_character_,
                text)

  to_process <- !is.na(out)

  out[to_process] <- tolower(out[to_process])
  out[to_process] <- stringr::str_replace_all(out[to_process],
                                              "[\\s(),+]+", ",")
  out[to_process] <- stringr::str_trim(out[to_process], side = "both")
  out[to_process] <- stringr::str_squish(out[to_process])

  # if exclude is not NULL
  excluded_words <- if(!is.null(exclude) && length(exclude) > 0) {
    paste0("\\b(", paste(exclude, collapse = "|"), ")\\b")
  } else {
    NULL
  }

  # For each element: split, exclude, correct, & rejoin
  out[to_process] <- vapply(out[to_process], function(txt) {
    words <- unlist(stringr::str_split(txt, ","))
    words <- words[words != ""]
    words <- stringr::str_squish(words)
    if(!is.null(excluded_words)){
      words <- words[!stringr::str_detect(words, excluded_words)]
    }
    corrected_words <- dict[words]
    corrected_words[is.na(corrected_words)] <- words[is.na(corrected_words)]
    cleaned_words <- corrected_words[!is.na(corrected_words)]
    sorted_words <- sort(unique(cleaned_words))
    stringr::str_c(sorted_words, collapse = ", ")
  }, character(1))

  return(out)
}
