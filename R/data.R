#' Mock epidemiological dataset
#'
#' A toy dataset containing demographic, vaccination, and outcome variables.
#'
#' @format A data frame with 20 rows and 8 variables:
#' \describe{
#'   \item{id}{Unique ID}
#'   \item{area}{Area A–D}
#'   \item{vaccination_status}{Vaccinated / unvaccinated}
#'   \item{age}{Age in years}
#'   \item{gender}{M / F}
#'   \item{econ}{Socio-economic status: low / middle / high}
#'   \item{house_type}{House type: brick / wood / mixed}
#'   \item{positive}{Infection outcome: 0 = negative, 1 = positive}
#' }
#'
#' @examples
#' data(messy_data)
#' head(messy_data)
"messy_data"
