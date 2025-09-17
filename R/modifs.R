
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
