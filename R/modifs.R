#' Title
#'
#' @param column_id
#'
#' @returns
#' @export
#'
#' @examples
check_duplicate <- function(df, column_id, other_iden = NULL){
  column_id <- rlang::ensym(column_id)

  if(!is.null(rlang::ensym(other_iden))){
    other_idenSym <- rlang::ensym(other_iden)

    out <- df %>%
      dplyr::group_by(!!column_id) %>%
      dplyr::summarise(
        n = dplyr::n(),
        !!other_idenSym := paste(unique(!!other_idenSym), collapse = ", "),
        .groups = "drop"
      )

  }else{
    # other_iden not provided
    out <- df %>%
      dplyr::group_by(!!column_id) %>%
      dplyr::summarise(
        n = dplyr::n(),
        .groups = "drop"
      )
  }

  out <- out %>%
    dplyr::filter(n > 1) %>%
    dplyr::mutate(category = case_when(
      n == 2 ~ "Duplicated",
      n == 3 ~ "Triplicated",
      n == 4 ~ "Quadruplicated",
      n > 4 ~ "More than Quadruplicated"
    ))

  return(out)
}


#' Title
#'
#' @param column_id
#' @param column_target
#'
#' @returns
#' @export
#'
#' @examples
modif_onehot <- function(column_id, column_target){
  column_target %>%
    tidyr::separate_rows(column_target, sep = ", ") %>%
    dplyr::mutate(value = as.numeric(1)) %>%
    tidyr::pivot_wider(
      id_cols = column_id,
      names_from = column_target,
      values_from = value,
      values_fill = 0,
      values_fn = length
    ) %>%
    dplyr::mutate(
      across(where(is.list), ~ as.numeric(.))
    )
}
