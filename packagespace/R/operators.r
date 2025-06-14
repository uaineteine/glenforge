#' @name not_in
#' @aliases %!in%
#' @title Not In Operator
#' @description Check if elements are not in a vector
#' @param x A vector.
#' @param y A vector.
#' @return A logical vector indicating whether each element of x is not in y.
#' @examples
#' c(1, 2, 3) %!in% c(3, 4, 5)
#' @export
'%!in%' <- function(x,y) {
  !('%in%'(x, y))
}
